return {
  -- LSP Configuration
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      -- LSP Manager
      { "williamboman/mason.nvim", config = true },
      "williamboman/mason-lspconfig.nvim",
      -- LSP Status UI
      { "j-hui/fidget.nvim", opts = {} },
      -- Neovim API の型定義（Lua LSP用）
      "folke/neodev.nvim",
    },
    config = function()
      -- neodev は lspconfig より先にセットアップ
      require("neodev").setup()

      -- キーマップ設定（LSPがアタッチされた時のみ有効）
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim. api.nvim_create_augroup("lsp-attach", { clear = true }),
        callback = function(event)
          local map = function(keys, func, desc)
            vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
          end

          -- ナビゲーション
          map("gd", vim.lsp.buf.definition, "Goto Definition")
          map("gD", vim.lsp.buf.declaration, "Goto Declaration")
          map("gr", vim. lsp.buf.references, "Goto References")
          map("gI", vim.lsp.buf.implementation, "Goto Implementation")
          map("gy", vim.lsp.buf.type_definition, "Goto Type Definition")

          -- ドキュメント
          map("K", vim.lsp.buf.hover, "Hover Documentation")
          map("<C-k>", vim.lsp.buf.signature_help, "Signature Help")

          -- アクション
          map("<leader>rn", vim.lsp.buf.rename, "Rename")
          map("<leader>ca", vim.lsp.buf.code_action, "Code Action")

          -- ワークスペース
          map("<leader>ws", vim.lsp.buf. workspace_symbol, "Workspace Symbols")

          -- 診断（Diagnostics）
          map("<leader>d", vim.diagnostic.open_float, "Open Diagnostic Float")
          map("[d", vim.diagnostic.goto_prev, "Prev Diagnostic")
          map("]d", vim.diagnostic.goto_next, "Next Diagnostic")
          map("<leader>q", vim.diagnostic.setloclist, "Diagnostic List")

          -- フォーマット機能は conform.nvim (lua/plugins/formatting.lua) に統合
        end,
      })

      -- 補完機能との連携（nvim-cmp使用時）
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      local ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
      if ok then
        capabilities = cmp_nvim_lsp.default_capabilities(capabilities)
      end

      -- 各LSPの個別設定
      local servers = {
        -- Lua
        lua_ls = {
          settings = {
            Lua = {
              workspace = { checkThirdParty = false },
              telemetry = { enable = false },
              diagnostics = { globals = { "vim" } },
            },
          },
        },
        -- TypeScript/JavaScript
        ts_ls = {},
        -- Python
        pyright = {},
        -- Rust
        rust_analyzer = {
          settings = {
            ["rust-analyzer"] = {
              checkOnSave = { command = "clippy" },
            },
          },
        },
        -- Go
        gopls = {
          settings = {
            gopls = {
              analyses = { unusedparams = true },
              staticcheck = true,
            },
          },
        },
        -- JSON
        jsonls = {},
        -- YAML
        yamlls = {},
        -- HTML/CSS
        html = {},
        cssls = {},
        -- Tailwind CSS
        tailwindcss = {},
      }

      local function with_capabilities(server)
        server = server or {}
        server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
        return server
      end

      local mason_lspconfig = require("mason-lspconfig")
      local server_names = vim.tbl_keys(servers)

      -- Neovim 0.11+ / nvim-lspconfig 2.0+: native API を使用
      if vim.lsp and vim.lsp.config and vim.lsp.enable then
        for name, server in pairs(servers) do
          vim.lsp.config(name, with_capabilities(vim.deepcopy(server)))
        end

        mason_lspconfig.setup({
          ensure_installed = server_names,
          -- automatic_enable = true, -- default
        })
      else
        -- 互換: 古い mason-lspconfig.nvim / nvim-lspconfig 向け
        mason_lspconfig.setup({
          ensure_installed = server_names,
          automatic_installation = true,
        })

        if type(mason_lspconfig.setup_handlers) == "function" then
          mason_lspconfig.setup_handlers({
            function(server_name)
              require("lspconfig")[server_name].setup(with_capabilities(servers[server_name]))
            end,
          })
        else
          for name, server in pairs(servers) do
            require("lspconfig")[name].setup(with_capabilities(server))
          end
        end
      end

      -- Diagnostic の表示設定
      vim.diagnostic.config({
        virtual_text = {
          prefix = "●",
          source = "if_many",
        },
        float = {
          source = "always",
          border = "rounded",
        },
        signs = true,
        underline = true,
        update_in_insert = false,
        severity_sort = true,
      })

      -- Diagnostic アイコン設定
      local signs = { Error = " ", Warn = " ", Hint = "󰌵 ", Info = " " }
      for type, icon in pairs(signs) do
        local hl = "DiagnosticSign" ..  type
        vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
      end
    end,
  },
}
