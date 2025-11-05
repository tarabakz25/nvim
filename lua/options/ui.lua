-- 端末（ターミナル）の背景色をそのまま使うため、
-- 主要なハイライトグループの背景を透過（NONE）にする。
local function apply_transparent_background()
  local groups = {
    -- 基本
    "Normal", "NormalNC", "MsgArea",
    -- 行番号/記号
    "SignColumn", "LineNr", "CursorLineNr", "FoldColumn",
    -- ステータス/フロート/ボーダー
    "StatusLine", "StatusLineNC", "NormalFloat", "FloatBorder",
    -- プラグイン系
    "NeoTreeNormal", "TelescopeNormal", "TelescopeBorder",
    -- 補完メニュー
    "Pmenu", "PmenuSbar", "PmenuThumb",
    -- その他
    "EndOfBuffer",
  }

  for _, group in ipairs(groups) do
    local ok_group, existing = pcall(vim.api.nvim_get_hl, 0, { name = group, link = false })
    existing = ok_group and existing or {}
    existing.bg = "NONE"
    existing.ctermbg = "NONE"
    vim.api.nvim_set_hl(0, group, existing)
  end
end

vim.api.nvim_create_autocmd("ColorScheme", {
  pattern = "*",
  callback = apply_transparent_background,
})

-- 起動直後にも一度適用
apply_transparent_background()

-- True color and termguicolors to ensure highlight groups render correctly
vim.o.termguicolors = true
