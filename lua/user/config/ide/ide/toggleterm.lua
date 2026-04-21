vim.api.nvim_create_autocmd('TermOpen', {
    pattern = 'term://*',
    callback = function()
        local opts = { buffer = 0 }

        vim.keymap.set('t', '<S-Tab>', [[<C-\><C-n>]], opts)
        vim.keymap.set('t', '<M-q>', '<cmd>close<CR>', opts)

        vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
        vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
        vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
        vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
    end,
})

local term_buf = nil
local prev_buf = nil  -- track where to return to

local function toggle_terminal()
    if term_buf and vim.api.nvim_buf_is_valid(term_buf) then
        local cur = vim.api.nvim_get_current_buf()
        if cur == term_buf then
            -- We're on the terminal, go back
            if prev_buf and vim.api.nvim_buf_is_valid(prev_buf) then
                vim.cmd('buffer ' .. prev_buf)
            else
                vim.cmd('bprevious')
            end
            return
        end
        -- Switch to terminal
        prev_buf = cur
        vim.cmd('buffer ' .. term_buf)
        vim.cmd('startinsert')
        return
    end

    -- First time
    prev_buf = vim.api.nvim_get_current_buf()
    vim.cmd('terminal')
    term_buf = vim.api.nvim_get_current_buf()
    vim.cmd('startinsert')
end

vim.keymap.set('n', '<leader>to', toggle_terminal, { desc = 'Toggle terminal' })
