return {
  "echasnovski/mini.files",
  version = "*",
  keys = {
    {
      "<C-o>",
      function()
        require("mini.files").open(vim.api.nvim_buf_get_name(0), true)
      end,
      desc = "Open mini.files (Directory of Current File)",
    },
    {
      "<C-n>",
      function()
        require("mini.files").open(vim.uv.cwd(), true)
      end,
      desc = "Open mini.files (cwd)",
    },
  },
  config = function()
    require("mini.files").setup({
      mappings = {
        synchronize = "<C-s>",
      },
    })
  end,
}
