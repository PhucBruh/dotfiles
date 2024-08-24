local filetype = {
  "filetype",
  icon_only = true,
  colored = true,
}

local diff = {
  "diff",
  colored = true, -- Displays a colored diff status if set to true
  diff_color = {
    -- Same color values as the general color option can be used here.
    added = "LuaLineDiffAdd", -- Changes the diff's added color
    modified = "LuaLineDiffChange", -- Changes the diff's modified color
    removed = "LuaLineDiffDelete", -- Changes the diff's removed color you
  },
  symbols = {
    added = "+",
    modified = "~",
    removed = "-",
  }, -- Changes the symbols used by the diff.
}

local function mode_icon()
  local mode = vim.api.nvim_get_mode().mode
  local icons = {
    n = " ", -- Normal mode
    i = "󰴒 ", -- Insert mode
    v = "󰈈 ", -- Visual mode
    V = "󰈈 ", -- Visual Line mode
    c = " ", -- Command mode
    t = " ", -- Terminal mode
    s = "󰩐 ", -- Select mode
  }

  return icons[mode] or " " -- Default icon
end

return {
  "nvim-lualine/lualine.nvim",
  event = { "BufRead", "WinLeave" },
  opts = {
    options = {
      globalstatus = true,
      icons_enabled = true,
      component_separators = { left = "", right = "" },
      section_separators = { left = "", right = "" },
      disabled_filetypes = {
        statusline = {},
        winbar = {},
      },
      ignore_focus = {},
      always_divide_middle = true,
      refresh = {
        statusline = 1000,
        winbar = 1000,
      },
    },

    sections = {
      lualine_a = {
        {
          "mode",
          fmt = function(str)
            return mode_icon() .. str
          end,
        },
      },
      lualine_b = {},
      lualine_c = {
        {
          "filename",
          path = true,
          status = true,
        },
        filetype,
        "branch",
        diff,
      },
      lualine_x = {},
      lualine_y = {
        "encoding",
        "fileformat",
      },
      lualine_z = {},
    },
    inactive_sections = {
      lualine_a = {},
      lualine_b = {},
      lualine_c = { "filename" },
      lualine_x = { "location" },
      lualine_y = {},
      lualine_z = {},
    },
  },
  -- config = function()
  --   require("plugins.ui.lualine.setup")
  -- end,
}
