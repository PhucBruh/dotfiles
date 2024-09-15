local neoscroll_k = {
  "<C-u>",
  "<C-d>",
  "zt",
  "zz",
  "zb",
}

return {
  {
    "karb94/neoscroll.nvim",
    opts = { easing = "quadratic", hide_cursor = false, mappings = neoscroll_k },
  },

  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    opts = {
      scope = { show_start = false, show_end = false },
      indent = { tab_char = "▎" },
    },
  },

  { "brenoprata10/nvim-highlight-colors", opts = {} },

  {
    "echasnovski/mini.statusline",
    version = "*",
    config = function()
      require("mini.statusline").setup()
      -- Apply the global status
      vim.opt.laststatus = 3
    end,
  },
}
