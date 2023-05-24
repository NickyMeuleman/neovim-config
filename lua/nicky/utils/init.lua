local M = {}

-- to setup format on save
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

M.format_buffer = function(bufnr)
	local ft = vim.bo[bufnr].filetype
	local has_nullls_formatter = package.loaded["null-ls"]
		and (#require("null-ls.sources").get_available(ft, "NULL_LS_FORMATTING") > 0)

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
end

M.format_on_save = function(current_client, bufnr)
	if current_client.supports_method("textDocument/formatting") then
		vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
		vim.api.nvim_create_autocmd("BufWritePre", {
			group = augroup,
			buffer = bufnr,
			-- avoid formatter conflicts between regular lsp servers and null-ls
			-- https://github.com/jose-elias-alvarez/null-ls.nvim/wiki/Avoiding-LSP-formatting-conflicts#neovim-08
			callback = function()
				M.format_buffer(bufnr)
			end,
		})
	end
end

return M
