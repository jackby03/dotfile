-- ~/.config/awesome/modules/keys.lua
-- Key bindings configuration for AwesomeWM
-- Organized by categories with comprehensive descriptions

local awful = require("awful")
local gears = require("gears")
local hotkeys_popup = require("awful.hotkeys_popup")
local menubar = require("menubar")
local client = require("awful.client")

-- Ensure `root` is accessible
local root = require("awful").root

-- Module initialization
local M = {}

-- Default configuration (will be overridden in setup())
local terminal = "alacritty"
local modkey = "Mod4"
local mymainmenu = nil

-- Helper functions placeholders (populated in setup())
local update_brightness = function() end
local update_volume = function() end

-- =============================
-- Mouse bindings
-- =============================
M.root_buttons = gears.table.join(
    awful.button({}, 3, function()
        if mymainmenu then mymainmenu:toggle() end
    end, { description = "open main menu", group = "awesome" }),
    awful.button({}, 4, awful.tag.viewnext, { description = "view next tag", group = "tag" }),
    awful.button({}, 5, awful.tag.viewprev, { description = "view previous tag", group = "tag" })
)

-- =============================
-- Global Key Bindings
-- =============================
local global_keys = gears.table.join(
    -- Screenshot
    awful.key({ modkey, "Shift" }, "s", function()
        awful.spawn("scrot '%Y-%m-%d_%H-%M-%S_screenshot.png' -e 'mv $f ~/Images/Screenshots/'")
    end, { description = "take screenshot", group = "system" }),

    -- Brightness controls
    awful.key({}, "XF86MonBrightnessUp", function()
        awful.spawn("brightnessctl set +5%")
        update_brightness()
    end, { description = "increase brightness", group = "hardware" }),
    awful.key({}, "XF86MonBrightnessDown", function()
        awful.spawn("brightnessctl set 5%-")
        update_brightness()
    end, { description = "decrease brightness", group = "hardware" }),

    -- Volume controls
    awful.key({}, "XF86AudioRaiseVolume", function()
        awful.spawn("amixer set Master 5%+")
        update_volume()
    end, { description = "increase volume", group = "audio" }),
    awful.key({}, "XF86AudioLowerVolume", function()
        awful.spawn("amixer set Master 5%-")
        update_volume()
    end, { description = "decrease volume", group = "audio" }),
    awful.key({}, "XF86AudioMute", function()
        awful.spawn("amixer set Master toggle")
        update_volume()
    end, { description = "mute volume", group = "audio" }),

    -- Media controls
    awful.key({}, "XF86AudioPlay", function()
        awful.spawn("playerctl play-pause")
    end, { description = "play/pause media", group = "audio" }),
    awful.key({}, "XF86AudioNext", function()
        awful.spawn("playerctl next")
    end, { description = "next track", group = "audio" }),
    awful.key({}, "XF86AudioPrev", function()
        awful.spawn("playerctl previous")
    end, { description = "previous track", group = "audio" }),

    -- Tag navigation
    awful.key({ modkey }, "Left", awful.tag.viewprev, { description = "view previous tag", group = "tag" }),
    awful.key({ modkey }, "Right", awful.tag.viewnext, { description = "view next tag", group = "tag" }),

    -- Client focus
    awful.key({ modkey }, "j", function()
        awful.client.focus.byidx(1)
    end, { description = "focus next client", group = "client" }),
    awful.key({ modkey }, "k", function()
        awful.client.focus.byidx(-1)
    end, { description = "focus previous client", group = "client" }),

    -- Layout manipulation
    awful.key({ modkey, "Shift" }, "j", function()
        awful.client.swap.byidx(1)
    end, { description = "swap with next client", group = "client" }),
    awful.key({ modkey, "Shift" }, "k", function()
        awful.client.swap.byidx(-1)
    end, { description = "swap with previous client", group = "client" }),

    -- Standard programs
    awful.key({ modkey }, "Return", function()
        awful.spawn(terminal)
    end, { description = "open terminal", group = "launcher" }),
    awful.key({ modkey }, "b", function()
        awful.spawn("firefox")
    end, { description = "open browser", group = "launcher" })
)

-- Add XF86Launch keybindings
global_keys = gears.table.join(
    global_keys,
    -- XF86LaunchA: Cycle layout forward
    awful.key({}, "XF86LaunchA", function()
        awful.layout.inc(1)
    end, { description = "cycle layout forward", group = "layout" }),
    -- XF86LaunchB: Open application launcher (rofi)
    awful.key({}, "XF86LaunchB", function()
        awful.util.spawn("rofi -show drun")
    end, { description = "open application launcher (rofi)", group = "launcher" }),

    -- Fix reload keybinding
    awful.key({ modkey, "Control" }, "r", function()
        awesome.restart()
    end, { description = "reload awesome configuration", group = "awesome" })
)

