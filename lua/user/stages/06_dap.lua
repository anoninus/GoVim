-- user/stages/06_dap.lua
local dap_loaded = false
local function load_dap()
  if dap_loaded then return end
  dap_loaded = true
  require('user.config.dap.setup')
  require('user.config.dap.keymaps')
  require('user.config.dap.langs.rust')
end

-- Load on first debug keypress
vim.keymap.set('n', '<leader>db', function()
  load_dap()
  require('dap').toggle_breakpoint()
end, { desc = 'Debug: Toggle Breakpoint' })

vim.keymap.set('n', '<leader>dc', function()
  load_dap()
  require('dap').continue()
end, { desc = 'Debug: Continue' })

vim.keymap.set('n', '<leader>du', function()
  load_dap()
  require('dapui').toggle()
end, { desc = 'Debug: Toggle UI' })
