-- ~/.config/awesome/widgets/brightness.lua

local awful = require("awful")
local wibox = require("wibox")
local gears = require("gears")
local beautiful = require("beautiful")

-- Create the widget
local brightness_widget = wibox.widget {
    {
        id = "text_role",
        text = "🔆 N/A",
        widget = wibox.widget.textbox,
    },
    layout = wibox.layout.fixed.horizontal,
}

-- Function to update brightness
local function update_brightness()
    awful.spawn.easy_async_with_shell(
        "brightnessctl g && brightnessctl m",
        function(stdout)
            local current, max = stdout:match("(%d+)\n(%d+)")
            if current and max then
                local brightness_percentage = math.floor((current / max) * 100)
                brightness_widget.text_role.text = "🔆 " .. brightness_percentage .. "%"
            end
        end
    )
end

-- Update on startup
update_brightness()

-- Update every 5 seconds
gears.timer {
    timeout = 5,
    call_now = true,
    autostart = true,
    callback = update_brightness
}

-- Add scroll functionality to change brightness
brightness_widget:connect_signal("button::press", function(_, _, _, button)
    if button == 4 then -- Scroll up
        awful.spawn.with_shell("brightnessctl set +5%")
    elseif button == 5 then -- Scroll down
        awful.spawn.with_shell("brightnessctl set 5%-")
    end
    -- Update widget after brightness change
    gears.timer.start_new(0.1, function()
        update_brightness()
        return false
    end)
end)

return brightness_widget