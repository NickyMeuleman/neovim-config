-- shorten function name
local keymap = vim.keymap
-- reused keymap options
local opts = { noremap = true, silent = true }

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
keymap.set("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- return to normal mode the homerow way
keymap.set("i", "ht", "<ESC>", opts)
-- return to normal mode the primeagen way
keymap.set("i", "<C-c>", "<ESC>", opts)

-- clear search highlights
keymap.set("n", "<leader>nh", ":nohl<CR>")

-- window navigation
keymap.set("n", "<C-h>", "<C-w>h", opts)
keymap.set("n", "<C-j>", "<C-w>j", opts)
keymap.set("n", "<C-k>", "<C-w>k", opts)
-- HELP: moving right doesn't work
-- screen flashes, how to turn off screen refresh
-- :map <c-l> outputs n <C-L>   * <C-W>l
keymap.set("n", "<C-l>", "<C-w>l", opts)

-- window resizing
keymap.set("n", "<C-Up>", ":resize -2<CR>", opts)
keymap.set("n", "<C-Down>", ":resize +2<CR>", opts)
keymap.set("n", "<C-Left>", ":vertical resize -2<CR>", opts)
keymap.set("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- buffer navigation
keymap.set("n", "<S-l>", ":bnext<CR>", opts)
keymap.set("n", "<S-h>", ":bprevious<CR>", opts)

-- take highlighted code for a ride
keymap.set("v", "J", ":m '>+1<cr>gv=gv")
keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- stay in indent mode
keymap.set("v", "<", "<gv", opts)
keymap.set("v", ">", ">gv", opts)

-- allow pasting over something without copying the text that was just pasted over
keymap.set("v", "p", '"_dP', opts)

-- yank and paste to/from the system clipboard
-- I'm keeping the system clipboard seperate from the vim clipboard on purpose
-- you often see vim.opt.clipboard = "unnamedplus", but I don't want to do that
keymap.set({"n", "v"}, "<leader>y", [["+y]], opts)
keymap.set({"n", "v"}, "<leader>p", [["+p]], opts)
keymap.set("n", "<leader>Y", [["+Y]], opts)

-- Open file explorer on current file
keymap.set("n", "<leader>e", ":NvimTreeFindFileToggle<CR>", opts)
