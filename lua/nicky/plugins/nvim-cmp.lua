local M = {
    "hrsh7th/nvim-cmp",
    dependencies = {
        { "hrsh7th/cmp-nvim-lsp" },
        {
            "L3MON4D3/LuaSnip",
            -- follow latest release.
            version = "<CurrentMajor>.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
            -- install jsregexp (optional!).
            build = "make install_jsregexp",
            dependencies = { "rafamadriz/friendly-snippets" }
        },
        { "saadparwaiz1/cmp_luasnip" },
        { "hrsh7th/cmp-buffer" },
        { "hrsh7th/cmp-path" },
        -- a plugin for icons in autocompletion because I don't want to pick them all manually
        { "onsails/lspkind.nvim" }
    }
}

function M.config()
    local cmp_status, cmp = pcall(require, "cmp")
    if not cmp_status then
        return
    end

    local luasnip_status, luasnip = pcall(require, "luasnip")
    if not luasnip_status then
        return
    end

    local lspkind_status, lspkind = pcall(require, "lspkind")
    if not lspkind_status then
        return
    end

    -- Allow using VSCode style snippets (loads friendly-snippets)
    require("luasnip.loaders.from_vscode").lazy_load()

    cmp.setup {
        snippet = {
            expand = function(args)
                luasnip.lsp_expand(args.body)
            end,
        },
        mapping = cmp.mapping.preset.insert {
            ['<C-j>'] = cmp.mapping.select_next_item(),
            ['<C-k>'] = cmp.mapping.select_prev_item(),
            ['<C-b>'] = cmp.mapping.scroll_docs(-4),
            ['<C-f>'] = cmp.mapping.scroll_docs(4),
            ["<C-e>"] = cmp.mapping {
                i = cmp.mapping.abort(),
                c = cmp.mapping.close(),
            },
            ['<C-Space>'] = cmp.mapping.complete {},
            ['<CR>'] = cmp.mapping.confirm {
                behavior = cmp.ConfirmBehavior.Replace,
                -- complete first suggestion on confirm if no item is selected
                select = true,
            },
            ['<Tab>'] = cmp.mapping(function(fallback)
                if cmp.visible() then
                    cmp.select_next_item()
                elseif luasnip.expand_or_locally_jumpable() then
                    luasnip.expand_or_jump()
                else
                    fallback()
                end
            end, { 'i', 's' }),
            ['<S-Tab>'] = cmp.mapping(function(fallback)
                if cmp.visible() then
                    cmp.select_prev_item()
                elseif luasnip.locally_jumpable(-1) then
                    luasnip.jump(-1)
                else
                    fallback()
                end
            end, { 'i', 's' }),
        },
        formatting = {
            format = lspkind.cmp_format({
                maxwidth = 50,         -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
                ellipsis_char = "...", -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)
            })
        },
        sources = {
            { name = "nvim_lsp" },
            { name = "luasnip" },
            { name = "buffer" },
            { name = "path" },
        },
    }
end

return M
