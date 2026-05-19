-- user/ui/core/cokeline.lua
-- Keymaps are cheap, register immediately
vim.keymap.set('n', '<S-Tab>', '<Plug>(cokeline-focus-prev)', { silent = true, desc = 'Previous buffer' })
vim.keymap.set('n', '<Tab>', '<Plug>(cokeline-focus-next)', { silent = true, desc = 'Next buffer' })
vim.keymap.set('n', '<A-,>', '<Plug>(cokeline-switch-prev)', { silent = true })
vim.keymap.set('n', '<A-.>', '<Plug>(cokeline-switch-next)', { silent = true })

local get_hex = require('cokeline.hlgroups').get_hl_attr
require('cokeline').setup({
    default_hl = {
        fg = function(buffer)
            return buffer.is_focused and get_hex('TabLineSel', 'fg') or get_hex('TabLine', 'fg')
        end,
        bg = function(buffer)
            return buffer.is_focused and get_hex('TabLineSel', 'bg') or get_hex('TabLine', 'bg')
        end,
    },
    components = {
        {
            text = function(buffer) return ' ' .. buffer.index end,
        },
        { text = function(buffer) return buffer.unique_prefix end, fg = get_hex('Comment', 'fg') },
        {
            text = function(buffer) return ' ' .. buffer.filename .. ' ' end,
        },
        {
            text = function(buffer) return buffer.is_modified and ' [*]' or '' end,
            fg = function() return get_hex('Warn', 'fg') end,
            bold = true,
        },
        { text = '󰖭', on_click = function(_, _, _, _, buffer) buffer:delete() end },
        { text = ' ' },
    },
})
