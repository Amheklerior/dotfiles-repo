-- Anything regarding LSP, formatting, and linting
return {

  {
    -- a helper to automatically install LSP servers, formatters, etc
    "WhoIsSethDaniel/mason-tool-installer",
    dependencies = {
      -- the core package manager for Neovim, to install and manage
      --  external editor tools like LSP servers, DAP servers, linters, and formatters.
      -- NOTE: plugin must be immediately loaded (`opts = {}`)
      { "mason-org/mason.nvim", opts = {} },

      -- in order to use lspconfig names (example: "lua_ls" instead of "lua-language-server")
      "mason-org/mason-lspconfig.nvim",
    },
    opts = {
      ensure_installed = {
        -- lua development
        "lua_ls",
        "stylua",
        -- "luacheck", TODO: need to solve the undefined-vars warnings first

        -- markdown files
        "markdownlint",

        -- json files
        "jsonlint",

        -- zsh/bash scripting
        "bashls",
        "shfmt",
        "shellcheck",
      },
    },
  },

  {
    -- a bridge between mason-org/mason and nvim-lspconfig plugins
    "mason-org/mason-lspconfig.nvim",
    dependencies = {
      { "mason-org/mason.nvim", opts = {} },

      -- a collection of community curated LSP servers configurations
      -- INFO: overrides are located into the `/after/lsp` directory
      "neovim/nvim-lspconfig",
    },
    opts = {
      -- explicitly set to an empty table since installation is
      --  handled by mason-tool-installer
      ensure_installed = {},

      -- auto enable them (no need to call `vim.lsp.enable(...)` manually)
      automatic_enable = true,
    },
  },

  {
    -- linting
    "mfussenegger/nvim-lint",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      local lint = require "lint"

      -- set the linters to be used by filetype
      lint.linters_by_ft = {
        markdown = { "markdownlint" },
        json = { "jsonlint" },
        zsh = { "shellcheck" },
      }

      -- Create autocommand which carries out the actual linting on the specified events.
      -- NOTE: can add "InsertLeave" event for a more aggressive linting
      local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })
      vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost" }, {
        group = lint_augroup,
        callback = function()
          -- Only run the linter in buffers that you can modify in order to
          -- avoid superfluous noise, notably within the handy LSP pop-ups that
          -- describe the hovered symbol using Markdown.
          if vim.bo.modifiable then
            lint.try_lint()
          end
        end,
      })
    end,
  },

  -- TODO: consider adding: antosha417/nvim-lsp-file-operations
  -- TODO: consider adding: j-hui/fidget.nvim
}
