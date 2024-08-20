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
            ["rust-analyzer"] = {
              check = {
                command = "clippy",
                extraArgs = {
                  "--no-deps",
                },
              },
            },
          },
        },
        -- DAP configuration
        dap = {},
      }
    end,
  },
  {
    "saecki/crates.nvim",
    event = { "BufRead Cargo.toml" },
    config = function()
      require("crates").setup()
    end,
  },
}
