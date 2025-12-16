-- Highlight, indent, fold, and navigate code
--
-- Treesitter privide a framework for building a syntax tree (AST)
--  from the source code, and run queries against it to gather info about the code.
--
-- Neovim already comes with a Treesitter "engine", so why this plugin?
--  This plugins is to download and manage all the different grammars and queries for
--  various languages (then used by the neovim's treesitter engine)
-- 
-- More on:
--    - https://tree-sitter.github.io/tree-sitter/index.html
--    - https://youtu.be/09-9LltqWLY?si=yfeIafm19E0WrGXX
--
return {
  -- install and manage language parsers and syntax queries
  {
    'nvim-treesitter/nvim-treesitter',
    enabled = true,
    -- make sure all parsers are updated to the latest version when updating the plugin
    build = ':TSUpdate',
    -- Sets main module to use for opts
    main = 'nvim-treesitter.configs',
    -- [[ Configure Treesitter ]] See `:help nvim-treesitter`
    opts = {
      -- list of language parsers. Can choose 'all' or 'maintained', instead of listing specific parsers
      ensure_installed = { 'bash', 'c', 'diff', 'html', 'lua', 'luadoc', 'markdown', 'markdown_inline', 'query', 'vim', 'vimdoc' },
      -- Autoinstall missing language parsers when entering a buffer
      auto_install = true,

      -- ↓↓↓ treesitter applications ↓↓↓
      highlight = {
        enable = true,
        -- Some languages depend on vim's regex highlighting system (such as Ruby) for indent rules.
        --  If you are experiencing weird indenting issues, add the language to
        --  the list of additional_vim_regex_highlighting and disabled languages for indent.
        additional_vim_regex_highlighting = { 'ruby' },
      },
      indent = {
        enable = true,
        disable = { 'ruby' }
      },
    },
    -- other interesting applications to explore:
    -- Treesitter + textobjects   -> https://github.com/nvim-treesitter/nvim-treesitter-textobjects
    -- Show your current context  -> https://github.com/nvim-treesitter/nvim-treesitter-context
    -- View and navigate the AST  -> https://github.com/nvim-treesitter/playground
    -- Rainbow brackets           -> https://github.com/p00f/nvim-ts-rainbow
    -- Code folding               -> https://github.com/nvim-treesitter/nvim-treesitter?tab=readme-ov-file#folding
    -- Incremental selection      -> :help nvim-treesitter-incremental-selection-mod`
  },
}
