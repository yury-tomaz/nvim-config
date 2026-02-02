return {
  {
    "zaldih/themery.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("themery").setup({
        themes = {
          -- Gruvbox variants
          {
            name = "Gruvbox Dark (Hard)",
            colorscheme = "gruvbox",
            before = [[vim.o.background = "dark"]],
            after = [[require("gruvbox").setup({ contrast = "hard" })]],
          },
          {
            name = "Gruvbox Dark (Soft)",
            colorscheme = "gruvbox",
            before = [[vim.o.background = "dark"]],
            after = [[require("gruvbox").setup({ contrast = "soft" })]],
          },
          {
            name = "Gruvbox Light",
            colorscheme = "gruvbox",
            before = [[vim.o.background = "light"]],
          },
          -- Catppuccin variants
          { name = "Catppuccin Mocha", colorscheme = "catppuccin-mocha" },
          { name = "Catppuccin Macchiato", colorscheme = "catppuccin-macchiato" },
          { name = "Catppuccin Frappe", colorscheme = "catppuccin-frappe" },
          { name = "Catppuccin Latte", colorscheme = "catppuccin-latte" },
          -- Tokyo Night variants
          { name = "Tokyo Night", colorscheme = "tokyonight-night" },
          { name = "Tokyo Night Storm", colorscheme = "tokyonight-storm" },
          { name = "Tokyo Night Moon", colorscheme = "tokyonight-moon" },
          { name = "Tokyo Night Day", colorscheme = "tokyonight-day" },
          -- Rose Pine variants
          { name = "Rose Pine", colorscheme = "rose-pine" },
          { name = "Rose Pine Moon", colorscheme = "rose-pine-moon" },
          { name = "Rose Pine Dawn", colorscheme = "rose-pine-dawn" },
          -- Kanagawa
          { name = "Kanagawa", colorscheme = "kanagawa" },
          { name = "Kanagawa Wave", colorscheme = "kanagawa-wave" },
          { name = "Kanagawa Dragon", colorscheme = "kanagawa-dragon" },
          -- One Dark
          { name = "One Dark", colorscheme = "onedark" },
          -- Nord
          { name = "Nord", colorscheme = "nord" },
        },
        livePreview = true,
        globalAfter = [[vim.cmd("highlight CursorLineNr guifg=#fabd2f")]],
      })
    end,
  },

  -- Temas
  {
    "ellisonleao/gruvbox.nvim",
    lazy = false,
    priority = 999,
    config = function()
      require("gruvbox").setup({
        terminal_colors = true,
        undercurl = true,
        underline = true,
        bold = true,
        italic = {
          strings = true,
          emphasis = true,
          comments = true,
          operators = false,
          folds = true,
        },
        strikethrough = true,
        contrast = "hard",
        transparent_mode = false,
      })
    end,
  },

  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = false,
    priority = 999,
  },

  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 999,
  },

  {
    "rose-pine/neovim",
    name = "rose-pine",
    lazy = false,
    priority = 999,
  },

  {
    "rebelot/kanagawa.nvim",
    lazy = false,
    priority = 999,
  },

  {
    "navarasu/onedark.nvim",
    lazy = false,
    priority = 999,
  },

  {
    "shaunsingh/nord.nvim",
    lazy = false,
    priority = 999,
  },
}
