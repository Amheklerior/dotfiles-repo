
-- configure Lua LSP server
vim.lsp.config("lua-server", {
  -- the executable installed through Mason,
  -- to let vim LSP client know how to run the server
  cmd = { 'lua-language-server' },

  -- attach this LSP server when opening a lua file
  filetypes = { 'lua' },
  root_markers = {
    '.luarc.json',
    '.luarc.jsonc',
    '.luacheckrc',
    '.stylua.toml',
    'stylua.toml',
    'selene.toml',
    'selene.yml',
    '.git',
  },
})

-- enable the LSP
vim.lsp.enable("lua-server");
