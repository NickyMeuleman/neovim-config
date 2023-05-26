local M = {
	"HiPhish/nvim-ts-rainbow2",
	-- does not work when loaded on InsertEnter, loading this unconditionally
	dependencies = {
		"nvim-treesitter/nvim-treesitter",
	},
}

-- enable in treesitter config

return M
