return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  init = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 300
  end,
  opts = {
    -- デフォルト設定
    plugins = {
      marks = true, -- マークのプレビューを表示
      registers = true, -- レジスタのプレビューを表示
      spelling = {
        enabled = true, -- z= でスペル候補を表示
        suggestions = 20,
      },
      presets = {
        operators = true,
        motions = true,
        text_objects = true,
        windows = true,
        nav = true,
        z = true,
        g = true,
      },
    },
    icons = {
      breadcrumb = "»",
      separator = "➜",
      group = "+",
    },
    window = {
      border = "rounded",
      position = "bottom",
      margin = { 1, 0, 1, 0 },
      padding = { 1, 2, 1, 2 },
    },
    layout = {
      height = { min = 4, max = 25 },
      width = { min = 20, max = 50 },
      spacing = 3,
      align = "left",
    },
  },
  config = function(_, opts)
    local wk = require("which-key")
    wk.setup(opts)

    -- グループ名を登録
    wk.add({
      { "<leader>b", group = "Buffer" },
      { "<leader>c", group = "Code" },
      { "<leader>f", group = "Find/File" },
      { "<leader>g", group = "Git" },
      { "<leader>h", group = "Git Hunk" },
      { "<leader>l", group = "Live Server/Lint" },
      { "<leader>m", group = "Markdown" },
      { "<leader>p", group = "Project" },
      { "<leader>t", group = "Toggle" },
      { "<leader>w", group = "Workspace" },
      { "<leader>x", group = "Diagnostics/Trouble" },
    })
  end,
}
