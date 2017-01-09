-- Standard awesome library
local gears = require("gears")
local awful = require("awful")
              require("awful.autofocus")
-- Widget and layout library
local wibox = require("wibox")
-- Theme handling library
local beautiful = require("beautiful")
-- Notification library
local naughty = require("naughty")
local menubar = require("menubar")
local hotkeys_popup = require("awful.hotkeys_popup").widget
local lain      = require("lain")

-- Handle runtime errors after startup
do
    local in_error = false
    awesome.connect_signal("debug::error", function (err)
        -- Make sure we don't go into an endless error loop
        if in_error then return end
        in_error = true

        naughty.notify({ preset = naughty.config.presets.critical,
                         title = "Oops, an error happened!",
                         text = tostring(err) })
        in_error = false
    end)
end
-- }}}

local function file_exists(name)
  local f = io.open(name, "r")
  if f ~= nil then io.close(f) return true else return false end
end

local function doconf(name)
  local xdg_config_home = os.getenv("XDG_CONFIG_HOME")
  local cut = string.find(xdg_config_home, ":")
  local final_name

  if cut == nil then
    final_name = xdg_config_home
  else
    final_name = string.sub(xdg_config_home, 0, cut)
  end
  final_name = final_name .. "/kana-p/" .. name

  if file_exists(final_name) then
    dofile(final_name)
  else
    dofile("/usr/share/kana-p/config/" .. name)
  end
end

-- {{{ Variable definitions
-- Themes define colours, icons, font and wallpapers.
beautiful.init("/usr/share/kana-p/awesome/theme.lua")

-- This is used later as the default terminal and editor to run.
terminal = "kana-p-term"
explorer_cmd = "xdg-open " .. os.getenv("HOME")
lock_cmd = 'kana-p-lock'
launcher = 'kana-p-launcher'
close_session = 'kana-p-close-session'

-- Default modkey.
-- Usually, Mod4 is the key with a logo between Control and Alt.
-- If you do not like this or do not have such a key,
-- I suggest you to remap Mod4 to another key using xmodmap or other tools.
-- However, you can use another modifier like Mod1, but it may interact with others.
modkey = "Mod4"

-- Table of layouts to cover with awful.layout.inc, order matters.
awful.layout.layouts = {
  lain.layout.uselesstile,
  lain.layout.uselesstile.bottom,
  lain.layout.centerworkd,
  lain.layout.termfair,
  awful.layout.suit.floating
}
-- }}}

-- {{{ Helper functions
local function client_menu_toggle_fn()
    local instance = nil

    return function ()
        if instance and instance.wibox.visible then
            instance:hide()
            instance = nil
        else
            instance = awful.menu.clients({ theme = { width = 250 } })
        end
    end
end
-- }}}

