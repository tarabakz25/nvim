return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  config = function()
    require("nvim-treesitter.configs").setup({
      ensure_installed = {
        "javascript",
        "typescript",
        "tsx",
        "html",
        "css",
        "scss",
        "json",
        "vue",
        "lua",
        "vim",
        "vimdoc",
        "markdown",
        "markdown_inline",
        "bash",
        "prisma",
        "dart",
      },
      highlight = { 
        enable = true,
        disable = {},  -- 必要に応じて特定のファイルタイプを無効化可能
        additional_vim_regex_highlighting = { "markdown" },
        -- パフォーマンス最適化
        max_file_length = 100000,  -- 10万行以上のファイルでは無効化
      },
      indent = { enable = true },
    })
  end,
  event = { "BufReadPost", "BufNewFile" },
}
