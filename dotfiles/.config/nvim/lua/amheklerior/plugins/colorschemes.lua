
-- Here you can find every color palette plugin currently installed

-- NOTE: make sure to add the following spec props to the color plugin actually used:
--  lazy = false
--  priority = 1000

-- NOTE: within the main plugin dir ($XDG_DATA_HOME/nvim/lazy), prepend all downloaded
--  colorscheme's plugins with the following prefix.
local prefix = "colorscheme."

return {
  {
    "ellisonleao/gruvbox.nvim",
    enabled = true,
    name = prefix .. "gruvbox",
    -- make sure this plugin gets eagerly loaded at startup (since it's the one actually used)
    lazy = false,
    -- make sure it gets loaded with the highest priority (before any otehr startup plugin)
    priority = 1000,
    -- configure and set it up as the default palette
    opts = { contrast = "dark" },
    init = function()
      vim.o.background = "dark"
      vim.cmd.colorscheme "gruvbox"
    end,
  },

  { "folke/tokyonight.nvim", enabled = true, name = prefix .. "tokyonight" },
  { "catppuccin/nvim", enabled = true, name = prefix .. "catppuccin" },
}
