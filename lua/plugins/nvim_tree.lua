return {
  "nvim-tree/nvim-tree.lua",
  cond = not vim.g.vscode, -- ★VSCode/Cursor内は無効
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    require("nvim-tree").setup()
  end,
  cmd = { "NvimTreeToggle", "NvimTreeFocus", "NvimTreeOpen" },
  keys = {
    { "<C-m>", "<cmd>NvimTreeToggle<CR>", desc = "エクスプローラを開閉" },
    { "<C-n>", "<cmd>NvimTreeFocus<CR>",  desc = "エクスプローラへフォーカス" },
  }
}
