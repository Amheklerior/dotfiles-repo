-- enable language servers for the Neovim LSP client
--
-- INFO: default configurations are provided by the `neovim/nvim-lsconfig` plugin
-- so, no need to define them by hand every time you want to enable a new LSP server.
vim.lsp.enable("lua_ls");
