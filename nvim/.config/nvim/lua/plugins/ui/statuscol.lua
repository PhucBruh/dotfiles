return {
  "luukvbaal/statuscol.nvim",
  branch = "0.10",
  config = function()
    local git_sign_icon = "▎"
    local builtin = require("statuscol.builtin")
    require("statuscol").setup({
      relculright = true,

      clickhandlers = {
        Lnum = builtin.gitsigns_click,
      },

      ft_ignore = {
        "alpha",
        "aerial",
        "dbui",
        "dbee",
        "dbout",
        "lazy",
        "NvimTree",

        "dapui_watches",
        "dapui_scopes",
        "dapui_stacks",
        "dapui_breakpoints",
        "dapui_scopes",
        "dap-repl",
        "dapui_console",
      },
      bt_ignore = {
        "terminal",
      },
      segments = {
        {
          sign = {
            name = { "GitSigns*" },
            namespace = { "gitsigns" },
            colwidth = 1,
            fillchar = git_sign_icon,
            fillcharhl = "Nrline",
          },
          click = "v:lua.ScSa",
        },

        {
          sign = {
            name = { ".*" },
            namespace = { ".*" },
            maxwidth = 2,
            colwidth = 2,
            auto = false,
            wrap = true,
          },
        },

        {
          text = { builtin.lnumfunc, " " },
          maxwidth = 3,
          colwidth = 3,
          click = "v:lua.ScLa",
        },

        {
          text = {
            function(args)
              args.fold.close = ""
              args.fold.open = ""
              args.fold.sep = " "
              return builtin.foldfunc(args)
            end,
            " ",
          },
          hl = "FoldColumn",
          wrap = true,
          colwidth = 1,
          click = "v:lua.ScFa",
        },
      },
    })
  end,
}
