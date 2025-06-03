print "hello baby"

--[[ useful keymaps to avoid restarting neovim only to test lua code ]]

-- execute the current file
vim.keymap.set("n", "<space><space>x", "<cmd>source %<CR>")

-- execute the current line
vim.keymap.set("n", "<space>x", ":.lua<CR>")

-- execute the selected code
vim.keymap.set("v", "<space>x", ":lua<CR>")

