
local M = {}

M.setup = function (evt, map)
  -- restart the attached LSP server
  map('<leader>rs', ':LspRestart<CR>', '[R]estart LSP [S]erver')

  -- toggle inlay hints in the code (sometimes they get annoying)
  map('<leader>th', function()
    vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = evt.buf })
  end, '[T]oggle Inlay [H]ints')

  -- show docs for the symbol under the cursor
  map('K', vim.lsp.buf.hover, 'Show Documentation')

  -- rename the symbol under the cursor
  map('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')

  -- execute a code action, usually the cursor needs to be on top of an error
  -- or a suggestion from the LSP for this to activate
  map('<leader>ca', vim.lsp.buf.code_action, 'Show [C]ode [A]ction', { 'n', 'x' })

  -- find references for the symbol under the cursor
  map('<leader>gr', vim.lsp.buf.references, '[G]oto [R]eferences')

  -- jump to the implementation of the symbol under the cursor,
  --  useful when your language has ways of declaring types without an actual implementation.
  map('<leader>gi', vim.lsp.buf.implementation, '[G]oto [I]mplementation')

  -- jump to the definition of the symbol under the cursor.
  --  this is where a variable was first declared, or where a function is defined, etc.
  map('<leader>gd', vim.lsp.buf.definition, '[G]oto [D]efinition')

  -- jump to the declaration of the word under the cursor.
  -- WARN: this is not Goto Definition, this is Goto Declaration.
  --  for ex. in C this would take you to the header.
  map('<leader>gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

  -- find all the symbols in your current document.
  map('<leader>ds', vim.lsp.buf.document_symbol, 'Open [D]ocument [S]ymbols')

  -- find all the symbols in the current workspace.
  --  similar to document symbols, except searches over your entire project.
  map('<leader>ws', vim.lsp.buf.workspace_symbol, 'Open [W]orkspace [S]ymbols')

  -- jump to the type of the symbol under the cursor.
  map('<leader>gt', vim.lsp.buf.type_definition, '[G]oto [T]ype Definition')

end

return M
