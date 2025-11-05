return {
  "rcarriga/nvim-notify",
  event = "VeryLazy",
  opts = {
    background_colour = "#000000", -- for transparent backgrounds
    stages = "fade_in_slide_out",
    timeout = 2500,
    render = "compact",
    -- 右上に表示したいので "top_down = true" にする
    top_down = true,
  },
  config = function(_, opts)
    local notify = require("notify")
    notify.setup(opts)
    vim.notify = notify
  end,
}
