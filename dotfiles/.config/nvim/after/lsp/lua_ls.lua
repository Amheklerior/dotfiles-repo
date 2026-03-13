-- custom Lua language server configuration, to avoid the annoying
--  diagnostic warnings about missing `vim` global.
-- NOTE: this replaces the folke/lazydev.nvim plugin, which wasn't working
--  on my setup for some reason.
-- see: https://github.com/nvim-lua/kickstart.nvim/commit/0c17d320bb70b8e0a59608747508f102b1e41173
return {
  on_init = function(client)
    if client.workspace_folders then
      local path = client.workspace_folders[1].name
      if
          path ~= vim.fn.stdpath "config" and
          (vim.uv.fs_stat(path .. "/.luarc.json") or
            vim.uv.fs_stat(path .. "/.luarc.jsonc"))
      then
        return
      end
    end

    client.config.settings.Lua = vim.tbl_deep_extend("force", client.config.settings.Lua, {
      runtime = { version = "LuaJIT" },
      diagnostics = { globals = { "vim" } },
      workspace = {
        checkThirdParty = false,

        -- NOTE: this is a lot slower and will cause issues when working on your own configuration.
        -- See https://github.com/neovim/nvim-lspconfig/issues/3189
        -- library = vim.list_extend(vim.api.nvim_get_runtime_file("", true), {
        --   "${3rd}/luv/library",
        -- }),

        library = {
          vim.env.VIMRUNTIME,
          '${3rd}/luv/library',
        },
      },
    })
  end,
  settings = { Lua = {} },
}
