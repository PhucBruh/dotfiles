return {
  "folke/tokyonight.nvim",
  lazy = false,
  priority = 1000,
  init = function()
    vim.cmd.colorscheme("tokyonight-night")
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
  opts = {
    on_highlights = function(hl, c)
      hl.Visual = {
        bg = "#364b8a",
      }
      hl.Comment = {
        fg = "#9ba4cc",
        italic = true,
      }
      hl.CursorLineNr = {
        fg = "#2ac3de",
        bold = true,
        italic = true,
      }
      hl.WinSeparator = {
        fg = "#7aa2f7",
        bold = true,
      }
      hl.NvimTreeWinSeparator = {
        fg = "#7aa2f7",
      }
    end,
  },
}
