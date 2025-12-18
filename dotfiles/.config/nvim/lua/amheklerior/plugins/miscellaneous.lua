
return {
  {
    -- highlight todo, notes, etc in comments
    'folke/todo-comments.nvim',
    enabled = true,
    event = 'VimEnter',
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = { signs = false }
  }
}
