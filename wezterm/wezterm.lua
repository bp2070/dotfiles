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
-- Preserve modifier information for Ctrl+Shift+number. Without enhanced
-- keyboard reporting, these chords collapse into Ctrl+! / Ctrl+@ / etc.
config.enable_kitty_keyboard = true
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

-- Ctrl+Shift+number is received by WezTerm as shifted punctuation
-- (!, @, #, ...). Terminal protocols cannot reliably preserve that complete
-- chord set, so translate the physical key to Alt+number. Herdr binds the
-- latter as its tab-selection shortcut; Alt is an unambiguous ESC sequence.
local shifted_number_keys = { "!", "@", "#", "$", "%", "^", "&", "*", "(" }
for number, trigger_key in ipairs(shifted_number_keys) do
	table.insert(config.keys, {
		key = trigger_key,
		mods = "CTRL|SHIFT",
		action = wezterm.action.SendKey({
			key = tostring(number),
			mods = "ALT",
		}),
	})
end

return config
