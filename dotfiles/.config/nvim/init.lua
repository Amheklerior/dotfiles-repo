
-- set <space> as the leader key
-- NOTE: Must happen before plugins are loaded, otherwhise
--  they'll be configured with the wrong leader-key
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- load configurations
require "amheklerior/options"
require "amheklerior/keymaps"
require "amheklerior/autocmd"

-- load the plugin manager and setup plugins
require "amheklerior/lazy"
