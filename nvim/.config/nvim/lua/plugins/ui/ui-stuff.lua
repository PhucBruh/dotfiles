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
    opts = {
      easing = "quadratic",
      hide_cursor = false,
      mappings = neoscroll_k,
    },
  },

  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    opts = {
      scope = { show_start = false, show_end = false },
      indent = { tab_char = "▎" },
    },
  },

  {
    "brenoprata10/nvim-highlight-colors",
    opts = {},
  },

  {
    -- Calls `require('slimline').setup({})`
    "sschleemilch/slimline.nvim",
    opts = { bold = true, verbose_mode = true, style = "fg" },
  },
}
