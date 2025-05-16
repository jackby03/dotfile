-- ~/.config/awesome/modules/keys.lua
-- Key bindings configuration for AwesomeWM
-- Organized by categories with comprehensive descriptions

local awful = require("awful")
local gears = require("gears")
local hotkeys_popup = require("awful.hotkeys_popup")
local menubar = require("menubar")
local client = require("awful.client")

-- Module initialization
local M = {}

-- Default configuration (will be overridden in setup())
local terminal = "alacritty"
local modkey = "Mod4"
local mymainmenu = nil

-- Ensure required modules are available
local has_awful_client_focus = pcall(function() return awful.client.focus end)
if not has_awful_client_focus then
    awful.client = awful.client or {}
    awful.client.focus = awful.client.focus or {}
    awful.client.focus.history = awful.client.focus.history or {}
    awful.client.focus.history.get = function(s, idx)
        return nil
    end
    awful.client.focus.history.previous = function() end
    awful.client.focus.byidx = function(i) end
end

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
-- == System Control Keys ==
    awful.key({ modkey, "Shift" }, "s",
        function() awful.spawn("scrot '%Y-%m-%d_%H-%M-%S_screenshot.png' -e 'mv $f ~/Images/Screenshots/'") end,
        { description = "take full screenshot and save to ~/Images/Screenshots", group = "system" }),
    awful.key({ modkey }, "Escape",
        function() awful.spawn("xsecurelock") end,
        { description = "lock screen with xsecurelock", group = "system" }),

    -- == Hardware Control Keys ==
    -- Keyboard backlight
    awful.key({}, "XF86KbdBrightnessUp",
        function() awful.spawn("brightnessctl -d smc::kbd_backlight s +10%") end,
        { description = "increase keyboard backlight by 10%", group = "hardware" }),
    awful.key({}, "XF86KbdBrightnessDown",
        function() awful.spawn("brightnessctl -d smc::kbd_backlight s 10%-") end,
        { description = "decrease keyboard backlight by 10%", group = "hardware" }),

    -- Monitor brightness
    awful.key({}, "XF86MonBrightnessUp",
        function()
            awful.spawn("brightnessctl set +5%")
            update_brightness()
        end,
        { description = "increase screen brightness by 5%", group = "hardware" }),

    awful.key({}, "XF86MonBrightnessDown",
        function()
            awful.spawn("brightnessctl set 5%-")
            update_brightness()
        end,
        { description = "decrease screen brightness by 5%", group = "hardware" }),

    -- == Audio Control Keys ==
    -- Volume controls (PipeWire)
    awful.key({}, "XF86AudioRaiseVolume",
        function()
            awful.spawn("wpctl set-volume -l 1.5 @DEFAULT_AUDIO_SINK@ 5%+")
            update_volume()
        end,
        { description = "increase volume by 5% (max 150%)", group = "audio" }),

    awful.key({}, "XF86AudioLowerVolume",
        function()
            awful.spawn("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-")
            update_volume()
        end,
        { description = "decrease volume by 5%", group = "audio" }),

    awful.key({}, "XF86AudioMute",
        function()
            awful.spawn("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle")
            update_volume()
        end,
        { description = "toggle audio mute", group = "audio" }),

    -- Media controls
    awful.key({}, "XF86AudioPlay",
        function() awful.spawn("playerctl play-pause") end,
        { description = "play/pause media", group = "audio" }),

    awful.key({}, "XF86AudioNext",
        function() awful.spawn("playerctl next") end,
        { description = "next media track", group = "audio" }),

    awful.key({}, "XF86AudioPrev",
        function() awful.spawn("playerctl previous") end,
        { description = "previous media track", group = "audio" }),

    -- == AwesomeWM Controls ==
    awful.key({ modkey }, "s",
        hotkeys_popup.show_help,
        { description = "show keybinding help", group = "awesome" }),

    awful.key({ modkey, "Control" }, "r",
        function()
            if awesome and awesome.restart then
                awesome.restart()
            else
                os.execute("awesome-client 'awesome.restart()'")
            end
        end,
        { description = "reload awesome configuration", group = "awesome" }),

    awful.key({ modkey, "Shift" }, "q",
        function()
            if awesome and awesome.quit then
                awesome.quit()
            else
                os.execute("awesome-client 'awesome.quit()'")
            end
        end,
        { description = "quit awesome session", group = "awesome" }),

    -- == Tag Navigation ==
    awful.key({ modkey }, "Left",
        function()
            -- Store the currently focused client before switching tags
            local s = awful.screen.focused()
            local current_tag = awful.tag.selected(s)
            if current_tag then
                current_tag.last_client = client.focus
            end

            -- Navigate to the previous tag
            awful.tag.viewprev()

            -- After switching, try to restore focus to a client
            local new_tag = awful.tag.selected(s)
            if new_tag and new_tag.last_client and new_tag.last_client.valid and
                new_tag.last_client:isvisible() then
                client.focus = new_tag.last_client
                new_tag.last_client:raise()
            end
        end,
        { description = "view previous tag", group = "tag" }),

    awful.key({ modkey }, "Right",
        function()
            -- Store the currently focused client before switching tags
            local s = awful.screen.focused()
            local current_tag = awful.tag.selected(s)
            if current_tag then
                current_tag.last_client = client.focus
            end

            -- Navigate to the next tag
            awful.tag.viewnext()

            -- After switching, try to restore focus to a client
            local new_tag = awful.tag.selected(s)
            if new_tag and new_tag.last_client and new_tag.last_client.valid and
                new_tag.last_client:isvisible() then
                client.focus = new_tag.last_client
                new_tag.last_client:raise()
            end
        end,
        { description = "view next tag", group = "tag" }),

    -- == Client Focus Control ==
    awful.key({ modkey, }, "j",
        function()
            awful.client.focus.byidx(1)
        end,
        { description = "focus next by index", group = "client" }
    ),
    awful.key({ modkey, }, "k",
        function()
            awful.client.focus.byidx(-1)
        end,
        { description = "focus previous by index", group = "client" }
    ),

    awful.key({ modkey }, "Tab",
        function()
            if awful.client.focus.history and awful.client.focus.history.previous then
                awful.client.focus.history.previous()
                if client.focus then
                    if client.focus.raise then
                        client.focus:raise()
                    elseif client.focus.emit_signal then
                        client.focus:emit_signal("request::activate", "key.switch", { raise = true })
                    end
                end
            end
        end,
        { description = "cycle through clients", group = "client" }),

    awful.key({ modkey }, "u",
        awful.client.urgent.jumpto,
        { description = "jump to urgent client", group = "client" }),

    -- == Layout Manipulation ==
    awful.key({ modkey, "Shift" }, "j",
        function()
            if awful.client.swap and awful.client.swap.byidx then
                awful.client.swap.byidx(1)
                if client.focus then
                    client.focus:raise()
                end
            end
        end,
        { description = "swap with next client", group = "client" }),

    awful.key({ modkey, "Shift" }, "k",
        function()
            if awful.client.swap and awful.client.swap.byidx then
                awful.client.swap.byidx(-1)
                if client.focus then
                    client.focus:raise()
                end
            end
        end,
        { description = "swap with previous client", group = "client" }),

    awful.key({ modkey, "Control" }, "j",
        function() awful.screen.focus_relative(1) end,
        { description = "focus next screen", group = "screen" }),

    awful.key({ modkey, "Control" }, "k",
        function() awful.screen.focus_relative(-1) end,
        { description = "focus previous screen", group = "screen" }),

    -- == Layout Adjustments ==
    awful.key({ modkey }, "l",
        function() awful.tag.incmwfact(0.05) end,
        { description = "increase master width by 5%", group = "layout" }),

    awful.key({ modkey }, "h",
        function() awful.tag.incmwfact(-0.05) end,
        { description = "decrease master width by 5%", group = "layout" }),

    awful.key({ modkey, "Shift" }, "h",
        function() awful.tag.incnmaster(1, nil, true) end,
        { description = "increase master clients", group = "layout" }),

    awful.key({ modkey, "Shift" }, "l",
        function() awful.tag.incnmaster(-1, nil, true) end,
        { description = "decrease master clients", group = "layout" }),

    awful.key({ modkey, "Control" }, "h",
        function() awful.tag.incncol(1, nil, true) end,
        { description = "increase columns", group = "layout" }),

    awful.key({ modkey, "Control" }, "l",
        function() awful.tag.incncol(-1, nil, true) end,
        { description = "decrease columns", group = "layout" }),

    awful.key({}, "XF86LaunchA",
        function() awful.layout.inc(1) end,
        { description = "cycle layout forward", group = "layout" }),

    -- == Window Management ==
    awful.key({ modkey, "Control" }, "n",
        function()
            local c
            -- Check if awful.client.restore is available
            if awful.client.restore then
                c = awful.client.restore()
            end

            -- Handle restored client
            if c then
                if c.emit_signal then
                    c:emit_signal("request::activate", "key.unminimize", { raise = true })
                else
                    c.minimized = false
                    if c.raise then
                        c:raise()
                    end
                end
            else
                -- Fallback: find and unminimize the first minimized client
                for _, tc in ipairs(client.get()) do
                    if tc.minimized then
                        tc.minimized = false
                        client.focus = tc
                        if tc.raise then
                            tc:raise()
                        end
                        break
                    end
                end
            end
        end,
        { description = "restore minimized window", group = "client" }),

    -- == Application Launchers ==
    awful.key({ modkey }, "Return",
        function() awful.spawn(terminal) end,
        { description = "open terminal", group = "launcher" }),

    awful.key({ modkey }, "w",
        function() if mymainmenu then mymainmenu:show() end end,
        { description = "show main menu", group = "launcher" }),

    awful.key({}, "XF86LaunchB",
        function() awful.util.spawn("rofi -show drun") end,
        { description = "open application launcher (rofi)", group = "launcher" }),

    awful.key({ modkey }, "p",
        function() menubar.show() end,
        { description = "show menubar", group = "launcher" }),

    -- == Application Shortcuts ==
    awful.key({ modkey }, "b",
        function() awful.util.spawn("firefox") end,
        { description = "launch firefox browser", group = "applications" })
)

