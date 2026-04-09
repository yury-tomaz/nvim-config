return {
  "lewis6991/gitsigns.nvim",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    require("gitsigns").setup({
      signs = {
        add = { text = "│" },
        change = { text = "│" },
        delete = { text = "_" },
        topdelete = { text = "‾" },
        changedelete = { text = "~" },
        untracked = { text = "┆" },
      },
      current_line_blame = false,
      current_line_blame_opts = {
        virt_text = true,
        virt_text_pos = "eol",
        delay = 500,
      },
      on_attach = function(bufnr)
        local gs = package.loaded.gitsigns
        local opts = function(desc)
          return { noremap = true, silent = true, buffer = bufnr, desc = desc }
        end

        -- Navigation
        vim.keymap.set("n", "]c", function()
          if vim.wo.diff then return "]c" end
          vim.schedule(function() gs.next_hunk() end)
          return "<Ignore>"
        end, { buffer = bufnr, expr = true, desc = "Next hunk" })

        vim.keymap.set("n", "[c", function()
          if vim.wo.diff then return "[c" end
          vim.schedule(function() gs.prev_hunk() end)
          return "<Ignore>"
        end, { buffer = bufnr, expr = true, desc = "Prev hunk" })

        -- Actions
        vim.keymap.set("n", "<leader>gs", gs.stage_hunk, opts("Stage hunk"))
        vim.keymap.set("n", "<leader>gr", gs.reset_hunk, opts("Reset hunk"))
        vim.keymap.set("v", "<leader>gs", function() gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") }) end, opts("Stage hunk"))
        vim.keymap.set("v", "<leader>gr", function() gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") }) end, opts("Reset hunk"))
        vim.keymap.set("n", "<leader>gS", gs.stage_buffer, opts("Stage buffer"))
        vim.keymap.set("n", "<leader>gu", gs.undo_stage_hunk, opts("Undo stage hunk"))
        vim.keymap.set("n", "<leader>gR", gs.reset_buffer, opts("Reset buffer"))
        vim.keymap.set("n", "<leader>gp", gs.preview_hunk, opts("Preview hunk"))
        vim.keymap.set("n", "<leader>gb", function() gs.blame_line({ full = true }) end, opts("Blame line"))
        vim.keymap.set("n", "<leader>gB", gs.toggle_current_line_blame, opts("Toggle line blame"))
        vim.keymap.set("n", "<leader>gd", gs.diffthis, opts("Diff this"))
        vim.keymap.set("n", "<leader>gD", function() gs.diffthis("~") end, opts("Diff this ~"))
      end,
    })
  end,
}
