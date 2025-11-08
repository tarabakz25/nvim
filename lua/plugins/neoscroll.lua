return {
  "karb94/neoscroll.nvim",
  event = "VeryLazy",
  config = function()
    -- Use helper functions and normal keymaps (set_mappings is deprecated)
    require("neoscroll").setup({
      mappings = {}, -- we'll map keys ourselves below
      hide_cursor = true,
      stop_eof = true,
      respect_scrolloff = false,
      cursor_scrolls_alone = true,
      easing_function = nil,
      pre_hook = nil,
      post_hook = nil,
      performance_mode = true,
    })

    local neoscroll = require("neoscroll")
    local modes = { "n", "v", "x" }
    local map = function(lhs, rhs)
      vim.keymap.set(modes, lhs, rhs, { silent = true, desc = "Neoscroll " .. lhs })
    end

    -- durations tuned to your previous config
    map("<C-u>", function() neoscroll.ctrl_u({ duration = 50 }) end)
    map("<C-d>", function() neoscroll.ctrl_d({ duration = 50 }) end)
    map("<C-b>", function() neoscroll.ctrl_b({ duration = 150 }) end)
    map("<C-f>", function() neoscroll.ctrl_f({ duration = 150 }) end)
    map("<C-y>", function() neoscroll.scroll(-0.10, { move_cursor = false, duration = 50 }) end)
    map("<C-e>", function() neoscroll.scroll( 0.10, { move_cursor = false, duration = 50 }) end)
    map("zt",     function() neoscroll.zt({ duration = 100 }) end)
    map("zz",     function() neoscroll.zz({ duration = 100 }) end)
    map("zb",     function() neoscroll.zb({ duration = 100 }) end)
  end,
}
