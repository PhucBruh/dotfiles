vim.o.laststatus = 0
vim.cmd.colorscheme("tokyonight-night")

vim.api.nvim_set_hl(0, "YankHighlight", {
  bg = "#FF8F40", -- Change this to your desired background color
  fg = "#ffffff", -- Change this to your desired foreground color (text color)
  blend = 80, -- Optional: adjust the transparency (0-100)
})

vim.api.nvim_create_autocmd("TextYankPost", {
  group = vim.api.nvim_create_augroup("YankHighlight", { clear = true }),
  pattern = "*",
  callback = function()
    vim.highlight.on_yank({ higroup = "YankHighlight", timeout = 300 })
  end,
})

vim.api.nvim_create_autocmd({ "LspAttach", "InsertEnter", "InsertLeave" }, {
  callback = function(args)
    local enabled = args.event ~= "InsertEnter"
    vim.lsp.inlay_hint.enable(enabled, { bufnr = args.buf })
  end,
})
