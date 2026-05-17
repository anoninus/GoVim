-- user/config/server/HighLevel/pyright.lua
vim.lsp.config('pyright', {
  cmd          = { 'pyright-langserver', '--stdio' },
  filetypes    = { 'python' },
})
vim.lsp.enable('pyright')
