return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("nvim-treesitter").setup({
        ensure_installed = {
          "java",
          "lua",
          "vim",
          "vimdoc",
          "query",
          "xml",
          "yaml",
          "json",
          "html",
          "css",
          "javascript",
          "typescript",
          "markdown",
          "markdown_inline",
          "bash",
          "dockerfile",
          "gitignore",
          "sql",
          "properties",
          "groovy",
          "kotlin",
        },
      })
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    config = function()
      ---@diagnostic disable-next-line: missing-fields
      require("nvim-treesitter-textobjects").setup({
        select = {
          enable = true,
          lookahead = true,
          keymaps = {
            ["af"] = { query = "@function.outer", desc = "Select outer function" },
            ["if"] = { query = "@function.inner", desc = "Select inner function" },
            ["ac"] = { query = "@class.outer", desc = "Select outer class" },
            ["ic"] = { query = "@class.inner", desc = "Select inner class" },
            ["aa"] = { query = "@parameter.outer", desc = "Select outer parameter" },
            ["ia"] = { query = "@parameter.inner", desc = "Select inner parameter" },
          },
        },
        move = {
          enable = true,
          set_jumps = true,
          goto_next_start = {
            ["]m"] = { query = "@function.outer", desc = "Next function start" },
            ["]]"] = { query = "@class.outer", desc = "Next class start" },
          },
          goto_next_end = {
            ["]M"] = { query = "@function.outer", desc = "Next function end" },
            ["]["] = { query = "@class.outer", desc = "Next class end" },
          },
          goto_previous_start = {
            ["[m"] = { query = "@function.outer", desc = "Prev function start" },
            ["[["] = { query = "@class.outer", desc = "Prev class start" },
          },
          goto_previous_end = {
            ["[M"] = { query = "@function.outer", desc = "Prev function end" },
            ["[]"] = { query = "@class.outer", desc = "Prev class end" },
          },
        },
        swap = {
          enable = true,
          swap_next = {
            ["<leader>a"] = { query = "@parameter.inner", desc = "Swap with next parameter" },
          },
          swap_previous = {
            ["<leader>A"] = { query = "@parameter.inner", desc = "Swap with prev parameter" },
          },
        },
      })
    end,
  },
}
