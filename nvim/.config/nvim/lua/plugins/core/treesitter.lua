return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  config = function()
    local opts = {
      ensure_installed = {
        "lua",

        "cpp",

        "http",

        -- web dev
        "css",
        "html",
        "json",
        "jsonc",
        "jsdoc",

        "svelte",

        "markdown",
        "markdown_inline",

        "python",

        "rust",

        "sql",

        "toml",

        "vim",
        "vimdoc",

        "norg",
      },
      sync_install = false,
      highlight = { enable = true },
      indent = { enable = true },
      auto_install = true,
    }
    require("nvim-treesitter.configs").setup(opts)
  end,
}
