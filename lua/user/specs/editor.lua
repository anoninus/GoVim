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
        'numToStr/Comment.nvim',
        config = function()
            require('Comment').setup({
                ignore = '^$',
                toggler = {
                    line = 'gcc',
                    block = 'gbc',
                },
            })
        end
    },
    {
        {
            "akinsho/toggleterm.nvim",
            version = "*",
            cmd = "ToggleTerm", -- also loaded on command
            keys = { "<A-t>" },    -- lazy-load trigger
            opts = {
                size = 15,
                open_mapping = "<A-t>",
                hide_numbers = true,
                shade_terminals = false, -- keep this false because is  heavy
                -- shading_factor = 2,
                start_insert = true,
                insert_mappings = false, -- tt works in insert mode too
                terminal_mappings = true,
                persist_size = true,
                direction = "horizontal", -- no floating, ever
                close_on_exit = true,
                shell = vim.o.shell,
                auto_scroll = true,
            },
            vim.keymap.set("t", "<A-End>", "<C-\\><C-n>", { desc = "Exit terminal mode" })
        },
    }
}
