return {
  "ahmedkhalf/project.nvim",
  event = "VeryLazy",
  config = function()
    require("project_nvim").setup({
      -- 検出方法
      detection_methods = { "lsp", "pattern" },
      
      -- プロジェクトのルートを示すパターン
      patterns = {
        ".git",
        "_darcs",
        ".hg",
        ".bzr",
        ".svn",
        "Makefile",
        "package.json",
        "pom.xml",
        "Cargo.toml",
        "go.mod",
        "pyproject.toml",
        "requirements.txt",
      },
      
      -- カレントディレクトリを自動的にプロジェクトルートに変更
      silent_chdir = true,
      
      -- プロジェクト変更時にコマンド実行
      scope_chdir = "global",
      
      -- パスの除外
      ignore_lsp = {},
      
      -- 手動モード
      manual_mode = false,
      
      -- データパス
      datapath = vim.fn.stdpath("data"),
      
      -- 除外ディレクトリ
      exclude_dirs = {},
      
      -- シンボリックリンクをたどる
      show_hidden = false,
    })
    
    -- Telescope拡張をロード
    pcall(require("telescope").load_extension, "projects")
    
    -- キーマップ
    vim.keymap.set("n", "<leader>fp", "<cmd>Telescope projects<CR>", { desc = "Projects" })
  end,
}
