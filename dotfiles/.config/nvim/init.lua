-- set <space> as the leader key
-- NOTE: Must happen before plugins are loaded, otherwhise
--  they'll be configured with the wrong leader-key
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- set this global variable to easily enable/disable settings
--  which requires a nerd font to be installed
vim.g.have_nerd_font = true

-- load the plugin manager and setup plugins
require "amheklerior/lazy"

-- load configurations
require "amheklerior/options"
require "amheklerior/keymaps"
require "amheklerior/autocmd"
require "amheklerior/lsp"
