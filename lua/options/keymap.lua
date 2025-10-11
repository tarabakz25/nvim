vim.keymap.set('n', '<C-m>', ':NvimTreeToggle<CR>', { noremap = true, silent = true })

vim.api.nvim_create_autocmd({"TextChanged", "TextChangedI"}, {
  pattern = "*",
  command = "silent! write"
})

-- Copilot Chat
vim.keymap.set("n", "<leader>cc", ":CopilotChat<CR>", { noremap = true, silent = true, desc = "Copilot Chat を開く" })
vim.keymap.set("v", "<leader>cc", ":CopilotChat<CR>", { noremap = true, silent = true, desc = "選択範囲で Copilot Chat" })

-- Web開発用キーマップ
vim.keymap.set("n", "<leader>ls", ":LiveServerStart<CR>", { noremap = true, silent = true, desc = "Live Server 開始" })
vim.keymap.set("n", "<leader>lq", ":LiveServerStop<CR>", { noremap = true, silent = true, desc = "Live Server 停止" })
vim.keymap.set("n", "<leader>pf", ":Prettier<CR>", { noremap = true, silent = true, desc = "Prettier でフォーマット" })
vim.keymap.set("n", "<leader>li", ":Lint<CR>", { noremap = true, silent = true, desc = "Lint 実行" })

-- Emmet キーマップ
vim.keymap.set("i", "<C-e>,", "<Plug>(emmet-expand-abbr)", { noremap = true, silent = true, desc = "Emmet 展開" })
vim.keymap.set("i", "<C-e>;", "<Plug>(emmet-expand-word)", { noremap = true, silent = true, desc = "Emmet 単語展開" })

-- HTML タグ補完
vim.keymap.set("i", "<C-e>", "<Plug>(emmet-expand-abbr)", { noremap = true, silent = true, desc = "Emmet 展開" })
