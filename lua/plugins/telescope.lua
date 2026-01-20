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
    local builtin = require("telescope.builtin")

    local has_rg = vim.fn.executable("rg") == 1
    local has_fd = vim.fn.executable("fd") == 1

    local find_files_command
    if has_rg then
      find_files_command = {
        "rg",
        "--files",
        "--hidden",
        "--glob",
        "!**/.git/*",
        "--glob",
        "!**/node_modules/*",
        "--glob",
        "!**/dist/*",
        "--glob",
        "!**/build/*",
      }
    elseif has_fd then
      find_files_command = {
        "fd",
        "--type",
        "f",
        "--hidden",
        "--exclude",
        ".git",
        "--exclude",
        "node_modules",
        "--exclude",
        "dist",
        "--exclude",
        "build",
      }
    else
      find_files_command = {
        "find",
        ".",
        "-path",
        "*/.git",
        "-prune",
        "-o",
        "-path",
        "*/node_modules",
        "-prune",
        "-o",
        "-path",
        "*/dist",
        "-prune",
        "-o",
        "-path",
        "*/build",
        "-prune",
        "-o",
        "-type",
        "f",
        "-print",
      }
    end

    local function require_rg(feature)
      if has_rg then
        return true
      end
      vim.notify(
        ("Telescope %s requires ripgrep (`rg`). Install it and ensure it is on $PATH."):format(feature),
        vim.log.levels.ERROR
      )
      return false
    end

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
          find_command = find_files_command,
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
    keymap.set("n", "<leader>ff", builtin.find_files, { desc = "ファイル検索" })
    keymap.set("n", "<leader>fg", function()
      if require_rg("live_grep") then
        builtin.live_grep()
      end
    end, { desc = "文字列検索" })
    keymap.set("n", "<leader>fw", function()
      if require_rg("grep_string") then
        builtin.grep_string()
      end
    end, { desc = "カーソル下の単語を検索" })
    keymap.set("n", "<leader>fb", builtin.buffers, { desc = "バッファ検索" })
    keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "ヘルプ検索" })
    keymap.set("n", "<leader>fr", builtin.oldfiles, { desc = "最近開いたファイル" })
    keymap.set("n", "<leader>fc", builtin.commands, { desc = "コマンド検索" })
    keymap.set("n", "<leader>fk", builtin.keymaps, { desc = "キーマップ検索" })
    keymap.set("n", "<leader>fs", builtin.lsp_document_symbols, { desc = "ドキュメントシンボル検索" })
    keymap.set("n", "<leader>fS", builtin.lsp_workspace_symbols, { desc = "ワークスペースシンボル検索" })
  end,
  cmd = "Telescope",
}
