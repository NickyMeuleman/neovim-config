local M = {
	"folke/which-key.nvim",
	event = "VeryLazy",
	init = function()
		vim.o.timeout = true
		vim.o.timeoutlen = 300
	end,
}

function M.config()
	local status_ok, which_key = pcall(require, "which-key")
	if not status_ok then
		return
	end

	local mappings = {
		["<leader>"] = {
			g = {
				name = "git",
			},
			s = {
				name = "search",
			},
			l = {
				name = "LSP",
			},
			w = {
				name = "window",
			},
		},
	}
	which_key.register(mappings, {})
end

return M
