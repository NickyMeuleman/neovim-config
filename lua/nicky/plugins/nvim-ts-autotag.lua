local M = {
	"windwp/nvim-ts-autotag",
	-- does not work when loaded on InsertEnter, loading this unconditionally
	dependencies = {
		"nvim-treesitter/nvim-treesitter",
	},
}

-- enable in treesitter config

-- Enable update on insert
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
	underline = true,
	virtual_text = {
		spacing = 5,
		severity_limit = "Warning",
	},
	update_in_insert = true,
})

return M
