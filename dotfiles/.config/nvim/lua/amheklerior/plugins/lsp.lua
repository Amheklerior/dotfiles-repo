return {
  {
    -- automatically install and enable LSP servers
    "mason-org/mason-lspconfig.nvim",
    enabled = true,
    dependencies = {
      -- package manager for Neovim, to install and manage external editor tools
      --  like LSP servers, DAP servers, linters, and formatters.
      { "mason-org/mason.nvim", opts = {} },

      -- a collection of community curated LSP servers configurations
      -- NOTE: overrides are located into the `/after/lsp` directory
      "neovim/nvim-lspconfig",
    },
    opts = {
      -- automatically install these LSP servers
      -- NOTE: it understands server names as defined in nvim-lspconfig and figure out
      -- which Mason package needs to install
      ensure_installed = { 'lua_ls' },

      -- auto enable them (no need to call `vim.lsp.enable(...)` manually)
      automatic_enable = true,
    },
  },

  {
    -- configures Lua LSP for your Neovim config, runtime and plugins
    -- used for completion, annotations and signatures of Neovim apis
    'folke/lazydev.nvim',
    enabled = true,
    ft = 'lua',
    opts = {
      library = {
        -- load luvit types when the `vim.uv` word is found
        { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
      },
    },
  },

  -- TODO: consider adding: antosha417/nvim-lsp-file-operations
}
