vim.o.laststatus = 0

vim.api.nvim_create_autocmd({ "LspAttach", "InsertEnter", "InsertLeave" }, {
  callback = function(args)
    local enabled = args.event ~= "InsertEnter"
    vim.lsp.inlay_hint.enable(enabled, { bufnr = args.buf })
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "markdown",
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.linebreak = true
  end,
})
