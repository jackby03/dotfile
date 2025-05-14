-- ~/.config/awesome/widgets/bluetooth.lua

-- -- Imports
local awful = require("awful")
local beautiful = require("beautiful")
local gears = require("gears")
local wibox = require("wibox")
local naughty = require("naughty")

-- -- Module
local bluetooth = {}

-- -- Nerd Font icons
local icon_on = ""  -- Bluetooth icon (U+F293)
local icon_off = "󰂲" -- Bluetooth off icon (U+F5AB)

-- -- Initialize widget
bluetooth.widget = wibox.widget {
    {
        id = "icon",
        widget = wibox.widget.textbox,
        font = "Hack Nerd Font 14"
    },
    layout = wibox.container.margin(_, _, _, _),
    set_bluetooth_status = function(self, is_enabled)
        self.icon.markup = string.format('<span color="%s">%s</span>', 
            beautiful.fg_normal or "#FFFFFF", 
            is_enabled and icon_on or icon_off)
    end
}

-- -- Functions to manage bluetooth
function bluetooth.enable()
    awful.spawn.easy_async_with_shell("bluetoothctl power on", function()
        bluetooth.update()
    end)
end

function bluetooth.disable()
    awful.spawn.easy_async_with_shell("bluetoothctl power off", function()
        bluetooth.update()
    end)
end

function bluetooth.toggle()
    awful.spawn.easy_async_with_shell("bluetoothctl show | grep 'Powered: yes'", function(stdout)
        if stdout:match('Powered: yes') then
            bluetooth.disable()
        else
            bluetooth.enable()
        end
    end)
end

-- -- Update widget status
function bluetooth.update()
    awful.spawn.easy_async_with_shell("bluetoothctl show | grep 'Powered: yes'", function(stdout)
        local is_enabled = stdout:match('Powered: yes') ~= nil
        bluetooth.widget:set_bluetooth_status(is_enabled)
    end)
end

-- -- Initialize widget with click behavior
bluetooth.widget:buttons(
    gears.table.join(
        awful.button({}, 1, function()
            bluetooth.toggle()
        end),
        awful.button({}, 3, function()
            awful.spawn("blueman-manager")
        end)
    )
)

-- -- Start with update
bluetooth.update()

-- -- Setup timer for updating
gears.timer {
    timeout = 5,
    call_now = true,
    autostart = true,
    callback = bluetooth.update
}

return bluetooth
