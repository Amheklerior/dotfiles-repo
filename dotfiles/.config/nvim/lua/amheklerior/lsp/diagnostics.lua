local M = {}

local severity = vim.diagnostic.severity

-- for info see `:help vim.diagnostic.Opts`
M.setup = function(map)
  vim.diagnostic.config {
    -- don't update messages with every keystroke (wait till the end of the edit)
    update_in_insert = false,

    -- show messages at the end of the line instead of underneath it
    virtual_text = true,
    virtual_lines = false,

    -- sort messages by severity
    seaverity_sort = true,

    -- underline error messages
    underline = { severity = severity.ERROR },

    -- don't auto open the floating window when jumping with `[d` and `]d`
    -- NOTE: you can open up the floating window with `:lua vim.diagnostic.open_float()`
    jump = { float = false },

    -- customize floating window
    float = { border = "rounded", source = "if_many" },

    -- use simbols instead of letters if a nerd font is available
    signs = vim.g.have_nerd_font and {
      text = {
        [severity.ERROR] = "✖︎ ",
        [severity.WARN] = "⚠︎ ",
        [severity.INFO] = "󰙎 ",
        [severity.HINT] = "󰌶 ",
      },
    } or {},
  }

  -- toggle diagnostics for this buffer
  map("<leader>td", function()
    vim.diagnostic.enable(not vim.diagnostic.is_enabled())
  end, "[T]oggle [D]iagnostics")

  -- open the diagnostic floating window to show the full message
  map("<leader>sd", function()
    vim.diagnostic.open_float()
  end, "[S]how [D]iagnostic floating panel")
end

return M
