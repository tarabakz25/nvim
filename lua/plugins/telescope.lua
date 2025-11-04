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
        sorting_strategy = "ascending",
        layout_strategy = "horizontal",
        layout_config = {
          horizontal = {
            prompt_position = "top",
            preview_width = 0.55,
            results_width = 0.8,
          },
          vertical = {
            mirror = false,
          },
          width = 0.87,
          height = 0.80,
          preview_cutoff = 120,
        },
        mappings = {
          i = {
            ["<C-j>"] = actions.move_selection_next,
            ["<C-k>"] = actions.move_selection_previous,
            ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
            ["<C-x>"] = actions.select_horizontal,
            ["<C-v>"] = actions.select_vertical,
            ["<C-t>"] = actions.select_tab,
            ["<C-u>"] = actions.preview_scrolling_up,
            ["<C-d>"] = actions.preview_scrolling_down,
            ["<Esc>"] = actions.close,
          },
          n = {
            ["q"] = actions.close,
            ["<C-x>"] = actions.select_horizontal,
            ["<C-v>"] = actions.select_vertical,
            ["<C-t>"] = actions.select_tab,
          },
        },
        file_ignore_patterns = { "node_modules", ".git/", "dist/", "build/" },
      },
      pickers = {
        find_files = {
          theme = "dropdown",
          previewer = false,
          find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" },
        },
        live_grep = {
          additional_args = function()
            return { "--hidden" }
          end,
        },
      },
    })

    -- 拡張機能のロード
    telescope.load_extension("fzf")
    pcall(telescope.load_extension, "projects")

    -- キーマッピング設定
    local keymap = vim.keymap
    keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "ファイル検索" })
    keymap.set("n", "<leader>fg", "<cmd>Telescope live_grep<cr>", { desc = "文字列検索" })
    keymap.set("n", "<leader>fw", "<cmd>Telescope grep_string<cr>", { desc = "カーソル下の単語を検索" })
    keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<cr>", { desc = "バッファ検索" })
    keymap.set("n", "<leader>fh", "<cmd>Telescope help_tags<cr>", { desc = "ヘルプ検索" })
    keymap.set("n", "<leader>fr", "<cmd>Telescope oldfiles<cr>", { desc = "最近開いたファイル" })
    keymap.set("n", "<leader>fc", "<cmd>Telescope commands<cr>", { desc = "コマンド検索" })
    keymap.set("n", "<leader>fk", "<cmd>Telescope keymaps<cr>", { desc = "キーマップ検索" })
    keymap.set("n", "<leader>fs", "<cmd>Telescope lsp_document_symbols<cr>", { desc = "ドキュメントシンボル検索" })
    keymap.set("n", "<leader>fS", "<cmd>Telescope lsp_workspace_symbols<cr>", { desc = "ワークスペースシンボル検索" })
  end,
  cmd = "Telescope",
}
