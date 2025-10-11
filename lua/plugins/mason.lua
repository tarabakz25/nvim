return {
  "williamboman/mason.nvim",
  build = ":MasonUpdate",
  config = function()
    require("mason").setup({
      ui = {
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗",
        },
      },
    })
    -- ensure_installed は LSP 側で一括設定します（循環 require を避ける）
  end,
  dependencies = {
    "williamboman/mason-lspconfig.nvim",
  },
  event = "VeryLazy",
  desc = "LSP/Formatter/DAP自動インストール"
}
