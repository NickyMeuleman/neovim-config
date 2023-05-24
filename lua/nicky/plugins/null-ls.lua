local utils = require("nicky.utils")

local M = {
	"jose-elias-alvarez/null-ls.nvim",
	dependencies = {
		{ "nvim-lua/plenary.nvim" },
	},
}

function M.config()
	local local_status, null_ls = pcall(require, "null-ls")
	if not local_status then
		return
	end

	local diagnostics = null_ls.builtins.diagnostics -- linters
	local formatting = null_ls.builtins.formatting -- formatters

	null_ls.setup({
		sources = {
			-- linters
			diagnostics.stylelint,
			-- formatters
			formatting.prettierd,
			formatting.stylua,
		},
		on_attach = function(current_client, bufnr)
			-- configure format on save
			-- https://github.com/jose-elias-alvarez/null-ls.nvim/wiki/Formatting-on-save
			utils.format_on_save(current_client, bufnr)
		end,
	})
end

return M
