local M = {}

-- NOTE: The LSP formatter and the editor might apply different styling rules
--  (ex. a different tab-width). To make sure Neovim and the LSP (an external process)
--  use the same settings I can use an `.editorconfig` file (https://editorconfig.org/)

M.setup = function(evt)
  local client = vim.lsp.get_client_by_id(evt.data.client_id)

  -- do nothing if the LSP client is not found or it doesn't support formatting
  if not client then
    vim.notify "format on save: no lsp client found!"
    return
  end
  ---@diagnostic disable-next-line: missing-parameter, param-type-mismatch
  if not client:supports_method('textDocument/formatting') then
    vim.notify "format on save: lsp doesn't support formatting!"
    return
  end

  -- setup an autocommand to format the current buffer on save
  vim.api.nvim_create_autocmd('BufWritePre', {
    buffer = evt.buf,
    callback = function()
      vim.lsp.buf.format { bufnr = evt.buf, id = client.id }
    end,
  })
end

return M
