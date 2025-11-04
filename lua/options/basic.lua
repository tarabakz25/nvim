vim.o.number = true
vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.o.expandtab = true
vim.opt.clipboard:append { "unnamedplus" }
vim.g.mapleader = " "

vim.o.autoindent = true
vim.o.smartindent = true
vim.o.cindent = true
vim.cmd [[filetype plugin indent on]]

-- パフォーマンス最適化設定
vim.o.lazyredraw = true          -- マクロ実行中に再描画を無効化（スクロール時も高速化）
vim.o.updatetime = 300           -- 300ms（デフォルト4000msから短縮して応答性向上）
vim.o.timeoutlen = 500           -- キーマッピングのタイムアウト
vim.o.ttimeoutlen = 0            -- ターミナルキーコードのタイムアウト（即座に処理）
vim.o.synmaxcol = 200            -- 長い行のシンタックスハイライトを制限（パフォーマンス向上）

-- ターミナル統合の最適化（Alacritty + tmux 環境対応）
-- TERM環境変数の確認と最適化
local term = vim.env.TERM or ""
if term:match("tmux") or term:match("screen") then
  -- Neovim では t_Co / t_ut は存在しないため設定不要
  -- Truecolor は下の termguicolors で有効化
end

-- TrueColor設定の強制（Alacritty対応）
vim.o.termguicolors = true

-- スクロール最適化
vim.o.scrolloff = 3           -- スクロールオフセット（少なめに）
vim.o.sidescrolloff = 5      -- 横スクロールオフセット
vim.o.scrolljump = 5         -- スクロールジャンプ量

-- ターミナル描画の最適化（Neovim には 'ttyfast' は存在しない）
vim.o.redrawtime = 2000      -- 再描画タイムアウト（2秒）

-- カーソル描画の最適化
vim.o.guicursor = "n-v-c-sm:block,i-ci-ve:ver25,r-cr-o:hor20"  -- カーソル形状の最適化

-- 外部プロセスによるファイル変更を自動リロード
vim.o.autoread = true

-- ファイル変更を定期的にチェック
vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter", "CursorHold", "CursorHoldI" }, {
  pattern = "*",
  callback = function()
    if vim.fn.mode() ~= 'c' then
      vim.cmd('checktime')
    end
  end,
})

-- 大きなファイルでのパフォーマンス最適化
vim.api.nvim_create_autocmd("BufReadPre", {
  callback = function()
    local line_count = vim.api.nvim_buf_line_count(0)
    -- 10000行以上のファイルでは一部のプラグイン機能を無効化
    if line_count > 10000 then
      -- Treesitterハイライトは max_file_length で制御されるため、ここではスキップ
      -- indent-blankline を無効化（必要に応じて）
      vim.g.indent_blankline_enabled = false
      -- シンタックスハイライトを軽量化
      vim.opt.syntax = "OFF"
    else
      vim.g.indent_blankline_enabled = true
      vim.opt.syntax = "ON"
    end
  end,
})
