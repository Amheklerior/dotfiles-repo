local set = vim.opt

-- enable 24-bit RGB colors
set.termguicolors = true

-- sync clipboard between OS and Neovim
set.clipboard = 'unnamedplus'

-- highlight all matches on search pattern
set.hlsearch = true

-- make searches case-insensitive, unless there are capital letters in the search pattern
set.ignorecase = true
set.smartcase = true

-- show line numbers
set.number = true
set.relativenumber = true

-- convert tabs to spaces
set.expandtab = true

-- use 2-spaces tabs
set.tabstop = 2

-- number of spaces inserted for each indentation
set.shiftwidth = 2

-- don't wrap long lines
set.wrap = false

-- keep sign column by default
set.signcolumn = 'yes'

-- show which line your cursor is on
set.cursorline = false

-- minimal number of screen lines to keep around the cursor
set.scrolloff = 8
set.sidescrolloff = 8

-- preserve indentation when wrapping lines
set.breakindent = true

-- sets how neovim will display certain whitespace characters in the editor.
set.list = true
set.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- enforce new vertical splits to open to the right of the current window
set.splitright = true

-- enforce new horizontal splits to open below the current window
set.splitbelow = true

-- if performing an operation that would fail due to unsaved changes in the buffer (like `:q`),
-- instead raise a dialog asking if you wish to save the current file(s)
set.confirm = true

-- decrease update time
-- NOTE: it's the time nvim uses to trigger the 'CursorHold' autocommands, used by many plugins,
--  but also to write the swap file on disk.
--  Reducing it, inevitably increases the number of writes on disk (potentially degrading real perf),
--  but it improves "perceptual" performance since many plugins will feel more responsive.
-- ref: https://www.reddit.com/r/vim/comments/jqogan/how_does_a_lower_updatetime_lead_to_better/
set.updatetime = 300

-- decrease the time neovim waits for completing a mapped sequence
set.timeoutlen = 300

-- shows effect of commands (like sed for example) directly on the buffer
set.inccommand = 'nosplit'

-- save undo history
set.undofile = true

-- consider hiphen-separated tokens a single "word"
-- NOTE: normally, normal-word would be treated as three words: normal, -, word
--  with this option it will be considered as one
set.iskeyword:append '-'
