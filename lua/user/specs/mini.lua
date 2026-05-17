-- ===========================
-- Mini.nvim Suite
-- ===========================
return {
    {
        'nvim-mini/mini.notify',
        commit = '29ec27f',
        event = 'VeryLazy',
    },
    {
        'nvim-mini/mini.indentscope',
        version = false, -- wait for stable versions for better stability
        event = 'VeryLazy',
    },
    {
        'echasnovski/mini.move',
        commit = '4d21420',
        keys = {
            { '<A-Left>',  mode = { 'n', 'v' } },
            { '<A-Right>', mode = { 'n', 'v' } },
            { '<A-Down>',  mode = { 'n', 'v' } },
            { '<A-Up>',    mode = { 'n', 'v' } },
        },
        config = function()
            require('mini.move').setup({
                mappings = {
                    left       = '<A-Left>',
                    right      = '<A-Right>',
                    down       = '<A-Down>',
                    up         = '<A-Up>',
                    line_left  = '<A-Left>',
                    line_right = '<A-Right>',
                    line_down  = '<A-Down>',
                    line_up    = '<A-Up>',
                },
                options = {
                    reindent_linewise = true,
                },
            })
        end,
    },
    {
        'echasnovski/mini.icons',
        commit = 'bac6317',
        version = false,
        event = "VeryLazy",
    },
}
