local split_height = 15
local term = nil  -- will hold the Terminal object

local function get_run_cmd()
    local ft        = vim.bo.filetype
    local file_dir  = vim.fn.expand('%:p:h')
    local file_name = vim.fn.expand('%:t')
    local root      = vim.fn.expand('%:t:r')

    local cmds = {
        rust       = 'cargo run',
        go         = 'go run .',
        python     = 'python3 '  .. file_name,
        lua        = 'lua '      .. file_name,
        javascript = 'node '     .. file_name,
        typescript = 'ts-node '  .. file_name,
        ruby       = 'ruby '     .. file_name,
        php        = 'php '      .. file_name,
        bash       = 'bash '     .. file_name,
        sh         = 'bash '     .. file_name,
        zig        = 'zig build-exe ' .. file_name,
        c          = 'gcc '  .. file_name .. ' -o ' .. root .. ' && ./' .. root,
        cpp        = 'g++ '  .. file_name .. ' -o ' .. root .. ' && ./' .. root,
        java       = 'javac ' .. file_name .. ' && java ' .. root,
    }

    local cmd = cmds[ft]
    if not cmd then
        vim.notify('No runner for filetype: ' .. ft, vim.log.levels.WARN)
        return nil, nil
    end

    return file_dir, cmd
end

local function run_code()
    local file_dir, cmd = get_run_cmd()
    if not cmd then return end

    local Terminal = require('toggleterm.terminal').Terminal

    -- Always create a fresh terminal so the command re-runs cleanly
    if term then
        term:shutdown()
    end

    term = Terminal:new({
        cmd        = 'cd ' .. vim.fn.shellescape(file_dir) .. ' && ' .. cmd,
        direction  = 'horizontal',
        size       = split_height,
        close_on_exit = false,   -- keep output visible after process exits
        auto_scroll   = true,
        on_open = function(t)
            vim.wo[t.window].number         = false
            vim.wo[t.window].relativenumber = false
            vim.wo[t.window].signcolumn     = 'no'
        end,
    })

    term:open()
end

local function toggle_runner()
    if not term then
        vim.notify('No runner session yet. Use <leader>zz first.', vim.log.levels.INFO)
        return
    end
    term:toggle(split_height, 'horizontal')
end

-- Resize keymaps
vim.keymap.set('n', '<C-Up>', function()
    if term and term.window and vim.api.nvim_win_is_valid(term.window) then
        split_height = split_height + 2
        vim.api.nvim_win_set_height(term.window, split_height)
    end
end, { silent = true, desc = 'Runner: increase height' })

vim.keymap.set('n', '<C-Down>', function()
    if term and term.window and vim.api.nvim_win_is_valid(term.window) then
        split_height = math.max(5, split_height - 2)
        vim.api.nvim_win_set_height(term.window, split_height)
    end
end, { silent = true, desc = 'Runner: decrease height' })

vim.keymap.set('n', '<leader>zz', run_code,      { silent = true, desc = 'Run code' })
vim.keymap.set('n', '<leader>zx', toggle_runner, { silent = true, desc = 'Toggle code runner' })
