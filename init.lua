-- 基本設定
require('basics')

-- mini.nvim のパス設定
local path_package = vim.fn.stdpath('data') .. '/site'
local mini_path = path_package .. '/pack/deps/start/mini.nvim'

-- mini.nvim をインストール（なければ）
if not vim.loop.fs_stat(mini_path) then
  vim.cmd('echo "Installing `mini.nvim`" | redraw')
  local clone_cmd = {
    'git', 'clone', '--filter=blob:none',
    'https://github.com/echasnovski/mini.nvim', mini_path
  }
  vim.fn.system(clone_cmd)
  vim.cmd('packadd mini.nvim | helptags ALL')
  vim.cmd('echo "Installed `mini.nvim`" | redraw')
end

-- mini.deps をセットアップ
require('mini.deps').setup({ path = { package = path_package } })

-- プラグイン読み込み
require('plugins')
require('keymap')
