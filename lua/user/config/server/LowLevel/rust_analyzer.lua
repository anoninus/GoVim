-- user/config/server/LowLevel/rust_analyzer.lua
local map = vim.keymap.set
map('n', '<leader>cc', '<cmd>Cargo check<cr>',   { desc = 'Cargo check' })
map('n', '<leader>cC', '<cmd>Cargo clean<cr>',   { desc = 'Cargo clean' })
map('n', '<leader>cz', '<cmd>Cargo run<cr>',     { desc = 'Cargo run' })
map('n', '<leader>cb', '<cmd>Cargo build<cr>',   { desc = 'Cargo build' })
map('n', '<leader>cu', '<cmd>Cargo update<cr>',  { desc = 'Cargo update' })
map('n', '<leader>cr', '<cmd>CargoReload<cr>',   { desc = 'Cargo reload' })

vim.lsp.config('rust_analyzer', {
  cmd           = { 'rust-analyzer' },
  filetypes     = { 'rust' },
  root_markers  = { 'Cargo.toml' },
  single_file_support = false,
  settings = {
    ['rust-analyzer'] = {
      cargo        = { allFeatures = false, buildScripts = { enable = false } },
      check        = { command = 'clippy', extraArgs = { '--no-deps' } },
      procMacro    = { enable = true, attributes = { enable = true } },
      diagnostics  = {
        enable = true,
        refresh = { workspace = { enable = false } },
        disabled = { 'unresolved-proc-macro', 'unresolved-macro-call' },
        experimental = { enable = false },
      },
      cachePriming = { enable = true, numThreads = 2 },
      checkOnSave  = true,
      files        = { excludeDirs = { '.git' }, watcher = 'client' },
    },
  },
})
vim.lsp.enable('rust_analyzer')
