-- user/ui/core/windows.lua
-- Lazy load fzf-lua only when helptags is actually invoked
vim.api.nvim_create_user_command('H', function(opts)
  vim.cmd('help ' .. opts.args)
  local buf = vim.api.nvim_get_current_buf()
  local help_topic = opts.args ~= '' and opts.args or 'help.txt'
  vim.cmd('wincmd q')

  local function get_dimensions()
    local w = math.floor(vim.o.columns * 0.75)
    local h = math.floor(vim.o.lines * 0.75)
    return w, h
  end

  local w, h = get_dimensions()
  local win = vim.api.nvim_open_win(buf, true, {
    relative  = 'editor',
    width     = w,
    height    = h,
    row       = math.floor((vim.o.lines - h) / 2),
    col       = math.floor((vim.o.columns - w) / 2),
    border    = 'rounded',
    title     = ' 󰋖 Help: ' .. help_topic .. ' ',
    title_pos = 'center',
  })

  vim.api.nvim_create_autocmd('VimResized', {
    buffer   = buf,
    callback = function()
      local new_w, new_h = get_dimensions()
      vim.api.nvim_win_set_config(win, {
        relative = 'editor',
        width    = new_w,
        height   = new_h,
        row      = math.floor((vim.o.lines - new_h) / 2),
        col      = math.floor((vim.o.columns - new_w) / 2),
      })
    end,
  })
end, { nargs = '?', complete = 'help' })

-- Don't touch fzf-lua at startup — patch it lazily on first helptags call
vim.keymap.set('n', '<leader>hf', function()
  local ok, fzf = pcall(require, 'fzf-lua')
  if not ok then
    vim.notify('fzf-lua not found')
    return
  end

  fzf.helptags({
    actions = {
      default = function(selected)
        if selected and selected[1] then
          local tag = selected[1]:match('^([^%s]+)')
          vim.cmd('H ' .. tag)
        end
      end,
    },
  })
end, { desc = 'Help tags (FzfLua)' })
