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
-- This does't work in Windows terminal (eventhough I remapped it there to do nothing)
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
keymap.set({ "n", "v" }, "<leader>y", [["+y]], opts)
keymap.set({ "n", "v" }, "<leader>p", [["+p]], opts)
keymap.set("n", "<leader>Y", [["+Y]], opts)
keymap.set({ "i", "c" }, "<C-v>", "<C-r>+", opts)
-- use <c-r> to insert original character without triggering things like auto-pairs
keymap.set("i", "<C-r>", "<C-v>", opts)

-- Diagnostic keymaps
-- some of these are overwritten by lsp-specific keybinds when an lsp loads
keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic message" })
keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next diagnostic message" })
keymap.set("n", "<leader>d", vim.diagnostic.open_float, { desc = "Open floating diagnostic message" })
-- Add buffer diagnostics to the location list.
keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostics list" })

-- Open file explorer on current file
keymap.set("n", "<leader>e", ":Neotree filesystem toggle reveal right<CR>", opts)

-- Telescope --
-- See `:help telescope.builtin`
-- adapted from https://github.com/nvim-lua/kickstart.nvim/blob/0470d07c8c44f270bd64d0d11f5ebb8d994a1c00/init.lua#L268-L284
keymap.set("n", "<leader>?", "<cmd>Telescope oldfiles<cr>", { desc = "[?] Find recently opened files" })
-- list open buffers in current neovim instance
keymap.set("n", "<leader><space>", "<cmd>Telescope buffers<cr>", { desc = "[ ] Find existing buffers" })
keymap.set("n", "<leader>/", function()
	-- You can pass additional configuration to telescope to change theme, layout, etc.
	require("telescope.builtin").current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
		winblend = 10,
		previewer = false,
	}))
end, { desc = "[/] Fuzzily search in current buffer" })
keymap.set("n", "<leader>gf", "<cmd>Telescope git_files<cr>", { desc = "Search [G]it [F]iles" })
-- find files within current working directory, respects .gitignore
keymap.set("n", "<leader>sf", "<cmd>Telescope find_files<cr>", { desc = "[S]earch [F]iles" })
-- list available help tags
keymap.set("n", "<leader>sh", "<cmd>Telescope help_tags<cr>", { desc = "[S]earch [H]elp" })
-- find string under cursor in current working directory
keymap.set("n", "<leader>sw", "<cmd>Telescope grep_string<cr>", { desc = "[S]earch current [W]ord" })
-- find string in current working directory as you type
keymap.set("n", "<leader>sg", "<cmd>Telescope live_grep<cr>", { desc = "[S]earch by [G]rep" })
keymap.set("n", "<leader>sd", "<cmd>Telescope diagnostics<cr>", { desc = "[S]earch [D]iagnostics" })

-- Lspsaga keybinds that don't need an lsp attached --
-- Because I'm used to the integrated terminal in VSCode
-- Terminals do not understand <C-`> so I'm using <C-t> for now. TODO: learn tmux or something
vim.keymap.set({ "n", "t" }, "<C-t>", "<cmd>Lspsaga term_toggle<CR>", {
	desc = "Toggle Floating Terminal",
})
