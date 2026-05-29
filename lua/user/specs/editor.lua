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
            keys = { "tt" }, -- lazy-load trigger
            opts = {
                size = 15,
                open_mapping = [[tt]],
                hide_numbers = true,
                shade_terminals = true,
                shading_factor = 2,
                start_insert = true,
                insert_mappings = true, -- tt works in insert mode too
                terminal_mappings = true,
                persist_size = true,
                direction = "horizontal", -- no floating, ever
                close_on_exit = true,
                shell = vim.o.shell,
                auto_scroll = true,
            },
            config = function(_, opts)
                local toggleterm = require("toggleterm")
                toggleterm.setup(opts)

                local Terminal = require("toggleterm.terminal").Terminal

                -- ── helpers ────────────────────────────────────────────────────────────
                local terminals = {}

                local function spawn_terminal()
                    local id = #terminals + 1
                    local t = Terminal:new({
                        id = id,
                        direction = "horizontal",
                        close_on_exit = true,
                        on_open = function(term)
                            -- <End> quits terminal mode (back to normal)
                            vim.keymap.set("t", "<End>", [[<C-\><C-n>]], { buffer = term.bufnr, silent = true })
                        end,
                    })
                    terminals[id] = t
                    t:toggle()
                end

                local function kill_all_terminals()
                    for id, t in pairs(terminals) do
                        if t and t:is_open() then
                            t:shutdown()
                        end
                        terminals[id] = nil
                    end
                    vim.notify("All terminals killed", vim.log.levels.INFO)
                end

                -- ── keymaps ────────────────────────────────────────────────────────────
                local map = function(mode, lhs, rhs, desc)
                    vim.keymap.set(mode, lhs, rhs, { silent = true, desc = desc })
                end

                -- spawn a new terminal (increments each call)
                map("n", "<leader>ts", spawn_terminal, "Terminal: Spawn new")

                -- kill every open terminal
                map("n", "<leader>tk", kill_all_terminals, "Terminal: Kill all")

                -- toggle terminal #1 quickly (tt already does this globally, but keep it explicit)
                map("n", "<leader>tt", "<cmd>ToggleTerm<cr>", "Terminal: Toggle")

                -- navigate between open terminals by number (<leader>t1 … <leader>t9)
                for i = 1, 9 do
                    map("n", "<leader>t" .. i, function()
                        if terminals[i] then
                            terminals[i]:toggle()
                        else
                            vim.notify("No terminal #" .. i, vim.log.levels.WARN)
                        end
                    end, "Terminal: Toggle #" .. i)
                end

                -- ── global terminal-mode escape ─────────────────────────────────────────
                -- fallback for any toggleterm buffer not caught by on_open
                vim.api.nvim_create_autocmd("TermOpen", {
                    pattern = "term://*toggleterm#*",
                    callback = function(ev)
                        vim.keymap.set("t", "<End>", [[<C-\><C-n>]], { buffer = ev.buf, silent = true })
                    end,
                })
            end,
        },
    }
}
