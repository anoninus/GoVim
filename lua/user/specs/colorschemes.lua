-- ===========================
-- Colorschemes (all lazy loaded)
-- ===========================
return {
  {
    'folke/tokyonight.nvim',
    lazy = false,    -- important for colorschemes
    priority = 1000, -- ensure it loads first

    opts = {
      styles = {
        comments  = { italic = false },
        keywords  = { italic = false },
        functions = { italic = false },
        variables = { italic = false },
      },
      sidebars = 'dark',
      floats = 'dark',
    },
  },
  {
    'catppuccin/nvim',
    name     = 'catppuccin',
    lazy     = false,
    priority = 1000,
    opts = {
      flavour = 'mocha', -- dark options: latte (light), frappe, macchiato, mocha
      no_italic = true,  -- matches your no-italic preference above
      no_bold   = false,
      integrations = {
        cmp        = true,
        gitsigns   = true,
        nvimtree   = true,
        treesitter = true,
        telescope  = { enabled = true },
      },
    },
  },
}
