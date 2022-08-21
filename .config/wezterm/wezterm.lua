local wezterm = require 'wezterm'
return {
  font = wezterm.font 'JuliaMono',
  color_scheme = "nightfox",
  hide_tab_bar_if_only_one_tab=true,
  show_update_window = false,
  check_for_updates = false,
}
