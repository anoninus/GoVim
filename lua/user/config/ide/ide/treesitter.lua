require('nvim-treesitter').setup({
  install_dir = vim.fn.stdpath('data') .. '/site',
  indent = false,
})

-- Install parsers (run once or on demand)
require('nvim-treesitter').install({
  'lua',
  'vim',
  'rust',
  'toml',
  'json',
})

-- Enable Treesitter highlighting automatically
vim.api.nvim_create_autocmd('FileType', {
  callback = function(args)
    -- Start treesitter for this buffer
    pcall(vim.treesitter.start)
  end,
})
