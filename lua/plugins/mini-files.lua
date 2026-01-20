return {
  "echasnovski/mini.files",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  keys = {
    {
      "<leader>e",
      function()
        require("mini.files").open()
      end,
      desc = "MiniFiles: Open (current dir)",
    },
    {
      "<leader>E",
      function()
        require("mini.files").open(vim.loop.cwd(), true)
      end,
      desc = "MiniFiles: Open CWD",
    },
    {
      "<C-m>",
      function()
        require("mini.files").open()
      end,
      desc = "MiniFiles: Open (current dir)",
    },
    {
      "<C-n>",
      function()
        require("mini.files").open(vim.loop.cwd(), true)
      end,
      desc = "MiniFiles: Open CWD",
    },
  },
  opts = {
    options = {
      use_as_default_explorer = true,
    },
    windows = {
      preview = true,
      width_focus = 30,
      width_preview = 60,
    },
  },
  config = function(_, opts)
    -- Disable netrw to avoid conflicts when using mini.files as explorer.
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1

    require("mini.files").setup(opts)

    -- Map <CR> to open file/enter directory without overriding default `l`.
    vim.api.nvim_create_autocmd("User", {
      pattern = "MiniFilesBufferCreate",
      callback = function(args)
        local buf_id = args.data.buf_id
        vim.keymap.set("n", "<CR>", function()
          require("mini.files").go_in()
        end, { buffer = buf_id, desc = "MiniFiles: Go in/open" })

        -- Skip confirmation prompt during synchronization (`=`).
        -- Still requires explicit `=` to apply edits, but does not ask `y/n`.
        vim.keymap.set("n", "=", function()
          local confirm_orig = vim.fn.confirm
          vim.fn.confirm = function()
            return 1 -- "Yes"
          end
          local ok, err = pcall(function()
            require("mini.files").synchronize()
          end)
          vim.fn.confirm = confirm_orig
          if not ok then error(err) end
        end, { buffer = buf_id, desc = "MiniFiles: Synchronize (no confirm)" })
      end,
    })
  end,
}
