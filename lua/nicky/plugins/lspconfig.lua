local utils = require("nicky.utils")

local M = {
	"neovim/nvim-lspconfig",
	dependencies = {
		{
			"hrsh7th/cmp-nvim-lsp",
		},
	},
}

function M.config()
	local lspconfig_status, lspconfig = pcall(require, "lspconfig")
	if not lspconfig_status then
		return
	end

	local cmp_nvim_lsp_status, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
	if not cmp_nvim_lsp_status then
		return
	end

	-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
	local capabilities = vim.lsp.protocol.make_client_capabilities()
	capabilities = cmp_nvim_lsp.default_capabilities(capabilities)

	-- enable keybinds only for when lsp server available
	-- This function gets run when an LSP connects to a particular buffer.
	local lsp_keymaps = function(_, bufnr)
		-- NOTE: Remember that lua is a real programming language, and as such it is possible
		-- to define small helper and utility functions so you don't have to repeat yourself
		-- many times.
		--
		-- In this case, we create a function that lets us more easily define mappings specific
		-- for LSP related items. It sets the mode, buffer and description for us each time.
		local nmap = function(keys, func, desc)
			if desc then
				desc = "LSP: " .. desc
			end

			vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
		end

		nmap("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
		nmap("gi", vim.lsp.buf.implementation, "[G]oto [I]mplementation")
		nmap("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")
		nmap("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")
		nmap("<C-h>", vim.lsp.buf.signature_help, "Signature Documentation")

		-- Lesser used LSP functionality
		nmap("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
		nmap("<leader>wa", vim.lsp.buf.add_workspace_folder, "[W]orkspace [A]dd Folder")
		nmap("<leader>wr", vim.lsp.buf.remove_workspace_folder, "[W]orkspace [R]emove Folder")
		nmap("<leader>wl", function()
			print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
		end, "[W]orkspace [L]ist Folders")
		-- Create a command `:Format` local to the LSP buffer
		vim.api.nvim_buf_create_user_command(bufnr, "Format", function(_)
			utils.format_buffer(bufnr)
		end, { desc = "Format current buffer with LSP" })

		-- Lspsaga keymaps
		-- LSP finder - Find the symbol's definition
		-- If there is no definition, it will instead be hidden
		-- When you use an action in finder like "open vsplit",
		-- you can use <C-t> to jump back
		nmap("gf", "<cmd>Lspsaga lsp_finder<CR>", "[G]oto definition/reference [F]inder")
		-- Code action
		nmap("<leader>ca", "<cmd>Lspsaga code_action<CR>", "[C]ode [A]ction")
		-- Rename all occurrences of the hovered word for the entire file
		nmap("<leader>rn", "<cmd>Lspsaga rename<CR>", "[R]e[n]ame")
		-- Peek definition
		-- You can edit the file containing the definition in the floating window
		-- It also supports open/vsplit/etc operations, do refer to "definition_action_keys"
		-- It also supports tagstack
		-- Use <C-t> to jump back
		nmap("gd", "<cmd>Lspsaga peek_definition<CR>", "[G]oto Peek [D]efinition")
		-- Peek type definition
		-- You can edit the file containing the type definition in the floating window
		-- It also supports open/vsplit/etc operations, do refer to "definition_action_keys"
		-- It also supports tagstack
		-- Use <C-t> to jump back
		nmap("gt", "<cmd>Lspsaga peek_type_definition<CR>", "[G]oto Peek [T]ype Definition")
		-- Show line diagnostics
		-- You can pass argument ++unfocus to
		-- unfocus the show_line_diagnostics floating window
		nmap("<leader>D", "<cmd>Lspsaga show_line_diagnostics<CR>", "Show Line [D]iagnostics")
		-- the regular way because the line diagnostic popup is weird sometimes
		nmap("gl", vim.diagnostic.open_float, "[G]oto [L]ine Diagnostic")
		-- Show cursor diagnostics
		nmap("<leader>d", "<cmd>Lspsaga show_cursor_diagnostics<CR>", "Show Cursor [D]iagnostics")
		-- Diagnostic jump
		-- You can use <C-o> to jump back to your previous location
		nmap("[d", "<cmd>Lspsaga diagnostic_jump_prev<CR>", "Jump to previous [D]iagnostic message")
		nmap("]d", "<cmd>Lspsaga diagnostic_jump_next<CR>", "Jump to next [D]iagnostic message")
		-- Toggle outline
		nmap("<leader>o", "<cmd>Lspsaga outline<CR>", "Toggle [O]utline")
		-- Hover Doc
		-- See `:help K` for why this keymap
		-- If there is no hover doc,
		-- there will be a notification stating that
		-- there is no information available.
		-- To disable it just use ":Lspsaga hover_doc ++quiet"
		-- Pressing the key twice will enter the hover window
		nmap("K", "<cmd>Lspsaga hover_doc<CR>", "Hover Documentation")

		-- because I'm used to these from VSCode
		nmap("<F2>", "<cmd>Lspsaga rename<CR>", "Rename with LSP")
		-- TODO: extract that filtering formatter logic to be a shared function
		-- between the on_attach handlers and the keymap, right now they can use different formatters
		nmap("<A-F>", function()
			local buf = vim.api.nvim_get_current_buf()
			utils.format_buffer(buf)
		end, "Format buffer with LSP")
	end

	-- rust
	lspconfig["rust_analyzer"].setup({
		capabilities = capabilities,
		on_attach = function(current_client, bufnr)
			lsp_keymaps(current_client, bufnr)
			utils.format_on_save(current_client, bufnr)
		end,
	})

	-- lua
	lspconfig["lua_ls"].setup({
		capabilities = capabilities,
		on_attach = lsp_keymaps,
		settings = {
			Lua = {
				-- make the language server recognize "vim" global
				diagnostics = {
					globals = { "vim" },
				},
				workspace = {
					-- make language server aware of runtime files
					library = {
						[vim.fn.expand("$VIMRUNTIME/lua")] = true,
						[vim.fn.stdpath("config") .. "/lua"] = true,
					},
				},
			},
		},
	})

	-- typescript
	lspconfig["tsserver"].setup({
		capabilities = capabilities,
		on_attach = lsp_keymaps,
	})

	-- Eslint through here and not eslint_d from null-ls
	-- the reason: I want support for the autofixes ESLint provides, I also want to execute that command on save
	lspconfig["eslint"].setup({
		capabilities = capabilities,
		on_attach = function(client, bufnr)
			lsp_keymaps(client, bufnr)
			-- TODO: find method where this runs before fomat-on-save. right now I don't know what happens first
			vim.api.nvim_create_autocmd("BufWritePre", {
				buffer = bufnr,
				command = "EslintFixAll",
			})
		end,
	})

	-- html
	lspconfig["html"].setup({
		capabilities = capabilities,
		on_attach = lsp_keymaps,
	})

	-- json
	lspconfig["jsonls"].setup({
		capabilities = capabilities,
		on_attach = lsp_keymaps,
	})
end

return M
