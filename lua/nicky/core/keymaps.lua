-- reused keymap options
local default_opts = { noremap = true, silent = true }
local function map(mode, lhs, rhs, extra_opts)
	extra_opts = extra_opts or {}
	local merged_opts = vim.tbl_deep_extend("force", default_opts, extra_opts)
	vim.keymap.set(mode, lhs, rhs, merged_opts)
end

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- Set <space> as the leader key
-- See `:help mapleader`
-- NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
map("", "<Space>", "<Nop>")
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- return to normal mode the homerow way
map("i", "ht", "<ESC>")
-- return to normal mode the primeagen way
map("i", "<C-c>", "<ESC>")

-- clear search highlights
map("n", "<leader>h", "<cmd>nohlseach<CR>", { desc = "No [h]ighlights" })

-- Easier reach to beginning and end of lines
map("n", "H", "^", { desc = "Move to beginning of text on current line" })
map({ "n", "v" }, "L", "g_", { desc = "Move to end of text on current line" })

-- window navigation
map("n", "<C-h>", "<C-w>h")
map("n", "<C-j>", "<C-w>j")
map("n", "<C-k>", "<C-w>k")
map("n", "<C-l>", "<C-w>l")

-- window resizing
map("n", "<C-Up>", "<cmd>resize -2<CR>")
map("n", "<C-Down>", "<cmd>resize +2<CR>")
map("n", "<C-Left>", "<cmd>vertical resize -2<CR>")
map("n", "<C-Right>", "<cmd>vertical resize +2<CR>")

-- misc window manipulation
map("n", "<leader>wv", "<C-w>v", { desc = "Split [w]indow [v]ertically" })
map("n", "<leader>wh", "<C-w>s", { desc = "Split [w]indow [h]orizontally" })
map("n", "<leader>wH", "<C-w>H", { desc = "Move [w]indow to the far left [H]" })
map("n", "<leader>wL", "<C-w>L", { desc = "Move [w]indow to the Far right [L]" })
map("n", "<leader>wJ", "<C-w>J", { desc = "Move [w]indow to the very bottom [J]" })
map("n", "<leader>wK", "<C-w>K", { desc = "Move [w]indow to the very top [K]" })
map("n", "<leader>w=", "<C-w>=", { desc = "Make [w]indows same width & height [=]" })
map("n", "<leader>wc", "<C-w>c", { desc = "[w]indow [c]lose" })
map("n", "<leader>wr", "<C-w>r", { desc = "[w]indow [r]otate downwards" })

-- take highlighted code for a ride
map("v", "J", ":move '>+1<CR>gv=gv")
map("v", "K", ":move '<-2<CR>gv=gv")

-- stay in indent mode
map("v", "<", "<gv")
map("v", ">", ">gv")

-- do not place the target of the x command in a register
map("n", "x", '"_x')

-- allow pasting over something without copying the text that was just pasted over
map("v", "p", "P")

