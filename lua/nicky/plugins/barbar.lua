local M = {
	"romgrk/barbar.nvim",
	dependencies = {
		"lewis6991/gitsigns.nvim", -- OPTIONAL: for git status
		"nvim-tree/nvim-web-devicons", -- OPTIONAL: for file icons
	},
	init = function()
		vim.g.barbar_auto_setup = false
	end,
	version = "^1.0.0", -- optional: only update when a new 1.x version is released
}

function M.config()
	local status_ok, barbar = pcall(require, "barbar")
	if not status_ok then
		return
	end

	barbar.setup({
		icons = {
			gitsigns = {
				added = { enabled = true, icon = "+" },
				changed = { enabled = true, icon = "~" },
				deleted = { enabled = true, icon = "-" },
			},
			diagnostics = {
				[vim.diagnostic.severity.ERROR] = { enabled = true },
				[vim.diagnostic.severity.WARN] = { enabled = true },
				[vim.diagnostic.severity.INFO] = { enabled = true },
				[vim.diagnostic.severity.HINT] = { enabled = true },
			},
		},
		-- Set the filetypes which barbar will offset itself for
		sidebar_filetypes = {
			-- Or, specify the event which the sidebar executes when leaving:
			["neo-tree"] = { event = "BufWipeout" },
		},
	})
end

return M
