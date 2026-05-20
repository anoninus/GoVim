-- statusline.lua
-- Requires Nerd Font. Tuned for tokyonight.nvim.

vim.o.showcmdloc = "statusline"
vim.o.cmdheight  = 1

-- ── Highlight groups (tokyonight palette) ────────────────────────────────────
local function set_hls()
  local hls = {
    -- Mode pills
    StatusNormal  = { fg = "#1a1b26", bg = "#7aa2f7", bold = true },
    StatusInsert  = { fg = "#1a1b26", bg = "#9ece6a", bold = true },
    StatusVisual  = { fg = "#1a1b26", bg = "#bb9af7", bold = true },
    StatusReplace = { fg = "#1a1b26", bg = "#f7768e", bold = true },
    StatusCommand = { fg = "#1a1b26", bg = "#e0af68", bold = true },
    StatusOther   = { fg = "#1a1b26", bg = "#73daca", bold = true },
    -- Surrounding powerline separators (same bg as pill → bar bg)
    StatusNormalSep  = { fg = "#7aa2f7", bg = "#16161e" },
    StatusInsertSep  = { fg = "#9ece6a", bg = "#16161e" },
    StatusVisualSep  = { fg = "#bb9af7", bg = "#16161e" },
    StatusReplaceSep = { fg = "#f7768e", bg = "#16161e" },
    StatusCommandSep = { fg = "#e0af68", bg = "#16161e" },
    StatusOtherSep   = { fg = "#73daca", bg = "#16161e" },
    -- Bar chrome
    StatusBar     = { fg = "#a9b1d6", bg = "#16161e" },
    StatusBarDim  = { fg = "#565f89", bg = "#16161e" },
    StatusFile    = { fg = "#c0caf5", bg = "#16161e", bold = true },
    StatusModified= { fg = "#e0af68", bg = "#16161e", bold = true },
    StatusRO      = { fg = "#f7768e", bg = "#16161e" },
    -- LSP & diagnostics
    StatusLSP     = { fg = "#7aa2f7", bg = "#16161e" },
    StatusError   = { fg = "#f7768e", bg = "#16161e", bold = true },
    StatusWarn    = { fg = "#e0af68", bg = "#16161e", bold = true },
    StatusInfo    = { fg = "#7aa2f7", bg = "#16161e" },
    StatusHint    = { fg = "#1abc9c", bg = "#16161e" },
    -- Right side
    StatusCoords  = { fg = "#c0caf5", bg = "#1e2030", bold = true },
    StatusCoordsSep = { fg = "#1e2030", bg = "#16161e" },
    StatusPercent = { fg = "#565f89", bg = "#16161e" },
    StatusShowCmd = { fg = "#e0af68", bg = "#16161e" },
  }
  for name, val in pairs(hls) do
    vim.api.nvim_set_hl(0, name, val)
  end
end

set_hls()

-- Re-apply after colorscheme changes so we always win
vim.api.nvim_create_autocmd("ColorScheme", {
  callback = set_hls,
})

-- ── Helpers ──────────────────────────────────────────────────────────────────
local mode_map = {
  n      = { label = "NORMAL",  hl = "Normal"  },
  no     = { label = "N·OP",    hl = "Normal"  },
  nov    = { label = "N·OP",    hl = "Normal"  },
  niI    = { label = "NORMAL",  hl = "Normal"  },
  niR    = { label = "NORMAL",  hl = "Normal"  },
  niV    = { label = "NORMAL",  hl = "Normal"  },
  i      = { label = "INSERT",  hl = "Insert"  },
  ic     = { label = "INSERT",  hl = "Insert"  },
  ix     = { label = "INSERT",  hl = "Insert"  },
  R      = { label = "REPLACE", hl = "Replace" },
  Rc     = { label = "REPLACE", hl = "Replace" },
  Rx     = { label = "REPLACE", hl = "Replace" },
  Rv     = { label = "V·RPLC",  hl = "Replace" },
  v      = { label = "VISUAL",  hl = "Visual"  },
  V      = { label = "V·LINE",  hl = "Visual"  },
  [""] = { label = "V·BLOCK", hl = "Visual"  },
  s      = { label = "SELECT",  hl = "Visual"  },
  S      = { label = "S·LINE",  hl = "Visual"  },
  [""] = { label = "S·BLOCK", hl = "Visual"  },
  c      = { label = "COMMAND", hl = "Command" },
  cv     = { label = "EX",      hl = "Command" },
  ce     = { label = "EX",      hl = "Command" },
  r      = { label = "PROMPT",  hl = "Other"   },
  rm     = { label = "MORE",    hl = "Other"   },
  ["r?"] = { label = "CONFIRM", hl = "Other"   },
  ["!"]  = { label = "SHELL",   hl = "Other"   },
  t      = { label = "TERM",    hl = "Insert"  },
}

