return {
  -- sql plugin
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
    local function dbui_toggle()
      -- close alpha if is active
      if vim.bo.filetype == "alpha" then
        vim.cmd("bd")
      end
      vim.cmd("DBUIToggle")
    end

    local map = vim.keymap.set
    vim.g.db_ui_use_nvim_notify = 1
    vim.g.db_ui_show_help = 0
    vim.g.db_ui_debug = 1
    vim.g.db_ui_icons = {
      expanded = {
        db = " 󰆼",
        buffers = " ",
        saved_queries = " ",
        schemas = " 󰤏",
        schema = " 󰙅",
        tables = " ",
        table = " ",
      },
      collapsed = {
        db = " 󰆼",
        buffers = " ",
        saved_queries = " ",
        schemas = " 󰤏",
        schema = " 󰙅",
        tables = " ",
        table = " ",
      },
      saved_query = "",
      new_query = "  󰓰",
      tables = "",
      buffers = "",
      add_connection = "󱘖",
      connection_ok = "✓",
      connection_error = "✕",
    }

    -- Disable some ui in DBUI
    vim.api.nvim_create_autocmd("FileType", {
      pattern = {
        "dbui",
        "dbout",
      },
      callback = function()
        vim.wo.winfixwidth = true
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
            { name = "luasnip" },
          },
        })
      end,
    })

    map("n", "<leader>ud", dbui_toggle, { noremap = true, silent = true, desc = "DadbodUI Toggle" })
  end,
}
