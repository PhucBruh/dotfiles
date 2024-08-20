return {
  "hrsh7th/nvim-cmp", -- Completion plugin
  event = { "InsertEnter", "CmdlineEnter" },
  dependencies = {
    "hrsh7th/cmp-nvim-lsp", -- LSP source for nvim-cmp
    "hrsh7th/cmp-buffer", -- Buffer source for nvim-cmp
    "hrsh7th/cmp-path", -- Path source for nvim-cmp
    "hrsh7th/cmp-cmdline", -- Cmdline source for nvim-cmp

    -- for luasnip and preset snippets
    "saadparwaiz1/cmp_luasnip",
    "L3MON4D3/LuaSnip",
    "rafamadriz/friendly-snippets",

    "onsails/lspkind.nvim", --Better look
  },
  config = function()
    require("plugins.editor.cmp.setup")
  end,
}
