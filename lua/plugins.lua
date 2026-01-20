local add, now, later = MiniDeps.add, MiniDeps.now, MiniDeps.later

-- 背景透過関数
local function set_transparent()
  local groups = {
    'Normal', 'NormalNC', 'NormalFloat', 'SignColumn', 'EndOfBuffer', 'FloatBorder', 'FloatTitle',
    'MiniFilesBorder', 'MiniFilesNormal', 'MiniFilesTitle', 'MiniFilesTitleFocused',
    'MiniPickBorder', 'MiniPickNormal', 'MiniPickPrompt', 'MiniPickBorderText',
  }
  for _, group in ipairs(groups) do
    local hl = vim.api.nvim_get_hl(0, { name = group })
    hl.bg = nil
    vim.api.nvim_set_hl(0, group, hl)
  end
end

-- カラースキーム
now(function()
  add('cocopon/iceberg.vim')
  vim.cmd('colorscheme iceberg')
  set_transparent()

  vim.api.nvim_create_autocmd('ColorScheme', {
    callback = set_transparent,
  })
end)

-- 起動時に読み込む
now(function()
  require('mini.basics').setup({
    options = {
      basic = true,
      extra_ui = true,
      win_borders = 'default',
    },
    mappings = {
      basic = true,
      windows = true,
    },
  })
end)

now(function()
  require('mini.statusline').setup()
end)

now(function()
  require('mini.tabline').setup()
end)

now(function()
  require('mini.starter').setup()
end)

later(function()
  require('mini.files').setup()
  set_transparent()
end)

later(function()
  require('mini.surround').setup()
end)

later(function()
  require('mini.pairs').setup()
end)

later(function()
  require('mini.comment').setup()
end)

later(function()
  require('mini.pick').setup()
  set_transparent()
end)

later(function()
  require('mini.jump').setup()
end)

later(function()
  require('mini.jump2d').setup()
end)

later(function()
  require('mini.indentscope').setup()
end)

later(function()
  require('mini.comment').setup()
end)

later(function() 
  add('folke/zen-mode.nvim')
  require('zen-mode').setup({
    plugins = {
      options = {
        enabled = true,
        laststatus = vim.o.laststatus,
      },
    },
    window = {
      width = 120,
      options = {
        number = true,
        relativenumber = false,
        signcolumn = 'no',
      },
    },
  })
end)

later(function()
  add('rainbowhxch/accelerated-jk.nvim')
  require('accelerated-jk').setup({})
end)
