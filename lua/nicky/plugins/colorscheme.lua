local M = {
	-- "bluz71/vim-nightfly-colors",
	-- name = "nightfly",
	"catppuccin/nvim",
	name = "catppuccin",
	lazy = false, -- make sure we load this during startup if it is your main colorscheme
	priority = 1000, -- make sure to load this before all the other start plugins
}

function M.config()
	local status_ok, colorscheme = pcall(require, "catppuccin")
	if not status_ok then
		return
	end

	colorscheme.setup({
		flavour = "frappe",
		term_colors = true,
		dim_inactive = {
			enabled = true,
		},
		integrations = {
			barbar = true,
			barbecue = {
				dim_dirname = true,
			},
			gitsigns = true,
			indent_blankline = {
				enabled = true,
				colored_indent_levels = false,
			},
			lsp_saga = true,
			mason = true,
			neotree = true,
			cmp = true,
			native_lsp = {
				enabled = true,
				virtual_text = {
					errors = { "italic" },
					hints = { "italic" },
					warnings = { "italic" },
					information = { "italic" },
				},
				underlines = {
					errors = { "underline" },
					hints = { "underline" },
					warnings = { "underline" },
					information = { "underline" },
				},
			},
			treesitter = true,
			ts_rainbow2 = true,
			telescope = true,
		},
	})

	-- load colorscheme by executing a vim command
	local colorscheme_ok, _ = pcall(vim.cmd.colorscheme, M.name)
	if not colorscheme_ok then
		return
	end

	-- Tweak highlight groups
	-- To see all highlight groups :Telescope highlights
	-- because untracked files are usually new files
	vim.api.nvim_set_hl(0, "NeoTreeGitUntracked", { link = "NeoTreeGitAdded" })
	-- for nightfly
	-- dotfiles and ignored files are a bit hard to read out of the box
	-- vim.api.nvim_set_hl(0, "NeoTreeDotfile", { link = "NeoTreeDimText" })
	-- the confirmation prompts are unreadable
	-- vim.api.nvim_set_hl(0, "NeoTreeTitleBar", { link = "NeoTreePreview" })
end

-- return the plugin spec lua table lazy.nvim uses
return M
