-- Important: lazy_load to prevent unnecessary startup time
local blink_capabilities = require('blink.cmp').get_lsp_capabilities()

blink_capabilities.textDocument.completion.completionItem = {
  snippetSupport          = true,
  insertReplaceSupport    = true,
  labelDetailsSupport     = true,
  commitCharactersSupport = true,
  deprecatedSupport       = true,
  preselectSupport        = true,
  documentationFormat     = { 'markdown', 'plaintext' },
  resolveSupport = {
    properties = { 'documentation', 'detail', 'additionalTextEdits' },
  },
}

blink_capabilities.workspace = blink_capabilities.workspace or {}
blink_capabilities.workspace.didChangeWatchedFiles = {
  dynamicRegistration    = true,
  relativePatternSupport = true,
}

_G.blink_capabilities = blink_capabilities

vim.defer_fn(function()
  require('luasnip.loaders.from_vscode').lazy_load()
end, 100)

-- Floating window defaults (hover, signature help, diagnostics)
-- vim.lsp.config is the 0.11+ way; open_floating_preview override no longer needed
local float_opts = {
  border     = "rounded",
  max_width  = 80,
  max_height = 20,
}

vim.lsp.config('*', {
  capabilities = blink_capabilities,
})

-- Override hover and signature_help handlers with border opts
-- (still valid in 0.11, vim.lsp.with is not deprecated)
vim.lsp.handlers["textDocument/hover"] =
  vim.lsp.with(vim.lsp.handlers.hover, float_opts)

vim.lsp.handlers["textDocument/signatureHelp"] =
  vim.lsp.with(vim.lsp.handlers.signature_help, float_opts)

-- Single consolidated LspAttach
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', { clear = true }),
  callback = function(ev)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    if not client then return end

    -- Suppress documentHighlight for servers that don't support it cleanly
    if client.name == "marksman" or client.name == "gdscript" then
      client.server_capabilities.documentHighlightProvider = false
    end

    local opts = { buffer = ev.buf, silent = true }
    vim.keymap.set('n', 'K',      vim.lsp.buf.hover,           opts)
    vim.keymap.set('i', '<C-h>',  vim.lsp.buf.signature_help,  opts)
  end,
})

-- Inlay hint toggle — 0.11+ requires buf arg for is_enabled()
vim.keymap.set("n", "<leader>ti", function()
  local buf     = vim.api.nvim_get_current_buf()
  local enabled = vim.lsp.inlay_hint.is_enabled({ bufnr = buf })
  vim.lsp.inlay_hint.enable(not enabled, { bufnr = buf })
end, { desc = "Toggle Inlay Hints" })
