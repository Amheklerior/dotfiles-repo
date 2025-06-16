
-- set the installation path for the Lazy plugin manager to $XDG_DATA_HOME/nvim/lazy/lazy.nvim
-- NOTE: $XDG_DATA_HOME/nvim/ dir is where all plugins will be installed
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'

-- install Lazy, if not already installed
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then
    error('Error cloning lazy.nvim:\n' .. out)
  end
end

-- add lazy installation dir to the runtime path for neovim
vim.opt.runtimepath:prepend(lazypath)

-- setup lazy.nvim
-- NOTE: you can find the full list of all the config options
--  at https://lazy.folke.io/configuration
require('lazy').setup({
  -- install and setup plugins from the plugins directory
  -- NOTE: plugins will be installed in the $XDG_DATA_HOME/nvim/lazy/ dir
  spec = {
    { import = "amheklerior.plugins" },
  },

  -- automatically check for plugin updates
  checker = { enabled = true },

})

