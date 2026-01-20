return {
  -- フォーマッター統合
  {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    keys = {
      {
        "<leader>f",
        function()
          require("conform").format({ async = true, lsp_fallback = true })
        end,
        mode = "",
        desc = "Format buffer",
      },
    },
    opts = {
      formatters_by_ft = {
        javascript = { "prettier" },
        typescript = { "prettier" },
        javascriptreact = { "prettier" },
        typescriptreact = { "prettier" },
        vue = { "prettier" },
        css = { "prettier" },
        scss = { "prettier" },
        html = { "prettier" },
        json = { "prettier" },
        jsonc = { "prettier" },
        yaml = { "prettier" },
        markdown = { "prettier" },
        lua = { "stylua" },
        rust = { "rustfmt" },
        go = { "gofmt" },
        python = { "black" },
      },
      format_on_save = function(bufnr)
        -- グローバル変数で保存時フォーマットを制御
        if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
          return
        end
        return {
          timeout_ms = 500,
          lsp_fallback = true,
        }
      end,
    },
    init = function()
      -- フォーマット有効/無効切り替えコマンド
      vim.api.nvim_create_user_command("FormatDisable", function(args)
        if args.bang then
          vim.b.disable_autoformat = true
        else
          vim.g.disable_autoformat = true
        end
      end, {
        desc = "Disable autoformat-on-save",
        bang = true,
      })
      vim.api.nvim_create_user_command("FormatEnable", function()
        vim.b.disable_autoformat = false
        vim.g.disable_autoformat = false
      end, {
        desc = "Re-enable autoformat-on-save",
      })
    end,
  },

  -- リンター統合
  {
    "mfussenegger/nvim-lint",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      local lint = require("lint")

      local function pick_eslint()
        if vim.fn.executable("eslint_d") == 1 then
          return "eslint_d"
        end
        if vim.fn.executable("eslint") == 1 then
          return "eslint"
        end
        return nil
      end

      local linters_by_ft = {
        python = { "pylint" },
      }

      local eslint = pick_eslint()
      if eslint then
        linters_by_ft.javascript = { eslint }
        linters_by_ft.typescript = { eslint }
        linters_by_ft.javascriptreact = { eslint }
        linters_by_ft.typescriptreact = { eslint }
        linters_by_ft.vue = { eslint }
      end

      lint.linters_by_ft = linters_by_ft

      -- リント実行タイミング
      local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })
      vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
        group = lint_augroup,
        callback = function()
          lint.try_lint()
        end,
      })

      -- 手動リント実行コマンド
      vim.keymap.set("n", "<leader>li", function()
        lint.try_lint()
      end, { desc = "Trigger linting" })
    end,
  },
}
