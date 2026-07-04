require("nvim-treesitter").setup({
  ensure_installed = {
    "lua",

    -- golang
    "go",
    "gomod",
    "gosum",

    -- web
    "javascript",
    "typescript",
    "tsx",
    "html",
    "css",

    -- data
    "http",
    "json",
    "yaml",
    "toml",

    -- markdown
    "markdown",
    "markdown_inline",

    "bash",
    "python",
    "rust",

    -- vim
    "vim",
    "vimdoc",

    -- extra
    "query",
    "latex",
  },

  auto_install = true,
  sync_install = false,

  highlight = { enable = false },
  indent = { enable = false },
})
