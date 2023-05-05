local M = {
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
}

function M.config()
    local status_ok, nvim_surround = pcall(require, "nvim-surround")
    if not status_ok then
        return
    end
    nvim_surround.setup({
        -- Configuration here, or leave empty to use defaults
    })
end

return M
