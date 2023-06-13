local utils = require("nicky.utils")

local M = {
	"neovim/nvim-lspconfig",
	dependencies = {
		{
			"hrsh7th/cmp-nvim-lsp",
		},
		{
			"folke/neodev.nvim",
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

	local neodev_ok, neodev = pcall(require, "neodev")
	if not neodev_ok then
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

		local telescope_builtin = require("telescope.builtin")

		nmap("<leader>f", function()
			local buf = vim.api.nvim_get_current_buf()
			utils.format_buffer(buf)
		end, "[f]ormat buffer with LSP")
		nmap("<leader>ld", function()
			telescope_builtin.diagnostics({ bufnr = 0 })
		end, "Buffer [d]iagnosics")
		nmap("<leader>lr", "<cmd>LspRestart<CR>", "[r]estart lsp server")
		nmap("gr", telescope_builtin.lsp_references, "[g]oto [r]eferences")
		nmap("gi", vim.lsp.buf.implementation, "[g]oto [i]mplementation")
		nmap("<leader>ls", telescope_builtin.lsp_document_symbols, "Document [s]ymbols")
		nmap("<leader>lw", telescope_builtin.lsp_dynamic_workspace_symbols, "[w]orkspace symbols")
		nmap("gD", vim.lsp.buf.declaration, "[g]oto [D]eclaration")
		nmap("<leader>la", vim.lsp.buf.add_workspace_folder, "Workspace [a]dd folder")
		nmap("<leader>lr", vim.lsp.buf.remove_workspace_folder, "Workspace [r]emove folder")
		nmap("<leader>ll", function()
			print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
		end, "workspace [l]ist folders")
		-- LSP finder - Find the symbol's definition
		-- If there is no definition, it will instead be hidden
		-- When you use an action in finder like "open vsplit",
		-- you can use <C-t> to jump back
		nmap("<leader>lf", "<cmd>Lspsaga lsp_finder<CR>", "Definition/Reference [f]inder")
		nmap("<leader>a", "<cmd>Lspsaga code_action<CR>", "Code [a]ction")
		nmap("<leader>r", "<cmd>Lspsaga rename<CR>", "[r]ename")
		-- You can edit the file containing the definition in the floating window
		-- It also supports open/vsplit/etc operations, do refer to "definition_action_keys"
		-- It also supports tagstack
		-- Use <C-t> to jump back
		nmap("gd", "<cmd>Lspsaga peek_definition<CR>", "[g]oto peek [d]efinition")
		-- You can edit the file containing the type definition in the floating window
		-- It also supports open/vsplit/etc operations, do refer to "definition_action_keys"
		-- It also supports tagstack
		-- Use <C-t> to jump back
		nmap("gt", "<cmd>Lspsaga peek_type_definition<CR>", "[g]oto peek [t]ype Definition")
		-- You can pass argument ++unfocus to
		-- unfocus the show_line_diagnostics floating window
		nmap("<leader>d", "<cmd>Lspsaga show_line_diagnostics<CR>", "Show line [d]iagnostics")
		-- the regular way because the line diagnostic popup is weird sometimes
		nmap("gl", vim.diagnostic.open_float, "[g]oto [l]ine diagnostic")
		nmap("<leader>D", "<cmd>Lspsaga show_cursor_diagnostics<CR>", "Show cursor [D]iagnostics")
		-- You can use <C-o> to jump back to your previous location
		nmap("[d", "<cmd>Lspsaga diagnostic_jump_prev<CR>", "Jump to previous [d]iagnostic message")
		nmap("]d", "<cmd>Lspsaga diagnostic_jump_next<CR>", "Jump to next [d]iagnostic message")
		nmap("<leader>o", "<cmd>Lspsaga outline<CR>", "Toggle [o]utline")
		-- See `:help K` for why this keymap
		-- If there is no hover doc,
		-- there will be a notification stating that
		-- there is no information available.
		-- Pressing the key twice will enter the hover window
		nmap("K", "<cmd>Lspsaga hover_doc<CR>", "Hover documentation")
		nmap("<leader>k", vim.lsp.buf.signature_help, "[k] Signature documentation")

		-- because I'm used to these from VSCode
		nmap("<F2>", "<cmd>Lspsaga rename<CR>", "Rename with LSP")
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
	-- IMPORTANT: make sure to setup neodev BEFORE lspconfig
	neodev.setup()
	lspconfig["lua_ls"].setup({
		capabilities = capabilities,
		on_attach = lsp_keymaps,
		settings = {
			Lua = {
				workspace = {
					checkThirdParty = false,
				},
				telemetry = {
					enable = false,
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
