-- use :help <setting_name> for more info than the short comments here

-- Shorten variable
local opt = vim.opt

-- Line numbers
opt.number = true -- set numbered lines
opt.relativenumber = true -- relative numbers
opt.numberwidth = 4 -- minimal number of columns to use for the line number

-- Tabs & Indentation
opt.tabstop = 2 -- insert spaces for a tab
opt.softtabstop = 2 -- tabs and spaces can be used together seamlessly
opt.shiftwidth = 2 -- the number of spaces inserted for each indentation
opt.expandtab = true -- expand tabs to spaces
opt.autoindent = true -- copy indent from current line when starting new one
opt.smartindent = true -- make indenting smarter

-- Searching
opt.hlsearch = true -- highlight all matches of previous search
-- to turn off highlights again, run :noh
opt.ignorecase = true -- ignore case in search patterns
opt.smartcase = true -- if you include mixed case in your search, assumes you want case-sensitive
opt.incsearch = true -- incrementally highilight matches

-- Ensure space remains at sides when scrolling
opt.scrolloff = 8 -- minimal number of  lines to keep above and below the cursor
opt.sidescrolloff = 8 -- minimal number of screen columns to keep to the left and right of the cursor if wrap is `false`

-- Misc look and feel
opt.termguicolors = true -- set term gui colors (most terminals support this)
opt.signcolumn = "yes" -- always show the sign column (the gutter left of line numbers)
opt.guifont = "monospace:h17" -- the font used in graphical neovim applications
opt.cursorline = true -- highlight the current line
opt.list = true -- show nomally invisible characters
opt.listchars:append({ -- override default characters
	eol = "↵",
	space = "·",
	trail = "·",
})

-- Split window
opt.splitbelow = true -- force all horizontal splits to go below current window
opt.splitright = true -- force all vertical splits to go to the right of current window

-- Update time & timeout
opt.timeout = true -- time out if keys from a combo are not pressed in time
opt.timeoutlen = 1000 -- time to wait for a mapped sequence to complete (in milliseconds)
opt.updatetime = 400 -- faster completion (4000ms default)

-- Misc (aka I didn't know where to put these)
opt.wrap = false -- turn off automatic line wrapping
opt.fileencoding = "utf-8" -- the encoding written to a file
opt.cmdheight = 1 -- space in the neovim command line for displaying messages
opt.backup = false -- creates a backup file
opt.mouse = "a" -- allow the mouse to be used
opt.showcmd = true -- show current command in the last line of the screen
opt.undofile = true -- enable persistent undo
opt.backspace = "indent,eol,start" -- allow backspace where it would not be by default
opt.iskeyword:append("-") -- treats words with `-` as single words
opt.linebreak = true -- line break on words instead of in the middle of a word
opt.conceallevel = 0 -- do not conceal anything (so that `` is visible in markdown files)
opt.swapfile = false -- creates a swapfile
opt.shortmess:append("c") -- hide all the completion messages, e.g. "-- XXX completion (YYY)", "match 1 of 2", "The only match", "Pattern not found"
opt.whichwrap:append("<,>,[,],h,l") -- keys allowed to move to the previous/next line when the beginning/end of line is reached
opt.formatoptions:remove({ "c", "r", "o" }) -- prevent automatic formatting of a new line when pressing o on a comment line in normal mode, enter in insert

-- lualine shows current mode
opt.showmode = false

-- luasnip
opt.completeopt = "menu,menuone,noselect" -- autocompletion dropdown behaviour
