return {
  "nvim-lualine/lualine.nvim",
  config = function()
    require("lualine").setup()
  end,
  event = "VimEnter",
  desc = "美しいステータスライン"
}
