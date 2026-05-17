-- user/config/server/Web/css_ls.lua
vim.lsp.config('cssls', {
  cmd          = { 'vscode-css-language-server', '--stdio' },
  filetypes    = { 'css', 'scss', 'less' },
})
vim.lsp.enable('cssls')
