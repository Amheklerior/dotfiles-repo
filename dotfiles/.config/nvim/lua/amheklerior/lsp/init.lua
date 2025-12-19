local lsp_highlight = require "amheklerior/lsp/highlight"
local lsp_navigation_keymaps = require "amheklerior/lsp/keymaps"
local lsp_diagnostics = require "amheklerior/lsp/diagnostics"

lsp_diagnostics.setup()

vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('lsp-attach', { clear = true }),
  callback = function(event)
    local map = function(keys, func, desc, mode)
      mode = mode or 'n'
      vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
    end

    -- toggle inlay hints in your code (sometimes they get annoying)
    map('<leader>th', function()
      vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
    end, '[T]oggle Inlay [H]ints')

    lsp_navigation_keymaps.setup(event, map)
    lsp_highlight.setup(event, map)
  end
})
