return {
  "lewis6991/gitsigns.nvim",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    require("gitsigns").setup({
      signs = {
        add = { text = "│" },
        change = { text = "│" },
        delete = { text = "_" },
        topdelete = { text = "‾" },
        changedelete = { text = "~" },
        untracked = { text = "┆" },
      },
      signcolumn = true,
      numhl = false,
      linehl = false,
      word_diff = false,
      watch_gitdir = {
        follow_files = true
      },
      attach_to_untracked = true,
      current_line_blame = false,
      current_line_blame_opts = {
        virt_text = true,
        virt_text_pos = "eol",
        delay = 1000,
        ignore_whitespace = false,
      },
      sign_priority = 6,
      update_debounce = 100,
      status_formatter = nil,
      max_file_length = 40000,
      preview_config = {
        border = "rounded",
        style = "minimal",
        relative = "cursor",
        row = 0,
        col = 1
      },
      on_attach = function(bufnr)
        local gs = package.loaded.gitsigns
        local map = vim.keymap.set
        
        -- Navigation
        map("n", "]c", function()
          if vim.wo.diff then return "]c" end
          vim.schedule(function() gs.next_hunk() end)
          return "<Ignore>"
        end, { expr = true, buffer = bufnr, desc = "Next Hunk" })
        
        map("n", "[c", function()
          if vim.wo.diff then return "[c" end
          vim.schedule(function() gs.prev_hunk() end)
          return "<Ignore>"
        end, { expr = true, buffer = bufnr, desc = "Prev Hunk" })
        
        -- Actions
        map("n", "<leader>hs", gs.stage_hunk, { buffer = bufnr, desc = "Stage Hunk" })
        map("n", "<leader>hr", gs.reset_hunk, { buffer = bufnr, desc = "Reset Hunk" })
        map("v", "<leader>hs", function() gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") }) end, { buffer = bufnr, desc = "Stage Hunk" })
        map("v", "<leader>hr", function() gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") }) end, { buffer = bufnr, desc = "Reset Hunk" })
        map("n", "<leader>hS", gs.stage_buffer, { buffer = bufnr, desc = "Stage Buffer" })
        map("n", "<leader>hu", gs.undo_stage_hunk, { buffer = bufnr, desc = "Undo Stage Hunk" })
        map("n", "<leader>hR", gs.reset_buffer, { buffer = bufnr, desc = "Reset Buffer" })
        map("n", "<leader>hp", gs.preview_hunk, { buffer = bufnr, desc = "Preview Hunk" })
        map("n", "<leader>hb", function() gs.blame_line({ full = true }) end, { buffer = bufnr, desc = "Blame Line" })
        map("n", "<leader>tb", gs.toggle_current_line_blame, { buffer = bufnr, desc = "Toggle Line Blame" })
        map("n", "<leader>hd", gs.diffthis, { buffer = bufnr, desc = "Diff This" })
        map("n", "<leader>hD", function() gs.diffthis("~") end, { buffer = bufnr, desc = "Diff This ~" })
        map("n", "<leader>td", gs.toggle_deleted, { buffer = bufnr, desc = "Toggle Deleted" })
        
        -- Text object
        map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", { buffer = bufnr, desc = "Select Hunk" })
      end,
    })
  end,
}
