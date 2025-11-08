return {
  "rainbowhxch/accelerated-jk.nvim",
  event = "VeryLazy",
  config = function()
    require("accelerated-jk").setup()
    -- Remap j/k to accelerated motions for smoother scrolling
    vim.keymap.set("n", "j", "<Plug>(accelerated_jk_gj)", { silent = true, noremap = false })
    vim.keymap.set("n", "k", "<Plug>(accelerated_jk_gk)", { silent = true, noremap = false })
  end,
}
