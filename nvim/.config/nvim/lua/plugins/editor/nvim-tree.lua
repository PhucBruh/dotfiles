return {
  "nvim-tree/nvim-tree.lua",
  cmd = { "NvimTreeToggle", "NvimTreeFocus" },
  -- stylua: ignore
  keys = {
    { "<C-n>", mode = { "n", "i" }, "<cmd>NvimTreeToggle<CR>", desc = "Nvimtree toggle window" },
    { "<C-e>", mode = { "n", "i" }, "<cmd>NvimTreeFocus<CR>", desc = "Nvimtree focus window" },
  },
  version = "*",
  opts = {
    git = {
      enable = false, -- Disable Git status
    },

    view = {
      width = 30,
      preserve_window_proportions = true,
      signcolumn = "no",
    },

    renderer = {
      root_folder_label = false,
      highlight_git = true,
      indent_markers = { enable = true },
      icons = {
        glyphs = {
          default = "󰈚",
          folder = {
            default = "",
            empty = "",
            empty_open = "",
            open = "",
            symlink = "",
          },
        },
      },
    },
  },
}
