local M = {
    "hrsh7th/nvim-cmp",
    dependencies = {
        { "hrsh7th/cmp-buffer" },
        { "hrsh7th/cmp-path" },
    }
}

function M.config()
    local cmp_status, cmp = pcall(require, "cmp")
    if not cmp then
        return
    end

    cmp.setup {
        mapping = cmp.mapping.preset.insert {
            ['<C-j>'] = cmp.mapping.select_next_item(),
            ['<C-k>'] = cmp.mapping.select_prev_item(),
            ['<C-b>'] = cmp.mapping.scroll_docs(-4),
            ['<C-f>'] = cmp.mapping.scroll_docs(4),
            ['<C-Space>'] = cmp.mapping.complete {},
            ['<CR>'] = cmp.mapping.confirm {
                behavior = cmp.ConfirmBehavior.Replace,
                select = true,
            },
            ['<Tab>'] = cmp.mapping(function(fallback)
                if cmp.visible() then
                    cmp.select_next_item()
                else
                    fallback()
                end
            end, { 'i', 's' }),
            ['<S-Tab>'] = cmp.mapping(function(fallback)
                if cmp.visible() then
                    cmp.select_prev_item()
                else
                    fallback()
                end
            end, { 'i', 's' }),
        },
        sources = {
            { name = "buffer" },
            { name = "path" },
        },
    }
end

return M
