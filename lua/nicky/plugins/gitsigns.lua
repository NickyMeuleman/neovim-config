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
		on_attach = function(bufnr)
			vim.keymap.set("n", "<leader>gp", gitsigns.prev_hunk, { buffer = bufnr, desc = "[g]it [p]revious hunk" })
			vim.keymap.set("n", "<leader>gn", gitsigns.next_hunk, { buffer = bufnr, desc = "[g]it [n]ext hunk" })
			vim.keymap.set("n", "<leader>gh", gitsigns.preview_hunk, { buffer = bufnr, desc = "[g]it preview [h]unk" })
		end,
	})
end

return M