-- {{{ Menu
-- Create a launcher widget and a main menu
function TableConcat(t1,t2)
    for i=1,#t2 do
        t1[#t1+1] = t2[i]
    end
    return t1
end

local kanapmenu = {
  { "lock", lock_cmd },
  { "close session", close_session },
  { "halt", "systemctl poweroff" },
  { "reboot", "systemctl reboot" }
}

local markup    = lain.util.markup

--mymainmenu = awful.menu({ items = TableConcat(xdgmenu, kanapmenu) })
mymainmenu = awful.menu({ items = kanapmenu })

mylauncher = wibox.widget.textbox("")
mylauncher:set_markup(markup(beautiful.info_spacer, " v "))
mylauncher:buttons(awful.util.table.join( awful.button({ }, 1, function () mymainmenu:toggle() end )))

-- Menubar configuration
menubar.utils.terminal = terminal -- Set the terminal for applications that require it
-- }}}

-- Keyboard map indicator and switcher
mykeyboardlayout = awful.widget.keyboardlayout()

-- {{{ Wibar

-- Spacers
local spacer = wibox.widget.textbox(" ")

widget_spacer = wibox.widget.textbox("%")
widget_spacer:set_markup(markup(beautiful.info_spacer, " | "))

-- Clock
mytextclock = awful.widget.textclock(markup(beautiful.info_value, "%d %B ") .. markup(beautiful.info_spacer, ">") .. markup(beautiful.info_value, " %H:%M "))

-- Battery
batwidget = lain.widgets.bat({
    timeout = 1,
    settings = function()
        local status
        if bat_now.status == "Discharging" then
            status = "d"
        else
            status = "u"
        end

        local value
        if bat_now.perc == "N/A" then
            value = "AC"
            status = "u"
        else
            value = bat_now.perc
        end

        widget:set_markup(markup(beautiful.info_battery, "b ") .. markup(beautiful.info_value, value .. status))
    end
})

-- CPU
cpuwidget = lain.widgets.cpu({
    settings = function()
        widget:set_markup(markup(beautiful.info_cpu, "c ") .. markup(beautiful.info_value, cpu_now.usage))
    end
})

-- MEM
memwidget = lain.widgets.mem({
    settings = function()
      widget:set_markup(markup(beautiful.info_mem, "r ") .. markup(beautiful.info_value, mem_now.used))
    end
})

-- Net usage
netdownwidget = wibox.widget.textbox()

netupwidget = lain.widgets.net({
    notify = "off",
    settings = function()
        widget:set_markup(markup(beautiful.info_upload, "u ") .. markup(beautiful.info_value, string.format("%.2f", net_now.sent / 1024)))
        netdownwidget:set_markup(markup(beautiful.info_download, "d ") .. markup(beautiful.info_value, string.format("%.2f", net_now.received / 1024)))
    end
})

--- Wifi
wifiwidget = wibox.widget.textbox("?%")
function wifiInfo()
    local wifiStrength = awful.util.pread("awk 'NR==3 {printf \"%.0f\\n\",($3/70)*100}' /proc/net/wireless")
    local title = markup(beautiful.info_wifi, "w ")
    if wifiStrength == "" then
        wifiwidget:set_markup(title .. markup(beautiful.info_value, "x"))
    else
        wifiwidget:set_markup(title .. markup(beautiful.info_value, wifiStrength))
    end
end

wifiInfo()
wifi_timer = timer({timeout = 1})
wifi_timer:connect_signal("timeout", wifiInfo)
wifi_timer:start()

-- Volume
volumewidget = lain.widgets.alsa({
    settings = function()
        if volume_now.status == "off" then
            widget:set_markup(markup(beautiful.info_volume, "v ") .. markup(beautiful.info_value, "M"))
        else
            widget:set_markup(markup(beautiful.info_volume, "v ") .. markup(beautiful.info_value, volume_now.level))
        end
    end
})

vol_timer = timer({timeout = 1})
vol_timer:connect_signal("timeout", volumewidget.update)
vol_timer:start()

-- Global systray
globalsystray = wibox.widget.systray()

-- Create a wibox for each screen and add it
local taglist_buttons = awful.util.table.join(
                    awful.button({ }, 1, function(t) t:view_only() end),
                    awful.button({ modkey }, 1, function(t)
                                              if client.focus then
                                                  client.focus:move_to_tag(t)
                                              end
                                          end),
                    awful.button({ }, 3, awful.tag.viewtoggle),
                    awful.button({ modkey }, 3, function(t)
                                              if client.focus then
                                                  client.focus:toggle_tag(t)
                                              end
                                          end),
                    awful.button({ }, 4, function(t) awful.tag.viewnext(t.screen) end),
                    awful.button({ }, 5, function(t) awful.tag.viewprev(t.screen) end)
                )

local function set_wallpaper(s)
    -- Wallpaper
    if beautiful.wallpaper then
        local wallpaper = beautiful.wallpaper
        -- If wallpaper is a function, call it with the screen
        if type(wallpaper) == "function" then
            wallpaper = wallpaper(s)
        end
        gears.wallpaper.maximized(wallpaper, s, true)
    end
end

-- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
screen.connect_signal("property::geometry", set_wallpaper)

awful.screen.connect_for_each_screen(function(s)
    -- Wallpaper
    set_wallpaper(s)

    -- Each screen has its own tag table.
    awful.tag({ "1", "2", "3", "4", "5", "6", "7", "8", "9" }, s, awful.layout.layouts[1])

    -- Create an imagebox widget which will contains an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    s.mylayoutbox = awful.widget.layoutbox(s)
    s.mylayoutbox:buttons(awful.util.table.join(
                           awful.button({ }, 1, function () awful.layout.inc( 1) end),
                           awful.button({ }, 3, function () awful.layout.inc(-1) end),
                           awful.button({ }, 4, function () awful.layout.inc( 1) end),
                           awful.button({ }, 5, function () awful.layout.inc(-1) end)))
    -- Create a taglist widget
    s.mytaglist = awful.widget.taglist(s, awful.widget.taglist.filter.all, taglist_buttons)

    -- Create the systray
    s.systray = {}
    s.systray.stupid_bug = drawin({})
    s.systray.container = wibox.layout.constraint()
    s.systray.widget = wibox.widget.textbox("")
    
    s.systray.show = function ()
        for d in screen do
            if d ~= s then
                d.mysystray.hide()
            end
        end
        s.systray.container:set_strategy("min")
        s.systray.container:set_widget(globalsystray)
        s.systray.visible = true
        s.systray.widget:set_markup(markup(beautiful.info_spacer, " > "))
    end
    
    s.systray.hide = function ()
        awesome.systray(s.systray.stupid_bug, 0, 0, 10, true, "#000000")
        s.systray.container:set_widget(nil)
        s.systray.container:set_strategy("exact")
        s.systray.visible = false
        s.systray.widget:set_markup(markup(beautiful.info_spacer, " &lt; "))
    end
    
    s.systray.hide()
    
    s.systray.widget:buttons(awful.util.table.join(
    awful.button({ }, 1, function ()
        if s.systray.visible == true then
            s.systray.hide()
        else
            s.systray.show()
        end
    end)
    ))

    -- Create the wibox
    s.mywibox = awful.wibar({ position = "top", screen = s })

    -- Add widgets to the wibox
    s.mywibox:setup {
        layout = wibox.layout.align.horizontal,
        { -- Left widgets
            layout = wibox.layout.fixed.horizontal,
            spacer,
            spacer,
            mylauncher,
            s.mytaglist,
        },
        {
            layout  = wibox.layout.flex.horizontal,
        },
        { -- Right widgets
            layout = wibox.layout.fixed.horizontal,
            mykeyboardlayout,
            s.systray.container,
            s.systray.widget,
            volumewidget,
            widget_spacer,
            wifiwidget,
            widget_spacer,
            netupwidget,
            widget_spacer,
            netdownwidget,
            widget_spacer,
            cpuwidget,
            widget_spacer,
            memwidget,
            widget_spacer,
            batwidget,
            widget_spacer,
            mytextclock,
            s.mylayoutbox,
        },
    }
end)
-- }}}

-- {{{ Mouse bindings
root.buttons(awful.util.table.join(
    awful.button({ }, 3, function () mymainmenu:toggle() end),
    awful.button({ }, 4, awful.tag.viewnext),
    awful.button({ }, 5, awful.tag.viewprev)
))
-- }}}

-- {{{ Key bindings
globalkeys = awful.util.table.join(
    -- Awesome
    awful.key({ modkey,           }, "s",      hotkeys_popup.show_help,
              {description = "show help", group = "awesome"}),
    awful.key({ modkey, "Control" }, "r", awesome.restart,
              {description = "reload awesome", group = "awesome"}),
    awful.key({ modkey, "Control" }, "q", awesome.quit,
              {description = "quit awesome", group = "awesome"}),
    awful.key({ modkey            }, "l", function () os.execute(lock_cmd) end,
              {description = "lock screen", group = "awesome"}),

    -- Tag
    awful.key({ modkey,           }, "Left",   awful.tag.viewprev,
              {description = "view previous", group = "tag"}),
    awful.key({ modkey,           }, "Right",  awful.tag.viewnext,
              {description = "view next", group = "tag"}),
    awful.key({ modkey,           }, "Escape", awful.tag.history.restore,
              {description = "go back", group = "tag"}),

    -- Client
    awful.key({ modkey,           }, "j", function () awful.client.focus.byidx( 1)    end,
              {description = "focus next by index", group = "client"}),
    awful.key({ modkey,           }, "k", function () awful.client.focus.byidx(-1)    end,
              {description = "focus previous by index", group = "client"}),
    awful.key({ modkey, "Shift"   }, "j", function () awful.client.swap.byidx(  1)    end,
              {description = "swap with next client by index", group = "client"}),
    awful.key({ modkey, "Shift"   }, "k", function () awful.client.swap.byidx( -1)    end,
              {description = "swap with previous client by index", group = "client"}),
    awful.key({ modkey,           }, "u", awful.client.urgent.jumpto,
              {description = "jump to urgent client", group = "client"}),
    awful.key({ modkey,           }, "Tab",
        function ()
            awful.client.focus.history.previous()
            if client.focus then
                client.focus:raise()
            end
        end,
        {description = "go back", group = "client"}), 
    awful.key({ modkey, "Control" }, "n",
              function ()
                  local c = awful.client.restore()
                  -- Focus restored client
                  if c then
                      client.focus = c
                      c:raise()
                  end
              end,
              {description = "restore minimized", group = "client"}),

    -- Screen
    awful.key({ modkey, "Control" }, "j", function () awful.screen.focus_relative( 1) end,
              {description = "focus the next screen", group = "screen"}),
    awful.key({ modkey, "Control" }, "k", function () awful.screen.focus_relative(-1) end,
              {description = "focus the previous screen", group = "screen"}),

    -- Layout manipulation
    awful.key({ modkey,           }, "l",     function () awful.tag.incmwfact( 0.05)          end,
              {description = "increase master width factor", group = "layout"}),
    awful.key({ modkey,           }, "h",     function () awful.tag.incmwfact(-0.05)          end,
              {description = "decrease master width factor", group = "layout"}),
    awful.key({ modkey, "Shift"   }, "h",     function () awful.tag.incnmaster( 1, nil, true) end,
              {description = "increase the number of master clients", group = "layout"}),
    awful.key({ modkey, "Shift"   }, "l",     function () awful.tag.incnmaster(-1, nil, true) end,
              {description = "decrease the number of master clients", group = "layout"}),
    awful.key({ modkey, "Control" }, "h",     function () awful.tag.incncol( 1, nil, true)    end,
              {description = "increase the number of columns", group = "layout"}),
    awful.key({ modkey, "Control" }, "l",     function () awful.tag.incncol(-1, nil, true)    end,
              {description = "decrease the number of columns", group = "layout"}),
    awful.key({ modkey,           }, "space", function () awful.layout.inc( 1)                end,
              {description = "select next", group = "layout"}),
    awful.key({ modkey, "Shift"   }, "space", function () awful.layout.inc(-1)                end,
              {description = "select previous", group = "layout"}),

    -- Special keys
    awful.key({                   }, "XF86MonBrightnessUp", function () os.execute("light -A 5") end),
    awful.key({                   }, "XF86MonBrightnessDown", function () os.execute("light -U 5") end),
    awful.key({                   }, "XF86Sleep", function () os.execute("systemctl suspend") end),
    awful.key({                   }, "XF86Display", function () os.execute("kana-p-screen") end),
    awful.key({                   }, "Print", function () os.execute("scrot -e 'mv $f ~/Images/shots/'") end),

    -- Standard program
    awful.key({ modkey,           }, "Return", function () awful.spawn(terminal)     end,
              {description = "open a terminal", group = "launcher"}),
    awful.key({ modkey            }, "e", function () awful.util.spawn(explorer_cmd) end,
              {description = "open file explorer", group = "launcher"}),
    awful.key({ modkey },            "r",     function () awful.spawn(launcher) end,
              {description = "open app launcher", group = "launcher"}),
    awful.key({ modkey, "Shift" }, "r", function () awful.util.spawn('gksudo ' .. launcher) end,
              {description = "open root app launcher", group = "launcher"}),

    -- Menubar
    awful.key({ modkey }, "p", function() menubar.show() end,
              {description = "show the menubar", group = "launcher"})
)

clientkeys = awful.util.table.join(
    awful.key({ modkey,           }, "f",
        function (c)
            c.fullscreen = not c.fullscreen
            c:raise()
        end,
        {description = "toggle fullscreen", group = "client"}),
    awful.key({ modkey            }, "c",      function (c) c:kill()                         end,
              {description = "close", group = "client"}),
    awful.key({ modkey, "Control" }, "space",  awful.client.floating.toggle                     ,
              {description = "toggle floating", group = "client"}),
    awful.key({ modkey, "Control" }, "Return", function (c) c:swap(awful.client.getmaster()) end,
              {description = "move to master", group = "client"}),
    awful.key({ modkey,           }, "o",      function (c) c:move_to_screen()               end,
              {description = "move to screen", group = "client"}),
    awful.key({ modkey,           }, "t",      function (c) c.ontop = not c.ontop            end,
              {description = "toggle keep on top", group = "client"}),
    awful.key({ modkey,           }, "n",
        function (c)
            -- The client currently has the input focus, so it cannot be
            -- minimized, since minimized clients can't have the focus.
            c.minimized = true
        end ,
        {description = "minimize", group = "client"}),
    awful.key({ modkey,           }, "m",
        function (c)
            c.maximized = not c.maximized
            c:raise()
        end ,
        {description = "maximize", group = "client"})
)

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it work on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 9 do
    globalkeys = awful.util.table.join(globalkeys,
        -- View tag only.
        awful.key({ modkey }, "#" .. i + 9,
                  function ()
                        local screen = awful.screen.focused()
                        local tag = screen.tags[i]
                        if tag then
                           tag:view_only()
                        end
                  end,
                  {description = "view tag #"..i, group = "tag"}),
        -- Toggle tag display.
        awful.key({ modkey, "Control" }, "#" .. i + 9,
                  function ()
                      local screen = awful.screen.focused()
                      local tag = screen.tags[i]
                      if tag then
                         awful.tag.viewtoggle(tag)
                      end
                  end,
                  {description = "toggle tag #" .. i, group = "tag"}),
        -- Move client to tag.
        awful.key({ modkey, "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus then
                          local tag = client.focus.screen.tags[i]
                          if tag then
                              client.focus:move_to_tag(tag)
                          end
                     end
                  end,
                  {description = "move focused client to tag #"..i, group = "tag"}),
        -- Toggle tag on focused client.
        awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus then
                          local tag = client.focus.screen.tags[i]
                          if tag then
                              client.focus:toggle_tag(tag)
                          end
                      end
                  end,
                  {description = "toggle focused client on tag #" .. i, group = "tag"})
    )
end

clientbuttons = awful.util.table.join(
    awful.button({ }, 1, function (c) client.focus = c; c:raise() end),
    awful.button({ modkey }, 1, awful.mouse.client.move),
    awful.button({ modkey }, 3, awful.mouse.client.resize))

-- Set keys
root.keys(globalkeys)
-- }}}

-- {{{ Rules
-- Rules to apply to new clients (through the "manage" signal).
awful.rules.rules = {
    -- All clients will match this rule.
    {
        rule = { },
        properties = {
            border_width = beautiful.border_width,
            border_color = beautiful.border_normal,
            focus = awful.client.focus.filter,
            raise = true,
            keys = clientkeys,
            buttons = clientbuttons,
            screen = awful.screen.preferred,
            placement = awful.placement.no_overlap+awful.placement.no_offscreen
        }
    },

    -- Floating clients.
    {
        rule_any = {
            instance = {
                "DTA",  -- Firefox addon DownThemAll.
                "copyq",  -- Includes session name in class.
            },
            class = {
                "Arandr",
                "Gpick",
                "Kruler",
                "MessageWin",  -- kalarm.
                "Sxiv",
                "Wpa_gui",
                "pinentry",
                "veromix",
                "xtightvncviewer"
            },
            name = {
                "Event Tester",  -- xev.
            },
            role = {
                "AlarmWindow",  -- Thunderbird's calendar.
            }
        },
        properties = {
            floating = true
        }
    },

    -- Add titlebars to normal clients and dialogs
    {
        rule_any = {
            type = {
                "normal",
                "dialog"
            }
        },
        properties = {
            titlebars_enabled = true
        }
    },

    {
        rule_any = {
            class = {
                "Vlc"
            },
            name = {
                "Netflix"
            }
        },
        properties = {
            sticky = true,
            titlebars_enabled = false
        }
    },
    {
        rule_any = {
            class = {
                "URxvt",
                "XTerm"
            }
        },
        properties = {
            size_hints_honor = false
        }
    },
    {
        rule = {
            instance = "plugin-container"
        },
        properties = {
            floating = true,
            maximized_vertical = true,
            maximized_horizontal = true,
            focus = yes,
            titlebars_enabled = false
        }
    }

    -- Set Firefox to always map on the tag named "2" on screen 1.
    -- { rule = { class = "Firefox" },
    --   properties = { screen = 1, tag = "2" } },
}
-- }}}

-- {{{ Signals
-- Signal function to execute when a new client appears.
client.connect_signal("manage", function (c)
    -- Set the windows at the slave,
    -- i.e. put it at the end of others instead of setting it master.
    -- if not awesome.startup then awful.client.setslave(c) end

    if awesome.startup and
      not c.size_hints.user_position
      and not c.size_hints.program_position then
        -- Prevent clients from being unreachable after screen count changes.
        awful.placement.no_offscreen(c)
    end
end)

-- Add a titlebar if titlebars_enabled is set to true in the rules.
client.connect_signal("request::titlebars", function(c)
    -- buttons for the titlebar
    local buttons = awful.util.table.join(
        awful.button({ }, 1, function()
            client.focus = c
            c:raise()
            awful.mouse.client.move(c)
        end),
        awful.button({ }, 3, function()
            client.focus = c
            c:raise()
            awful.mouse.client.resize(c)
        end)
    )

    local spacer = wibox.widget.textbox(" ")

    awful.titlebar(c, {size = "18"}) : setup {
        { -- Left
            spacer,
            wibox.container.margin(awful.titlebar.widget.iconwidget(c), 2, 3, 3, 2),
            spacer,
            buttons = buttons,
            layout  = wibox.layout.fixed.horizontal
        },
        { -- Middle
            { -- Title
                align  = "left",
                widget = awful.titlebar.widget.titlewidget(c)
            },
            buttons = buttons,
            layout  = wibox.layout.flex.horizontal
        },
        { -- Right
            --awful.titlebar.widget.floatingbutton (c),
            --awful.titlebar.widget.maximizedbutton(c),
            --awful.titlebar.widget.stickybutton   (c),
            --awful.titlebar.widget.ontopbutton    (c),
            awful.titlebar.widget.closebutton    (c),
            layout = wibox.layout.fixed.horizontal()
        },
        layout = wibox.layout.align.horizontal
    }
end)

-- Enable sloppy focus, so that focus follows mouse.
--client.connect_signal("mouse::enter", function(c)
--    if awful.layout.get(c.screen) ~= awful.layout.suit.magnifier
--        and awful.client.focus.filter(c) then
--        client.focus = c
--    end
--end)

client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)
-- }}}
