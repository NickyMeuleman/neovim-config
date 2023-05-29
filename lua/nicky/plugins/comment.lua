local M = {
	"numToStr/Comment.nvim",
	dependencies = {
		"JoosepAlviste/nvim-ts-context-commentstring",
	},
}

function M.config()
	local comment_status, comment = pcall(require, "Comment")
	if not comment_status then
		return
	end

	local context_commentstring_status, _ = pcall(require, "ts_context_commentstring")
	if not context_commentstring_status then
		return
	end

	comment.setup({
		pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
	})
end

return M
