return {
  "neovim/nvim-lspconfig",
  config = function()
    local lspconfig = require("lspconfig")

    lspconfig.clangd.setup({})

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

    -- lspconfig.basedpyright.setup({})
    lspconfig.pyright.setup({})
    -- lspconfig.python_lsp_server.setup({})

    -- webdev
    lspconfig.html.setup({})
    lspconfig.css.setup({})
    lspconfig.emmet_ls.setup({})

    lspconfig.svelte.setup({
      settings = {
        typescript = {
          updateImportsOnFileMove = { enabled = "always" },
          inlayHints = {
            parameterNames = { enabled = "all" },
            parameterTypes = { enabled = true },
            variableTypes = { enabled = true },
            propertyDeclarationTypes = { enabled = true },
            functionLikeReturnTypes = { enabled = true },
            enumMemberValues = { enabled = true },
          },
        },
        javascript = {
          updateImportsOnFileMove = { enabled = "always" },
          inlayHints = {
            parameterNames = { enabled = "literals" },
            parameterTypes = { enabled = true },
            variableTypes = { enabled = true },
            propertyDeclarationTypes = { enabled = true },
            functionLikeReturnTypes = { enabled = true },
            enumMemberValues = { enabled = true },
          },
        },
      },
    })
  end,
}
