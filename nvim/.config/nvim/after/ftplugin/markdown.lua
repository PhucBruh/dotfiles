-- vim.wo.conceallevel = 2
-- vim.wo.concealcursor = "nc"
vim.opt.wrap = false

local map = function(mode, lhs, rhs, desc)
  vim.keymap.set(mode, lhs, rhs, { buffer = true, desc = desc })
end

local wk = require("which-key")

wk.add({
  { "m", group = "markdown" },
  { "mh", group = "header" },
  { "mf", group = "footnote" },
  { "mQ", group = "callout" },
  { "lt", group = "list type" },
  { "t", group = "table" },
})

-- Formatting
map({ "n", "x" }, "mb", "<Plug>(MarkdownPlusBold)", "Bold")
map({ "n", "x" }, "mi", "<Plug>(MarkdownPlusItalic)", "Italic")
map({ "n", "x" }, "ms", "<Plug>(MarkdownPlusStrikethrough)", "Strikethrough")
map({ "n", "x" }, "m`", "<Plug>(MarkdownPlusCode)", "Inline code")
map("x", "mw", "<Plug>(MarkdownPlusCodeBlock)", "Wrap in code block")
map({ "n", "x" }, "mx", "<Plug>(MarkdownPlusToggleCheckbox)", "Checkbox")

-- Headers
map("n", "mh+", "<Plug>(MarkdownPlusPromoteHeader)", "Promote header")
map("n", "mh-", "<Plug>(MarkdownPlusDemoteHeader)", "Demote header")
map("n", "mh1", "<Plug>(MarkdownPlusHeader1)", "Set H1")
map("n", "mh2", "<Plug>(MarkdownPlusHeader2)", "Set H2")
map("n", "mh3", "<Plug>(MarkdownPlusHeader3)", "Set H3")
map("n", "mh4", "<Plug>(MarkdownPlusHeader4)", "Set H4")
map("n", "mh5", "<Plug>(MarkdownPlusHeader5)", "Set H5")
map("n", "mh6", "<Plug>(MarkdownPlusHeader6)", "Set H6")
map("n", "mht", "<Plug>(MarkdownPlusGenerateTOC)", "Generate TOC")
map("n", "mhu", "<Plug>(MarkdownPlusUpdateTOC)", "Update TOC")
map("n", "mhT", "<Plug>(MarkdownPlusOpenTocWindow)", "TOC window")

-- Links & images
map("n", "ml", "<Plug>(MarkdownPlusInsertLink)", "Insert link")
map("x", "ml", "<Plug>(MarkdownPlusSelectionToLink)", "Selection to link")
map("n", "mp", "<Plug>(MarkdownPlusSmartPaste)", "Paste as link")
map("n", "mL", "<Plug>(MarkdownPlusInsertImage)", "Insert image")

-- Quote
map({ "n", "x" }, "mq", "<Plug>(MarkdownPlusToggleQuote)", "Toggle quote")

-- Thematic break
map("n", "mhb", "<Plug>(MarkdownPlusInsertThematicBreak)", "Insert break")
