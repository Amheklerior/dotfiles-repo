
-- NOTE: <cmd> is more performant and avids unnecessary redraw, compared to using `:`
--  However, <cmd> can create issues for keymaps in visual modes ('v' or 'x') because
--  <cmd> clears the selection before executing the command. This means that if the command
--  need to run on the selection or the selection must be preserved after command execution,
--  <cmd> cannot be used and `:` should be used insted.

-- NOTE: ALT cannot be used for keymaps, because on MacOS ALT is the Option key (⌥),
--  The ⌥ key breaks <A-*> keymaps because it often sends special characters by default
--  instead of acting as a Meta/Alt modifier (unless the terminal is set to send Escape + key

local kmap = vim.keymap.set

-- clear highlights on search when pressing <Esc> in normal mode
kmap("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- don't replace yanked content when pasting over a selection
kmap("v", "p", '"_dP')

-- open the file explorer as a column to the left
-- NOTE: 20 is the percentage of the screen the column will occupy
kmap("n", "<leader>e", "<cmd>Lex 20<CR>", { desc = "Open the file [E]xplorer to the left" })

-- utilities to quickly test lua code
kmap("n", "<leader><leader>x", "<cmd>source %<CR><cmd>echo \"executed file\"<CR>", { desc = "E[X]ecute current file (Lua)" })
kmap("n", "<leader>x", "<cmd>.lua<CR><cmd>echo \"executed line\"<CR>", { desc = "E[X]ecute current line (Lua)" })
kmap("v", "<leader>x", ":lua<CR><cmd>echo \"executed block selection\"<CR>", { desc = "E[X]ecute selected block (Lua)" })

-- disable arrow keys in normal mode, to force using hjkl keys instead
kmap("n", "<left>", '<cmd>echo "Use h to move left!"<CR>')
kmap("n", "<right>", '<cmd>echo "Use l to move right!"<CR>')
kmap("n", "<up>", '<cmd>echo "Use k to move up!"<CR>')
kmap("n", "<down>", '<cmd>echo "Use j to move down!"<CR>')

-- make split navigation easier
-- use SHIFT+<hjkl> to switch between windows
kmap("n", "<S-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
kmap("n", "<S-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
kmap("n", "<S-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
kmap("n", "<S-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })
-- NOTE: some terminals have colliding keymaps or are not able to send distinct keycodes
-- vim.keymap.set("n", "<C-S-h>", "<C-w>H", { desc = "Move window to the left" })
-- vim.keymap.set("n", "<C-S-l>", "<C-w>L", { desc = "Move window to the right" })
-- vim.keymap.set("n", "<C-S-j>", "<C-w>J", { desc = "Move window to the lower" })
-- vim.keymap.set("n", "<C-S-k>", "<C-w>K", { desc = "Move window to the upper" })

-- use CTRL+SHIFT+<arrow-keys> to resize the current window
-- NOTE: CTRL alone conflicts with OS shortcuts
kmap("n", "<C-S-left>", "<cmd>vertical resize -2<CR>", { desc = "Make current window narrower" })
kmap("n", "<C-S-right>", "<cmd>vertical resize +2<CR>", { desc = "Make current window wider" })
kmap("n", "<C-S-up>", "<cmd>resize -2<CR>", { desc = "Make current window shorter" })
kmap("n", "<C-S-down>", "<cmd>resize +2<CR>", { desc = "Make current window taller" })

-- use SHIFT+<hjkl> to move selected text
kmap("v", "<S-h>", "<gv", { desc = "Indent left" })
kmap("v", "<S-l>", ">gv", { desc = "Indent right" })
kmap("v", "<S-k>", ":move '<-2<CR>gv=gv", { desc = "Move selected lines up" })
kmap("v", "<S-j>", ":move '>+1<CR>gv=gv", { desc = "Move selected lines down" })

