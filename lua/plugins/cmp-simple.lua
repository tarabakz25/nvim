-- シンプルな補完設定（LSP不要）
return {
  "hrsh7th/nvim-cmp",
  event = "InsertEnter",
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",    -- LSP補完
    "hrsh7th/cmp-buffer",      -- バッファ補完
    "hrsh7th/cmp-path",         -- パス補完
    "hrsh7th/cmp-cmdline",      -- コマンドライン補完
    "L3MON4D3/LuaSnip",         -- スニペット
    "saadparwaiz1/cmp_luasnip", -- LuaSnip連携
    "onsails/lspkind.nvim",     -- アイコン
  },
  config = function()
    local cmp = require("cmp")
    local lspkind = require("lspkind")
    
    cmp.setup({
      snippet = {
        expand = function(args)
          require("luasnip").lsp_expand(args.body)
        end,
      },
      mapping = cmp.mapping.preset.insert({
        ["<Tab>"] = cmp.mapping.select_next_item(),
        ["<S-Tab>"] = cmp.mapping.select_prev_item(),
        ["<CR>"] = cmp.mapping.confirm({ select = true }),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-e>"] = cmp.mapping.abort(),
      }),
      sources = cmp.config.sources({
        { name = "nvim_lsp", priority = 15 },
        { name = "luasnip", priority = 10 },
        { name = "buffer", priority = 8 },
        { name = "path", priority = 7 },
      }),
      formatting = {
        format = lspkind.cmp_format({
          mode = "symbol_text",
          maxwidth = 50,
        }),
      },
      performance = {
        max_view_entries = 20,  -- 表示する候補数を制限
      },
    })
    
    -- コマンドライン補完
    cmp.setup.cmdline(":", {
      mapping = cmp.mapping.preset.cmdline(),
      sources = {
        { name = "path" },
        { name = "cmdline" },
      },
    })
    
    -- 検索補完
    cmp.setup.cmdline({ "/", "?" }, {
      mapping = cmp.mapping.preset.cmdline(),
      sources = {
        { name = "buffer" },
      },
    })
  end,
}
