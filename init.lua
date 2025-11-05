vim.g.mapleader = " "

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  print("lazy.nvim が見つかりません: " .. lazypath)
  return
end
vim.opt.rtp:prepend(lazypath)

-- Compatibility: silence plugins still calling deprecated APIs
-- Replace deprecated vim.lsp.buf_get_clients() with vim.lsp.get_clients()
if vim.lsp and vim.lsp.get_clients and vim.lsp.buf_get_clients then
  vim.lsp.buf_get_clients = function(bufnr)
    local opts = {}
    if bufnr ~= nil then opts.bufnr = bufnr end
    return vim.lsp.get_clients(opts)
  end
end

-- plugins/init.lua が table を返す想定
require("lazy").setup("plugins")

-- 基本設定
require("options.basic")
require("options.keymap")
require("options.ui")
require("options.devserver")

-- LuaSnip のスニペットロード
require("luasnip.loaders.from_lua").load({
  paths = vim.fn.stdpath("config") .. "/luasnippets"
})


-- 以前は「ファイラーだけが残ったら終了」していたが、
-- <leader>x で最後のバッファを閉じた際に意図せず Neovim が終了するため無効化。
