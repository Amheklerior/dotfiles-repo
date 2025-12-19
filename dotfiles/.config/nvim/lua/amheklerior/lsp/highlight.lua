-- INFO: highlight references of the word under the cursor when it rests there for a little while.
--  see `:help CursorHold` for information about when this is executed
--  when you move your cursor, the highlights will be cleared (the second autocommand).
local M = {}

-- define the group for the highlight feature
local highlight_augroup = vim.api.nvim_create_augroup('lsp-doc-highlight', { clear = false })

-- keep track whether the highlighting is currently enabled or not
local hl_enabled = false

M.turn_on = function (evt)
  hl_enabled = true
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
  hl_enabled = false
  vim.lsp.buf.clear_references()
  vim.api.nvim_clear_autocmds({
    group = highlight_augroup,
    buffer = evt.buf
  })
end

local toggle = function (evt)
  if hl_enabled then
    M.turn_off(evt)
  else
    M.turn_on(evt)
  end
end

M.setup = function (evt, keymapFn)
  -- turn refs highlight by default
  M.turn_on(evt)
  vim.api.nvim_create_autocmd('LspDetach', {
    group = vim.api.nvim_create_augroup('lsp-detach', { clear = true }),
    callback = M.turn_off
  })

  -- provide a keymap to easily toggle LSP references highlighting
  keymapFn('<leader>hl', function()
    toggle(evt)
  end, 'Toggle Reference [H]igh[L]ight')
end

return M
