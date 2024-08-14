return {
  {
    "mrcjkb/rustaceanvim",
    ft = "rust",
    version = "^5", -- Recommended
    config = function()
      vim.g.rustaceanvim = {
        -- Plugin configuration
        tools = {},
        -- LSP configuration
        server = {
          on_attach = function(client, bufnr) end,
          default_settings = {
            -- rust-analyzer language server configuration
            ["rust-analyzer"] = {},
          },
        },
        -- DAP configuration
        dap = {},
      }
    end,
  },
  {
    "saecki/crates.nvim",
    lazy = true,
    tag = "stable",
    opts = {
      completion = {
        cmp = { enabled = true },
        crates = {
          enabled = true,
        },
      },
      null_ls = {
        enabled = true,
        name = "crates.nvim",
      },
    },
  },
}
