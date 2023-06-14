local M = {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	dependencies = {
		"JoosepAlviste/nvim-ts-context-commentstring",
		"windwp/nvim-ts-autotag",
		"HiPhish/nvim-ts-rainbow2",
		"nvim-treesitter/nvim-treesitter-textobjects",
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
		incremental_selection = {
			enable = true,
			keymaps = {
				init_selection = "<CR>", -- set to `false` to disable one of the mappings
				node_incremental = "<TAB>",
				node_decremental = "<S-TAB>",
			},
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
		textobjects = {
			select = {
				enable = true,
				lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
				keymaps = {
					-- You can use the capture groups defined in textobjects.scm in the textobjects plugin
					["aa"] = { query = "@parameter.outer", desc = "around parameter" },
					["ia"] = { query = "@parameter.inner", desc = "inner parameter" },
					["af"] = { query = "@function.outer", desc = "around function" },
					["if"] = { query = "@function.inner", desc = "inner function" },
					["ac"] = { query = "@class.outer", desc = "around class" },
					["ic"] = { query = "@class.inner", desc = "inner class" },
				},
			},
			swap = {
				enable = true,
				swap_previous = {
					-- mnemonics: capitals for previous, lowercase for next. (like n and N for highlights)
					--  [t]reesitter [s]wap [i]nner [A]ttribute
					--  [t]reesitter [s]wap [a]round [a]ttribute
					["<leader>tsiA"] = "@attribute.inner",
					["<leader>tsiP"] = "@parameter.inner",
					["<leader>tsaA"] = "@attribute.outer",
					["<leader>tsaP"] = "@parameter.outer",
					["<leader>tsiF"] = "@function.inner",
					["<leader>tsaF"] = "@function.outer",
				},
				swap_next = {
					["<leader>tsia"] = "@attribute.inner",
					["<leader>tsaa"] = "@attribute.outer",
					["<leader>tsip"] = "@parameter.inner",
					["<leader>tsif"] = "@function.inner",
					["<leader>tsap"] = "@parameter.outer",
					["<leader>tsaf"] = "@function.outer",
				},
			},
			move = {
				enable = true,
				set_jumps = true, -- whether to set jumps in the jumplist
				goto_next_start = {
					["]m"] = { query = "@function.outer", desc = "next function/method start" },
					["]]"] = { query = "@block.outer", desc = "next block start" },
				},
				goto_next_end = {
					["]M"] = { query = "@function.outer", desc = "next function/method end" },
					["]["] = { query = "@block.outer", desc = "next block end" },
				},
				goto_previous_start = {
					["[m"] = { query = "@function.outer", desc = "previous function/method start" },
					["[["] = { query = "@block.outer", desc = "previous block start" },
				},
				goto_previous_end = {
					["[M"] = { query = "@function.outer", desc = "previous function/method end" },
					["[]"] = { query = "@block.outer", desc = "previous block end" },
				},
			},
		},
	})
end

return M
