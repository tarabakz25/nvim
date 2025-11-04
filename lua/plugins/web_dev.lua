-- Web開発に特化したプラグイン
return {
  -- SchemaStore for JSON schemas
  {
    "b0o/schemastore.nvim",
    lazy = true,
  },
  
  
  -- Auto close HTML tags
  {
    "windwp/nvim-ts-autotag",
    ft = { "html", "javascript", "javascriptreact", "typescript", "typescriptreact", "vue" },
    config = function()
      require("nvim-ts-autotag").setup()
    end,
  },
  
  -- CSS color preview
  {
    "norcalli/nvim-colorizer.lua",
    ft = { "css", "scss", "less", "html", "javascript", "javascriptreact", "typescript", "typescriptreact" },
    config = function()
      require("colorizer").setup({
        css = { css = true },
        scss = { css = true },
        less = { css = true },
        html = { css = true },
        javascript = { css = true },
        javascriptreact = { css = true },
        typescript = { css = true },
        typescriptreact = { css = true },
      })
    end,
  },
  
  -- Prettier formatting
  {
    "prettier/vim-prettier",
    ft = { "javascript", "javascriptreact", "typescript", "typescriptreact", "json", "css", "scss", "html", "vue" },
    config = function()
      vim.g["prettier#autoformat"] = 1
      vim.g["prettier#autoformat_require_pragma"] = 0
    end,
  },
}