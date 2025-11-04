return {
  "nanotech/jellybeans.vim",
  name = "jellybeans",
  lazy = false,
  priority = 1000,
  config = function()
    vim.opt.termguicolors = true
    vim.cmd.colorscheme("jellybeans")
  end,
}

