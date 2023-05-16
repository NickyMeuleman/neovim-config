local M = {
  "williamboman/mason.nvim",
  -- :MasonUpdate updates registry contents
  build = ":MasonUpdate",
  dependencies = {
    {
      -- bridges the gap between mason and nvim-lspconfig
      "williamboman/mason-lspconfig.nvim",
    },
  },
}

function M.config()
    local mason_status, mason = pcall(require, "mason")
    if not mason_status then
        return
    end

    local mason_lspconfig_status, mason_lspconfig = pcall(require, "mason-lspconfig")
    if not mason_lspconfig_status then
        return
    end

    mason.setup()

    mason_lspconfig.setup({
        ensure_installed = {
            "rust_analyzer",
            "lua_ls",
            "tsserver",
            "html",
            "jsonls"
        },
        -- Whether servers that are set up (via lspconfig) should be automatically installed if they're not already installed.
        -- This setting has no relation with the `ensure_installed` setting.
        automatic_installation = true,
    })
end

return M
