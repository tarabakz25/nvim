return {
  "folke/zen-mode.nvim",
  cmd = "ZenMode",
  keys = {
    { "<leader>tz", "<cmd>ZenMode<CR>", desc = "Zen Mode" },
  },
  opts = function()
    return {
      -- ステータスライン（フッター）を ZenMode 中も表示したいので、
      -- 有効化前の laststatus を保持する。
      plugins = {
        options = {
          enabled = true,
          laststatus = vim.o.laststatus,
        },
      },
      window = {
        width = 120,
        options = {
          number = false,
          relativenumber = false,
          signcolumn = "no",
        },
      },
    }
  end,
}
