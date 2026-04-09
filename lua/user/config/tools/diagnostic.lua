vim.diagnostic.config({
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = "●",
      [vim.diagnostic.severity.WARN]  = "●",
      [vim.diagnostic.severity.INFO]  = "●",
      [vim.diagnostic.severity.HINT]  = "●",
    },
  },
})
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
  },
})

vim.opt.updatetime = 100

-- Toggle state
local diagnostic_float_enabled = true
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local bufnr = args.buf

    vim.api.nvim_create_autocmd("CursorHold", {
      buffer = bufnr,
      callback = function()
        if not diagnostic_float_enabled then return end

        vim.diagnostic.open_float(nil, {
          focusable = false,
          close_events = { "CursorMoved", "CursorMovedI", "BufLeave", "InsertEnter" },
        })
      end,
    })
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
