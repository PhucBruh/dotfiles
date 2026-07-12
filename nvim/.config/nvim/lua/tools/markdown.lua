require("markdown-plus").setup({})
require("render-markdown").setup({
  file_types = {
    "markdown",
  },
  latex = { enabled = false },
  heading = {
    icons = { "󰲡 ", "󰲣 ", "󰲥 ", "󰲧 ", "󰲩 ", "󰲫 " },
    position = "overlay",
    sign = false,
    backgrounds = {},
  },
  bullet = {
    icons = { "●", "○", "◆", "◇" },
  },
  quote = {
    icon = "▋",
  },
  checkbox = {
    custom = {
      todo = { raw = "[-]", rendered = "󰥔 ", highlight = "RenderMarkdownTodo" },
    },
  },
})

require("render_latex").setup({})

require("image").setup({
  processor = "magick_cli",
  integrations = {
    markdown = {
      enabled = true,
      clear_in_insert_mode = false,
      download_remote_images = true,
      only_render_image_at_cursor = false,
      floating_windows = false,
    },
    typst = {
      enabled = true,
    },
  },
})

require("img-clip").setup({
  default = {
    dir_path = "attachments",
    template = "![$CURSOR]($FILE_PATH)",
  },
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "markdown",
  callback = function(ev)
    vim.opt_local.conceallevel = 2
    vim.opt_local.concealcursor = "nc"
    vim.keymap.set({ "n", "i" }, "<C-j>", "<CR>", {
      buffer = ev.buf,
      remap = true,
      desc = "Markdown Enter",
    })
  end,
})
