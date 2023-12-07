local wezterm = require 'wezterm'
local config = {}

config.enable_scroll_bar = true
config.scrollback_lines  = 100000

config.font = wezterm.font("Source Code Pro", { weight = "Medium" })
config.font_size = 14.0

-- Make alt modifier work on macOS
config.send_composed_key_when_left_alt_is_pressed  = true
config.send_composed_key_when_right_alt_is_pressed = true

config.keys = {
  { key = "LeftArrow",  mods = "CMD|SHIFT", action = wezterm.action.MoveTabRelative(-1) },
  { key = "RightArrow", mods = "CMD|SHIFT", action = wezterm.action.MoveTabRelative(1) },
  { key = "Space",      mods = "ALT",       action = wezterm.action.SendKey({ key = "Space" }) }
}

config.color_schemes = {
  ["OneHalfDark"] = {
    foreground       = "#dcdfe4",
    background       = "#282c34",
    cursor_bg        = "#979db4",
    cursor_fg        = "#282c34",
    selection_bg     = "#3e4452",
    selection_fg     = "#dcdfe4",
    scrollbar_thumb  = "#4e565c",
    split            = "#3e4452",
    ansi             = {"#282c34", "#e06c75", "#98c379", "#e5c07b", "#61afef", "#c678dd", "#56b6c2", "#dcdfe4"},
    brights          = {"#5f6672", "#e06c75", "#98c379", "#e5c07b", "#61afef", "#c678dd", "#56b6c2", "#ffffff"},
  },
  ["OneHalfLight"] = {
    foreground       = "#383a42",
    background       = "#fafafa",
    cursor_bg        = "#4f525e",
    cursor_fg        = "#fafafa",
    selection_bg     = "#a0a1a7",
    selection_fg     = "#fafafa",
    scrollbar_thumb  = "#a0a1a7",
    split            = "#a0a1a7",
    ansi             = {"#383a42", "#e45649", "#50a14f", "#986801", "#4078f2", "#a626a4", "#0184bc", "#a0a1a7"},
    brights          = {"#696c77", "#e45649", "#50a14f", "#986801", "#4078f2", "#a626a4", "#0184bc", "#fafafa"},
  },
  -- ansi and brights table:
  -- ansi[1]: Black
  -- ansi[2]: Red
  -- ansi[3]: Green
  -- ansi[4]: Yellow
  -- ansi[5]: Blue
  -- ansi[6]: Magenta
  -- ansi[7]: Cyan
  -- ansi[8]: White (light gray)
}

-- wezterm.gui is not available to the mux server, so take care to
-- do something reasonable when this config is evaluated by the mux
local function get_appearance()
  if wezterm.gui then
    return wezterm.gui.get_appearance()
  end
  return "Dark"
end

local function scheme_for_appearance(appearance)
  if appearance:find "Dark" then
    return "OneHalfDark"
  else
    return "OneHalfLight"
  end
end

-- Change theme when on macOS appearance changes.
config.color_scheme = scheme_for_appearance(get_appearance())

config.window_frame = {
  font = wezterm.font({ family = "Source Code Pro", weight = "Bold" }),
  font_size = 14.0,
  -- active_titlebar_bg = "#282c34",
}

return config
