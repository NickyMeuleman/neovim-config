local M = {
    "nvim-treesitter/nvim-treesitter",
    build = ':TSUpdate',
}

function M.config()
    local status_ok, treesitter = pcall(require, "nvim-treesitter.configs")
    if not status_ok then
        return
    end
    treesitter.setup({
        ensure_installed = {
            "markdown",
            "markdown_inline",
        },
        auto_install = true,
    })
end

return M
