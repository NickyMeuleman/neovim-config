local M = {
	"j-hui/fidget.nvim",
	tag = "legacy",
}

function M.config()
	local status_ok, fidget = pcall(require, "fidget")
	if not status_ok then
		return
	end

	fidget.setup({
		window = {
			blend = 0,
		},
	})
end

return M
