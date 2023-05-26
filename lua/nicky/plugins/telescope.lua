local M = {
	"nvim-telescope/telescope.nvim",
	version = "*",
	dependencies = {
		{ "nvim-lua/plenary.nvim" },
		-- Fuzzy Finder Algorithm which requires local dependencies to be built.
		-- Only load if `make` is available. Make sure you have the system
		-- requirements installed.
		{
			"nvim-telescope/telescope-fzf-native.nvim",
			-- NOTE: If you are having trouble with this installation,
			--       refer to the README for telescope-fzf-native for more instructions.
			build = "make",
			cond = function()
				return vim.fn.executable("make") == 1
			end,
		},
	},
}

function M.config()
	local telescope_status, telescope = pcall(require, "telescope")
	if not telescope_status then
		return
	end

	local actions_status, actions = pcall(require, "telescope.actions")
	if not actions_status then
		return
	end

	telescope.setup({
		defaults = {
			file_ignore_patterns = { ".git/", "node_modules" },
			mappings = {
				i = {
					["<C-k>"] = actions.move_selection_previous, -- move to prev result
					["<C-j>"] = actions.move_selection_next, -- move to next result
					["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist, -- send selected to quickfixlist
				},
			},
		},
		extensions = {
			fzf = {
				fuzzy = true, -- false will only do exact matching
				override_generic_sorter = true, -- override the generic sorter
				override_file_sorter = true, -- override the file sorter
				case_mode = "smart_case", -- or "ignore_case" or "respect_case"
				-- the default case_mode is "smart_case"
			},
		},
	})

	-- To get fzf loaded and working with telescope, you need to call
	-- load_extension, somewhere after setup function:
	telescope.load_extension("fzf")
end

return M
