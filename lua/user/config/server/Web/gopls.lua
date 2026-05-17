-- user/config/server/Web/gopls.lua
vim.lsp.config('gopls', {
  cmd          = { 'gopls' },
  filetypes    = { 'go', 'gomod', 'gowork', 'gotmpl' },
  settings = {
    gopls = {
      analyses        = { unusedparams = true, shadow = false, unusedwrite = false, useany = false },
      completeUnimported = true,
      completionBudget   = '100ms',
      matcher            = 'Fuzzy',
      deepCompletion     = false,
      semanticTokens     = false,
      staticcheck        = false,
      hints = {
        assignVariableTypes      = false,
        compositeLiteralFields   = false,
        compositeLiteralTypes    = false,
        constantValues           = false,
        functionTypeParameters   = false,
        parameterNames           = false,
        rangeVariableTypes       = false,
      },
      codelenses = {
        generate   = false,
        gc_details = false,
        test       = false,
        tidy       = false,
      },
    },
  },
})
vim.lsp.enable('gopls')
