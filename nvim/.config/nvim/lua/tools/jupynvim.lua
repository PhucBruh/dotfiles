-- local root = vim.fn.stdpath("data") .. "/site/pack/core/opt/jupynvim"
-- local core = root .. "/core"
-- local bin = core .. "/target/release/jupynvim-core"
--
-- local function setup()
--   vim.env.PATH = vim.env.PATH .. ":" .. core .. "/target/release"
-- end
--
-- local function build_then_setup()
--   if vim.fn.filereadable(bin) == 1 then
--     setup()
--     return
--   end
--
--   vim.notify("jupynvim: building core...")
--
--   vim.fn.jobstart({ "cargo", "build", "--release" }, {
--     cwd = core,
--     on_exit = function(_, code)
--       if code ~= 0 then
--         vim.notify("jupynvim build failed", vim.log.levels.ERROR)
--         return
--       end
--
--       vim.schedule(setup)
--     end,
--   })
-- end
--
-- vim.api.nvim_create_autocmd("VimEnter", {
--   callback = build_then_setup,
-- })

require("jupynvim").setup({
  workspace = {
    enabled = false,
  },

  explorer_keys = {},
  terminal_keys = {},
  terminal_right_keys = {},
  pick_keys = {
    files = {},
    grep = {},
  },

  log_level = "info",
  image_renderer = "placeholder",
})
