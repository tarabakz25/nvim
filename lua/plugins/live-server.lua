return {
  "wolandark/vim-live-server",
  cmd = { "LiveServerStart", "LiveServerStop" },
  keys = {
    { "<leader>ls", "<cmd>LiveServerStart<CR>", desc = "Live Server 開始" },
    { "<leader>lq", "<cmd>LiveServerStop<CR>", desc = "Live Server 停止" },
  },
}

