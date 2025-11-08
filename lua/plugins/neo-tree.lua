return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  cmd = "Neotree",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
  },
  keys = {
    { "<leader>e", "<cmd>Neotree toggle<CR>", desc = "Neo-tree: Toggle" },
    { "<leader>E", "<cmd>Neotree focus<CR>",  desc = "Neo-tree: Focus"  },
  },
  opts = {
    close_if_last_window = true,
    popup_border_style = "rounded",
    filesystem = {
      visible = true,
      hide_dotfiles = false,
      bind_to_cwd = true,
      follow_current_file = { enabled = true },
      use_libuv_file_watcher = true,
      hijack_netrw_behavior = "open_default",
    },
    window = {
      width = 32,
      mappings = {
        ["<space>"] = "none", -- leader 衝突回避
      },
    },
  },
}

