local M = {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	dependencies = {
		"JoosepAlviste/nvim-ts-context-commentstring",
		"windwp/nvim-ts-autotag",
		"HiPhish/nvim-ts-rainbow2",
	},
}

function M.config()
	local status_ok, treesitter = pcall(require, "nvim-treesitter.configs")
	if not status_ok then
		return
	end

	treesitter.setup({
		-- A list of parser names, or "all"
		ensure_installed = {
			"markdown",
			"markdown_inline",
			"vimdoc",
			"javascript",
			"typescript",
			"lua",
			"rust",
		},
		-- Install parsers synchronously (only applied to `ensure_installed`)
		sync_install = false,
		-- Automatically install missing parsers when entering buffer
		-- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
		auto_install = true,
		highlight = {
			-- `false` will disable the whole extension
			enable = true,
			-- Setting this to true will run `:h syntax` and tree-sitter at the same time.
			-- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
			-- Using this option may slow down your editor, and you may see some duplicate highlights.
			-- Instead of true it can also be a list of languages
			additional_vim_regex_highlighting = false,
		},
		indent = {
			-- Indentation based on treesitter for the = operator
			enable = true,
		},
		autotag = {
			-- enable ts autotag plugin
			enable = true,
		},
		rainbow = {
			-- enable ts rainbow plugin
			enable = true,
		},
		context_commentstring = {
			-- enable ts-context-commentstring plugin to get correct comments in JSX
			enable = true,
			enable_autocmd = false, -- autocmd recalculates commentstring on cursorhold
		},
	})
end

return M
