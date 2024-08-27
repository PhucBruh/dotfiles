vim.g.python3_host_prog = "~/.anaconda3/bin/python3"

return {
  "quarto-dev/quarto-nvim",
  dependencies = {
    "jmbuhr/otter.nvim",
    "nvim-treesitter/nvim-treesitter",
  },
}
