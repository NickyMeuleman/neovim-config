local M = {
    "bluz71/vim-nightfly-colors",
    name = "nightfly",
    -- "catppuccin/nvim",
    -- name = "catppuccin",
    lazy = false,  -- make sure we load this during startup if it is your main colorscheme
    priority = 1000, -- make sure to load this before all the other start plugins
}

-- load colorscheme by executing a vim command
function M.config()
    local status_ok, _ = pcall(vim.cmd.colorscheme, M.name)
    if not status_ok then
        return
    end
end

-- return the plugin spec lua table lazy.nvim uses
return M
