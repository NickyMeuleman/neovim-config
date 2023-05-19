local M = {
    "utilyre/barbecue.nvim",
    name = "barbecue",
    version = "*",
    dependencies = {
        "SmiteshP/nvim-navic",
        "nvim-tree/nvim-web-devicons", -- optional dependency
    },
}

function M.config()
    local status_ok, barbecue = pcall(require, "barbecue")
    if not status_ok then
        return
    end

    barbecue.setup()
end

return M