-- yank and paste to/from the system clipboard
-- I'm keeping the system clipboard separate from the vim clipboard on purpose
-- you often see vim.opt.clipboard = "unnamedplus", but I don't want to do that
map({ "n", "v" }, "<leader>y", [["+y]], { desc = "[y]ank into OS clipboard" })
map({ "n", "v" }, "<leader>p", [["+p]], { desc = "[p]aste from OS clipboard" })
map("n", "<leader>Y", [["+Y]], { desc = "[Y]ank line into OS clipboard" })
map({ "i", "c" }, "<C-v>", "<C-r>+", { desc = "Paste from OS clipboard" })
-- i_<C-v> was remapped, use i_<C-q>, it's identical

-- Open file explorer on current file
map("n", "<leader>e", "<cmd>Neotree filesystem toggle reveal right<CR>", { desc = "File [e]xplorer" })

-- Diagnostic keymaps
-- some of these are overwritten by lsp-specific keybinds when an lsp loads
map("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous [d]iagnostic message" })
map("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next [d]iagnostic message" })
map("n", "<leader>d", vim.diagnostic.open_float, { desc = "Open floating [d]iagnostic message" })
-- Add buffer diagnostics to the location list.
map("n", "<leader>q", vim.diagnostic.setloclist, { desc = "[q] Open diagnostics location list" })
map("n", "<leader>sd", "<cmd>Telescope diagnostics<CR>", { desc = "[s]earch [d]iagnostics" })

-- Telescope: see `:help telescope.builtin`
-- adapted from https://github.com/nvim-lua/kickstart.nvim/blob/0470d07c8c44f270bd64d0d11f5ebb8d994a1c00/init.lua#L268-L284
map("n", "<leader>?", "<cmd>Telescope oldfiles<CR>", { desc = "[?] Find recently opened files" })
map("n", "<leader><space>", "<cmd>Telescope buffers<CR>", { desc = "[ ] Find existing buffers" })
map("n", "<leader>/", "<cmd>Telescope current_buffer_fuzzy_find<CR>", { desc = "[/] Fuzzily search in current buffer" })
-- find files within current working directory, respects .gitignore
map("n", "<leader>sf", "<cmd>Telescope find_files<CR>", { desc = "[s]earch [f]iles" })
map("n", "<leader>sh", "<cmd>Telescope help_tags<CR>", { desc = "[s]earch [h]elp" })
-- find string under cursor in current working directory
map("n", "<leader>sw", "<cmd>Telescope grep_string<CR>", { desc = "[s]earch current [w]ord" })
-- find string in current working directory as you type
map("n", "<leader>sg", "<cmd>Telescope live_grep<CR>", { desc = "[s]earch by [g]rep" })

-- Lspsaga keybinds that don't need an lsp attached --
-- Terminals do not understand <C-`> so I'm using <C-t> for now. TODO: learn tmux or something
map({ "n", "t" }, "<C-t>", "<cmd>Lspsaga term_toggle<CR>", {
	desc = "Toggle floating [t]erminal",
})

-- barbar.nvim buffer navigation
map("n", "<A-l>", "<cmd>BufferNext<CR>")
map("n", "<A-h>", "<cmd>BufferPrevious<CR>")
map("n", "<A-c>", "<cmd>BufferClose<CR>")
map("n", "<A-S-c>", "<cmd>BufferRestore<CR>")
map("n", "<leader>c", "<cmd>BufferCloseAllButPinned<CR>", { desc = "[c]lose All Buffers" })
map("n", "<C-p>", "<cmd>BufferPick<CR>")
-- Goto buffer in position...
map("n", "<A-1>", "<Cmd>BufferGoto 1<CR>")
map("n", "<A-2>", "<Cmd>BufferGoto 2<CR>")
map("n", "<A-3>", "<Cmd>BufferGoto 3<CR>")
map("n", "<A-4>", "<Cmd>BufferGoto 4<CR>")
map("n", "<A-5>", "<Cmd>BufferGoto 5<CR>")
map("n", "<A-6>", "<Cmd>BufferGoto 6<CR>")
map("n", "<A-7>", "<Cmd>BufferGoto 7<CR>")
map("n", "<A-8>", "<Cmd>BufferGoto 8<CR>")
map("n", "<A-9>", "<Cmd>BufferGoto 9<CR>")
map("n", "<A-0>", "<Cmd>BufferLast<CR>")

-- git related
map("n", "<leader>gf", "<cmd>Telescope git_files<CR>", { desc = "Search [g]it [f]iles" })
map("n", "<leader>gc", "<cmd>Telescope git_commits<CR>", { desc = "List all [g]it [c]ommits (<CR> to checkout)" })
map(
	"n",
	"<leader>gn",
	"<cmd>Telescope git_bcommits<CR>",
	{ desc = "List [g]it commits for file/buffer that is active [n]ow (<CR> to checkout)" }
)
map("n", "<leader>gb", "<cmd>Telescope git_branches<CR>", { desc = "List [g]it [b]ranches (<CR> to checkout)" })
map(
	"n",
	"<leader>gs",
	"<cmd>Telescope git_status<CR>",
	{ desc = "List [g]it current change[s] per file with diff preview" }
)
map("n", "<leader>ge", "<cmd>Neotree git_status toggle right<CR>", { desc = "[g]it status [e]xplorer" })

-- because I'm used to it
map("n", "<C-s>", "<cmd>w<CR>", { desc = "[s]ave buffer" })
