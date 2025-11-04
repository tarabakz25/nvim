local function apply_theme_background()
  local ok, normal = pcall(vim.api.nvim_get_hl, 0, { name = "Normal", link = false })
  if not ok or not normal or not normal.bg then
    return
  end

  local groups = {
    "NormalNC", "EndOfBuffer",
    "SignColumn", "LineNr", "CursorLineNr",
    "MsgArea", "StatusLine", "NvimTreeNormal",
    "TelescopeNormal", "TelescopeBorder",
  }

  for _, group in ipairs(groups) do
    local ok_group, existing = pcall(vim.api.nvim_get_hl, 0, { name = group, link = false })
    existing = ok_group and existing or {}
    existing.bg = normal.bg
    vim.api.nvim_set_hl(0, group, existing)
  end
end

vim.api.nvim_create_autocmd("ColorScheme", {
  pattern = "*",
  callback = apply_theme_background,
})

-- 起動直後に一度だけ実行（colorscheme を後から変える人は不要）
apply_theme_background()

-- True color and termguicolors to ensure highlight groups render correctly
vim.o.termguicolors = true
