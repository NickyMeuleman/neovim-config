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
	local sources = require("null-ls.sources")

	local diagnostics = null_ls.builtins.diagnostics -- linters
	local formatting = null_ls.builtins.formatting -- formatters

	-- to setup format on save
	local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

	null_ls.setup({
		sources = {
			-- linters
			diagnostics.stylelint,
			-- formatters
			formatting.prettierd,
			formatting.stylua,
		},
		-- configure format on save
		-- https://github.com/jose-elias-alvarez/null-ls.nvim/wiki/Formatting-on-save
		on_attach = function(current_client, bufnr)
			if current_client.supports_method("textDocument/formatting") then
				vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
				vim.api.nvim_create_autocmd("BufWritePre", {
					group = augroup,
					buffer = bufnr,
					-- avoid formatter conflicts between regular lsp servers and null-ls
					-- https://github.com/jose-elias-alvarez/null-ls.nvim/wiki/Avoiding-LSP-formatting-conflicts#neovim-08
					callback = function()
						-- to setup the filtering logic
						local ft = vim.bo[bufnr].filetype
						local has_nullls_formatter = package.loaded["null-ls"]
							and (#sources.get_available(ft, "NULL_LS_FORMATTING") > 0)

						vim.lsp.buf.format({
							filter = function(client)
								-- prefer formatting via null-ls if null-ls has at least one source that can format the current buffer
								-- if no sources exist, the lsp probably handles formatting and we should allow that (like rust-analyzer)
								-- https://github.com/LazyVim/LazyVim/blob/f8982332be70499b74623f6ed44c1c58217eb546/lua/lazyvim/plugins/lsp/format.lua#L33
								if has_nullls_formatter then
									return client.name == "null-ls"
								end
								return client.name ~= "null-ls"
							end,
							bufnr = bufnr,
						})
					end,
				})
			end
		end,
	})
end

return M
