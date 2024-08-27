return {
  "Wansmer/treesj",
  keys = {
    -- stylua: ignore
    { "<leader>ut", mode = { "n" }, function() require("treesj").toggle() end, desc = "Treesj Toggle" },
  },
  dependencies = { "nvim-treesitter/nvim-treesitter" }, -- if you install parsers with `nvim-treesitter`
  config = function()
    require("treesj").setup({})
  end,
}
