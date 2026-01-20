return {
  "nvim-lualine/lualine.nvim",
  config = function()
    vim.o.laststatus = 0

    require("lualine").setup({
      options = {
        theme = "auto",
        globalstatus = false,
        disabled_filetypes = {
          winbar = { "TelescopePrompt", "neo-tree" },
        },
      },
      sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {},
        lualine_x = {},
        lualine_y = {},
        lualine_z = {},
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {},
        lualine_x = {},
        lualine_y = {},
        lualine_z = {},
      },
      winbar = {
        lualine_a = { "mode" },
        lualine_b = { "branch", "diff" },
        lualine_c = { { "filename", path = 1 } },
        lualine_x = { "diagnostics" },
        lualine_y = { "filetype" },
        lualine_z = { "location" },
      },
      inactive_winbar = {
        lualine_c = { { "filename", path = 1 } },
      },
    })
  end,
  event = "VimEnter",
  desc = "美しいステータスライン"
}
