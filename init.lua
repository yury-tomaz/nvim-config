-- Neovim Java/Spring Boot Configuration
-- Generated from SPEC.md

-- Leader key (must be set before lazy)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Load core configurations
require("config.options")
require("config.lazy")
require("config.keymaps")
