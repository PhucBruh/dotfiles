local function has_words_before()
  local line, col = (unpack or table.unpack)(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end
local function is_visible(cmp)
  return cmp.core.view:visible() or vim.fn.pumvisible() == 1
end

-- nvim-cmp configuration
local cmp = require("cmp")
local luasnip = require("luasnip")
local lspkind = require("lspkind")

require("luasnip.loaders.from_vscode").lazy_load()

cmp.setup({
  preselect = cmp.PreselectMode.None,
  formatting = {
    expandable_indicator = true,
    fields = { "kind", "abbr", "menu" },
    format = function(entry, vim_item)
      local kind = lspkind.cmp_format({ mode = "symbol_text", maxwidth = 50 })(entry, vim_item)
      local strings = vim.split(kind.kind, "%s", { trimempty = true })
      local is_cmdline = vim.fn.getcmdtype() ~= ""

      kind.kind = (strings[1] or "") .. " "
      kind.menu = is_cmdline and "" or " [" .. (strings[2] or "") .. "]"

      return kind
    end,
  },

  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body) -- For LuaSnip users
    end,
  },

  ---@Key-Cmp
  mapping = cmp.mapping.preset.insert({
    ["<C-u>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
    ["<C-d>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<C-e>"] = cmp.mapping.abort(),
    ["<C-y>"] = cmp.config.disable,
    ["<C-j>"] = cmp.mapping(cmp.mapping.confirm({ select = false }), { "i", "c" }),
    ["<Tab>"] = cmp.mapping(function(fallback)
      if vim.api.nvim_get_mode().mode ~= "c" and luasnip.expand_or_locally_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { "i", "s" }),
    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if vim.api.nvim_get_mode().mode ~= "c" and luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { "i", "s" }),
  }),

  sources = cmp.config.sources({
    { name = "nvim_lsp" },
    { name = "buffer" },
    { name = "path" },
    { name = "luasnip" },
  }),

  window = {
    completion = cmp.config.window.bordered({
      col_offset = -2,
      side_padding = 0,
      border = "single",
      winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder,CursorLine:PmenuSel,Search:None",
    }),
    documentation = cmp.config.window.bordered({
      border = "single",
      winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder,CursorLine:PmenuSel,Search:None",
    }),
  },
})

-- Cmdline setup
cmp.setup.cmdline("/", {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = "buffer" },
  },
})

cmp.setup.cmdline(":", {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = "path" },
  }, {
    { name = "cmdline" },
  }),
})

luasnip.setup({
  history = true,
  delete_check_events = "TextChanged",
  region_check_events = "CursorMoved",
})
