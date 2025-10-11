return {
  -- ★ VSCode/Cursor 内では Neovim の LSP を起動しない
  {
    "neovim/nvim-lspconfig",
    cond = not vim.g.vscode,
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      -- diagnostics 表示・サイン・UI
      local signs = { Error = " ", Warn = " ", Hint = "󰌵 ", Info = " " }
      for type, icon in pairs(signs) do
        local hl = "DiagnosticSign" .. type
        vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
      end
      vim.diagnostic.config({
        virtual_text = { prefix = "●", spacing = 2 },
        signs = true,
        underline = true,
        update_in_insert = false,
        severity_sort = true,
        float = { border = "rounded", source = "if_many" },
      })
      vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })
      vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" })

      -- capabilities (nvim-cmp 連携)
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      local ok_cmp, cmp_lsp = pcall(require, "cmp_nvim_lsp")
      if ok_cmp then
        capabilities = cmp_lsp.default_capabilities(capabilities)
      end

      -- on_attach: 共通キーマップ等
      local on_attach = function(client, bufnr)
        local map = function(mode, lhs, rhs, desc)
          vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, silent = true, noremap = true, desc = desc })
        end
        map("n", "K", vim.lsp.buf.hover, "LSP Hover")
        map("n", "gd", vim.lsp.buf.definition, "Go to Definition")
        map("n", "gD", vim.lsp.buf.declaration, "Go to Declaration")
        map("n", "gi", vim.lsp.buf.implementation, "Go to Implementation")
        map("n", "gr", vim.lsp.buf.references, "References")
        map("n", "gt", vim.lsp.buf.type_definition, "Type Definition")
        map("n", "<leader>rn", vim.lsp.buf.rename, "Rename Symbol")
        map("n", "<leader>ca", vim.lsp.buf.code_action, "Code Action")
        map("n", "gl", vim.diagnostic.open_float, "Line Diagnostics")
        map("n", "[d", vim.diagnostic.goto_prev, "Prev Diagnostic")
        map("n", "]d", vim.diagnostic.goto_next, "Next Diagnostic")
        map({ "n", "v" }, "<leader>f", function()
          vim.lsp.buf.format({ async = false })
        end, "Format")

        -- tsserver はフォーマット無効化（Prettier 等と競合回避）
        if client.name == "ts_ls" then
          client.server_capabilities.documentFormattingProvider = false
          client.server_capabilities.documentRangeFormattingProvider = false
        end
      end

      local lspconfig = require("lspconfig")

      -- mason-lspconfig は自動有効化を無効化して、個別に setup する
      local ok_mlsp, mason_lspconfig = pcall(require, "mason-lspconfig")
      if ok_mlsp then
        mason_lspconfig.setup({ automatic_enable = false, ensure_installed = { "prismals" } })
        -- 個別設定（下のフォールバックと同一設定）
        lspconfig.ts_ls.setup({
          capabilities = capabilities,
          on_attach = on_attach,
          settings = {
            typescript = { preferences = { includePackageJsonAutoImports = "on" } },
            javascript = { preferences = { includePackageJsonAutoImports = "on" } },
          },
          filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
        })
        lspconfig.tailwindcss.setup({ capabilities = capabilities, on_attach = on_attach })
        lspconfig.html.setup({ capabilities = capabilities, on_attach = on_attach, filetypes = { "html", "templ" } })
        lspconfig.cssls.setup({
          capabilities = capabilities,
          on_attach = on_attach,
          filetypes = { "css", "scss", "less" },
          settings = { css = { validate = true }, less = { validate = true }, scss = { validate = true } },
        })
        local ok_ss, schemastore = pcall(require, "schemastore")
        lspconfig.jsonls.setup({
          capabilities = capabilities,
          on_attach = on_attach,
          settings = { json = { schemas = ok_ss and schemastore.json.schemas() or nil, validate = { enable = true } } },
        })
        lspconfig.volar.setup({ capabilities = capabilities, on_attach = on_attach, filetypes = { "vue" } })
        lspconfig.emmet_ls.setup({
          capabilities = capabilities,
          on_attach = on_attach,
          filetypes = { "html", "css", "scss", "javascript", "javascriptreact", "typescript", "typescriptreact", "vue" },
        })
        lspconfig.lua_ls.setup({
          capabilities = capabilities,
          on_attach = on_attach,
          settings = {
            Lua = {
              runtime = { version = "LuaJIT" },
              diagnostics = { globals = { "vim" } },
              workspace = { checkThirdParty = false, library = { vim.env.VIMRUNTIME } },
              telemetry = { enable = false },
            },
          },
        })
        lspconfig.prismals.setup({ capabilities = capabilities, on_attach = on_attach })
      else
        -- フォールバック: 既存の個別設定
        lspconfig.ts_ls.setup({ capabilities = capabilities, on_attach = on_attach })
        lspconfig.tailwindcss.setup({ capabilities = capabilities, on_attach = on_attach })
        lspconfig.html.setup({ capabilities = capabilities, on_attach = on_attach, filetypes = { "html", "templ" } })
        lspconfig.cssls.setup({
          capabilities = capabilities,
          on_attach = on_attach,
          filetypes = { "css", "scss", "less" },
          settings = { css = { validate = true }, less = { validate = true }, scss = { validate = true } },
        })
        local ok_ss, schemastore = pcall(require, "schemastore")
        lspconfig.jsonls.setup({
          capabilities = capabilities,
          on_attach = on_attach,
          settings = { json = { schemas = ok_ss and schemastore.json.schemas() or nil, validate = { enable = true } } },
        })
        lspconfig.volar.setup({ capabilities = capabilities, on_attach = on_attach, filetypes = { "vue" } })
        lspconfig.emmet_ls.setup({
          capabilities = capabilities,
          on_attach = on_attach,
          filetypes = { "html", "css", "scss", "javascript", "javascriptreact", "typescript", "typescriptreact", "vue" },
        })
        lspconfig.lua_ls.setup({
          capabilities = capabilities,
          on_attach = on_attach,
          settings = {
            Lua = {
              runtime = { version = "LuaJIT" },
              diagnostics = { globals = { "vim" } },
              workspace = { checkThirdParty = false, library = { vim.env.VIMRUNTIME } },
              telemetry = { enable = false },
            },
          },
        })
        lspconfig.prismals.setup({ capabilities = capabilities, on_attach = on_attach })
      end
    end,
  },

  -- Telescope も VSCode 内では無効化（任意）
  {
    "nvim-telescope/telescope.nvim",
    cond = not vim.g.vscode,
    keys = {
      { "<leader>d", "<cmd>Telescope diagnostics<CR>", desc = "Telescope diagnostics" },
      { "<leader>b", "<cmd>lua vim.diagnostic.open_float()<CR>", desc = "Diagnostics detail" },
    },
  },
}
