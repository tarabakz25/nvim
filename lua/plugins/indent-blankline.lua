return {
  "lukas-reineke/indent-blankline.nvim",
  main = "ibl",
  event = { "BufReadPost", "BufNewFile" },
  config = function()
    require("ibl").setup({
      indent = {
        char = "│",
        tab_char = "│",
        highlight = "IblIndent",
        smart_indent_cap = true,
        priority = 1,
      },
      whitespace = {
        highlight = "IblWhitespace",
        remove_blankline_trail = true,
      },
      scope = {
        enabled = true,
        char = "│",
        show_start = true,
        show_end = false,
        show_exact_scope = false,
        injected_languages = true,
        highlight = "IblScope",
        priority = 1024,
        include = {
          node_type = {
            ["*"] = {
              "class",
              "function",
              "method",
              "^if",
              "^while",
              "^for",
              "^object",
              "^table",
              "block",
              "arguments",
            },
          },
        },
      },
      exclude = {
        filetypes = {
          "help",
          "dashboard",
          "NvimTree",
          "neo-tree",
          "Trouble",
          "trouble",
          "lazy",
          "mason",
          "notify",
          "toggleterm",
          "lazyterm",
        },
        buftypes = {
          "terminal",
          "nofile",
          "quickfix",
          "prompt",
        },
      },
    })
    
    -- Treesitter連携でスコープハイライト
    local hooks = require("ibl.hooks")
    hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)
  end,
}
