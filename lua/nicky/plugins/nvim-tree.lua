-- disable netrw at the very start of your init.lua (strongly advised)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- set termguicolors to enable highlight groups
vim.opt.termguicolors = true

local M = {
    "nvim-tree/nvim-tree.lua",
    version = "*",
    dependencies = {
        "nvim-tree/nvim-web-devicons",
    }    
}

function M.config()
    local status_ok, nvim_tree = pcall(require, "nvim-tree")
    if not status_ok then
        return
    end
    nvim_tree.setup({
        --  right side causes opened buffer to become invisible on tree close, rendering the plugin unusable, big-sad
        -- view = {
        --     side = "right"
        -- },
        renderer = {
            indent_markers = {
                enable = true
            }
        }
    })
end

return M
