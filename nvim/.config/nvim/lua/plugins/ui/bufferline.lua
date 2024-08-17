return {
  "akinsho/bufferline.nvim",
  version = "*",
  dependencies = "nvim-tree/nvim-web-devicons",
  config = function()
    vim.opt.termguicolors = true
    local bufferline = require("bufferline")
    bufferline.setup({
      options = {
        style_preset = bufferline.style_preset.minimal,
        indicator = {
          style = "underline",
        },
        hover = {
          enabled = true,
          delay = 200,
          reveal = { "close" },
        },

        offsets = {
          {
            filetype = "NvimTree",
            text = "File Explorer",
            highlight = "Directory",
            separator = true, -- use a "true" to enable the default, or set your own character
          },

          {
            filetype = "dbui",
            text = "Database",
            highlight = "Directory",
            separator = true, -- use a "true" to enable the default, or set your own character
          },
        },
      },
    })
  end,
}
