
return {
  -- package manager for Neovim, to install and manage external editor tools
  --  like LSP servers, DAP servers, linters, and formatters.
  --
  -- INFO: to check the current status of installed tools and/or manually install others,
  -- you can run `:Mason`
  { "mason-org/mason.nvim", opts = {} },

  -- a collection of community curated LSP servers configurations
  -- NOTE: overrides are located into the `/after/lsp` directory
  "neovim/nvim-lspconfig",
}
