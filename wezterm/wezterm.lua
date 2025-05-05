local wezterm = require("wezterm")
local launch_menu = {}
local catppuccin_palette = {
	mauve = "#cba6f7",
	peach = "#fab387",
	green = "#a6e3a1",
	base = "#1e1e2e",
	mantle = "#181825",
	crust = "#11111b",
	subtext0 = "#a6adc8",
	subtext1 = "#bac2de",
	text = "#cdd6f4",
	base_grayer = "#212129",
	lavender = "#b4befe",
	surface0 = "#313244",
	surface1 = "#45475a",
}

-- This event handler will be called when the custom "close_all_tabs" event is emitted.
-- ClostTab is not a valid action...need to find a way to close all tabs
-- wezterm.on("close_all_tabs", function(window, pane)
-- 	for _, tab in ipairs(window:mux_window():tabs()) do
-- 		window:perform_action(wezterm.action({ CloseTab = { tab_id = tab:tab_id() } }), pane)
-- 	end
-- end)

local config = wezterm.config_builder()

local function tab(tab_info)
	local title = tab_info.tab_title
	local tab_index = tostring(tab_info.tab_index + 1)

	-- if the tab title is explicitly set, take that
	if title and #title > 0 then
		return "[" .. tab_index .. ":" .. title .. "]"
	end
	-- Otherwise, use the tab index
	return "[" .. tab_index .. "]"
end

local tabline = wezterm.plugin.require("https://github.com/michaelbrusegard/tabline.wez")
tabline.setup({
	options = {
		tab_separators = " ",
		theme_overrides = {
			tab = {
				active = { fg = catppuccin_palette.peach, bg = catppuccin_palette.base_grayer },
				inactive = { fg = catppuccin_palette.subtext1, bg = catppuccin_palette.base_grayer },
			},
			normal_mode = {
				a = { fg = catppuccin_palette.base_grayer, bg = catppuccin_palette.lavender },
				b = { fg = catppuccin_palette.lavender, bg = catppuccin_palette.surface0 },
				c = { fg = catppuccin_palette.lavender, bg = catppuccin_palette.base_grayer },
			},
		},
	},
	sections = {
		tabline_a = { cond = false },
		tabline_b = { cond = false },
		tabline_c = { "  " },
		tabline_z = { cond = false },
		tab_active = { tab, padding = 0 },
		tab_inactive = { tab, padding = 0 },
	},
})

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
config.show_new_tab_button_in_tab_bar = false
config.use_fancy_tab_bar = false
config.colors = {
	tab_bar = {
		background = catppuccin_palette.base_grayer,
	},
	background = catppuccin_palette.base_grayer,
}

-- Keybindings
config.keys = {
	{ key = "v", mods = "CTRL", action = wezterm.action({ PasteFrom = "Clipboard" }) },
}

return config
