local runner_buf = nil
local prev_buf   = nil

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

    prev_buf = vim.api.nvim_get_current_buf()

    -- Kill old runner buffer
    if runner_buf and vim.api.nvim_buf_is_valid(runner_buf) then
        vim.api.nvim_buf_delete(runner_buf, { force = true })
    end

    vim.cmd('terminal')
    runner_buf = vim.api.nvim_get_current_buf()

    vim.defer_fn(function()
        local chan = vim.bo[runner_buf].channel
        if chan and chan > 0 then
            vim.fn.chansend(chan, 'cd ' .. vim.fn.shellescape(file_dir) .. '\n')
            vim.fn.chansend(chan, 'clear\n')
            vim.fn.chansend(chan, cmd .. '\n')
        end
    end, 80)
end

local function toggle_runner()
    if not (runner_buf and vim.api.nvim_buf_is_valid(runner_buf)) then
        vim.notify('No runner session yet. Use <leader>zz first.', vim.log.levels.INFO)
        return
    end

    local cur = vim.api.nvim_get_current_buf()
    if cur == runner_buf then
        if prev_buf and vim.api.nvim_buf_is_valid(prev_buf) then
            vim.cmd('buffer ' .. prev_buf)
        else
            vim.cmd('bprevious')
        end
    else
        prev_buf = cur
        vim.cmd('buffer ' .. runner_buf)
        vim.cmd('startinsert')
    end
end

vim.keymap.set('n', '<leader>zz', run_code,      { silent = true, desc = 'Run code' })
vim.keymap.set('n', '<leader>xz', toggle_runner, { silent = true, desc = 'Toggle code runner' })
