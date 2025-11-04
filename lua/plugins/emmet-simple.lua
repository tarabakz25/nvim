return {
  {
    "mattn/emmet-vim",
    event = "VeryLazy",  -- 起動後すぐに読み込む
    init = function()
      -- グローバル設定（プラグインロード前）
      vim.g.user_emmet_leader_key = "<C-e>"
      vim.g.user_emmet_install_global = 1  -- 全ファイルタイプで有効化
      vim.g.user_emmet_mode = 'inv'  -- insert, normal, visual モード
      
      -- JSX/TSX/Astro対応
      vim.g.user_emmet_settings = {
        javascript = {
          extends = "jsx",
        },
        javascriptreact = {
          extends = "jsx",
        },
        typescript = {
          extends = "tsx",
        },
        typescriptreact = {
          extends = "tsx",
        },
        astro = {
          extends = "html",
        },
        vue = {
          extends = "html",
        },
        svelte = {
          extends = "html",
        },
      }
    end,
  },
}
