return {
  "nvim-telescope/telescope.nvim",
  tag = "0.1.8",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "folke/noice.nvim",
  },
  config = function()
    local map = vim.keymap.set
    local builtin = require("telescope.builtin")
    local actions = require("telescope.actions")

    -- Normal telescope find
    -- stylua: ignore start
    map("n", "<leader>fa", function()
      builtin.find_files({ prompt_title = "Config Files", cwd = vim.fn.stdpath("config"), follow = true, })
    end, { desc = "Config file" })
    map("n", "<leader>f'", builtin.marks, { desc = "Marks" })
    map("n", "<leader>fb", builtin.buffers, { desc = "Buffers" })
    map("n", "<leader>fc", builtin.grep_string, { desc = "Word under cursor" })
    map("n", "<leader>fC", builtin.commands, { desc = "Command" })
    map("n", "<leader>ff", builtin.find_files, { desc = "Files" })
    map("n", "<leader>fF", function() require("telescope.builtin").find_files({ hidden = true, no_ignore = true }) end, { desc = "All files" })
    map("n", "<leader>fh", builtin.help_tags, { desc = "Help" })
    map("n", "<leader>fk", builtin.keymaps, { desc = "Keymaps" })
    map("n", "<leader>fm", builtin.man_pages, { desc = "Man" })
    map("n", "<leader>fo", builtin.oldfiles, { desc = "Recent files" })
    map("n", "<leader>fr", builtin.registers, { desc = "Registers" })
    map("n", "<leader>ft", function() builtin.colorscheme({ enable_preview = true, ignore_builtins = true }) end, { desc = "Themes" })
    map("n", "<leader>fw", builtin.live_grep, { desc = "Words" })
    map("n", "<leader>fd", builtin.diagnostics, { desc = "Diagnostics" })
    map("n", "<leader>f/", builtin.current_buffer_fuzzy_find, { desc = "Words in current buffer" })
    map("n", "<leader>fn", "<cmd>Noice telescope<CR>", { desc = "Noice" })

    -- Git telescope find
    map("n", "<leader>g", "", { desc = "Git" })
    map("n", "<leader>gb", function() builtin.git_branches({ use_file_path = true }) end, { desc = "Branches" })
    map("n", "<leader>gc", function() builtin.git_commits({ use_file_path = true }) end, { desc = "Commit (repository)" })
    map("n", "<leader>gC", function() builtin.git_bcommits({ use_file_path = true }) end, { desc = "Commit (current file)" })
    map("n", "<leader>gt", function() builtin.git_status({ use_file_path = true }) end, { desc = "Status" })

    -- LSP Pickers
    map("n", "grr", builtin.lsp_references, { desc = "LSP References" })
    map("n", "gi", builtin.lsp_implementations, { desc = "LSP Implementations" })
    map("n", "gd", builtin.lsp_definitions, { desc = "LSP Definitions" })
    map("n", "gD", builtin.lsp_type_definitions, { desc = "LSP Type Definitions" })
    -- stylua: ignore end

    require("telescope").setup({
      defaults = {
        path_display = { "truncate" },
        sorting_strategy = "ascending",
        layout_config = {
          horizontal = { prompt_position = "top", preview_width = 0.55 },
          vertical = { mirror = false },
          width = 0.87,
          height = 0.80,
          preview_cutoff = 120,
        },
        borderchars = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
        mappings = {
          i = {
            ["<C-j>"] = actions.select_default,
          },
          n = {
            q = actions.close,
            ["<C-j>"] = actions.select_default,
          },
        },
        file_ignore_patterns = {
          "node_modules",
          "target",
        },
      },
    })
  end,
}
