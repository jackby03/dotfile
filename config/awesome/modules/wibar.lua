-- ~/.config/awesome/modules/wibar.lua

local wibox = require("wibox")
local awful = require("awful")
local gears = require("gears")
local wallpaper = require("modules.wallpaper")
local naughty = require("naughty")

-- Import widgets from widgets folder
local volume_widget = require("widgets.volume")
local battery_widget = require("widgets.battery")()
local wifi_widget = require("widgets.wifi")
local bluetooth_widget = require("widgets.bluetooth")
-- local keyboard_widget = require("widgets.keyboard")

mytextclock = wibox.widget.textclock()

-- Create a wibox for each screen and add it
local taglist_buttons = gears.table.join(
    -- taglist buttons remain unchanged
)

local tasklist_buttons = gears.table.join(
    -- tasklist buttons remain unchanged
)

awful.screen.connect_for_each_screen(function(s)
    -- Wallpaper
    wallpaper.set_wallpaper(s)

    -- Each screen has its own tag table.
    awful.tag({ "1", "2", "3", "4", "5", "6", "7", "8", "9" }, s, awful.layout.layouts[1])

    -- Create a promptbox for each screen
    s.mypromptbox = awful.widget.prompt()
    
    -- Create an imagebox widget which will contain an icon indicating which layout we're using.
    s.mylayoutbox = awful.widget.layoutbox(s)
    s.mylayoutbox:buttons(gears.table.join(
        -- layoutbox buttons remain unchanged
    ))
    
    -- Create a taglist widget
    s.mytaglist = awful.widget.taglist({
        screen = s,
        filter = awful.widget.taglist.filter.all,
        buttons = taglist_buttons,
    })

    -- Create a tasklist widget
    s.mytasklist = awful.widget.tasklist({
        screen = s,
        filter = awful.widget.tasklist.filter.currenttags,
        buttons = tasklist_buttons,
    })

    -- Create the wibox
    s.mywibox = awful.wibar({ position = "top", screen = s })

    -- Add widgets to the wibox
    s.mywibox:setup({
        layout = wibox.layout.align.horizontal,
        { -- Left widgets
            layout = wibox.layout.fixed.horizontal,
            mylauncher,
            s.mytaglist,
            s.mypromptbox,
        },
        s.mytasklist, -- Middle widget
        { -- Right widgets
            layout = wibox.layout.fixed.horizontal,
            spacing = 5,
            volume_widget,
            battery_widget,
            wifi_widget,
            bluetooth_widget,
            -- keyboard_widget,
            wibox.widget.systray(),
            mytextclock,
            s.mylayoutbox,
        },
    })
end)
