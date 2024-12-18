return {
  "neovim/nvim-lspconfig",
  config = function()
    local lspconfig = require("lspconfig")

    lspconfig.lua_ls.setup({
      settings = {
        Lua = {
          diagnostics = {
            globals = { "vim" },
          },
        },
      },
    })

    lspconfig.jqls.setup({})

    lspconfig.taplo.setup({})

    lspconfig.pyright.setup({})

    -- webdev
    lspconfig.html.setup({})
    lspconfig.css.setup({})
    lspconfig.emmet_ls.setup({})
  end,
}
