return {
  "alexghergh/nvim-tmux-navigation",
  config = function()
    local nvim_tmux_nav = require("nvim-tmux-navigation")

    nvim_tmux_nav.setup({
      disable_when_zoomed = true, -- defaults to false
    })

    local map = vim.keymap.set

    -- this is also the keybind for navigate between pane
    map("n", "<M-h>", nvim_tmux_nav.NvimTmuxNavigateLeft)
    map("n", "<M-j>", nvim_tmux_nav.NvimTmuxNavigateDown)
    map("n", "<M-k>", nvim_tmux_nav.NvimTmuxNavigateUp)
    map("n", "<M-l>", nvim_tmux_nav.NvimTmuxNavigateRight)
    -- map("n", "<A-\\>", nvim_tmux_nav.NvimTmuxNavigateLastActive)
    -- map("n", "<A-Space>", nvim_tmux_nav.NvimTmuxNavigateNext)
  end,
}
