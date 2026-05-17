-- user/config/tools/lsp.lua

local float_opts = { border = 'rounded', max_width = 80, max_height = 20 }

-- Don't call capabilities.get() here — blink may not be loaded yet
-- Set handlers only, capabilities go on each server via capabilities.lua
vim.lsp.config('*', {
  handlers = {
    ['textDocument/hover']         = vim.lsp.with(vim.lsp.handlers.hover, float_opts),
    ['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.signature_help, float_opts),
  },
})

-- user/config/tools/lsp.lua
-- Set capabilities once on first attach, not at config time
vim.api.nvim_create_autocmd('LspAttach', {
  once = true,
  callback = function()
    local ok, blink = pcall(require, 'blink.cmp')
    if ok then
      vim.lsp.config('*', {
        capabilities = blink.get_lsp_capabilities(
          vim.lsp.protocol.make_client_capabilities()
        ),
      })
    end
  end,
})

vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', { clear = true }),
  callback = function(ev)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    if not client then return end

    if client.name == 'marksman' or client.name == 'gdscript' then
      client.server_capabilities.documentHighlightProvider = false
    end

    local opts = { buffer = ev.buf, silent = true }
    vim.keymap.set('n', 'K',      vim.lsp.buf.hover,          opts)
    vim.keymap.set('i', '<C-h>',  vim.lsp.buf.signature_help, opts)
  end,
})

vim.keymap.set('n', '<leader>ti', function()
  local buf = vim.api.nvim_get_current_buf()
  vim.lsp.inlay_hint.enable(
    not vim.lsp.inlay_hint.is_enabled({ bufnr = buf }),
    { bufnr = buf }
  )
end, { desc = 'Toggle Inlay Hints' })
