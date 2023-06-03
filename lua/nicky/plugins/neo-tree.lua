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

	-- If you want icons for diagnostic errors, you'll need to define them somewhere:
	vim.fn.sign_define("DiagnosticSignError", { text = " ", texthl = "DiagnosticSignError" })
	vim.fn.sign_define("DiagnosticSignWarn", { text = " ", texthl = "DiagnosticSignWarn" })
	vim.fn.sign_define("DiagnosticSignInfo", { text = " ", texthl = "DiagnosticSignInfo" })
	vim.fn.sign_define("DiagnosticSignHint", { text = "", texthl = "DiagnosticSignHint" })

	neo_tree.setup({
		close_if_last_window = true, -- Close Neo-tree if it is the last window left in the tab
		window = {
			position = "right",
		},
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
		-- Add this section only if you've configured source selector.

		source_selector = {
			winbar = true,
			sources = {
				{ source = "filesystem", display_name = " 󰉓 Files " },
				{ source = "git_status", display_name = " 󰊢 Git " },
			},
		},
	})
	vim.cmd([[ let g:neo_tree_remove_legacy_commands = 1 ]])
	vim.api.nvim_set_hl(0, "NeoTreeGitUntracked", { link = "NeoTreeGitAdded" })
end

return M

--[[ source_selector provides clickable tabs to switch between sources.
  source_selector = {
    winbar = false, -- toggle to show selector on winbar
    statusline = false, -- toggle to show selector on statusline
      filtered_items = {
      visible = false, -- when true, they will just be displayed differently than normal items
      force_visible_in_empty_folder = false, -- when true, hidden files will be shown if the root folder is otherwise empty
      show_hidden_count = true, -- when true, the number of hidden items in each folder will be shown as the last entry
      hide_dotfiles = true,
      hide_gitignored = true,
      hide_hidden = true, -- only works on Windows for hidden files/directories
      hide_by_name = {
        ".DS_Store",
        "thumbs.db"
        --"node_module ]]
