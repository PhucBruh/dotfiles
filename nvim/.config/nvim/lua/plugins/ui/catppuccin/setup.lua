require("catppuccin").setup({
  highlight_overrides = {
    all = function(colors)
      local overrides = {
        Headline = { style = { "bold" } },
      }
      for _, hl in ipairs({ "Headline", "rainbow" }) do
        for i, c in ipairs({ "blue", "mauve", "teal", "green", "peach", "flamingo" }) do
          overrides[hl .. i] = { fg = colors[c], style = { "bold" } }
        end
      end
      return overrides
    end,
    -- This is a comment and for the love of ...
    macchiato = function(colors)
      local overrides = {
        CurSearch = { bg = colors.peach },
        CursorLineNr = { fg = colors.blue, style = { "bold" } },
        FloatTitle = { fg = colors.mauve },
        Headline = { style = { "bold" } },
        IncSearch = { bg = colors.peach },
        MsgArea = { fg = colors.overlay1 },
        Search = { bg = colors.mauve, fg = colors.base },
        TreesitterContextBottom = { sp = colors.overlay1, style = { "underline" } },
        WinSeparator = { fg = colors.overlay0, style = { "bold" } },

        AlphaHeader = { fg = colors.blue, style = { "italic", "bold" } },
        AlphaFooter = { fg = colors.rosewater, style = {} },

        NvimTreeNormal = { bg = colors.base },
        NvimTreeWinSeparator = {
          fg = colors.overlay0,
          bg = colors.base,
        },

        TelescopeMatching = { fg = colors.mauve },
      }
      for _, hl in ipairs({ "Headline", "rainbow" }) do
        for i, c in ipairs({ "blue", "pink", "lavender", "green", "peach", "flamingo" }) do
          overrides[hl .. i] = { fg = colors[c], style = { "bold" } }
        end
      end
      return overrides
    end,
  },
  color_overrides = {
    macchiato = {
      rosewater = "#F5B8AB",
      flamingo = "#F29D9D",
      pink = "#AD6FF7",
      mauve = "#FF8F40",
      red = "#E66767",
      maroon = "#EB788B",
      peach = "#FAB770",
      yellow = "#FACA64",
      green = "#70CF67",
      teal = "#4CD4BD",
      sky = "#61BDFF",
      sapphire = "#4BA8FA",
      blue = "#00BFFF",
      lavender = "#00BBCC",
      text = "#C1C9E6",
      subtext1 = "#A3AAC2",
      subtext0 = "#8E94AB",
      overlay2 = "#7D8296",
      overlay1 = "#676B80",
      overlay0 = "#6c7a93",
      surface2 = "#3A3D4A",
      surface1 = "#4A5C6B",
      surface0 = "#1D1E29",
      base = "#0B0B12",
      mantle = "#11111A",
      crust = "#191926",
    },
  },
})

vim.cmd.colorscheme("catppuccin-macchiato")

vim.api.nvim_set_hl(0, "YankHighlight", {
  bg = "#FF8F40", -- Change this to your desired background color
  fg = "#ffffff", -- Change this to your desired foreground color (text color)
  blend = 20, -- Optional: adjust the transparency (0-100)
})

vim.api.nvim_create_autocmd("TextYankPost", {
  group = vim.api.nvim_create_augroup("YankHighlight", { clear = true }),
  pattern = "*",
  callback = function()
    vim.highlight.on_yank({ higroup = "YankHighlight", timeout = 150 })
  end,
})
