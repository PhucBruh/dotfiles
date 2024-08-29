return {
  "folke/noice.nvim",
  event = "VeryLazy",
  dependencies = {
    "MunifTanjim/nui.nvim",
    "j-hui/fidget.nvim",
  },
  opts = {
    cmdline = { view = "cmdline" },
    lsp = {

      -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
      override = {
        ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
        ["vim.lsp.util.stylize_markdown"] = true,
        ["cmp.entry.get_documentation"] = true,
      },
    },
    routes = {
      {
        filter = { event = "notify", find = "No information available" },
        opts = { skip = true },
      },
    },
    presets = {
      bottom_search = true, -- use a classic bottom cmdline for search
      lsp_doc_border = false, -- add a border to hover docs and signature help
    },
    commands = {
      enabled = false, -- Disable command output
    },
  },
}
