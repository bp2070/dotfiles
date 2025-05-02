local wezterm = require("wezterm")
local launch_menu = {}
local catppuccin_palette = {
	mauve = "#cba6f7",
	peach = "#fab387",
	green = "#a6e3a1",
	base = "#1e1e2e",
	subtext0 = "#a6adc8",
	subtext1 = "#bac2de",
	text = "#cdd6f4",
}
local config = wezterm.config_builder()

config.default_prog = { "pwsh.exe", "-NoLogo" }

if wezterm.target_triple == "x86_64-pc-windows-msvc" then
	table.insert(launch_menu, {
		label = "PowerShell",
		args = { "pwsh.exe", "-NoLogo" },
	})
end

config.color_scheme = "Catppuccin Mocha"
config.launch_menu = launch_menu

config.font = wezterm.font("CaskaydiaCove Nerd Font Mono")
config.font_size = 10

-- Window Configuration
-- config.initial_rows = 45
-- config.initial_cols = 180
config.window_decorations = "RESIZE"
-- config.window_background_opacity = opacity
-- config.window_background_image = (os.getenv("WEZTERM_CONFIG_FILE") or ""):gsub("wezterm.lua", "bg-blurred.png")
config.window_close_confirmation = "NeverPrompt"
config.win32_system_backdrop = "Acrylic"

-- Performance Settings
config.max_fps = 144
config.animation_fps = 60
config.cursor_blink_rate = 250

-- Tab Bar Configuration
config.enable_tab_bar = true
-- config.hide_tab_bar_if_only_one_tab = true
config.show_tab_index_in_tab_bar = false
config.use_fancy_tab_bar = false
config.colors = {
	tab_bar = {
		background = catppuccin_palette.base,
	},
}

-- Tab Formatting
local function tab_title(tab_info)
	local title = tab_info.tab_title
	local tab_index = tostring(tab_info.tab_index + 1)

	-- if the tab title is explicitly set, take that
	if title and #title > 0 then
		return "[" .. tab_index .. ":" .. title .. "]"
	end
	-- Otherwise, use the tab index
	return "[" .. tab_index .. "]"
end

wezterm.on("format-tab-title", function(tab, _, _, _, hover)
	local background = catppuccin_palette.base
	local foreground = catppuccin_palette.subtext1

	if tab.is_active then
		foreground = catppuccin_palette.peach
	elseif hover then
		foreground = catppuccin_palette.mauve
	end

	-- local title = tostring(tab.tab_index + 1)
	local title = tab_title(tab)
	return {
		{ Foreground = { Color = background } },
		{ Text = "█" },
		{ Background = { Color = background } },
		{ Foreground = { Color = foreground } },
		{ Text = title },
		{ Foreground = { Color = background } },
		{ Text = "█" },
	}
end)

-- Keybindings
config.keys = {
	{ key = "v", mods = "CTRL", action = wezterm.action({ PasteFrom = "Clipboard" }) },
}

return config
