return {
  "eldritch-theme/eldritch.nvim",
  lazy = false,
  priority = 1000,
  opts = {},
  init = function()
    vim.cmd.colorscheme("eldritch")
    vim.api.nvim_set_hl(0, "YankHighlight", {
      bg = "#FF8F40", -- Change this to your desired background color
      fg = "#ffffff", -- Change this to your desired foreground color (text color)
      blend = 80, -- Optional: adjust the transparency (0-100)
    })

    vim.api.nvim_create_autocmd("TextYankPost", {
      group = vim.api.nvim_create_augroup("YankHighlight", { clear = true }),
      pattern = "*",
      callback = function()
        vim.highlight.on_yank({ higroup = "YankHighlight", timeout = 300 })
      end,
    })
  end,
}
