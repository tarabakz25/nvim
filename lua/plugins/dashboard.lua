return {
  "nvimdev/dashboard-nvim",
  event = "VimEnter",
  config = function()
    require("dashboard").setup({
      theme = "hyper",
      config = {
        week_header = {
          enable = true,
        },
        shortcut = {
          {
            desc = "󰊳 Update",
            group = "@property",
            action = "Lazy update",
            key = "u",
          },
          {
            icon = " ",
            icon_hl = "@variable",
            desc = "Files",
            group = "Label",
            action = "Telescope find_files",
            key = "f",
          },
          {
            icon = " ",
            desc = "Recent",
            group = "Number",
            action = "Telescope oldfiles",
            key = "r",
          },
          {
            icon = " ",
            desc = "Projects",
            group = "DiagnosticHint",
            action = "Telescope projects",
            key = "p",
          },
          {
            icon = " ",
            desc = "Config",
            group = "Number",
            action = "edit ~/.config/nvim/init.lua",
            key = "c",
          },
          {
            icon = " ",
            desc = "Quit",
            group = "String",
            action = "quit",
            key = "q",
          },
        },
        packages = { enable = true },
        project = {
          enable = true,
          limit = 8,
          icon = " ",
          label = "",
          action = "Telescope find_files cwd=",
        },
        mru = {
          limit = 10,
          icon = " ",
          label = "",
        },
        footer = function()
          local stats = require("lazy").stats()
          local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
          return {
            "⚡ Neovim loaded " .. stats.loaded .. "/" .. stats.count .. " plugins in " .. ms .. "ms",
          }
        end,
      },
      hide = {
        statusline = false,
        tabline = false,
        winbar = false,
      },
      preview = {
        command = "",
        file_path = "",
        file_height = 0,
        file_width = 0,
      },
    })
  end,
  dependencies = { "nvim-tree/nvim-web-devicons" },
}
