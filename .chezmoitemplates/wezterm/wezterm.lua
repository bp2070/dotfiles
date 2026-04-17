local wezterm = require("wezterm")
local mux = wezterm.mux

wezterm.on("gui-startup", function()
	local workspace_dir = "C:\\Users\\bryan.petzinger\\workspace\\psif-workspace"
	local tab1, pane1, window = mux.spawn_window({ width = 150, height = 50 })
	local tab2, pane2, _ = window:spawn_tab({})
	-- local tab3, pane3, _ = window:spawn_tab {}

	tab1:activate()
	tab1:set_title("nvim")
	tab2:set_title("term")

	pane1:send_text("cd " .. workspace_dir .. "&& nvim \r\n")
	pane2:send_text("cd " .. workspace_dir .. " && clear \r\n")
end)

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

local gruvbox_palette = {
  fg1    = '#282828',
  color2 = '#504945',
  fg2    = '#ddc7a1',
  fg3    = '#cdd6f4',
  color3 = '#32302f',
  color4 = '#a89984',
  color5 = '#7daea3',
  color6 = '#a9b665',
  color7 = '#d8a657',
  color8 = '#d3869b',
  color9 = '#ea6962',
}

-- This event handler will be called when the custom "close_all_tabs" event is emitted.
-- ClostTab is not a valid action...need to find a way to close all tabs
-- wezterm.on("close_all_tabs", function(window, pane)
-- 	for _, tab in ipairs(window:mux_window():tabs()) do
-- 		window:perform_action(wezterm.action({ CloseTab = { tab_id = tab:tab_id() } }), pane)
-- 	end
-- end)

local config = wezterm.config_builder()

local function tab_component(tab_info)
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
				active = {
		        fg = gruvbox_palette.color3,
		        bg = gruvbox_palette.fg2,
		      },
				inactive = {
		        fg = gruvbox_palette.fg2,
		        bg = gruvbox_palette.color2,
		      },
			},
			normal_mode = {
				-- a = { fg = catppuccin_palette.mantle, bg = catppuccin_palette.lavender },
				b = { fg = gruvbox_palette.fg2, bg = gruvbox_palette.color2 },
				c = { fg = gruvbox_palette.fg2, bg = gruvbox_palette.color2 },
			},
		},
	},
	sections = {
		tabline_a = { cond = false },
		tabline_b = { cond = false },
		tabline_c = { "  " },
		tabline_z = { cond = false },
		tab_active = { tab_component, padding = 0 },
		tab_inactive = { tab_component, padding = 0 },
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

config.font = wezterm.font("Cascadia Code")
-- config.font = wezterm.font("Hack Nerd Font")
-- config.font = wezterm.font("FiraCode Nerd Font")
-- config.font = wezterm.font("JetBrains Mono")
-- config.font = wezterm.font("SauceCodePro Nerd Font")

config.font_size = 10

-- Window Configuration
config.window_decorations = "RESIZE"
config.background = {
	{
		source = { File = wezterm.config_dir .. "/gradient-sapphire2.png" },
	  hsb = { brightness = .1 },
		repeat_x = "NoRepeat",
	},
	-- {
	-- 	source = { Color = 'black' },
	-- 	height = "100%",
	-- 	width = "100%",
	-- 	opacity = .3,
	-- },
}
config.window_close_confirmation = "NeverPrompt"
config.win32_system_backdrop = "Acrylic"

-- Performance Settings
config.max_fps = 144
config.animation_fps = 60
config.cursor_blink_rate = 250

-- Tab Bar Configuration
config.enable_tab_bar = true
config.hide_tab_bar_if_only_one_tab = true
config.show_tab_index_in_tab_bar = false
config.show_new_tab_button_in_tab_bar = false
config.use_fancy_tab_bar = false
config.colors = {
	tab_bar = {
		background = gruvbox_palette.color2,
	},
}

-- Keybindings
config.keys = {
	{
		key = "v",
		mods = "CTRL",
		action = wezterm.action({ PasteFrom = "Clipboard" }),
	},
}

return config
