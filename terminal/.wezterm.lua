local wezterm = require 'wezterm'

local config = wezterm.config_builder()

config.color_scheme = 'Oceanic-Next'

config.font = wezterm.font 'Iosevka Term'
config.font_size = 16.0
config.cell_width = 1.05

config.enable_tab_bar = false

config.initial_cols = 200
config.initial_rows = 200

config.harfbuzz_features = { 'calt=0', 'clig=0', 'liga=0' }

return config
