local M = {}

local local_status, _ = pcall(require, "null-ls")
if not local_status then
	return
end
local sources = package.loaded["null-ls"] and require("null-ls.sources")

M.format_buffer = function(bufnr)
	local ft = vim.bo[bufnr].filetype
	local has_nullls_formatter = package.loaded["null-ls"] and (#sources.get_available(ft, "NULL_LS_FORMATTING") > 0)

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

return M
