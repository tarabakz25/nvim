return {
  "tpope/vim-sleuth",
  -- タブ幅を自動検出（設定不要）
  -- ファイルを開いた際に自動でインデント設定を適用
  event = { "BufReadPre", "BufNewFile" },
}
