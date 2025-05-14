-- ~/.config/awesome/modules/keys.lua

local awful = require("awful")
local gears = require("gears")
local hotkeys_popup = require("awful.hotkeys_popup")
local menubar = require("menubar") -- Add missing dependency

-- Configuration variables (should be passed from rc.lua or defined here)
local terminal = "alacrity" -- Default fallback, will be overridden in setup()
local modkey = "Mod4"

-- Helper functions for updating widgets (should be passed as parameters or imported)
local update_brightness = function()
	-- Placeholder function, should be implemented or passed in
	-- This will be called when brightness changes
end

local update_volume = function()
	-- Placeholder function, should be implemented or passed in
	-- This will be called when volume changes
end

-- Initialize the module table
local M = {}

-- {{{ Mouse bindings
M.root_buttons = gears.table.join(
	awful.button({}, 3, function()
		if mymainmenu then mymainmenu:toggle() end
	end),
	awful.button({}, 4, awful.tag.viewnext),
	awful.button({}, 5, awful.tag.viewprev)
)
-- }}}

-- {{{ Key bindings
-- Organize bindings by category for better readability
local global_keys = gears.table.join(
	-- System controls
	awful.key({ modkey, "Shift" }, "s", function()
		awful.spawn("scrot '%Y-%m-%d_%H-%M-%S_screenshot.png' -e 'mv $f ~/Images/Screenshots/'")
	end, { description = "captura de pantalla", group = "sistema" }),

	awful.key({ modkey }, "Escape", function() 
		awful.spawn("xsecurelock")
	end, { description = "lock screen", group = "sistema" }),

	-- Brightness controls
	awful.key({}, "XF86KbdBrightnessUp", function()
		awful.spawn("brightnessctl -d smc::kbd_backlight s +10%")
	end, { description = "Subir brillo teclado", group = "hardware" }),
	
	awful.key({}, "XF86KbdBrightnessDown", function()
		awful.spawn("brightnessctl -d smc::kbd_backlight s 10%-")
	end, { description = "Bajar brillo teclado", group = "hardware" }),
	
	awful.key({}, "XF86MonBrightnessUp", function()
		awful.spawn("brightnessctl set +5%")
		update_brightness()
	end, { description = "Subir brillo", group = "hardware" }),

	awful.key({}, "XF86MonBrightnessDown", function()
		awful.spawn("brightnessctl set 5%-")
		update_brightness()
	end, { description = "Bajar brillo", group = "hardware" }),

	-- Audio controls
	awful.key({}, "XF86AudioRaiseVolume", function()
		awful.spawn("amixer -q set Master 5%+")
		update_volume()
	end, { description = "Subir volumen", group = "audio" }),

	awful.key({}, "XF86AudioLowerVolume", function()
		awful.spawn("amixer -q set Master 5%-")
		update_volume()
	end, { description = "Bajar volumen", group = "audio" }),

	awful.key({}, "XF86AudioMute", function()
		awful.spawn("amixer -q set Master toggle")
		update_volume()
	end, { description = "Silenciar volumen", group = "audio" }),

	awful.key({}, "XF86AudioPlay", function()
		awful.spawn("playerctl play-pause")
	end, { description = "Reproducir/Pausar", group = "audio" }),

	awful.key({}, "XF86AudioNext", function()
		awful.spawn("playerctl next")
	end, { description = "Siguiente canción", group = "audio" }),

	awful.key({}, "XF86AudioPrev", function()
		awful.spawn("playerctl previous")
	end, { description = "Canción anterior", group = "audio" }),

	-- Awesome controls
	awful.key({ modkey }, "s", hotkeys_popup.show_help, { description = "show help", group = "awesome" }),
	awful.key({ modkey, "Control" }, "r", awesome.restart, { description = "reload awesome", group = "awesome" }),
	awful.key({ modkey, "Shift" }, "q", awesome.quit, { description = "quit awesome", group = "awesome" }),
	
	-- Tag navigation
	awful.key({ modkey }, "Left", awful.tag.viewprev, { description = "view previous", group = "tag" }),
	awful.key({ modkey }, "Right", awful.tag.viewnext, { description = "view next", group = "tag" }),

	-- Client focus
	awful.key({ modkey }, "j", function()
		awful.client.focus.byidx(1)
	end, { description = "focus next by index", group = "client" }),
	
	awful.key({ modkey }, "k", function()
		awful.client.focus.byidx(-1)
	end, { description = "focus previous by index", group = "client" }),
	
	awful.key({ modkey }, "Tab", function()
		awful.client.focus.history.previous()
		if client.focus then
			client.focus:raise()
		end
	end, { description = "go back", group = "client" }),

	awful.key({ modkey }, "u", awful.client.urgent.jumpto, { description = "jump to urgent client", group = "client" }),

	-- Layout manipulation
	awful.key({ modkey, "Shift" }, "j", function()
		awful.client.swap.byidx(1)
	end, { description = "swap with next client by index", group = "client" }),
	
	awful.key({ modkey, "Shift" }, "k", function()
		awful.client.swap.byidx(-1)
	end, { description = "swap with previous client by index", group = "client" }),
	
	awful.key({ modkey, "Control" }, "j", function()
		awful.screen.focus_relative(1)
	end, { description = "focus the next screen", group = "screen" }),
	
	awful.key({ modkey, "Control" }, "k", function()
		awful.screen.focus_relative(-1)
	end, { description = "focus the previous screen", group = "screen" }),
	
	-- Layout adjustments
	awful.key({ modkey }, "l", function()
		awful.tag.incmwfact(0.05)
	end, { description = "increase master width factor", group = "layout" }),
	
	awful.key({ modkey }, "h", function()
		awful.tag.incmwfact(-0.05)
	end, { description = "decrease master width factor", group = "layout" }),
	
	awful.key({ modkey, "Shift" }, "h", function()
		awful.tag.incnmaster(1, nil, true)
	end, { description = "increase the number of master clients", group = "layout" }),
	
	awful.key({ modkey, "Shift" }, "l", function()
		awful.tag.incnmaster(-1, nil, true)
	end, { description = "decrease the number of master clients", group = "layout" }),
	
	awful.key({ modkey, "Control" }, "h", function()
		awful.tag.incncol(1, nil, true)
	end, { description = "increase the number of columns", group = "layout" }),
	
	awful.key({ modkey, "Control" }, "l", function()
		awful.tag.incncol(-1, nil, true)
	end, { description = "decrease the number of columns", group = "layout" }),
	
	awful.key({}, "XF86LaunchA", function()
		awful.layout.inc(1)
	end, { description = "select next", group = "layout" }),

	-- Restore minimized
	awful.key({ modkey, "Control" }, "n", function()
		local c = awful.client.restore()
		if c then
			c:emit_signal("request::activate", "key.unminimize", { raise = true })
		end
	end, { description = "restore minimized", group = "client" }),

	-- Launchers
	awful.key({ modkey }, "Return", function()
		awful.spawn(terminal)
	end, { description = "open a terminal", group = "launcher" }),
	
	awful.key({ modkey }, "w", function()
		if mymainmenu then mymainmenu:show() end
	end, { description = "show main menu", group = "launcher" }),

	awful.key({}, "XF86LaunchB", function() 
		awful.util.spawn("rofi -show drun") 
	end, { description = "Abrir Spotlight (rofi)", group = "launcher" }),

	awful.key({ modkey }, "p", function()
		menubar.show()
	end, { description = "show the menubar", group = "launcher" }),

	-- Applications
	awful.key({ modkey }, "b", function()
		awful.util.spawn("firefox")
	end, { description = "firefox", group = "applications" })
)

-- Client keys (actions that operate on the focused client)
M.clientkeys = gears.table.join(
	awful.key({ modkey }, "f", function(c)
		c.fullscreen = not c.fullscreen
		c:raise()
	end, { description = "toggle fullscreen", group = "client" }),
	
	awful.key({ modkey, "Shift" }, "c", function(c)
		c:kill()
	end, { description = "close", group = "client" }),
	
	awful.key({ modkey }, "space", awful.client.floating.toggle,
		{ description = "toggle floating", group = "client" }
	),
	
	awful.key({ modkey, "Control" }, "Return", function(c)
		c:swap(awful.client.getmaster())
	end, { description = "move to master", group = "client" }),
	
	awful.key({ modkey }, "o", function(c)
		c:move_to_screen()
	end, { description = "move to screen", group = "client" }),
	
	awful.key({ modkey }, "t", function(c)
		c.ontop = not c.ontop
	end, { description = "toggle keep on top", group = "client" }),
	
	awful.key({ modkey }, "n", function(c)
		c.minimized = true
	end, { description = "minimize", group = "client" }),
	
	awful.key({ modkey }, "m", function(c)
		c.maximized = not c.maximized
		c:raise()
	end, { description = "(un)maximize", group = "client" }),
	
	awful.key({ modkey, "Control" }, "m", function(c)
		c.maximized_vertical = not c.maximized_vertical
		c:raise()
	end, { description = "(un)maximize vertically", group = "client" }),
	
	awful.key({ modkey, "Shift" }, "m", function(c)
		c.maximized_horizontal = not c.maximized_horizontal
		c:raise()
	end, { description = "(un)maximize horizontally", group = "client" })
)

-- Bind all key numbers to tags
for i = 1, 9 do
	global_keys = gears.table.join(
		global_keys,
		-- View tag only
		awful.key({ modkey }, "#" .. i + 9, function()
			local screen = awful.screen.focused()
			local tag = screen.tags[i]
			if tag then
				tag:view_only()
			end
		end, { description = "view tag #" .. i, group = "tag" }),
		
		-- Toggle tag display
		awful.key({ modkey, "Control" }, "#" .. i + 9, function()
			local screen = awful.screen.focused()
			local tag = screen.tags[i]
			if tag then
				awful.tag.viewtoggle(tag)
			end
		end, { description = "toggle tag #" .. i, group = "tag" }),
		
		-- Move client to tag
		awful.key({ modkey, "Shift" }, "#" .. i + 9, function()
			if client.focus then
				local tag = client.focus.screen.tags[i]
				if tag then
					client.focus:move_to_tag(tag)
				end
			end
		end, { description = "move focused client to tag #" .. i, group = "tag" }),
		
		-- Toggle tag on focused client
		awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9, function()
			if client.focus then
				local tag = client.focus.screen.tags[i]
				if tag then
					client.focus:toggle_tag(tag)
				end
			end
		end, { description = "toggle focused client on tag #" .. i, group = "tag" })
	)
end

-- Mouse button bindings for clients
M.clientbuttons = gears.table.join(
	awful.button({}, 1, function(c)
		c:emit_signal("request::activate", "mouse_click", { raise = true })
	end),
	
	awful.button({ modkey }, 1, function(c)
		c:emit_signal("request::activate", "mouse_click", { raise = true })
		awful.mouse.client.move(c)
	end),
	
	awful.button({ modkey }, 3, function(c)
		c:emit_signal("request::activate", "mouse_click", { raise = true })
		awful.mouse.client.resize(c)
	end)
)

-- Set keys
M.globalkeys = global_keys
root.keys(global_keys)
root.buttons(M.root_buttons)

-- Function to set up keys with external dependencies
M.setup = function(config)
	-- Set terminal from config
	terminal = config.terminal or terminal
	
	-- Allow setting the update functions
	if config.update_volume then
		update_volume = config.update_volume
	end
	
	if config.update_brightness then
		update_brightness = config.update_brightness
	end
	
	-- Allow setting the main menu
	if config.mymainmenu then
		mymainmenu = config.mymainmenu
	end
	
	-- Re-apply keys after config
	root.keys(M.globalkeys)
	root.buttons(M.root_buttons)
	
	return M
end

-- Return the module
return M