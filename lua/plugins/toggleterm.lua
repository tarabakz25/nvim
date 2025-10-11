-- ~/.config/nvim/lua/plugins/toggleterm.lua
return {
  "akinsho/toggleterm.nvim",
  version = "*",   -- 最新タグを自動取得
  event   = "VeryLazy",
  --------------------------------------------------------------------
  -- キーマップ
  --------------------------------------------------------------------
  keys = {
    -- <Space>gg で LazyGit をトグル
    { "<leader>gg", function() _lazygit_toggle() end, desc = "LazyGit (ToggleTerm)" },
    -- <leader>tt で通常ターミナル（Normal / Terminal モード双方）
    { "<leader>tt", "<cmd>ToggleTerm<CR>", mode = { "n", "t" }, desc = "Toggle Terminal" },
  },

  --------------------------------------------------------------------
  -- オプション（require("toggleterm").setup に渡す）
  --------------------------------------------------------------------
  opts = {
    open_mapping   = [[<C-\>]],
    shade_terminals = true,
    direction      = "float",
    float_opts     = { border = "rounded" },
  },

  --------------------------------------------------------------------
  -- config: ToggleTerm を初期化し、LazyGit 専用ターミナルを定義
  --------------------------------------------------------------------
  config = function(_, opts)
    -- 1️⃣ ToggleTerm を初期化
    require("toggleterm").setup(opts)

    -- 2️⃣ LazyGit 専用ターミナルを生成
    local Terminal = require("toggleterm.terminal").Terminal
    local lazygit  = Terminal:new({
      cmd      = "lazygit",
      hidden   = true,
      direction = "float",
      float_opts = { border = "double" },
      on_open = function(term)
        -- “q” で閉じる
        vim.keymap.set("n", "q", "<cmd>close<CR>",
          { noremap = true, silent = true, buffer = term.bufnr })
      end,
    })

    -- 3️⃣ グローバル関数としてトグルを公開（キーマップから呼び出し）
    function _lazygit_toggle()
      lazygit:toggle()
    end
  end,
}
