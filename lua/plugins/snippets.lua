-- plugins/snippets.lua

return {
  -- LuaSnip本体
  {
    "L3MON4D3/LuaSnip",
    version = "v2.*",
    build = "make install_jsregexp",
    dependencies = {
      -- VSCode形式のスニペットを読み込むためのプラグイン
      "rafamadriz/friendly-snippets",
    },
    config = function()
      require("luasnip.loaders.from_vscode").lazy_load()
    end,
  },
}

