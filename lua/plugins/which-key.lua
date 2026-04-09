return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  init = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 300
  end,
  config = function()
    local wk = require("which-key")

    wk.setup({
      plugins = {
        marks = true,
        registers = true,
        spelling = {
          enabled = true,
          suggestions = 20,
        },
        presets = {
          operators = true,
          motions = true,
          text_objects = true,
          windows = true,
          nav = true,
          z = true,
          g = true,
        },
      },
      win = {
        border = "rounded",
        padding = { 2, 2, 2, 2 },
      },
      layout = {
        height = { min = 4, max = 25 },
        width = { min = 20, max = 50 },
        spacing = 3,
        align = "left",
      },
    })

    -- Register key groups
    wk.add({
      { "<leader>b", group = "Buffer" },
      { "<leader>d", group = "Debug" },
      { "<leader>f", group = "Find (Telescope)" },
      { "<leader>h", group = "Harpoon" },
      { "<leader>j", group = "Java" },
      { "<leader>g", group = "Git" },
      { "<leader>n", group = "No highlight" },
      { "<leader>p", group = "PlantUML" },
      { "<leader>s", group = "Signature/Search" },
    })
  end,
}
