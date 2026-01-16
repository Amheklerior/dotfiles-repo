-- highlight yanked (copied) text
vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight yanked (copied) text",
  group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})
