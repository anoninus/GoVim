-- user/config/server/HighLevel/lua_ls.lua
vim.lsp.config('lua_ls', {
  filetypes    = { 'lua' },
  root_markers = { '.git', 'lua', 'init.lua' },
  settings = {
    Lua = {
      runtime     = { version = 'Lua 5.4', path = vim.split(package.path, ';') },
      diagnostics = {
        enable  = true,
        globals = { 'vim', 'describe', 'it', 'before_each', 'after_each' },
        disable = { 'trailing-space' },
        unusedLocalExclude = { '_*' },
      },
      workspace = {
        library         = { vim.env.VIMRUNTIME .. '/lua' },
        checkThirdParty = false,
        maxPreload      = 2000,
        preloadFileSize = 500,
      },
      completion  = { callSnippet = 'Replace', showWord = 'Disable' },
      hint        = { enable = true },
      telemetry   = { enable = false },
      semantic    = { enable = false },
    },
  },
  handlers = { ['$/progress'] = function() end },
})
vim.lsp.enable('lua_ls')
