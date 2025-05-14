-- ~/.config/awesome/widgets/wifi.lua

local awful = require("awful")
local wibox = require("wibox")
local gears = require("gears")
local beautiful = require("beautiful")

local wifi_widget = wibox.widget {
    {
        id = "icon",
        font = "Hack Nerd Font 12",
        widget = wibox.widget.textbox,
    },
    {
        id = "text",
        widget = wibox.widget.textbox,
        margins_left = 4,
    },
    layout = wibox.layout.fixed.horizontal,
    spacing = 4,
}

local function update_wifi(widget, stdout)
    local ssid = stdout:match("SSID:%s*([^\n]*)")
    local strength = stdout:match("SIGNAL:%s*(%d+)")
    if ssid and ssid ~= "--" then
        local quality = tonumber(strength) or 0
        local icon
        if quality >= 80 then
            icon = "󰤨"
        elseif quality >= 60 then
            icon = "󰤥"
        elseif quality >= 40 then
            icon = "󰤢"
        elseif quality >= 20 then
            icon = "󰤟"
        else
            icon = "󰤯"
        end
        widget:get_children_by_id("icon")[1]:set_markup(
            "<span foreground='" .. (beautiful.fg_normal or "#FFFFFF") .. "'>" .. icon .. "</span>"
        )
        widget:get_children_by_id("text")[1]:set_text(ssid .. "  " .. quality .. "%")
    else
        widget:get_children_by_id("icon")[1]:set_markup(
            "<span foreground='#FF0000'>󰤭</span>"
        )
        widget:get_children_by_id("text")[1]:set_text("No WiFi")
    end
end

local function handle_error(widget, err)
    widget:get_children_by_id("icon")[1]:set_markup(
        "<span foreground='#FF0000'>󰀦</span>"
    )
    widget:get_children_by_id("text")[1]:set_text("Error")
end

local function get_wifi_status(widget)
    awful.spawn.easy_async_with_shell(
        "nmcli -t -f active,ssid,signal dev wifi | grep '^yes' | head -n1 | awk -F: '{print \"SSID: \"$2\"\\nSIGNAL: \"$3}'",
        function(stdout, stderr, _, exit_code)
            if exit_code == 0 and stdout and #stdout > 0 then
                update_wifi(widget, stdout)
            else
                handle_error(widget, stderr)
            end
        end
    )
end

gears.timer {
    timeout = 10,
    autostart = true,
    callback = function()
        get_wifi_status(wifi_widget)
    end,
}

get_wifi_status(wifi_widget)

return wifi_widget
