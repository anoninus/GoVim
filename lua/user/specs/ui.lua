return {
    {
        'willothy/nvim-cokeline',
        commit = '9fbed13',
    },
    {
        'goolord/alpha-nvim',
        commit = '3979b01',
        event = 'VimEnter',
        dependencies = {
            { 'MaximilianLloyd/ascii.nvim', commit = '70783fe', lazy = false },
        },
    },
    {
        'stevearc/dressing.nvim',
        commit = '3a45525',
        init = function()
            local original_select = vim.ui.select
            local original_input  = vim.ui.input

            vim.ui.select         = function(...)
                vim.ui.select = original_select
                require('lazy').load({ plugins = { 'dressing.nvim' } })
                vim.ui.select(...)
            end

            vim.ui.input          = function(...)
                vim.ui.input = original_input
                require('lazy').load({ plugins = { 'dressing.nvim' } })
                vim.ui.input(...)
            end
        end,
    },
    {
        'rcarriga/nvim-notify',
        commit = 'a3020c2',
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
        commit = '4135f97',
        cmd = { 'FocusSplitNicely', 'FocusSplitCycle', 'FocusToggle' },
    },
}
