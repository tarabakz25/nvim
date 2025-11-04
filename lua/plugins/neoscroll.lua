return {
  "karb94/neoscroll.nvim",
  event = "VeryLazy",
  config = function()
    require("neoscroll").setup({
      -- デフォルトのマッピング
      mappings = {
        "<C-u>",
        "<C-d>",
        "<C-b>",
        "<C-f>",
        "<C-y>",
        "<C-e>",
        "zt",
        "zz",
        "zb",
      },
      hide_cursor = true,
      stop_eof = true,
      respect_scrolloff = false,
      cursor_scrolls_alone = true,
      easing_function = nil,
      pre_hook = nil,
      post_hook = nil,
      performance_mode = true,  -- パフォーマンスモードを有効化
    })
    
    -- カスタムスクロールアニメーション設定（アニメーション時間を短縮）
    local t = {}
    t["<C-u>"] = { "scroll", { "-vim.wo.scroll", "true", "50" } }  -- 250 -> 50
    t["<C-d>"] = { "scroll", { "vim.wo.scroll", "true", "50" } }  -- 250 -> 50
    t["<C-b>"] = { "scroll", { "-vim.api.nvim_win_get_height(0)", "true", "150" } }  -- 450 -> 150
    t["<C-f>"] = { "scroll", { "vim.api.nvim_win_get_height(0)", "true", "150" } }  -- 450 -> 150
    t["<C-y>"] = { "scroll", { "-0.10", "false", "50" } }  -- 100 -> 50
    t["<C-e>"] = { "scroll", { "0.10", "false", "50" } }  -- 100 -> 50
    t["zt"] = { "zt", { "100" } }  -- 250 -> 100
    t["zz"] = { "zz", { "100" } }  -- 250 -> 100
    t["zb"] = { "zb", { "100" } }  -- 250 -> 100
    
    require("neoscroll.config").set_mappings(t)
  end,
}
