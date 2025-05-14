-- ~/.config/awesome/widgets/volume.lua

local awful = require("awful")
local wibox = require("wibox")
local naughty = require("naughty")
local gears = require("gears")

-- Custom Volume Bar
local volume_widget = wibox.widget({
	widget = wibox.widget.textbox,
	align = "center",
	valign = "center",
})

local function update_volume()
	awful.spawn.easy_async_with_shell("amixer -D pulse sget Master", function(stdout)
		local volume = stdout:match("(%d+)%%")
		local mute = stdout:match("%[(o[^%]]*)%]")
		local icon = ""

		if mute == "off" then
			icon = ""
			volume = "Silenciado"
		else
			volume = volume .. "%"
		end

		volume_widget:set_text(icon .. "  " .. volume)
	end)
end

gears.timer.start_new(10, function()
	update_volume()
	return true
end)

volume_widget:connect_signal("button::press", function(_, _, _, button)
	if button == 1 then
		awful.spawn("amixer -D pulse set Master toggle")
		update_volume()
	elseif button == 4 then
		awful.spawn("amixer -D pulse set Master 5%+")
		update_volume()
	elseif button == 5 then
		awful.spawn("amixer -D pulse set Master 5%-")
		update_volume()
	end
end)

do return volume_widget end

-- Initialize the widget
local volume = require("widgets.volume")()

-- Connect to the volume change signal if you have one
if awesome then
	awesome.connect_signal("volume_change", function()
		update_volume()
	end)
end