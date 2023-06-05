local M = {
	"nvim-lualine/lualine.nvim",
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
}

function M.config()
	local status_ok, lualine = pcall(require, "lualine")
	if not status_ok then
		return
	end

	-- Customize nightfly colors
	-- local lualine_nightfly = require("lualine.themes.nightfly")
	--
	-- local new_colors = {
	-- 	black = "#000000",
	-- 	yellow = "#FFDA7B",
	-- }
	--
	-- lualine_nightfly.command = {
	-- 	a = {
	-- 		gui = "bold",
	-- 		bg = new_colors.yellow,
	-- 		fg = new_colors.black,
	-- 	},
	-- }

	lualine.setup({
		options = {
			icons_enabled = true,
			theme = "catppuccin",
			section_separators = { left = "", right = "" },
		},
		sections = {
			lualine_x = {
				{ "filetype" },
			},
		},
	})
end

return M