local function hl(name)
  return "%#Status" .. name .. "#"
end

local function mode_info()
  local m = vim.fn.mode(1)
  return mode_map[m] or { label = m, hl = "Other" }
end

local function lsp_clients()
  local clients = vim.lsp.get_clients({ bufnr = 0 })
  if #clients == 0 then return nil end
  local names = {}
  for _, c in ipairs(clients) do
    table.insert(names, c.name)
  end
  return table.concat(names, " · ")
end

local diag_icons = { " ", " ", " ", " " } -- error warn info hint (Nerd Font)

local function diagnostics()
  local counts = { 0, 0, 0, 0 }
  for _, item in ipairs(vim.diagnostic.get(0)) do
    counts[item.severity] = counts[item.severity] + 1
  end
  local hls   = { "Error", "Warn", "Info", "Hint" }
  local parts = {}
  for i = 1, 4 do
    if counts[i] > 0 then
      table.insert(parts, hl(hls[i]) .. diag_icons[i] .. counts[i])
    end
  end
  return parts -- array; empty = no diagnostics
end

-- ── Main statusline ───────────────────────────────────────────────────────────
function _G.Statusline()
  local mi   = mode_info()
  local mhl  = mi.hl      -- e.g. "Normal"

  -- Powerline separator glyphs
  local sep_r = ""  -- solid right arrow (U+E0B0)
  local sep_l = ""  -- solid left  arrow (U+E0B2)

  -- ── LEFT ─────────────────────────────────────────────────────────────────
  -- Mode pill
  local s = hl(mhl) .. "  " .. mi.label .. " "
          .. hl(mhl .. "Sep") .. sep_r

  -- File path (icon + name)
  s = s .. hl("File") .. "  %t "

  -- Modified / RO flags
  s = s .. "%{&modified ? '" .. hl("Modified") .. " ● ' : ''}"
  s = s .. "%{&readonly  ? '" .. hl("RO")       .. "  ' : ''}"

  -- Git branch (if fugitive / gitsigns exposes b:gitsigns_head)
  s = s .. hl("BarDim") .. "%{get(b:,'gitsigns_head','') != '' "
         .. "? '  ' .. get(b:,'gitsigns_head','') .. ' ' : ''}"

  -- ── MIDDLE ───────────────────────────────────────────────────────────────
  s = s .. hl("Bar") .. "%="

  -- showcmd (pending operator / selection size)
  s = s .. hl("ShowCmd") .. "%S "

  -- Diagnostics
  local diag_parts = diagnostics()
  if #diag_parts > 0 then
    s = s .. hl("Bar") .. " "
    s = s .. table.concat(diag_parts, hl("Bar") .. "  ")
    s = s .. hl("Bar") .. " "
  end

  -- LSP clients
  local lsp = lsp_clients()
  if lsp then
    s = s .. hl("LSP") .. "  " .. lsp .. " "
  end

  s = s .. hl("Bar") .. "%="

  -- ── RIGHT ────────────────────────────────────────────────────────────────
  -- Filetype
  s = s .. hl("BarDim") .. "%{&filetype != '' ? &filetype .. ' ' : ''}"

  -- Coords block
  s = s .. hl("CoordsSep") .. sep_l
  s = s .. hl("Coords") .. "  %l : %c "

  -- Percent
  s = s .. hl("BarDim") .. " %p%% "

  return s
end

vim.o.statusline = "%!v:lua.Statusline()"
