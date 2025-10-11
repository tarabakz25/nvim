return {
  {
    "prisma/vim-prisma",
    ft = { "prisma" },
    init = function()
      -- Ensure filetype detection for *.prisma
      pcall(vim.filetype.add, {
        extension = { prisma = "prisma" },
        pattern = { [".*%.prisma"] = "prisma" },
      })
    end,
    config = function()
      -- Format Prisma files on save if LSP is available
      local group = vim.api.nvim_create_augroup("PrismaFormatOnSave", { clear = true })
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = group,
        pattern = "*.prisma",
        callback = function()
          pcall(vim.lsp.buf.format, { async = false })
        end,
      })
    end,
  },
}
