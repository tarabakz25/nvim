return {
  "folke/noice.nvim",
  event = "VeryLazy",
  dependencies = {
    "MunifTanjim/nui.nvim",
    "rcarriga/nvim-notify", -- 推奨: 通知の UI を改善
  },
  opts = {
    lsp = {
      progress = { enabled = true },
      -- LSP ドキュメント表示を noice/markdown に委譲
      override = {
        ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
        ["vim.lsp.util.stylize_markdown"] = true,
        ["cmp.entry.get_documentation"] = true,
      },
    },
    presets = {
      bottom_search = true,        -- 画面下部の検索 UI
      command_palette = true,      -- : と / の UI を整える
      long_message_to_split = true,
      lsp_doc_border = true,
    },
  },
  config = function(_, opts)
    -- nvim-notify があれば既定の通知にする
    local ok, notify = pcall(require, "notify")
    if ok then vim.notify = notify end
    require("noice").setup(opts)
  end,
}

