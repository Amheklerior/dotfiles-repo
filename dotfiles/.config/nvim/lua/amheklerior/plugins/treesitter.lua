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

-- TODO: other interesting applications to explore:
-- Treesitter + textobjects   -> https://github.com/nvim-treesitter/nvim-treesitter-textobjects
-- Show your current context  -> https://github.com/nvim-treesitter/nvim-treesitter-context
-- Rainbow brackets           -> https://github.com/p00f/nvim-ts-rainbow
-- Incremental selection      -> :help nvim-treesitter-incremental-selection-mod`

return {
  {
    -- NOTE: After the rewrite, this plugin no longer provides features like autoinstalling parsers, or enabling
    --  functionalities like syntax highlighting, folding, indentation, or incremental code selection.
    "nvim-treesitter/nvim-treesitter",
    -- make sure it doesn't get lazly loaded, as the new rewrite doesn't support it
    lazy = false,
    -- make sure all parsers are updated to the latest version when updating the plugin
    build = ":TSUpdate",
    -- manually enable treesitter functionalities for specifies filetypes
    config = function()
      local filetypes = {
        "bash",
        "c",
        "diff",
        "html",
        "json",
        "ledger",
        "lua",
        "luadoc",
        "markdown",
        "markdown_inline",
        "query",
        "toml",
        "vim",
        "vimdoc",
      }

      -- autoisntall language parsers
      -- replicate `ensure_installed`, runs asynchronously, skips existing languages
      -- INFO: parsers and queries will be installed into the $XDG_DATA_HOME/nvim/site directory
      -- WARN: requires `tree-sitter-cli` to be installed on your system
      require("nvim-treesitter").install(filetypes)

      -- enable syntax highlighting
      -- replicate `highlight = { enable = true }`
      vim.api.nvim_create_autocmd("FileType", {
        pattern = filetypes,
        callback = function()
          -- debug print
          vim.notify("starting treesitter parser for: " .. vim.bo.filetype)
          vim.treesitter.start()
        end,
      })
    end,
  },
}
