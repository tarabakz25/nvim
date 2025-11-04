return {
  "zbirenbaum/copilot.lua",
  cmd = "Copilot",
  build = ":Copilot auth",
  event = "InsertEnter", -- InsertEnter の方が効率的
  opts = {
    suggestion = {
      enabled = not vim.g.ai_cmp,
      auto_trigger = true, -- 自動トリガーを有効化
      hide_during_completion = vim.g.ai_cmp,
      debounce = 75,
      keymap = {
        accept = "<M-l>", -- Option+L で受け入れ
        accept_word = "<M-w>", -- Option+W で単語単位
        accept_line = "<M-j>", -- Option+J で行単位
        next = "<M-]>",
        prev = "<M-[>",
        dismiss = "<C-]>",
      },
    },
    panel = { enabled = false },
    filetypes = {
      yaml = true,
      markdown = true,
      help = false,
      gitcommit = true,
      gitrebase = false,
      hgcommit = false,
      svn = false,
      cvs = false,
      ["."] = false,
    },
  },
}
