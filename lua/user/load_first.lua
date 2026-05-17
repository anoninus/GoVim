-- ================================================
-- load_first.lua
-- ================================================
-- Leader MUST be before everything else
vim.g.mapleader      = ' '
vim.g.maplocalleader = "'"
_G.map = vim.keymap.set

-- ================================================
-- Provider disable (speeds up startup)
-- ================================================
vim.g.loaded_python_provider = 0
vim.g.loaded_ruby_provider   = 0
vim.g.loaded_perl_provider   = 0
