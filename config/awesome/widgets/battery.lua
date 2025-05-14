-- ~/.config/awesome/widgets/battery.lua

-- Imports
local awful = require("awful")
local wibox = require("wibox")
local gears = require("gears")
local beautiful = require("beautiful")

-- Create the battery widget
local battery = {}

local function update_widget(widget)
  awful.spawn.easy_async("acpi -b", function(stdout)
    local battery_perc = stdout:match("(%d?%d?%d)%%") or "N/A"
    local charging = stdout:match("Charging") and true or false
    local icon = ""
    
    if charging then
      icon = "󰂄" -- charging icon
    else
      local percent = tonumber(battery_perc) or 0
      if percent <= 10 then
        icon = "󰁺" -- critical battery
      elseif percent <= 20 then
        icon = "󰁻" -- low battery
      elseif percent <= 30 then
        icon = "󰁼" -- battery at 30%
      elseif percent <= 40 then
        icon = "󰁽" -- battery at 40%
      elseif percent <= 50 then
        icon = "󰁾" -- battery at 50%
      elseif percent <= 60 then
        icon = "󰁿" -- battery at 60%
      elseif percent <= 70 then
        icon = "󰂀" -- battery at 70%
      elseif percent <= 80 then
        icon = "󰂁" -- battery at 80%
      elseif percent <= 90 then
        icon = "󰂂" -- battery at 90%
      else
        icon = "󰁹" -- full battery
      end
    end
    
    widget:set_text(icon .. "  " .. battery_perc .. "%")
  end)
end

function battery.new()
  local widget = wibox.widget.textbox()
  
  -- Initial update
  update_widget(widget)
  
  -- Setup timer for widget refresh
  local timer = gears.timer {
    timeout = 30,
    call_now = true,
    autostart = true,
    callback = function()
      update_widget(widget)
    end
  }
  
  return widget
end

return setmetatable(battery, { __call = function(_, ...) return battery.new(...) end })
