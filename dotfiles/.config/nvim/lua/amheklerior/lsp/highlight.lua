-- INFO: highlight references of the word under the cursor when it rests there for a little while.
--  see `:help CursorHold` for information about when this is executed
--  when you move your cursor, the highlights will be cleared (the second autocommand).
local M = {}

-- define the group for the highlight feature
local highlight_augroup = vim.api.nvim_create_augroup('lsp-doc-highlight', { clear = false })

M.turn_on = function (evt)
  vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
    buffer = evt.buf,
    group = highlight_augroup,
    callback = vim.lsp.buf.document_highlight,
  })
  vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
    buffer = evt.buf,
    group = highlight_augroup,
    callback = vim.lsp.buf.clear_references,
  })
end

M.turn_off = function (evt)
  vim.lsp.buf.clear_references()
  vim.api.nvim_clear_autocmds({
    group = highlight_augroup,
    buffer = evt.buf
  })
end

M.setup = function (evt)
  M.turn_on(evt)
  vim.api.nvim_create_autocmd('LspDetach', {
    group = vim.api.nvim_create_augroup('lsp-detach', { clear = true }),
    callback = M.turn_off
  })
end

return M
