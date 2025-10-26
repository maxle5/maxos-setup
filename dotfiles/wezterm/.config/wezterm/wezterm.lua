local wezterm = require("wezterm")
local act = wezterm.action

return {
	enable_wayland = true,
	default_cwd = "~/Source",
	default_cursor_style = "SteadyBar",
	color_scheme = "Gruvbox dark, hard (base16)",
	font = wezterm.font("JetBrainsMono NF"),
	font_size = 14.0,
	window_decorations = "NONE",
	window_background_opacity = 0.8,
	use_fancy_tab_bar = true,
	hide_tab_bar_if_only_one_tab = true,
	inactive_pane_hsb = {
		saturation = 0.85,
		brightness = 0.75,
	},
	disable_default_key_bindings = true,
	keys = {
		{
			key = "Space",
			mods = "CTRL|SHIFT",
			action = act.QuickSelect,
		},
		{
			key = "c",
			mods = "CTRL|SHIFT",
			action = act.CopyTo("Clipboard"),
		},
		{
			key = "v",
			mods = "CTRL|SHIFT",
			action = act.PasteFrom("Clipboard"),
		},
		{
			key = "w",
			mods = "CTRL",
			action = act.CloseCurrentPane({ confirm = true }),
		},
		{
			key = "p",
			mods = "CTRL|SHIFT",
			action = act.ShowLauncher,
		},
		{
			key = "_",
			mods = "CTRL|SHIFT",
			action = act.SplitVertical({ domain = "CurrentPaneDomain" }),
		},
		{
			key = "+",
			mods = "CTRL|SHIFT",
			action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }),
		},
		{
			key = "h",
			mods = "CTRL|SHIFT",
			action = act.ActivatePaneDirection("Left"),
		},
		{
			key = "l",
			mods = "CTRL|SHIFT",
			action = act.ActivatePaneDirection("Right"),
		},
		{
			key = "k",
			mods = "CTRL|SHIFT",
			action = act.ActivatePaneDirection("Up"),
		},
		{
			key = "j",
			mods = "CTRL|SHIFT",
			action = act.ActivatePaneDirection("Down"),
		},
		{
			key = "u",
			mods = "CTRL|SHIFT",
			action = act.AdjustPaneSize({ "Left", 5 }),
		},
		{
			key = "i",
			mods = "CTRL|SHIFT",
			action = act.AdjustPaneSize({ "Down", 5 }),
		},
		{
			key = "o",
			mods = "CTRL|SHIFT",
			action = act.AdjustPaneSize({ "Up", 5 }),
		},
		{
			key = "p",
			mods = "CTRL|SHIFT",
			action = act.AdjustPaneSize({ "Right", 5 }),
		},
	},
}
