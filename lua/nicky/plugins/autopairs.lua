local M = {
	"windwp/nvim-autopairs",
	event = "InsertEnter",
	dependencies = {
		{
			"hrsh7th/nvim-cmp",
			event = {
				"InsertEnter",
				"CmdlineEnter",
			},
		},
	},
}

function M.config()
	local autopairs_status, autopairs = pcall(require, "nvim-autopairs")
	if not autopairs_status then
		return
	end

	local cmp_autopairs_setup, cmp_autopairs = pcall(require, "nvim-autopairs.completion.cmp")
	if not cmp_autopairs_setup then
		return
	end

	local cmp_setup, cmp = pcall(require, "cmp")
	if not cmp_setup then
		return
	end

	autopairs.setup({
		check_ts = true, -- Treesitter integration
		ts_config = {
			lua = { "string" }, -- it will not add a pair on that treesitter node
			javascript = { "template_string" },
			java = false, -- don't check treesitter on java
		},
	})

	-- automatic brace insertion on nvim-cmp selection of funtions/methods
	-- needs`CR` mapping in nvim-cmp setup
	cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
end

return M
