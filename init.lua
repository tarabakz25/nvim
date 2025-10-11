vim.g.mapleader = " "

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  print("lazy.nvim が見つかりません: " .. lazypath)
  return
end
vim.opt.rtp:prepend(lazypath)

-- plugins/init.lua が table を返す想定
require("lazy").setup("plugins")

-- 基本設定
require("options.basic")
require("options.keymap")
require("options.ui")

-- LuaSnip のスニペットロード
require("luasnip.loaders.from_lua").load({
  paths = vim.fn.stdpath("config") .. "/luasnippets"
})


vim.api.nvim_create_autocmd("BufEnter", {
  nested = true,
  callback = function()
    if #vim.api.nvim_list_wins() == 1 and vim.bo.filetype == "NvimTree" then
      vim.cmd("quit")
    end
  end,
})
