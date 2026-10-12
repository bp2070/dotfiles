local wezterm = require("wezterm")

local config = wezterm.config_builder()

config.default_prog = { "pwsh.exe", "-NoLogo" }

local launch_menu = {}

if wezterm.target_triple == "x86_64-pc-windows-msvc" then
	table.insert(launch_menu, {
		label = "PowerShell",
		args = { "pwsh.exe", "-NoLogo" },
	})
end
config.enable_kitty_keyboard = false
config.launch_menu = launch_menu

config.color_scheme = "Catppuccin Mocha"

config.font = wezterm.font("Hasklug Nerd Font")
-- config.font = wezterm.font("DroidSansM Nerd Font")
-- config.font = wezterm.font("Inconsolata Nerd Font")
-- config.font = wezterm.font("Cascadia Code")
-- config.font = wezterm.font("Hack Nerd Font")
-- config.font = wezterm.font("FiraCode Nerd Font")
-- config.font = wezterm.font("JetBrains Mono")
-- config.font = wezterm.font("SauceCodePro Nerd Font")

config.font_size = 10

-- Window Configuration
config.window_decorations = "TITLE | RESIZE"
config.window_close_confirmation = "NeverPrompt"

-- Performance Settings
config.max_fps = 144
config.animation_fps = 60
config.cursor_blink_rate = 250

-- Tab Bar Configuration
config.enable_tab_bar = true
config.hide_tab_bar_if_only_one_tab = true
config.show_new_tab_button_in_tab_bar = false

-- Keybindings
config.keys = {
	{
		key = "v",
		mods = "CTRL",
		action = wezterm.action({ PasteFrom = "Clipboard" }),
	},
}

return config
