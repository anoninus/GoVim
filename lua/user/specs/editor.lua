-- ===========================
-- Editor Enhancements
-- ===========================
return {
    {
        'kylechui/nvim-surround',
        keys = { 'ys', 'ds', 'cs', { 'S', mode = 'v' } },
        config = function()
            require('nvim-surround').setup({})
        end,
    },
    {
        'windwp/nvim-autopairs',
        dependencies = {
            'saghen/blink.cmp',
        },
        lazy = true,
    },
    {
        'numToStr/Comment.nvim',
        keys = {
            { 'gcc', mode = 'n',          desc = 'Comment line' },
            { 'gc',  mode = { 'n', 'v' }, desc = 'Comment' },
        },
    },
}
