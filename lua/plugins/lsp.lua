return {
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
      vim.filetype.add({ extension = { ino = "arduino" } })

      -- capabilities (augmented by nvim-cmp if present)
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      local ok_cmp, cmp_lsp = pcall(require, "cmp_nvim_lsp")
      if ok_cmp then
        capabilities = cmp_lsp.default_capabilities(capabilities)
      end

      local function board_fqbn()
        local fqbn = vim.g.arduino_fqbn or os.getenv("ARDUINO_FQBN")
        if fqbn and fqbn ~= "" then
          return fqbn
        end
        return "arduino:avr:uno"
      end

      local function arduino_cmd()
        local binary = vim.fn.expand("~/go/bin/arduino-language-server")
        local cli = "/opt/homebrew/bin/arduino-cli"
        if vim.fn.executable(binary) == 0 then
          vim.notify("arduino-language-server が見つかりません: " .. binary, vim.log.levels.ERROR)
        end
        if vim.fn.executable(cli) == 0 then
          vim.notify("arduino-cli が見つかりません: " .. cli, vim.log.levels.ERROR)
        end
        return {
          binary,
          "-cli", cli,
          "-cli-config", vim.fn.expand("~/Library/Arduino15/arduino-cli.yaml"),
          "-fqbn", board_fqbn(),
        }
      end

      local function attach_keymaps(bufnr)
        local map = function(mode, lhs, rhs, desc)
          vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
        end
        map("n", "gd", vim.lsp.buf.definition, "Go to definition")
        map("n", "gD", vim.lsp.buf.declaration, "Go to declaration")
        map("n", "gi", vim.lsp.buf.implementation, "Go to implementation")
        map("n", "gr", vim.lsp.buf.references, "Find references")
        map("n", "K", vim.lsp.buf.hover, "Hover")
        map("n", "<leader>rn", vim.lsp.buf.rename, "Rename symbol")
        map("n", "<leader>ca", vim.lsp.buf.code_action, "Code action")
        map("n", "<leader>cf", function()
          vim.lsp.buf.format({ async = true })
        end, "Format buffer")
      end

      local function run_cli(subcommand, extra_args)
        local file = vim.api.nvim_buf_get_name(0)
        if file == "" then
          vim.notify("ファイルが保存されていません", vim.log.levels.ERROR)
          return
        end
        local fqbn = board_fqbn()
        local sketch_dir = vim.fn.fnamemodify(file, ":p:h")
        local cmd = {
          "/opt/homebrew/bin/arduino-cli",
          subcommand,
          "--fqbn",
          fqbn,
          sketch_dir,
        }
        if extra_args then
          for _, value in ipairs(extra_args) do
            table.insert(cmd, value)
          end
        end
        local title = "arduino-cli " .. subcommand
        local lines = {}
        vim.fn.jobstart(cmd, {
          stdout_buffered = true,
          stderr_buffered = true,
          on_stdout = function(_, data)
            if data then
              for _, line in ipairs(data) do
                if line ~= "" then
                  table.insert(lines, line)
                end
              end
            end
          end,
          on_stderr = function(_, data)
            if data then
              for _, line in ipairs(data) do
                if line ~= "" then
                  table.insert(lines, line)
                end
              end
            end
          end,
          on_exit = function(_, code)
            vim.schedule(function()
              vim.fn.setqflist({}, " ", { title = title, lines = lines })
              if code == 0 then
                vim.notify(title .. " 成功", vim.log.levels.INFO)
              else
                vim.notify(title .. " 失敗", vim.log.levels.ERROR)
                vim.cmd("copen")
              end
            end)
          end,
        })
      end

      if not vim.g.arduino_commands_loaded then
        vim.g.arduino_commands_loaded = true

        vim.api.nvim_create_user_command("ArduinoCompile", function()
          run_cli("compile")
        end, {})

        vim.api.nvim_create_user_command("ArduinoUpload", function(opts)
          local args = nil
          if opts.args ~= "" then
            args = { "--port", opts.args }
          end
          run_cli("upload", args)
        end, { nargs = "?" })
      end

      -- Migrate away from require('lspconfig') to vim.lsp.config/vim.lsp.enable
      -- See :help lspconfig-nvim-0.11
      vim.lsp.config("arduino_language_server", {
        capabilities = capabilities,
        cmd = arduino_cmd(),
        filetypes = { "arduino" },
        -- Prefer root markers; falls back to .git if present
        root_markers = { "arduino.json", ".git" },
      })

      -- Keymaps when any LSP attaches
      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
          attach_keymaps(args.buf)
        end,
      })

      -- Enable the server (starts per-filetype when needed)
      vim.lsp.enable("arduino_language_server")

      -- Commands
      -- Restart arduino_language_server after FQBN changes so new cmd() is used
      vim.api.nvim_create_user_command("ArduinoFqbn", function(opts)
        vim.g.arduino_fqbn = opts.args
        vim.notify("FQBN を " .. opts.args .. " に設定しました", vim.log.levels.INFO)
        -- disable then re-enable to restart with updated cmd
        vim.lsp.enable("arduino_language_server", false)
        vim.lsp.enable("arduino_language_server", true)
      end, { nargs = 1 })
    end,
  },
}