-- =============================
-- Client Key Bindings
-- =============================
M.clientkeys = gears.table.join(
    awful.key({ modkey }, "f",
        function(c)
            c.fullscreen = not c.fullscreen
            if c.emit_signal then
                c:emit_signal("request::activate", "key.unminimize", { raise = true })
            else
                c.minimized = false
            end
        end,
        { description = "toggle fullscreen", group = "client" }),

    awful.key({ modkey, "Shift" }, "c",
        function(c) c:kill() end,
        { description = "close window", group = "client" }),

    awful.key({ modkey }, "space",
        awful.client.floating.toggle,
        { description = "toggle floating mode", group = "client" }),

    awful.key({ modkey, "Control" }, "Return",
        function(c) c:swap(awful.client.getmaster()) end,
        { description = "move to master position", group = "client" }),

    awful.key({ modkey }, "o",
        function(c) c:move_to_screen() end,
        { description = "move to next screen", group = "client" }),

    awful.key({ modkey }, "t",
        function(c) c.ontop = not c.ontop end,
        { description = "toggle keep on top", group = "client" }),

    awful.key({ modkey }, "n",
        function(c) c.minimized = true end,
        { description = "minimize window", group = "client" }),

    awful.key({ modkey }, "m",
        function(c)
            c.maximized = not c.maximized
            if c.emit_signal then
                c:emit_signal("request::activate", "key.unminimize", { raise = true })
            else
                c.minimized = false
            end
        end,
        { description = "toggle maximize", group = "client" }),

    awful.key({ modkey, "Control" }, "m",
        function(c)
            c.maximized_vertical = not c.maximized_vertical
            if c.emit_signal then
                c:emit_signal("request::activate", "key.unminimize", { raise = true })
            else
                c.minimized = false
            end
        end,
        { description = "toggle vertical maximize", group = "client" }),

    awful.key({ modkey, "Shift" }, "m",
        function(c)
            c.maximized_horizontal = not c.maximized_horizontal
            if c.emit_signal then
                c:emit_signal("request::activate", "key.unminimize", { raise = true })
            else
                c.minimized = false
            end
        end,
        { description = "toggle horizontal maximize", group = "client" })
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
    root.keys(M.globalkeys)
    root.buttons(M.root_buttons)

    return M
end

return M