-- Restaurar keybindings para cambiar entre clientes y mover clientes a tags
global_keys = gears.table.join(
    -- Cambiar entre clientes
    awful.key({ modkey }, "Tab", function()
        awful.client.focus.byidx(1)
    end, { description = "focus next client", group = "client" }),

    awful.key({ modkey, "Shift" }, "Tab", function()
        awful.client.focus.byidx(-1)
    end, { description = "focus previous client", group = "client" }),

    -- Keybindings para tags (1-9)
    awful.key({ modkey }, "#1", function()
        local screen = awful.screen.focused()
        local tag = screen.tags[1]
        if tag then
            tag:view_only()
        end
    end, { description = "view tag #1", group = "tag" }),

    awful.key({ modkey, "Shift" }, "#1", function()
        if client.focus then
            local tag = client.focus.screen.tags[1]
            if tag then
                client.focus:move_to_tag(tag)
            end
        end
    end, { description = "move focused client to tag #1", group = "tag" })
)

-- =============================
-- Client Key Bindings
-- =============================
M.clientkeys = gears.table.join(
    awful.key({ modkey }, "f", function(c)
        c.fullscreen = not c.fullscreen
        c:raise()
    end, { description = "toggle fullscreen", group = "client" }),
    awful.key({ modkey, "Shift" }, "c", function(c)
        c:kill()
    end, { description = "close client", group = "client" }),
    awful.key({ modkey }, "n", function(c)
        c.minimized = true
    end, { description = "minimize client", group = "client" }),
    awful.key({ modkey }, "m", function(c)
        c.maximized = not c.maximized
        c:raise()
    end, { description = "maximize client", group = "client" })
)

-- =============================
-- Tag Keybindings (1-9)
-- =============================
for i = 1, 9 do
    global_keys = gears.table.join(
        global_keys,
        -- View tag only.
        awful.key({ modkey }, "#" .. i + 9,
            function()
                local screen = awful.screen.focused()
                local tag = screen.tags[i]
                if tag then
                    tag:view_only()
                end
            end,
            { description = "view tag #" .. i, group = "tag" }),

        -- Toggle tag display.
        awful.key({ modkey, "Control" }, "#" .. i + 9,
            function()
                local screen = awful.screen.focused()
                local tag = screen.tags[i]
                if tag then
                    awful.tag.viewtoggle(tag)
                end
            end,
            { description = "toggle tag #" .. i, group = "tag" }),

        -- Move client to tag.
        awful.key({ modkey, "Shift" }, "#" .. i + 9,
            function()
                if client.focus then
                    local tag = client.focus.screen.tags[i]
                    if tag then
                        client.focus:move_to_tag(tag)
                    end
                end
            end,
            { description = "move focused client to tag #" .. i, group = "tag" }),

        -- Toggle tag on focused client.
        awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
            function()
                if client.focus then
                    local tag = client.focus.screen.tags[i]
                    if tag then
                        client.focus:toggle_tag(tag)
                    end
                end
            end,
            { description = "toggle focused client on tag #" .. i, group = "tag" })
    )
end

-- =============================
-- Mouse Button Bindings
-- =============================
M.clientbuttons = gears.table.join(
-- Left click to focus
    awful.button({}, 1,
        function(c)
            c:emit_signal("request::activate", "mouse_click", { raise = true })
        end),

    -- Mod + Left click to move
    awful.button({ modkey }, 1,
        function(c)
            c:emit_signal("request::activate", "mouse_click", { raise = true })
            awful.mouse.client.move(c)
        end),

    -- Mod + Right click to resize
    awful.button({ modkey }, 3,
        function(c)
            c:emit_signal("request::activate", "mouse_click", { raise = true })
            awful.mouse.client.resize(c)
        end)
)

-- Set keys
M.globalkeys = global_keys
-- root.keys(global_keys) -- Comentado o eliminado ya que se llama en M.setup
-- root.buttons(M.root_buttons) -- Comentado o eliminado ya que se llama en M.setup

-- =============================
-- Setup function
-- =============================
M.setup = function(config)
    -- Apply configuration
    terminal = config.terminal or terminal

    -- Set update functions if provided
    if config.update_volume then
        update_volume = config.update_volume
    end

    if config.update_brightness then
        update_brightness = config.update_brightness
    end

    -- Configure main menu
    if config.mymainmenu then
        mymainmenu = config.mymainmenu
        -- Make it available globally
        _G.mymainmenu = mymainmenu
    end

    -- Apply key bindings
    require("awful").root.keys(M.globalkeys)
    require("awful").root.buttons(M.root_buttons)

    return M
end

return M
