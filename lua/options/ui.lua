vim.api.nvim_create_autocmd("ColorScheme", {
  pattern = "*",
  callback = function()
    local groups = {
      "Normal", "NormalNC", "EndOfBuffer",
      "SignColumn", "LineNr", "CursorLineNr",
      "MsgArea", "StatusLine", "NvimTreeNormal",
      "TelescopeNormal", "TelescopeBorder",
    }
    for _, g in ipairs(groups) do
      vim.api.nvim_set_hl(0, g, { bg = "none" })
    end
  end,
})

-- 起動直後に一度だけ実行（colorscheme を後から変える人は不要）
vim.cmd("doautocmd ColorScheme")

-- True color and termguicolors to ensure highlight groups render correctly
vim.o.termguicolors = true
