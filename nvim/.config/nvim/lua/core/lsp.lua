require("mason").setup()

require("mason-tool-installer").setup({
  ensure_installed = {
    -- lua
    "lua-language-server",
    "stylua",

    -- python
    "pyrefly",
    "ruff",
  },
  auto_update = false,
  run_on_start = true,
})

local on_attach = function(_, bufnr)
  local fzf = require("fzf-lua")
  local maps = vim.keymap.set

  -- FZF pickers
  maps("n", "gd", function()
    fzf.lsp_definitions({
      jump1 = true,
      ignore_current_line = true,
    })
  end, {
    buffer = bufnr,
    desc = "Goto Definition",
  })

  maps("n", "grr", function()
    fzf.lsp_references({
      jump1 = true,
      ignore_current_line = true,
    })
  end, {
    buffer = bufnr,
    desc = "References",
  })

  maps("n", "gri", function()
    fzf.lsp_implementations({
      jump1 = true,
      ignore_current_line = true,
    })
  end, {
    buffer = bufnr,
    desc = "Implementations",
  })

  maps("n", "grt", function()
    fzf.lsp_typedefs({
      jump1 = true,
      ignore_current_line = true,
    })
  end, {
    buffer = bufnr,
    desc = "Type Definitions",
  })

  -- Default LSP actions
  maps("n", "K", vim.lsp.buf.hover, {
    buffer = bufnr,
    desc = "Hover",
  })

  maps("n", "gk", vim.lsp.buf.signature_help, {
    buffer = bufnr,
    desc = "Signature Help",
  })

  maps("i", "<C-k>", vim.lsp.buf.signature_help, {
    desc = "Signature Help",
  })

  maps("n", "gD", vim.lsp.buf.declaration, {
    buffer = bufnr,
    desc = "Declaration",
  })
end

-- Global defaults
vim.lsp.config("*", {
  on_attach = on_attach,
})
