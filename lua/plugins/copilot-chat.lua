return {
  "CopilotC-Nvim/CopilotChat.nvim",
  dependencies = {
    "github/copilot.vim",
    "nvim-lua/plenary.nvim",
  },
  config = function()
    require("CopilotChat").setup()
    vim.keymap.set("n", "<leader>cc", ":CopilotChat<CR>", { noremap = true, silent = true, desc = "Copilot Chat を開く" })
    vim.keymap.set("v", "<leader>cc", ":CopilotChat<CR>", { noremap = true, silent = true, desc = "選択範囲で Copilot Chat" })
  end,
}
