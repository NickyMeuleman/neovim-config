local M = {
    "nvimdev/lspsaga.nvim",
    event = "LspAttach",
    dependencies = {
        { "nvim-tree/nvim-web-devicons" },
        -- TODO: revisit treesitter integration
        --Please make sure you install markdown and markdown_inline parser
        { "nvim-treesitter/nvim-treesitter" }
    }
}

function M.config()
    local status_ok, lspsaga = pcall(require, "lspsaga")
    if not status_ok then
        return
    end

    lspsaga.setup({
        symbol_in_winbar = {
            -- using barbecue.nvim instead, this one is too bright since inactive buffers do not dim
            enable = false,
            -- separator = " ",
        },
        scroll_preview = {
            scroll_down = "<C-f>",
            scroll_up = "<C-b>",
        },
        definition = {
            edit = "<CR>",
        },
        outline = {
            keys = {
                expand_or_jump = "<CR>",
            }
        }
    })
end

return M
