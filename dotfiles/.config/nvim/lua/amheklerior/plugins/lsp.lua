return {
  -- automatically install and enable LSP servers,
  "mason-org/mason-lspconfig.nvim",
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
}
