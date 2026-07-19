local icons = {
  title = "󰉵",
  author = "󰡉",
  date = "󰃭",
  id = "󰎠",
  tags = "󰓹",
  category = "󰠮",
  type = "󰆦",
  description = "󰦨",
  status = "󰄨",
  draft = "󰏫",
  version = "󰎠",
  meta = "󰋽",
}
local default_icon = "󰦨"

local function strip_quotes(text)
  return text:gsub('^"(.*)"$', "%1"):gsub("^'(.*)'$", "%1")
end

local function is_nested(value_node)
  return value_node ~= nil and value_node:type() == "block_node"
end

local function format_leaf_value(buf, value_node, key)
  if not value_node then
    return "", "MarkviewYmlEmpty"
  end
  local inner = value_node:named_child(0)
  if inner and inner:type() == "flow_sequence" then
    local items = {}
    for child in inner:iter_children() do
      if child:named() then
        local txt = strip_quotes(vim.treesitter.get_node_text(child, buf))
        if txt ~= "" then
          items[#items + 1] = "'" .. txt .. "'"
        end
      end
    end
    return (#items == 0 and "{}" or ("{ " .. table.concat(items, ", ") .. " }")), "MarkviewYmlList"
  end

  local text = strip_quotes(vim.treesitter.get_node_text(value_node, buf))
  if key == "title" then
    return text, "MarkviewYmlTitle"
  end
  if inner and inner:type() == "plain_scalar" then
    local scalar = inner:named_child(0)
    if scalar and scalar:type() == "integer_scalar" then
      return text, "MarkviewYmlNumber"
    end
  end
  if text:match("^%d%d%d%d%-%d%d%-%d%d") then
    return text, "MarkviewYmlDate"
  end
  if text == "true" or text == "false" then
    return text, "MarkviewYmlBoolean"
  end
  if text == "" then
    return "—", "MarkviewYmlEmpty"
  end
  return text, "MarkviewYmlScalar"
end

local function render_mapping(buf, mapping_node, depth, marks)
  local entries, max_key_len = {}, 0

  for child in mapping_node:iter_children() do
    if child:type() == "block_mapping_pair" then
      local key_node = child:field("key")[1]
      local value_node = child:field("value")[1]
      if key_node then
        local key_text = strip_quotes(vim.treesitter.get_node_text(key_node, buf))
        local nested = is_nested(value_node)
        if not nested then
          local icon = icons[key_text] or default_icon
          max_key_len = math.max(max_key_len, vim.fn.strdisplaywidth(icon .. " " .. key_text))
        end
        entries[#entries + 1] =
          { pair = child, key_node = key_node, value_node = value_node, key_text = key_text, nested = nested }
      end
    end
  end

  local indent_str = string.rep("  ", depth)

  for _, e in ipairs(entries) do
    local row, col = e.pair:range()
    local icon = icons[e.key_text] or default_icon

    if e.nested then
      local end_row, end_col = e.key_node:end_()
      marks[#marks + 1] = {
        conceal = true,
        start_row = row,
        start_col = col,
        opts = {
          end_row = end_row,
          end_col = end_col + 1,
          virt_text = {
            { indent_str, "Normal" },
            { icon .. " ", "MarkviewYmlIcon" },
            { e.key_text, "MarkviewYmlKey" },
          },
          virt_text_pos = "overlay",
        },
      }
      local nested_mapping = e.value_node:named_child(0)
      if nested_mapping and nested_mapping:type() == "block_mapping" then
        render_mapping(buf, nested_mapping, depth + 1, marks)
      end
    else
      local end_row, end_col = e.pair:end_()
      local key_disp = icon .. " " .. e.key_text
      local pad = string.rep(" ", max_key_len - vim.fn.strdisplaywidth(key_disp) + 3)
      local value_str, value_hl = format_leaf_value(buf, e.value_node, e.key_text)

      marks[#marks + 1] = {
        conceal = true,
        start_row = row,
        start_col = col,
        opts = {
          end_row = end_row,
          end_col = end_col,
          virt_text = {
            { indent_str, "Normal" },
            { icon .. " ", "MarkviewYmlIcon" },
            { e.key_text, "MarkviewYmlKey" },
            { pad, "Normal" },
            { value_str, value_hl },
          },
          virt_text_pos = "overlay",
        },
      }
    end
  end
end

local function find_root_mapping(node)
  if node:type() == "block_mapping" then
    return node
  end
  for child in node:iter_children() do
    local found = find_root_mapping(child)
    if found then
      return found
    end
  end
  return nil
end

local function parse_yaml(ctx)
  local ok, marks = pcall(function()
    local root_mapping = find_root_mapping(ctx.root)
    if not root_mapping then
      return {}
    end
    local result = {}
    render_mapping(ctx.buf, root_mapping, 0, result)
    return result
  end)
  if not ok then
    return {}
  end
  return marks
end

require("markdown-plus").setup({})

require("render-markdown").setup({
  file_types = { "markdown" },
  render_modes = { "n", "v", "i", "c" },
  latex = { enabled = false },
  preset = "obsidian",
  heading = {
    icons = { "󰼏  ", "󰼐  ", "󰼑  ", "󰼒  ", "󰼓  ", "󰼔  ", "󰼕  " },
    position = "inline",
    width = "normal",
    right_pad = 1,
    left_pad = 1,
    sign = false,
  },
  bullet = { icons = { "•" } },
  checkbox = {
    unchecked = { icon = "󰄱 " },
    checked = { icon = "󰱒 " },
  },
  code = {
    width = "block",
    language_pad = 1,
  },
  yaml = { enabled = false },
  custom_handlers = {
    yaml = { parse = parse_yaml, extends = false },
  },
})

require("render_latex").setup({})
