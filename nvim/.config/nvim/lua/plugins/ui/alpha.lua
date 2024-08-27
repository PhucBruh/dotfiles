return {
  "goolord/alpha-nvim",
  event = "VimEnter",
  enabled = true,
  init = false,
  config = function()
    local dashboard = require("alpha.themes.dashboard")
    local logo3 = [[
                 .88888888:.
                88888888.88888.
              .8888888888888888.
              888888888888888888
              88' _`88'_  `88888
              88 88 88 88  88888
              88_88_::_88_:88888
              88:::,::,:::::8888
              88`:::::::::'`8888
             .88  `::::'    8:88.
            8888            `8:888.
          .8888'             `888888.
         .8888:..  .::.  ...:'8888888:.
        .8888.'     :'     `'::`88:88888
       .8888        '         `.888:8888.
     888:8         .           888:88888
    .888:88        .:           888:88888:
    8888888.       ::           88:888888
    `.::.888.      ::          .88888888
   .::::::.888.    ::         :::`8888'.:.
  ::::::::::.888   '         .::::::::::::
  ::::::::::::.8    '      .:8::::::::::::.
 .::::::::::::::.        .:888:::::::::::::
 :::::::::::::::88:.__..:88888:::::::::::'
  `'.:::::::::::88888888888.88:::::::::'
        `':::_:' -- '' -'-' `':_::::'`
    ]]
    dashboard.section.header.val = vim.split(logo3, "\n")
    dashboard.section.buttons.val = {}
    dashboard.section.header.opts.hl = "AlphaHeader"
    -- dashboard.opts.layout[1].val = 4

    vim.api.nvim_create_autocmd("Filetype", {
      pattern = "alpha",
      callback = function()
        vim.opt_local.statuscolumn = ""
      end,
    })
    require("alpha").setup(dashboard.opts)
  end,
}
