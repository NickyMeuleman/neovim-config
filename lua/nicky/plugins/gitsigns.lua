local M = {
	"lewis6991/gitsigns.nvim",
	event = "BufReadPre",
}

function M.config()
	local status_ok, gitsigns = pcall(require, "gitsigns")
	if not status_ok then
		return
	end

	gitsigns.setup({
		current_line_blame = true,
	})
end

return M
