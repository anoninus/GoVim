-- Core system (truly needed at startup)
require('user.sys.env')        -- env vars, must be first
require('user.sys.plugins')    -- plugin manager, must be early

-- Defer everything else
vim.schedule(function()
  require('user.mini.mini_notify')   -- notifications, not needed until first notify
  require('user.sys.paste_from_sys') -- clipboard, not needed until first paste
  require('user.sys.last_pos')       -- last position, fires on BufReadPost anyway

  require('user.sys.options')       -- last position, fires on BufReadPost anyway
end)
