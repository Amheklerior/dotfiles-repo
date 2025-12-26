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
        "lua_ls",
        "stylua",

        -- TODO: add language servers, formatters, and linters
      },
    },
  },

  {
    -- a bridge between mason-org/mason and nvim-lspconfig plugins
    "mason-org/mason-lspconfig.nvim",
    enable = false,
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
    -- configures Lua LSP for your Neovim config, runtime and plugins
    -- used for completion, annotations and signatures of Neovim apis
    "folke/lazydev.nvim",
    enabled = true,
    ft = "lua",
    opts = {
      library = {
        -- load luvit types when the `vim.uv` word is found
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
      },
    },
  },

  -- TODO: consider adding: antosha417/nvim-lsp-file-operations
  -- TODO: consider adding: j-hui/fidget.nvim
}
