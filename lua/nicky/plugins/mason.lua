local M = {
	'williamboman/mason.nvim',
	-- :MasonUpdate updates registry contents
	build = ':MasonUpdate',
	dependencies = {
		{
			-- bridges the gap between mason and nvim-lspconfig
			'williamboman/mason-lspconfig.nvim',
		},
		{
			-- bridges the gap between mason and null-ls
			'jay-babu/mason-null-ls.nvim',
			event = { 'BufReadPre', 'BufNewFile' },
			dependencies = {
				'williamboman/mason.nvim',
				'jose-elias-alvarez/null-ls.nvim',
			},
		},
	},
}

function M.config()
	local mason_status, mason = pcall(require, 'mason')
	if not mason_status then
		return
	end

	local mason_lspconfig_status, mason_lspconfig = pcall(require, 'mason-lspconfig')
	if not mason_lspconfig_status then
		return
	end

	local mason_null_ls_status, mason_null_ls = pcall(require, 'mason-null-ls')
	if not mason_null_ls_status then
		return
	end

	mason.setup()

	mason_lspconfig.setup({
		ensure_installed = {
			'rust_analyzer',
			'lua_ls',
			'tsserver',
			'html',
			'jsonls',
		},
		-- Whether servers that are set up (via lspconfig) should be automatically installed if they're not already installed.
		-- This setting has no relation with the `ensure_installed` setting.
		automatic_installation = true,
	})

	mason_null_ls.setup({
		-- A list of sources to install if they're not already installed.
		-- This setting has no relation with the `automatic_installation` setting.
		ensure_installed = {
			-- linters
			'stylelint',
			-- formatters
			'prettierd',
			'stylua',
		},
		-- Will automatically install masons tools based on selected sources in `null-ls`.
		-- Can also be an exclusion list.
		-- Example: `automatic_installation = { exclude = { "rust_analyzer", "solargraph" } }`
		automatic_installation = false,
	})
end

return M
