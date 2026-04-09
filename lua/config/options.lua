-- General Neovim options
local opt = vim.opt

-- Line numbers
opt.number = true
opt.relativenumber = true

-- Tabs & indentation
opt.tabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.autoindent = true
opt.smartindent = true

-- Line wrapping
opt.wrap = false

-- Search settings
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = true
opt.incsearch = true

-- Appearance
opt.termguicolors = true
opt.background = "dark"
opt.signcolumn = "yes:1"
opt.cursorline = true
opt.scrolloff = 8
opt.sidescrolloff = 8
opt.showmode = false
opt.pumheight = 10
opt.fillchars = { eob = " " }

-- Backspace
opt.backspace = "indent,eol,start"

-- Clipboard
opt.clipboard = "unnamedplus"

-- Split windows
opt.splitright = true
opt.splitbelow = true
opt.confirm = true

-- Undo & backup
opt.undofile = true
opt.swapfile = false
opt.backup = false

-- Update time (for better UX)
opt.updatetime = 250
opt.timeoutlen = 300

-- Completion
opt.completeopt = "menuone,noselect"

-- File encoding
opt.fileencoding = "utf-8"

-- PlantUML filetypes (para preview em tempo real)
vim.filetype.add({
  extension = {
    puml = "plantuml",
    plantuml = "plantuml",
    iuml = "plantuml",
    pu = "plantuml",
    wsd = "plantuml",
  },
})
