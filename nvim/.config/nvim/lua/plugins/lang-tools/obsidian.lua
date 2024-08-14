local vaults = {
  {
    name = "notes",
    path = "~/Workspace/notes",
  },
}

return {
  "epwalsh/obsidian.nvim",
  ft = "markdown",
  opts = {
    completion = {
      -- Set to false to disable completion.
      nvim_cmp = true,
      -- Trigger completion at 2 chars.
      min_chars = 2,
    },
    workspaces = vaults,
    ui = { enable = false },
  },
}
