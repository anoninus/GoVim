return {
    {
        'willothy/nvim-cokeline',
        --         commit = '9fbed13',
    },
    {
        'stevearc/dressing.nvim',
        --         commit = '3a45525',
        lazy = true, -- loaded via vim.ui hijack above
        opts = {
            input = {
                enabled        = true,
                default_prompt = 'Input',
                trim_prompt    = true,
                title_pos      = 'left',
                start_mode     = 'insert',
                border         = 'rounded',
                relative       = 'cursor',
                prefer_width   = 40,
                max_width      = { 140, 0.9 },
                min_width      = { 20, 0.2 },
                win_options    = {
                    wrap          = true,
                    list          = true,
                    listchars     = 'precedes:…,extends:…',
                    sidescrolloff = 0,
                },
                mappings       = {
                    n = { ['<Esc>'] = 'Close', ['<CR>'] = 'Confirm' },
                    i = { ['<C-c>'] = 'Close', ['<CR>'] = 'Confirm', ['<Up>'] = 'HistoryPrev', ['<Down>'] = 'HistoryNext' },
                },
            },
            select = {
                enabled     = true,
                backend     = { 'fzf_lua', 'fzf', 'builtin' }, -- telescope removed
                trim_prompt = true,
                fzf_lua     = {},
                builtin     = {
                    show_numbers = true,
                    border       = 'rounded',
                    relative     = 'editor',
                    win_options  = {
                        cursorline    = true,
                        cursorlineopt = 'both',
                        winhighlight  = 'MatchParen:',
                        statuscolumn  = ' ',
                    },
                    max_width    = { 140, 0.8 },
                    min_width    = { 40, 0.2 },
                    max_height   = 0.9,
                    min_height   = { 10, 0.2 },
                    mappings     = { ['<Esc>'] = 'Close', ['<C-c>'] = 'Close', ['<CR>'] = 'Confirm' },
                },
            },
        },
    },
    {
        'rcarriga/nvim-notify',
        --         commit = 'a3020c2',
        init = function()
            local original_notify = vim.notify
            vim.notify = function(...)
                vim.notify = original_notify
                require('lazy').load({ plugins = { 'nvim-notify' } })
                vim.notify(...)
            end
        end,
    },
    {
        'beauwilliams/focus.nvim',
        --         commit = '4135f97',
        cmd = { 'FocusSplitNicely', 'FocusSplitCycle', 'FocusToggle' },
    },

    -- in user/specs/ui.lua or wherever your UI plugins live
    {
        'lukas-reineke/indent-blankline.nvim',
        main  = 'ibl',
        event = 'BufReadPost',
    },
}
