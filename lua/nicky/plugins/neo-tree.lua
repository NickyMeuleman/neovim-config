-- VSCode file colours in explorer:
-- lightblue
-- "gitDecoration.modifiedResourceForeground": "#a2bffc",
-- red
-- "gitDecoration.deletedResourceForeground": "#EF535090",
-- yellow
-- "gitDecoration.untrackedResourceForeground": "#c5e478ff",
-- darker blue
-- "gitDecoration.ignoredResourceForeground": "#395a75",
-- yellow/pink
-- "gitDecoration.conflictingResourceForeground": "#ffeb95cc",

local M = {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v2.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
		"MunifTanjim/nui.nvim",
	},
}

function M.config()
	local status_ok, neo_tree = pcall(require, "neo-tree")
	if not status_ok then
		return
	end

	-- Unless you are still migrating, remove the deprecated commands from v1.x
	vim.cmd([[ let g:neo_tree_remove_legacy_commands = 1 ]])

	-- If you want icons for diagnostic errors, you'll need to define them somewhere:
	vim.fn.sign_define("DiagnosticSignError", { text = " ", texthl = "DiagnosticSignError" })
	vim.fn.sign_define("DiagnosticSignWarn", { text = " ", texthl = "DiagnosticSignWarn" })
	vim.fn.sign_define("DiagnosticSignInfo", { text = " ", texthl = "DiagnosticSignInfo" })
	vim.fn.sign_define("DiagnosticSignHint", { text = "", texthl = "DiagnosticSignHint" })

	neo_tree.setup({
		close_if_last_window = true, -- Close Neo-tree if it is the last window left in the tab
		window = {
			position = "right", -- right side, correct side
		},
		source_selector = {
			winbar = true,
			sources = {
				{ source = "filesystem", display_name = " 󰉓 Files " },
				{ source = "git_status", display_name = " 󰊢 Git " },
			},
		},
		filesystem = {
			filtered_items = {
				visible = true, -- show dotfiles and gitignored files
			},
		},
		-- adding icons to be compatible with Nerdfont v3
		default_component_configs = {
			icon = {
				folder_empty = "󰜌",
				folder_empty_open = "󰜌",
			},
			git_status = {
				symbols = {
					renamed = "󰁕",
					unstaged = "󰄱",
				},
			},
		},
		document_symbols = {
			kinds = {
				File = { icon = "󰈙", hl = "Tag" },
				Namespace = { icon = "󰌗", hl = "Include" },
				Package = { icon = "󰏖", hl = "Label" },
				Class = { icon = "󰌗", hl = "Include" },
				Property = { icon = "󰆧", hl = "@property" },
				Enum = { icon = "󰒻", hl = "@number" },
				Function = { icon = "󰊕", hl = "Function" },
				String = { icon = "󰀬", hl = "String" },
				Number = { icon = "󰎠", hl = "Number" },
				Array = { icon = "󰅪", hl = "Type" },
				Object = { icon = "󰅩", hl = "Type" },
				Key = { icon = "󰌋", hl = "" },
				Struct = { icon = "󰌗", hl = "Type" },
				Operator = { icon = "󰆕", hl = "Operator" },
				TypeParameter = { icon = "󰊄", hl = "Type" },
				StaticMethod = { icon = "󰠄 ", hl = "Function" },
			},
		},
	})

	-- Tweak highlight groups
	-- To see all highlight groups :Telescope highlights
	-- because untracked files are usually new files
	vim.api.nvim_set_hl(0, "NeoTreeGitUntracked", { link = "NeoTreeGitAdded" })
	-- dotfiles and ignored files are a bit hard to read out of the box
	vim.api.nvim_set_hl(0, "NeoTreeDotfile", { link = "NeoTreeDimText" })
	-- the confirmation prompts are unreadably in nightfly
	vim.api.nvim_set_hl(0, "NeoTreeTitleBar", { link = "NeoTreePreview" })
end

return M
