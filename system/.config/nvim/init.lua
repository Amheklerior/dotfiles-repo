
-- set <space> as the leader key
-- NOTE: Must happen before plugins are loaded
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- load configurations
require "amheklerior/options"
require "amheklerior/keymaps"

-- load the plugin manager and setup plugins
require "amheklerior/lazy"

