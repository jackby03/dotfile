-- ~/.config/awesome/modules/layouts.lua

local awful = require("awful")

-- Table of layouts to cover with awful.layout.inc, order matters.
awful.layout.layouts = {
    awful.layout.suit.floating,
    awful.layout.suit.tile,
    awful.layout.suit.max,
    awful.layout.suit.magnifier,
    awful.layout.suit.fair,
    awful.layout.suit.spiral,
    awful.layout.suit.corner.nw,
}