return {
  "nvim-telescope/telescope.nvim",
  tag = "0.1.8",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope-fzf-native.nvim", -- 高速化のため
  },
  config = function()
    local telescope = require("telescope")
    local actions = require("telescope.actions")

    telescope.setup({
      defaults = {
        prompt_prefix = "🔍 ",
        selection_caret = "➜ ",
        path_display = { "truncate" },
        mappings = {
          i = {
            ["<C-j>"] = actions.move_selection_next,
            ["<C-k>"] = actions.move_selection_previous,
            ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
            ["<Esc>"] = actions.close,
          },
        },
      },
      pickers = {
        find_files = {
          theme = "dropdown",
          previewer = false,
        },
      },
    })

    -- キーマッピング設定
    local keymap = vim.keymap
    keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "ファイル検索" })
    keymap.set("n", "<leader>fg", "<cmd>Telescope live_grep<cr>", { desc = "文字列検索" })
    keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<cr>", { desc = "バッファ検索" })
    keymap.set("n", "<leader>fh", "<cmd>Telescope help_tags<cr>", { desc = "ヘルプ検索" })
    keymap.set("n", "<leader>fr", "<cmd>Telescope oldfiles<cr>", { desc = "最近開いたファイル" })
    keymap.set("n", "<leader>fc", "<cmd>Telescope commands<cr>", { desc = "コマンド検索" })
    keymap.set("n", "<leader>fk", "<cmd>Telescope keymaps<cr>", { desc = "キーマップ検索" })
  end,
  cmd = "Telescope",
}
