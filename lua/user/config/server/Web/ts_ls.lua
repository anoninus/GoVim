-- user/config/server/Web/ts_ls.lua
vim.lsp.config('ts_ls', {
  filetypes    = { 'typescript', 'typescriptreact', 'javascript', 'javascriptreact' },
  flags        = { debounce_text_changes = 300 },
  settings = {
    typescript = {
      inlayHints = {
        includeInlayParameterNameHints                         = 'literals',
        includeInlayParameterNameHintsWhenArgumentMatchesName  = false,
        includeInlayFunctionParameterTypeHints                 = false,
        includeInlayVariableTypeHints                          = false,
        includeInlayPropertyDeclarationTypeHints               = false,
        includeInlayFunctionLikeReturnTypeHints                = true,
        includeInlayEnumMemberValueHints                       = true,
      },
    },
    javascript = {
      inlayHints = {
        includeInlayParameterNameHints                         = 'literals',
        includeInlayParameterNameHintsWhenArgumentMatchesName  = false,
        includeInlayFunctionParameterTypeHints                 = false,
        includeInlayVariableTypeHints                          = false,
        includeInlayPropertyDeclarationTypeHints               = false,
        includeInlayFunctionLikeReturnTypeHints                = true,
        includeInlayEnumMemberValueHints                       = true,
      },
    },
  },
})
vim.lsp.enable('ts_ls')
