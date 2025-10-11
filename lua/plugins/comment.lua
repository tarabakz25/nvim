return {
  "numToStr/Comment.nvim",
  config = function()
    require("Comment").setup()
  end,
  keys = { "gc", "gb" },
  desc = "コメントアウト"
}

