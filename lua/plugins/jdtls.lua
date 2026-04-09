return {
  "mfussenegger/nvim-jdtls",
  ft = "java",
  dependencies = {
    "mfussenegger/nvim-dap",
    "williamboman/mason.nvim",
    "hrsh7th/cmp-nvim-lsp",
  },
  config = function()
    local jdtls = require("jdtls")

    -- Use Mason's standard path directly (more reliable)
    local mason_path = vim.fn.stdpath("data") .. "/mason/packages"
    local jdtls_path = mason_path .. "/jdtls"

    -- Check if jdtls is installed
    if vim.fn.isdirectory(jdtls_path) == 0 then
      vim.notify("jdtls not installed. Run :MasonInstall jdtls", vim.log.levels.WARN)
      return
    end

    local java_debug_path = mason_path .. "/java-debug-adapter"
    local java_test_path = mason_path .. "/java-test"

    -- OS-specific config (darwin = macOS)
    local os_uname = vim.uv and vim.uv.os_uname or vim.loop.os_uname
    local sysname = (os_uname and os_uname() or { sysname = "Linux" }).sysname
    local config_os = (sysname == "Darwin" and "mac") or (sysname == "Linux" and "linux") or "win"
    local config_dir = jdtls_path .. "/config_" .. config_os

    local lombok_path = jdtls_path .. "/lombok.jar"
    if vim.fn.filereadable(lombok_path) == 0 then
      lombok_path = nil
    end

    -- Bundles para debug e testes (instalar via :MasonInstall java-debug-adapter java-test)
    local bundles = {}

    if vim.fn.isdirectory(java_debug_path) == 1 then
      local java_debug_bundle = vim.split(
        vim.fn.glob(java_debug_path .. "/extension/server/com.microsoft.java.debug.plugin-*.jar"),
        "\n"
      )
      if java_debug_bundle[1] ~= "" then
        vim.list_extend(bundles, java_debug_bundle)
      end
    end

    if vim.fn.isdirectory(java_test_path) == 1 then
      local java_test_bundle = vim.split(vim.fn.glob(java_test_path .. "/extension/server/*.jar"), "\n")
      local excluded = { "com.microsoft.java.test.runner-jar-with-dependencies.jar", "jacocoagent.jar" }
      for _, jar in ipairs(java_test_bundle) do
        if jar ~= "" and not vim.tbl_contains(excluded, vim.fn.fnamemodify(jar, ":t")) then
          table.insert(bundles, jar)
        end
      end
    end

    -- Capabilities
    local capabilities = require("cmp_nvim_lsp").default_capabilities()

    local extendedClientCapabilities = jdtls.extendedClientCapabilities
    extendedClientCapabilities.resolveAdditionalTextEditsSupport = true

    -- Autocommand to start JDTLS
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "java",
      callback = function()
        local root_markers = { ".git", "mvnw", "gradlew", "pom.xml", "build.gradle", "build.gradle.kts" }
        local root_dir = require("jdtls.setup").find_root(root_markers) or vim.fn.getcwd()

        local project_name = vim.fn.fnamemodify(root_dir, ":p:t")
        local workspace_dir = vim.fn.stdpath("data") .. "/jdtls-workspace/" .. project_name

        local cmd = {
          "java",
          "-Declipse.application=org.eclipse.jdt.ls.core.id1",
          "-Dosgi.bundles.defaultStartLevel=4",
          "-Declipse.product=org.eclipse.jdt.ls.core.product",
          "-Dlog.protocol=true",
          "-Dlog.level=INFO",
          "-Xmx1g",
          "--add-modules=ALL-SYSTEM",
          "--add-opens", "java.base/java.util=ALL-UNNAMED",
          "--add-opens", "java.base/java.lang=ALL-UNNAMED",
        }
        if lombok_path then
          table.insert(cmd, "-javaagent:" .. lombok_path)
        end
        vim.list_extend(cmd, {
          "-jar", vim.fn.glob(jdtls_path .. "/plugins/org.eclipse.equinox.launcher_*.jar"),
          "-configuration", config_dir,
          "-data", workspace_dir,
        })

        local config = {
          cmd = cmd,
          root_dir = root_dir,
          capabilities = capabilities,

          settings = {
            java = {
              server = { launchMode = "Hybrid" },
              eclipse = { downloadSources = true },
              configuration = { updateBuildConfiguration = "interactive" },
              maven = { downloadSources = true },
              implementationsCodeLens = { enabled = true },
              referencesCodeLens = { enabled = true },
              references = { includeDecompiledSources = true },
              inlayHints = { parameterNames = { enabled = "all" } },
              format = { enabled = true },
              signatureHelp = { enabled = true },
              completion = {
                favoriteStaticMembers = {
                  "org.junit.jupiter.api.Assertions.*",
                  "org.mockito.Mockito.*",
                  "org.assertj.core.api.Assertions.*",
                },
                importOrder = { "java", "javax", "org", "com" },
              },
              sources = {
                organizeImports = { starThreshold = 9999, staticStarThreshold = 9999 },
              },
              codeGeneration = {
                toString = { template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}" },
                useBlocks = true,
              },
            },
          },

          init_options = {
            bundles = bundles,
            extendedClientCapabilities = extendedClientCapabilities,
          },

          on_attach = function(client, bufnr)
            pcall(function()
              jdtls.setup_dap({ hotcodereplace = "auto" })
              require("jdtls.dap").setup_dap_main_class_configs()
            end)

            local opts = { noremap = true, silent = true, buffer = bufnr }

            vim.keymap.set("n", "<leader>jo", jdtls.organize_imports, vim.tbl_extend("force", opts, { desc = "Organize imports" }))
            vim.keymap.set("n", "<leader>jc", jdtls.extract_constant, vim.tbl_extend("force", opts, { desc = "Extract constant" }))
            vim.keymap.set("v", "<leader>jc", function() jdtls.extract_constant(true) end, vim.tbl_extend("force", opts, { desc = "Extract constant" }))
            vim.keymap.set("n", "<leader>jv", jdtls.extract_variable, vim.tbl_extend("force", opts, { desc = "Extract variable" }))
            vim.keymap.set("v", "<leader>jv", function() jdtls.extract_variable(true) end, vim.tbl_extend("force", opts, { desc = "Extract variable" }))
            vim.keymap.set("v", "<leader>jm", function() jdtls.extract_method(true) end, vim.tbl_extend("force", opts, { desc = "Extract method" }))
            vim.keymap.set("n", "<leader>jt", jdtls.test_nearest_method, vim.tbl_extend("force", opts, { desc = "Test nearest method" }))
            vim.keymap.set("n", "<leader>jT", jdtls.test_class, vim.tbl_extend("force", opts, { desc = "Test class" }))

          end,
        }

        jdtls.start_or_attach(config)
      end,
    })
  end,
}
