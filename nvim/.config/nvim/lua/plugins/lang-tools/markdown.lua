return {
  {
    "jakewvincent/mkdnflow.nvim",
    ft = "markdown",
    opts = {},
  },

  --  this plugin for rendering markdown file
  {
    "OXY2DEV/markview.nvim",
    ft = { "markdown", "quarto", "rmd" },
    dependencies = {
      -- You will not need this if you installed the
      -- parsers manually
      -- Or if the parsers are in your $RUNTIMEPATH
      "nvim-treesitter/nvim-treesitter",

      "nvim-tree/nvim-web-devicons",
    },
    opts = {
      modes = { "n", "no" }, -- Change these modes
      -- to what you need

      hybrid_modes = { "n" }, -- Uses this feature on
      -- normal mode

      -- This is nice to have
      callbacks = {
        on_enable = function(_, win)
          vim.wo[win].conceallevel = 2
          vim.wo[win].conecalcursor = "c"
        end,
      },

      code_blocks = {
        pad_amount = 0,
      },
    },
  },
}
