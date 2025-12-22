local M = {}

local severity = vim.diagnostic.severity

-- for info see `:help vim.diagnostic.Opts`
M.setup = function ()
  vim.diagnostic.config {
    severity_sort = true,
    float = { border = 'rounded', source = 'if_many' },
    underline = { severity = severity.ERROR },

    -- use simbols instead of letters if a nerf font is available
    signs = vim.g.have_nerd_font and {
      text = {
        [severity.ERROR] = '✖︎ ',
        [severity.WARN] = '⚠︎ ',
        [severity.INFO] = '󰙎 ',
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

return M
