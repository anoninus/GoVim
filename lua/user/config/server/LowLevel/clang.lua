-- user/config/server/LowLevel/clang.lua
vim.lsp.config('clangd', {
  cmd       = { 'clangd', '--background-index', '--clang-tidy', '--log=error' },
  filetypes = { 'c', 'cpp' },
})
vim.lsp.enable('clangd')
