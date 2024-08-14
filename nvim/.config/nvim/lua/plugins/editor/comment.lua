return {
  {
    "numToStr/Comment.nvim",
    opts = {},
    config = function()
      local comment = require("Comment.api")
      local map = vim.keymap.set
      map(
        "n",
        "<leader>/",
        comment.call("toggle.linewise.current", "g@$"),
        { expr = true, desc = "Toggle comment line" }
      )
      map("v", "<leader>/", comment.call("toggle.linewise", "g@"), { expr = true, desc = "Toggle comment block" })
    end,
  },

  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {},
  },
}
