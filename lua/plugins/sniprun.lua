return {
  "michaelb/sniprun",
  build = "sh install.sh",
  cmd = { "SnipRun", "SnipInfo", "SnipReset", "SnipClose", "SnipReplMemoryClean", "SnipTerminate" },
  config = function()
    require("sniprun").setup({
      selected_interpreters = {},
      repl_enable = {},
      repl_disable = {},
      interpreter_options = {
        GFM_original = {
          use_on_filetypes = { "markdown.pandoc" }
        },
        Python3_original = {
          error_truncate = "auto"
        },
      },
      display = {
        "Classic",
        "VirtualText",
      },
      live_display = { "VirtualText" },
      display_options = {
        terminal_scrollback = vim.o.scrollback,
        terminal_line_number = false,
        terminal_signcolumn = false,
        terminal_persistence = true,
        terminal_width = 45,
        notification_timeout = 5
      },
      show_no_output = {
        "Classic",
        "TempFloatingWindow",
      },
      snipruncolors = {
        SniprunVirtualTextOk = { bg = "#66eeff", fg = "#000000", ctermbg = "Cyan", ctermfg = "Black" },
        SniprunFloatingWinOk = { fg = "#66eeff", ctermfg = "Cyan" },
        SniprunVirtualTextErr = { bg = "#881515", fg = "#000000", ctermbg = "DarkRed", ctermfg = "Black" },
        SniprunFloatingWinErr = { fg = "#881515", ctermfg = "DarkRed" },
      },
      live_mode_toggle = "off",
      inline_messages = false,
      borders = "rounded",
    })
    
    -- キーマップ
    vim.keymap.set("v", "<leader>r", "<Plug>SnipRun", { desc = "Run Selected Code" })
    vim.keymap.set("n", "<leader>r", "<Plug>SnipRunOperator", { desc = "Run Code" })
    vim.keymap.set("n", "<leader>rr", "<Plug>SnipRun", { desc = "Run Line" })
    vim.keymap.set("n", "<leader>rc", "<Plug>SnipReset", { desc = "Reset SnipRun" })
    vim.keymap.set("n", "<leader>rx", "<Plug>SnipClose", { desc = "Close SnipRun" })
    vim.keymap.set("n", "<leader>ri", "<Plug>SnipInfo", { desc = "SnipRun Info" })
  end,
}
