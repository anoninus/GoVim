vim.diagnostic.config({
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = "●",
      [vim.diagnostic.severity.WARN]  = "●",
      [vim.diagnostic.severity.INFO]  = "●",
      [vim.diagnostic.severity.HINT]  = "●",
    },
  },
  virtual_text = false,
  underline = false,
  update_in_insert = false,
  severity_sort = true,
  float = {
    focusable = false,
    style = "minimal",
    border = "rounded",
    source = "always",
    header = "",
    prefix = "",
  },
})

vim.opt.updatetime = 100

-- Returns true if any floating window with a known LSP/hover filetype is visible
local function lsp_hover_visible()
  for _, winid in ipairs(vim.api.nvim_list_wins()) do
    if vim.api.nvim_win_get_config(winid).relative ~= "" then
      local buf = vim.api.nvim_win_get_buf(winid)
      local ft = vim.bo[buf].filetype
      -- markdown is what nvim-lspconfig hover windows use
      if ft == "markdown" then
        return true
      end
    end
  end
  return false
end

local diagnostic_float_enabled = false

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local bufnr = args.buf

    vim.api.nvim_create_autocmd("CursorHold", {
      buffer = bufnr,
      callback = function()
        if not diagnostic_float_enabled then return end
        if lsp_hover_visible() then return end

        vim.diagnostic.open_float(nil, {
          focusable = false,
          close_events = { "CursorMoved", "CursorMovedI", "BufLeave", "InsertEnter" },
        })
      end,
    })
  end,
})

vim.keymap.set("n", "H", function()
  diagnostic_float_enabled = not diagnostic_float_enabled
  vim.notify(
    "Diagnostic float " .. (diagnostic_float_enabled and "enabled" or "disabled"),
    vim.log.levels.INFO
  )
end, { desc = "Toggle diagnostic float popup" })
