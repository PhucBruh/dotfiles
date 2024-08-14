return {
  "kristijanhusak/vim-dadbod-ui",
  dependencies = {
    { "tpope/vim-dadbod", lazy = true },
    { "kristijanhusak/vim-dadbod-completion", ft = { "sql", "mysql", "plsql" }, lazy = true },
  },
  cmd = {
    "DBUI",
    "DBUIToggle",
    "DBUIAddConnection",
    "DBUIFindBuffer",
  },
  init = function()
    local function dbui_focus()
      -- close alpha if is active
      if vim.bo.filetype == "alpha" then
        vim.cmd("bd")
      end
      vim.cmd("DBUI")
    end

    local function dbui_toggle()
      -- close alpha if is active
      if vim.bo.filetype == "alpha" then
        vim.cmd("bd")
      end
      vim.cmd("DBUIToggle")
    end

    local map = vim.keymap.set
    vim.g.db_ui_use_nerd_fonts = 1
    vim.g.db_ui_use_nvim_notify = 1
    vim.g.db_ui_show_help = 0
    vim.g.db_ui_debug = 1

    -- Disable some ui in DBUI
    vim.api.nvim_create_autocmd("FileType", {
      pattern = { "dbui", "dbout" },
      callback = function()
        vim.wo.winbar = nil
        vim.wo.number = false
        vim.o.foldenable = false
        vim.o.foldcolumn = "0"
      end,
    })

    -- Dadbob completion for db
    vim.api.nvim_create_autocmd("FileType", {
      pattern = { "sql", "mysql", "plsql" },
      callback = function()
        require("cmp").setup.buffer({
          sources = {
            { name = "vim-dadbod-completion" },
            { name = "nvim_lsp" },
            { name = "luasnip" },
          },
        })
      end,
    })

    map("n", "<leader><Tab>o", dbui_focus, { noremap = true, silent = true, desc = "Focus Dadbod" })
    map("n", "<leader><Tab>e", dbui_toggle, { noremap = true, silent = true, desc = "Toggle Dadbod" })
    map("n", "<leader><Tab>n", "<cmd>DBUIAddConnection<CR>", { noremap = true, silent = true, desc = "Add connection" })
  end,
}
