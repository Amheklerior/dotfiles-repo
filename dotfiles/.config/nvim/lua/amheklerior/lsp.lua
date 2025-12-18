
-- TODO: add my custom keymaps

-- TODO: highlight all instances of the symbol under the cursor

-- TODO: integrate autocompletion


local setup_lsp_keymaps = function ()
  vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(event)
      local map = function(keys, func, desc, mode)
        mode = mode or 'n'
        vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
      end

      -- toggle inlay hints in your code (sometimes they get annoying)
      map('<leader>th', function()
        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
      end, '[T]oggle Inlay [H]ints')
    end,
  })
end

-- for info see `:help vim.diagnostic.Opts`
local setup_lsp_diagnostics = function ()
  local severity = vim.diagnostic.severity

  vim.diagnostic.config {
    severity_sort = true,
    float = { border = 'rounded', source = 'if_many' },
    underline = { severity = severity.ERROR },

    -- use simbols instead of letters if a nerf font is available
    signs = vim.g.have_nerd_font and {
      text = {
        [severity.ERROR] = '✖︎ ',
        [severity.WARN] = '⚠︎ ',
        [severity.INFO] = 'ℹ ',
        [severity.HINT] = '󰌶 ',
      },
    } or {},

    virtual_text = {
      source = 'if_many',
      spacing = 2,
      format = function(diagnostic)
        local diagnostic_message = {
          [severity.ERROR] = diagnostic.message,
          [severity.WARN] = diagnostic.message,
          [severity.INFO] = diagnostic.message,
          [severity.HINT] = diagnostic.message,
        }
        return diagnostic_message[diagnostic.severity]
      end,
    },
  }

end

setup_lsp_keymaps()
setup_lsp_diagnostics()
