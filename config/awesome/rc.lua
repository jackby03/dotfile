-- ~/.config/awesome/rc.lua

local gears = require("gears")
local awful = require("awful")
local beautiful = require("beautiful")

-- Load awesome library
local keys = require("modules.keys")
root.keys(keys.globalkeys)

-- Load core error handling and variable definitions
require("modules.core")

-- Load theme
local beautiful = require("beautiful")
beautiful.init(gears.filesystem.get_configuration_dir() .. "theme.lua")

-- Load layouts
require("modules.layouts")

-- Load menu and launcher
require("modules.menu")

-- Load rules
require("modules.rules")

-- Load signals
require("modules.signals")

-- Load wibar (top bar and widgets)
require("modules.wibar")

-- Optionally, autostart applications
awful.spawn.with_shell("picom -b")