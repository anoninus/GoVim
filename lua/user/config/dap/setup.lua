-- user/config/dap/setup.lua
-- Don't require dap/dapui at load time — load on first debug keypress
local M = {}

function M.setup()
  local dap    = require('dap')
  local dapui  = require('dapui')

  dapui.setup()

  dap.listeners.after.event_initialized['dapui']  = function() dapui.open()  end
  dap.listeners.before.event_terminated['dapui']  = function() dapui.close() end
  dap.listeners.before.event_exited['dapui']      = function() dapui.close() end

  vim.fn.sign_define('DapBreakpoint', { text = '●', texthl = 'DiagnosticError' })
  vim.fn.sign_define('DapStopped',    { text = '▶', texthl = 'DiagnosticWarn', linehl = 'Visual' })

  return dap
end

return M
