return {
  {
    "olexsmir/gopher.nvim",
    ft = "go",
    -- branch = "develop", -- if you want develop branch
    -- keep in mind, it might break everything
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "mfussenegger/nvim-dap", -- (optional) only if you use `gopher.dap`
    },
    -- (optional) will update plugin's deps on every update
    -- build = function()
    --   vim.cmd.GoInstallDeps()
    -- end,
    -- ---@type gopher.Config
    opts = {},
  },
  {
    "leoluz/nvim-dap-go",
    ft = "go",
    opts = {},
    config = function()
      require("dap-go").setup()
    end,
  },
}
