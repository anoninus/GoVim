vim.opt.shortmess:append('I')  -- skip intro
vim.opt.shortmess:append('W')  -- skip warnings
vim.notify = function(msg, level)
    if level == vim.log.levels.ERROR then return end
    -- or filter specific messages
    if msg:find('Spawning language server') then return end
    if msg:find('deprecated') then return end
end
-- require("user.sys.profiler") -- Precedence = #1 (for profiling)
require('user.sys.options') -- Precedence = #2
-- =========================================================
-- 1. Safe require helper
-- =========================================================
local function safe_require(module)
    local ok, result = pcall(require, module)
    if not ok then
        vim.notify(
            'Failed to load: ' .. module .. '\n' .. tostring(result),
            vim.log.levels.ERROR,
            { title = 'Module Load Error' }
        )
        return nil
    end
    return result
end

-- =========================================================
-- 2. Auto-discover and load stages in numerical order
-- =========================================================
local function load_stages()
    local stages_path = vim.fn.stdpath('config') .. '/lua/user/stages'
    local files = vim.fn.readdir(stages_path)

    -- Filter for .lua files and sort them numerically
    local lua_files = {}
    for _, file in ipairs(files) do
        if file:match('%.lua$') then
            table.insert(lua_files, file)
        end
    end

    -- Sort numerically by extracting leading numbers
    table.sort(lua_files, function(a, b)
        local num_a = tonumber(a:match('^(%d+)'))
        local num_b = tonumber(b:match('^(%d+)'))
        if num_a and num_b then
            return num_a < num_b
        end
        return a < b -- Fallback to alphabetical
    end)

    -- Load each stage in order
    for _, file in ipairs(lua_files) do
        local module_name = file:gsub('%.lua$', '')
        local stage_module = 'user.stages.' .. module_name
        safe_require(stage_module)
    end
end

load_stages()
-- =========================================================
-- 3. Post-init
-- =========================================================
-- ===========================
-- Colorscheme Cycler
-- ===========================
local schemes = { 'tokyonight-moon', 'catppuccin-latte' }
local state_file = vim.fn.stdpath('data') .. '/colorscheme.txt'

-- Load saved scheme or fall back to first
local function load_saved()
  local f = io.open(state_file, 'r')
  if f then
    local saved = f:read('*l')
    f:close()
    -- validate it's one of our schemes
    for _, name in ipairs(schemes) do
      if name == saved then return saved end
    end
  end
  return schemes[1]
end

local function save_scheme(name)
  local f = io.open(state_file, 'w')
  if f then f:write(name) f:close() end
end

local function cycle_colorscheme()
  local current = vim.g.colors_name
  -- find exact match in our list
  for i, name in ipairs(schemes) do
    if name == current then
      local next = schemes[(i % #schemes) + 1]
      vim.cmd.colorscheme(next)
      save_scheme(next)
      vim.notify('colorscheme → ' .. next, vim.log.levels.INFO)
      return
    end
  end
  -- current theme is outside our list — jump to first
  vim.cmd.colorscheme(schemes[1])
  save_scheme(schemes[1])
  vim.notify('colorscheme → ' .. schemes[1], vim.log.levels.INFO)
end

-- Apply persisted scheme on startup
vim.cmd.colorscheme(load_saved())

vim.keymap.set('n', '<leader>C', cycle_colorscheme, { desc = 'Cycle colorscheme' })

-- ===========================
-- Float, Border & Separator Highlights
-- ===========================
-- Derives colors from the active theme rather than hardcoding them.
-- Works with any colorscheme automatically.

local function set_ui_highlights()
  -- Helper: safely pull a highlight group's attributes
  local function hl(group)
    return vim.api.nvim_get_hl(0, { name = group, link = false })
  end

  -- Helper: convert decimal color to hex string
  local function to_hex(dec)
    if not dec then return nil end
    return string.format('#%06x', dec)
  end

  -- -------------------------------------------------------
  -- Derive a border accent color from the theme itself.
  -- Priority: Special > Function > Statement > Keyword > fg
  -- -------------------------------------------------------
  local accent_sources = {
    'Special', 'Function', 'Statement', 'Keyword', '@function', 'Title',
  }
  local accent_fg = nil
  for _, group in ipairs(accent_sources) do
    local h = hl(group)
    if h.fg then
      accent_fg = to_hex(h.fg)
      break
    end
  end

  -- -------------------------------------------------------
  -- Derive float background: prefer NormalFloat, else Normal
  -- but slightly offset it so it's distinct from the editor
  -- -------------------------------------------------------
  local float_bg = to_hex(hl('NormalFloat').bg)
                or to_hex(hl('Normal').bg)
                or (vim.o.background == 'dark' and '#1e1e2e' or '#eff1f5')

  -- Derive float foreground
  local float_fg = to_hex(hl('NormalFloat').fg)
                or to_hex(hl('Normal').fg)

  -- -------------------------------------------------------
  -- Title: use accent color as bg, pick contrasting fg
  -- -------------------------------------------------------
  -- Determine if accent is dark or light to pick readable title text
  local title_fg
  if accent_fg then
    -- Parse hex to luminance check
    local r = tonumber(accent_fg:sub(2,3), 16) or 128
    local g = tonumber(accent_fg:sub(4,5), 16) or 128
    local b = tonumber(accent_fg:sub(6,7), 16) or 128
    local luminance = (0.299 * r + 0.587 * g + 0.114 * b)
    title_fg = luminance > 140 and '#1e1e2e' or '#ffffff'
  else
    title_fg = vim.o.background == 'dark' and '#1e1e2e' or '#ffffff'
  end

  -- -------------------------------------------------------
  -- Apply
  -- -------------------------------------------------------
  vim.api.nvim_set_hl(0, 'NormalFloat',  { fg = float_fg,  bg = float_bg })
  vim.api.nvim_set_hl(0, 'FloatBorder',  { fg = accent_fg, bg = float_bg, bold = true })
  vim.api.nvim_set_hl(0, 'FloatTitle',   { fg = title_fg,  bg = accent_fg, bold = true })
  vim.api.nvim_set_hl(0, 'WinSeparator', { fg = accent_fg, bold = true })
end

-- Apply on startup
set_ui_highlights()

-- Re-apply after every colorscheme change
vim.api.nvim_create_autocmd('ColorScheme', {
  pattern  = '*',
  callback = set_ui_highlights,
  desc     = 'Re-derive float/border/separator highlights from active theme',
})
