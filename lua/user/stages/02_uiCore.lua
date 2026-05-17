-- ===========================
-- 02_uiCore
-- ===========================

-- Must be at startup (colorscheme/visuals needed before first render)

vim.schedule(function()
  -- Buffer/status UI: only once a buffer exists
  require('user.ui.core.cokeline')
  require('user.ui.core.statusline')
  require('user.ui.core.equalizer')
end)

vim.api.nvim_create_autocmd('BufReadPost', {
  once = true,
  callback = function()
    -- These only make sense with actual file content
    require('user.ui.core.ibl')      -- indent lines
    require('user.ui.core.windows')  -- window management
    require('user.ui.core.sgt')
  end,
})

-- dressing: hijack vim.ui (same pattern as before)
vim.ui.select = function(...)
  require('user.ui.core.dressing')
  vim.ui.select(...)
end
vim.ui.input = function(...)
  require('user.ui.core.dressing')
  vim.ui.input(...)
end
