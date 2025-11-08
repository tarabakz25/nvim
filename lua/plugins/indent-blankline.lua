-- lua/plugins/indent-blankline.lua
return {
  "lukas-reineke/indent-blankline.nvim",
  main = "ibl",
  opts = {
    indent = {
      char = "│",
      tab_char = "│",
    },
    scope = {
      enabled = true,
      show_start = false,
      show_end = false,
    },
    exclude = {
      filetypes = { "help", "lazy", "mason", "NvimTree", "Trouble", "dashboard" },
      buftypes = { "terminal", "nofile" },
    },
  },
  config = function(_, opts)
    -- 1) iblを初期化
    require("ibl").setup(opts)

    -- 2) hooksを正しくrequireしてから使う（ここがエラー箇所の本質）
    local hooks = require("ibl.hooks")

    -- ハイライトは前景のみ指定（bgは触らない）
    hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
      vim.api.nvim_set_hl(0, "IblIndent", { fg = "#5e5e5e", nocombine = true })
      vim.api.nvim_set_hl(0, "IblScope",  { fg = "#aaaaaa", nocombine = true })
    end)

    -- カラースキーム変更時にも再適用（背景はターミナルそのまま）
    vim.api.nvim_create_autocmd("ColorScheme", {
      group = vim.api.nvim_create_augroup("ibl-rehighlight", { clear = true }),
      callback = function()
        hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
          vim.api.nvim_set_hl(0, "IblIndent", { fg = "#5e5e5e", nocombine = true })
          vim.api.nvim_set_hl(0, "IblScope",  { fg = "#aaaaaa", nocombine = true })
        end)
        hooks.trigger(hooks.type.HIGHLIGHT_SETUP)
      end,
    })
  end,
}
