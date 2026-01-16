local lsp_highlight = require "amheklerior/lsp/highlight"
local lsp_keymaps = require "amheklerior/lsp/keymaps"
local lsp_diagnostics = require "amheklerior/lsp/diagnostics"
local format_on_save = require "amheklerior/lsp/format_on_save"

lsp_diagnostics.setup()

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
  callback = function(event)
    local map = function(keys, func, desc, mode)
      mode = mode or "n"
      vim.keymap.set(mode, keys, func, {
        buffer = event.buf,
        desc = "LSP: " .. desc,
      })
    end

    lsp_keymaps.setup(event, map)
    lsp_highlight.setup(event, map)
    format_on_save.setup(event)
  end,
})
