local wk = require('which-key')

-- ============================================
-- SETUP
-- ============================================
wk.setup({
    preset = 'modern',
    delay = 200,
    modes = {
        n = true, -- Normal
        v = true, -- Visual
        o = true, -- Operator pending
        i = false, -- Insert (disabled)
        c = false, -- Command line (disabled)
    },
    win = {
        border = 'rounded',
        wo = { winblend = 0 },
    },
    icons = { mappings = false },
})

-- ============================================
-- GROUP DEFINITIONS (no-action keys)
-- ============================================
wk.add({
    -- Top-level groups
    { '<leader>b', group = '󰓩 Buffers' },
    { '<leader>c', group = ' Cargo' },
    { '<leader>d', group = '󰃤 Diagnostics' },
    { '<leader>f', group = '󰍉 FZF' },
    { '<leader>g', group = '󰊢 Git' },
    { '<leader>l', group = '󰒲 Lazy / LSP' },
    { '<leader>n', group = '󰵙 Notifications' },
    { '<leader>o', group = '󰇥 Yazi' },
    { '<leader>p', group = '󰅇 Paste' },
    { '<leader>q', group = '󰗼 Quit' },
    { '<leader>s', group = '󰆓 Sessions' },
    { '<leader>u', group = '󰔡 Toggles' },
    { '<leader>w', group = '󰆓 Save' },
    { '<leader>y', group = '󰅎 Yank' },
    { '<leader>z', group = '󱐋 Code Runner' },

    -- Sub-groups
    { '<leader>ll', group = '󰒲 Lazy' },
    { '<leader>ls', group = '󰒍 LSP Server' },
    { '<leader>qf', group = '󰗼 Force Quit' },
    { '<leader>wf', group = '󰆓 Force Save' },
})

-- ============================================
-- BUFFERS
-- ============================================
wk.add({
    { '<leader>bs', '<Cmd>w<CR>',       desc = 'Save Buffer' },
    { '<leader>bc', '<Cmd>%d<CR>',      desc = 'Clear Buffer' },
    { '<leader>bd', '<Cmd>bdelete<CR>', desc = 'Delete Buffer' },
    { '<leader>bn', '<Cmd>bnext<CR>',   desc = 'Next Buffer' },
    { '<leader>bp', '<Cmd>bprev<CR>',   desc = 'Prev Buffer' },
})

-- ============================================
-- GIT
-- ============================================
wk.add({
    { '<leader>gl', '<Cmd>LazyGit<CR>', desc = 'LazyGit' },
})

-- ============================================
-- NOTIFICATIONS
-- ============================================
wk.add({
    { '<leader>nh', '<Cmd>lua MiniNotify.show_history()<CR>', desc = 'History' },
    { '<leader>nr', '<Cmd>lua MiniNotify.refresh()<CR>',      desc = 'Refresh' },
    { '<leader>nd', '<Cmd>lua MiniNotify.clear()<CR>',        desc = 'Dismiss All' },
})

-- ============================================
-- QUIT
-- ============================================
wk.add({
    { '<leader>qq',  '<Cmd>q<CR>',   desc = 'Quit' },
    { '<leader>qfq', '<Cmd>q!<CR>',  desc = 'Force Quit' },
    { '<leader>qfa', '<Cmd>qa<CR>',  desc = 'Quit All' },
    { '<leader>qfw', '<Cmd>qa!<CR>', desc = 'Force Quit All' },
})

-- ============================================
-- TOGGLES
-- ============================================
wk.add({
    { '<leader>ui', '<Cmd>IBLToggle<CR>',           desc = 'Indent Lines' },
    { '<leader>un', '<Cmd>set number!<CR>',         desc = 'Line Numbers' },
    { '<leader>ur', '<Cmd>set relativenumber!<CR>', desc = 'Relative Numbers' },
    { '<leader>uw', '<Cmd>set wrap!<CR>',           desc = 'Word Wrap' },
    { '<leader>us', '<Cmd>set spell!<CR>',          desc = 'Spell Check' },
    { '<leader>ul', '<Cmd>set list!<CR>',           desc = 'List Chars' },
    { '<leader>uc', '<Cmd>set cursorline!<CR>',     desc = 'Cursor Line' },
    { '<leader>uh', '<Cmd>set hlsearch!<CR>',       desc = 'Highlight Search' },
})

-- ============================================
-- SAVE
-- ============================================
wk.add({
    { '<leader>ws',  '<Cmd>wall<CR>',   desc = 'Save All' },
    { '<leader>wq',  '<Cmd>wq<CR>',     desc = 'Save & Quit' },
    { '<leader>wfs', '<Cmd>w!<CR>',     desc = 'Force Save' },
    { '<leader>wfS', '<Cmd>wall!<CR>',  desc = 'Force Save All' },
    { '<leader>wfa', '<Cmd>wqall!<CR>', desc = 'Force Save & Quit All' },
})

-- ============================================
-- YANK
-- ============================================
wk.add({
    { '<leader>ya', '<Cmd>%y+<CR>',                    desc = 'Yank All' },
    { '<leader>yp', "<Cmd>let @+ = expand('%:p')<CR>", desc = 'Yank File Path' },
    { '<leader>yf', "<Cmd>let @+ = expand('%:t')<CR>", desc = 'Yank File Name' },
})

-- ============================================
-- LAZY
-- ============================================
wk.add({
    { '<leader>llp', '<Cmd>Lazy profile<CR>', desc = 'Profile' },
    { '<leader>llu', '<Cmd>Lazy update<CR>',  desc = 'Update' },
    { '<leader>lls', '<Cmd>Lazy sync<CR>',    desc = 'Sync' },
})

-- ============================================
-- LSP SERVER
-- ============================================
wk.add({
    { '<leader>lsi', '<Cmd>LspInfo<CR>',    desc = 'Info' },
    { '<leader>lsl', '<Cmd>LspLog<CR>',     desc = 'Log' },
    { '<leader>lsr', '<Cmd>LspRestart<CR>', desc = 'Restart' },
})

-- ============================================
-- VISUAL MODE
-- ============================================
wk.add({
    mode = { 'v', 'x' },
    { '<leader>r', group = '󰛔 Replace' },
    { '<leader>y', '"+y', desc = 'Yank to Clipboard' },
})

-- ============================================
-- KEYMAP CONFLICT CHECKER  (run :CheckKeymaps)
-- ============================================
local function check_leader_conflicts()
    local seen = {}
    local conflicts = {}

    for _, map in ipairs(vim.api.nvim_get_keymap('n')) do
        if map.lhs:match('^<leader>') then
            if seen[map.lhs] then
                table.insert(conflicts, string.format(
                    '  %-20s  %s  ←→  %s', map.lhs, seen[map.lhs], map.rhs or '?'
                ))
            else
                seen[map.lhs] = map.rhs or '?'
            end
        end
    end

    if #conflicts > 0 then
        vim.notify(
            '󰀪 Leader conflicts found:\n' .. table.concat(conflicts, '\n'),
            vim.log.levels.WARN,
            { title = 'Keymap Conflicts' }
        )
    else
        vim.notify('󰸞 No leader conflicts found', vim.log.levels.INFO, { title = 'Keymaps' })
    end
end

vim.api.nvim_create_user_command('CheckKeymaps', check_leader_conflicts, {
    desc = 'Check for leader keymap conflicts',
})
