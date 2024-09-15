local map = vim.keymap.set

return {
  {
    "max397574/better-escape.nvim",
    event = "VeryLazy",
    opts = {
      timeout = 300,
      default_mappings = false,
      mappings = { i = { j = { k = "<Esc>", j = "<Esc>" } } },
    },
  },

  {
    "numToStr/Comment.nvim",
    opts = {},
    config = function()
      local comment = require("Comment.api")
      -- stylua: ignore
      map("n", "<leader>/", comment.call("toggle.linewise.current", "g@$"), { expr = true, desc = "Toggle comment line" })
      map("v", "<leader>/", comment.call("toggle.linewise", "g@"), { expr = true, desc = "Toggle comment block" })
      map("n", "gco", "o<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>", { desc = "Add Comment Below" })
      map("n", "gcO", "O<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>", { desc = "Add Comment Above" })
    end,
  },

  { "folke/todo-comments.nvim", dependencies = { "nvim-lua/plenary.nvim" }, opts = {} },

  { "h-hg/fcitx.nvim", event = "InsertLeave" },

  {
    "folke/flash.nvim",
    event = "VeryLazy",
    opts = {},
    -- stylua: ignore
    keys = {
      { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
      { "S", mode = { "n", "o", "x" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
      { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
      { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
      { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
    },
  },

  {
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup({})
    end,
  },

  {
    "alexghergh/nvim-tmux-navigation",
    config = function()
      local nvim_tmux_nav = require("nvim-tmux-navigation")

      nvim_tmux_nav.setup({ disable_when_zoomed = true })

      -- this is also the keybind for navigate between pane
      map("n", "<M-h>", nvim_tmux_nav.NvimTmuxNavigateLeft)
      map("n", "<M-j>", nvim_tmux_nav.NvimTmuxNavigateDown)
      map("n", "<M-k>", nvim_tmux_nav.NvimTmuxNavigateUp)
      map("n", "<M-l>", nvim_tmux_nav.NvimTmuxNavigateRight)
      -- map("n", "<A-\\>", nvim_tmux_nav.NvimTmuxNavigateLastActive)
      -- map("n", "<A-Space>", nvim_tmux_nav.NvimTmuxNavigateNext)
    end,
  },

  {
    "Wansmer/treesj",
    -- stylua: ignore
    keys = { { "<leader>ut", mode = { "n" }, function() require("treesj").toggle() end, desc = "Treesj Toggle" }, },
    dependencies = { "nvim-treesitter/nvim-treesitter" }, -- if you install parsers with `nvim-treesitter`
  },

  {
    "windwp/nvim-autopairs",
    event = { "InsertEnter", "CmdlineEnter" },
    config = true,
    opts = { map_c_h = true },
  },
}
