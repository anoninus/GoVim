-- user/config/server/Web/html.lua
vim.lsp.config('html', {
  cmd          = { 'vscode-html-language-server', '--stdio' },
  filetypes    = { 'html', 'templ' },
})
vim.lsp.enable('html')
