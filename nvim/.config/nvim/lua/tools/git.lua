require("gitsigns").setup({
  -- stylua: ignore start
    style = "sign",
    delete       = { text = "_" },
    topdelete    = { text = "‾" },
    changedelete = { text = "~" },
    untracked    = { text = "┆" },
  },
  on_attach = function(bufnr)
    local gs = package.loaded.gitsigns
    local map = function(mode, l, r, opts)
      opts = opts or {}
      opts.buffer = bufnr
      vim.keymap.set(mode, l, r, opts)
    end

    map("n", "]c", function()
      if vim.wo.diff then return "]c" end
      vim.schedule(function() gs.next_hunk() end)
      return "<Ignore>"
    end, { expr = true, desc = "Next hunk" })

    map("n", "[c", function()
      if vim.wo.diff then return "[c" end
      vim.schedule(function() gs.prev_hunk() end)
      return "<Ignore>"
    end, { expr = true, desc = "Prev hunk" })

    map("n", "<leader>gs", gs.stage_hunk, { desc = "Stage hunk" })
    map("n", "<leader>gr", gs.reset_hunk, { desc = "Reset hunk" })
    map("v", "<leader>gs", function() gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") }) end, { desc = "Stage selection" })
    map("v", "<leader>gr", function() gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") }) end, { desc = "Reset selection" })
    map("n", "<leader>gS", gs.stage_buffer, { desc = "Stage buffer" })
    map("n", "<leader>gu", gs.undo_stage_hunk, { desc = "Undo stage" })
    map("n", "<leader>gR", gs.reset_buffer, { desc = "Reset buffer" })
    map("n", "<leader>gp", gs.preview_hunk, { desc = "Preview hunk" })
    map("n", "<leader>gb", function() gs.blame_line({ full = true }) end, { desc = "Blame line" })
    map("n", "<leader>gd", gs.diffthis, { desc = "Diff this" })
    map("n", "<leader>gD", function() gs.diffthis("~") end, { desc = "Diff this ~" })
  end,
  -- stylua: ignore end
})
