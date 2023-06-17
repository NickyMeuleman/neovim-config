-- highlight text that was just yanked, useful when yanking without first visually selecting
vim.api.nvim_create_autocmd({ "TextYankPost" }, {
	callback = function()
		pcall(vim.highlight.on_yank, { higroup = "IncSearch", timeout = 400 })
	end,
})
