-- ===========================
-- File Exploration & Navigation
-- ===========================
return {
  {
    'stevearc/oil.nvim',
    commit = '975a77c',
    dependencies = { 'echasnovski/mini.icons' },
    lazy = true,
  },
  {
    'ibhagwan/fzf-lua',
    commit = '518ab7a',
    lazy = true,
  },
  {
    'ggandor/leap.nvim',
    commit = 'f19d435',
  },
  {
    'mikavilpas/yazi.nvim',
    commit = '5634692',
    event = 'VeryLazy',
    keys = {
      {
        '<leader>yod',
        '<cmd>Yazi<cr>',
        desc = 'Open cwd',
      },
      {
        '<leader>yoc',
        function()
          require('yazi').yazi(nil, vim.fn.stdpath('config'))
        end,
        desc = 'Open runtime',
      },
      {
        '<leader>you',
        function()
          require('yazi').yazi(nil, vim.fn.stdpath('config') .. '/lua/user/')
        end,
        desc = 'Open user/',
      },
    },
    opts = {
      open_for_directories = false, -- Keep oil as default
      keymaps = {
        show_help = '<f1>',
        '<leader>yoh',
        open_file_in_vertical_split = '<c-v>',
        open_file_in_horizontal_split = '<c-x>',
        open_file_in_tab = '<c-t>',
        grep_in_directory = '<c-g>',
        replace_in_directory = '<c-r>',
        cycle_open_buffers = '<tab>',
        copy_relative_path_to_selected_files = '<c-y>',
        send_to_quickfix_list = '<c-q>',
      },
    },
  },
  {
    'kdheepak/lazygit.nvim',
    commit = 'a04ad0d',
    lazy = false,
    cmd = {
      'LazyGit',
      'LazyGitConfig',
      'LazyGitCurrentFile',
      'LazyGitFilter',
      'LazyGitFilterCurrentFile',
    },
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
  },
}
