local wezterm = require 'wezterm'
local mux = wezterm.mux

wezterm.on("gui-startup", function()
  local tab, pane, window = mux.spawn_window{}
  window:gui_window():maximize()
end)

local config = wezterm.config_builder()

config.window_close_confirmation = 'NeverPrompt'

config.color_scheme = 'Oceanic-Next'

config.font = wezterm.font 'Iosevka Term'
config.font_size = 16.0
config.cell_width = 1.05

config.enable_tab_bar = false

config.harfbuzz_features = { 'calt=0', 'clig=0', 'liga=0' }

return config
