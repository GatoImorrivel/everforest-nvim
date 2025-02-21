local util = {}

---@param group string
---@param hl Highlight
util.generate_highlight = function(group, hl)
  -- We can't add a highlight without a group
  if not group then
    return
  end

  vim.api.nvim_set_hl(0, group, hl)
end

---@param syntax_entries Highlights
util.generate_highlights = function(syntax_entries)
  for group, highlights in pairs(syntax_entries) do
    util.generate_highlight(group, highlights)
  end
end

---@param generated_syntax Highlights
util.load = function(generated_syntax)
  if vim.g.colors_name then
    vim.cmd([[highlight clear]])
  end

  vim.o.termguicolors = true
  vim.g.colors_name = "everforest"

  util.generate_highlights(generated_syntax)
end

-- Helper function to convert hex color to RGB
util.hex_to_rgb = function(hex)
  hex = hex:gsub("#", "")
  return {
    r = tonumber(hex:sub(1, 2), 16) / 255,
    g = tonumber(hex:sub(3, 4), 16) / 255,
    b = tonumber(hex:sub(5, 6), 16) / 255,
  }
end

-- Helper function to convert RGB back to hex
util.rgb_to_hex = function(r, g, b)
  return string.format("#%02X%02X%02X", math.floor(r * 255), math.floor(g * 255), math.floor(b * 255))
end

-- Function to darken a color
util.darken_color = function(color, amount)
  local rgb = util.hex_to_rgb(color)
  
  -- Darken each component by the amount
  rgb.r = rgb.r * (1 - amount)
  rgb.g = rgb.g * (1 - amount)
  rgb.b = rgb.b * (1 - amount)
  
  -- Return the darkened color in hex format
  return util.rgb_to_hex(rgb.r, rgb.g, rgb.b)
end


return util
