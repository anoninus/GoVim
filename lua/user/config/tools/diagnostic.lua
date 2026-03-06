local icons = {
    Error = "● ",
    Warn  = "● ",
    Hint  = "● ",
    Info  = "● ",
}

for type, icon in pairs(icons) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

vim.diagnostic.config({
  virtual_text = false,
  underline = true,
  update_in_insert = false,
  severity_sort = true,
  float = {
    focused = false,
    style = "minimal",
    border = "rounded",
    source = "always",
    header = "",
    prefix = function(diagnostic)
      local level = vim.diagnostic.severity[diagnostic.severity]
      return icons[level:sub(1,1) .. level:sub(2):lower()] or "", "Diagnostic" .. level
    end,
  },
})

vim.opt.updatetime = 100

-- Toggle state
local diagnostic_float_enabled = true

vim.api.nvim_create_autocmd("CursorHold", {
  buffer = bufnr,
  callback = function()
    if not diagnostic_float_enabled then return end
    local opts = {
      focusable = false,
      close_events = { "CursorMoved", "CursorMovedI", "BufLeave", "InsertEnter" },
    }
    vim.diagnostic.open_float(nil, opts)
  end,
})

-- Toggle keymap: <leader>dt  (diagnostic toggle)
vim.keymap.set("n", "gl", function()
  diagnostic_float_enabled = not diagnostic_float_enabled
  vim.notify(
    "Diagnostic float " .. (diagnostic_float_enabled and "enabled" or "disabled"),
    vim.log.levels.INFO
  )
end, { desc = "Toggle diagnostic float popup" })
