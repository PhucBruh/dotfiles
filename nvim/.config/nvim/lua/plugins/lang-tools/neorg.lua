return {
  "nvim-neorg/neorg",
  ft = "norg",
  dependencies = {
    "juniorsundar/neorg-extras",
    "max397574/neorg-kanban",
    "nvim-telescope/telescope.nvim", -- Required for the Neorg-Roam features
    "nvim-lua/plenary.nvim", -- Required as part of Telescope installation
  },
  config = function()
    require("neorg").setup({
      load = {
        ["core.defaults"] = {}, -- Loads default behaviour
        ["core.concealer"] = {}, -- Adds pretty icons to your documents
        ["core.dirman"] = { -- Manages Neorg workspaces
          config = {
            workspaces = {
              notes = "~/Workspace/my-org",
            },
          },
        },
      },
    })
  end,
}
