
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

vim.o.updatetime  = 300   -- not 0, that hammers swapfile/cursorhold
vim.o.ttimeoutlen = 0
vim.o.timeoutlen  = 300
vim.o.swapfile    = true
vim.o.confirm     = true
-- lazyredraw is deprecated in 0.10+, causes issues with some plugins
-- vim.o.lazyredraw = true
-- ================================================
-- Indent and Movement
-- ================================================
vim.o.startofline  = false
vim.o.breakindent  = true
vim.o.tabstop      = 4
vim.o.shiftwidth   = 4
vim.o.softtabstop  = 4
vim.o.expandtab    = true
vim.keymap.set('n', '<Up>',   'g<Up>')
vim.keymap.set('n', '<Down>', 'g<Down>')
-- ================================================
-- UI & Display
-- ================================================
vim.opt.splitright    = true
vim.opt.splitbelow    = true
vim.o.ignorecase      = true
vim.o.smartcase       = true
vim.o.incsearch       = true
vim.o.hlsearch        = true
vim.o.winborder       = 'rounded'
vim.o.winminheight    = 0
vim.o.number          = true
vim.o.relativenumber  = true
vim.o.cursorline      = true
vim.o.termguicolors   = true
vim.o.signcolumn      = 'yes'
vim.o.showtabline     = 2
vim.o.scrolloff       = 8
vim.o.sidescrolloff   = 8
vim.opt.fillchars:append({ eob = ' ' })
-- ================================================
-- Fold (defer LSP fold until LSP is ready)
-- ================================================
vim.opt.foldlevel      = 99
vim.opt.foldlevelstart = 99
vim.opt.foldenable     = true

-- Don't set LSP foldexpr at startup — LSP isn't attached yet anyway
-- Set it per-buffer once LSP attaches
vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(ev)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    if client and client.supports_method('textDocument/foldingRange') then
      local win = vim.fn.bufwinid(ev.buf)
      if win == -1 then return end -- buffer not visible in any window
      vim.wo[win].foldmethod = 'expr'
      vim.wo[win].foldexpr   = 'v:lua.vim.lsp.foldexpr()'
    end
  end,
})

-- ================================================
-- Bell
-- ================================================
vim.o.visualbell = false
vim.o.errorbells = false
-- ================================================
-- End
-- ================================================
