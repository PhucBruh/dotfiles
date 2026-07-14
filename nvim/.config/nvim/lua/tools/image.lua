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
  default = {},
  filetypes = {
    markdown = {
      template = "![]($FILE_PATH)",
      relative_template_path = true,
    },
  },
})
