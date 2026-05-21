return {
    {
        'nvim-treesitter/nvim-treesitter',
        build = ':TSUpdate',
        ft = { 'lua', 'vim', 'rust', 'toml', 'json' },
        config = function()
            -- 1. configure where parsers live
            require('nvim-treesitter').setup({
                install_dir = vim.fn.stdpath('data') .. '/site',
                indent = false,
            })

            -- 2. declare which parsers you want
            require('nvim-treesitter').install({
                'lua', 'vim', 'rust', 'toml', 'json',
            })

            -- 3. enable highlighting per filetype via autocmd
            vim.api.nvim_create_autocmd('FileType', {
                -- Add desired file types
                pattern = { 'lua', 'rust', 'vim', 'toml', 'json' },
                callback = function()
                    pcall(vim.treesitter.start)
                end,
            })
        end,
    },
}
