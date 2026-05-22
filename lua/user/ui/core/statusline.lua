-- statusline.lua
-- Requires Nerd Font · Tuned for tokyonight.nvim
-- Fast: LSP cached, no repeated vim.diagnostic calls on every redraw tick

vim.o.showcmd   = false
vim.o.cmdheight = 1

-- ── Palette (tokyonight-night) ────────────────────────────────────────────────
local P = {
  bg      = "#16161e",
  bg_dark = "#13131a",
  fg      = "#a9b1d6",
  fg_dim  = "#565f89",
  blue    = "#7aa2f7",
  green   = "#9ece6a",
  purple  = "#bb9af7",
  red     = "#f7768e",
  yellow  = "#e0af68",
  cyan    = "#73daca",
  white   = "#c0caf5",
  dark1   = "#1a1b26",
  dark2   = "#1e2030",
}

-- ── Highlight groups ──────────────────────────────────────────────────────────
local function set_hls()
  local hls = {
    -- Mode pills
    StatusNormal     = { fg = P.dark1, bg = P.blue,   bold = true },
    StatusInsert     = { fg = P.dark1, bg = P.green,  bold = true },
    StatusVisual     = { fg = P.dark1, bg = P.purple, bold = true },
    StatusReplace    = { fg = P.dark1, bg = P.red,    bold = true },
    StatusCommand    = { fg = P.dark1, bg = P.yellow, bold = true },
    StatusOther      = { fg = P.dark1, bg = P.cyan,   bold = true },
    -- Powerline separators (pill → bar)
    StatusNormalSep  = { fg = P.blue,   bg = P.bg },
    StatusInsertSep  = { fg = P.green,  bg = P.bg },
    StatusVisualSep  = { fg = P.purple, bg = P.bg },
    StatusReplaceSep = { fg = P.red,    bg = P.bg },
    StatusCommandSep = { fg = P.yellow, bg = P.bg },
    StatusOtherSep   = { fg = P.cyan,   bg = P.bg },
    -- Bar chrome
    StatusBar        = { fg = P.fg,     bg = P.bg },
    StatusBarDim     = { fg = P.fg_dim, bg = P.bg },
    StatusFile       = { fg = P.white,  bg = P.bg,    bold = true },
    StatusModified   = { fg = P.yellow, bg = P.bg,    bold = true },
    StatusRO         = { fg = P.red,    bg = P.bg },
    -- Git
    StatusGit        = { fg = P.fg_dim, bg = P.bg },
    -- LSP & diagnostics
    StatusLSP        = { fg = P.blue,   bg = P.bg },
    StatusError      = { fg = P.red,    bg = P.bg,    bold = true },
    StatusWarn       = { fg = P.yellow, bg = P.bg,    bold = true },
    StatusInfo       = { fg = P.blue,   bg = P.bg },
    StatusHint       = { fg = P.cyan,   bg = P.bg },
    -- Right block
    StatusCoords     = { fg = P.white,  bg = P.dark2, bold = true },
    StatusCoordsSep  = { fg = P.dark2,  bg = P.bg },
    StatusPercent    = { fg = P.fg_dim, bg = P.bg },
  }
  for name, val in pairs(hls) do
    vim.api.nvim_set_hl(0, name, val)
  end
end

set_hls()
vim.api.nvim_create_autocmd("ColorScheme", { callback = set_hls })


-- ── LSP cache (refresh every ~2 s via timer, not every redraw) ───────────────
local _lsp_str   = ""
local _lsp_timer = nil

local function refresh_lsp()
  local clients = vim.lsp.get_clients({ bufnr = 0 })
  if #clients == 0 then
    _lsp_str = ""
    return
  end
  local names = {}
  for _, c in ipairs(clients) do
    -- skip null-ls / none-ls noise if you prefer cleaner display
    if c.name ~= "null-ls" and c.name ~= "none-ls" then
      table.insert(names, c.name)
    end
  end
  _lsp_str = #names > 0 and ("  " .. table.concat(names, " · ") .. " ") or ""
end

-- Refresh on LSP attach/detach events (accurate) + light periodic fallback
vim.api.nvim_create_autocmd({ "LspAttach", "LspDetach", "BufEnter" }, {
  callback = function()
    vim.defer_fn(refresh_lsp, 50)
  end,
})

-- ── Diagnostics ───────────────────────────────────────────────────────────────
-- Icons: error  warn  info  hint
local DIAG_ICONS = { " ", " ", " ", " " }
local DIAG_HLS   = { "Error", "Warn", "Info", "Hint" }

local function diagnostics_str()
  local counts = { 0, 0, 0, 0 }
  for _, d in ipairs(vim.diagnostic.get(0)) do
    local s = d.severity
    if s and counts[s] then counts[s] = counts[s] + 1 end
  end

  local parts = {}
  for i = 1, 4 do
    if counts[i] > 0 then
      parts[#parts + 1] = "%#Status" .. DIAG_HLS[i] .. "#" .. DIAG_ICONS[i] .. counts[i]
    end
  end
  if #parts == 0 then return "" end
  return " " .. table.concat(parts, "%#StatusBar# ") .. "%#StatusBar# "
end

-- ── Git branch (gitsigns stores head in b:gitsigns_status_dict.head) ──────────
local function git_branch()
  local ok, dict = pcall(vim.api.nvim_buf_get_var, 0, "gitsigns_status_dict")
  if not ok or type(dict) ~= "table" then return "" end
  local head = dict.head
  if not head or head == "" then return "" end
  return "  " .. head .. " "
end

-- ── Main statusline ───────────────────────────────────────────────────────────
function _G.Statusline()

  -- ── LEFT ─────────────────────────────────────────────────────────────────
  -- Mode pill + powerline arrow
  local left = "%#StatusFile# %t"   -- filename (tail)

  -- Modified / readonly flags
  if vim.bo.modified then
    left = left .. "%#StatusModified# ●"
  end
  if vim.bo.readonly then
    left = left .. "%#StatusRO# "
  end

  -- Git branch
  local branch = git_branch()
  if branch ~= "" then
    left = left .. "%#StatusGit#" .. branch
  end

  -- ── CENTRE (spacer) ───────────────────────────────────────────────────────
  local center = "%#StatusBar#%="

  -- ── RIGHT ─────────────────────────────────────────────────────────────────
  -- Diagnostics
  local diag = diagnostics_str()

  -- LSP name (cached)
  local lsp = _lsp_str ~= "" and ("%#StatusLSP#" .. _lsp_str) or ""

  -- Filetype
  local ft = vim.bo.filetype
  local ft_str = ft ~= "" and ("%#StatusBarDim# " .. ft .. " ") or ""

  -- Coords block with powerline reverse arrow
  local coords = "%#StatusCoordsSep#"
               .. "%#StatusCoords#  %l : %-3c"
               .. "%#StatusPercent#  %p%% "

  local right = diag .. lsp .. ft_str .. center .. coords

  return left .. center .. right
end

vim.o.statusline = "%!v:lua.Statusline()"
