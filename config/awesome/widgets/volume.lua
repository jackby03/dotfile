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
    awful.spawn.easy_async_with_shell("wpctl get-volume @DEFAULT_AUDIO_SINK@", function(stdout)
        local volume = stdout:match("(%d+%.?%d*)")
        local mute = stdout:find("%[MUTED%]")
        local icon = ""

        if mute then
            icon = "󰝟"
            volume = "Silenciado"
        else
            volume = math.floor((tonumber(volume) or 0) * 100) .. "%"
            icon = "󰕾"
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
        awful.spawn("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle")
        update_volume()
    elseif button == 4 then
        awful.spawn("wpctl set-volume -l 1.5 @DEFAULT_AUDIO_SINK@ 5%+")
        update_volume()
    elseif button == 5 then
        awful.spawn("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-")
        update_volume()
    end
end)

do return volume_widget end