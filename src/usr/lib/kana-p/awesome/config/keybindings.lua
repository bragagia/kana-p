globalkeys = awful.util.table.join(
    -- Awesome
    awful.key({ modkey,           }, "s",      hotkeys_popup.show_help,
              {description = "show help", group = "awesome"}),
    awful.key({ modkey, "Control" }, "r", awesome.restart,
              {description = "reload awesome", group = "awesome"}),
    awful.key({ modkey, "Control" }, "q", awesome.quit,
              {description = "quit awesome", group = "awesome"}),
    awful.key({ modkey            }, "q", function () os.execute(lock_cmd) end,
              {description = "lock screen", group = "awesome"}),
    awful.key({ modkey            }, "d", togglewibox,
              {description = "toggle top bar", group = "awesome"}),

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
    awful.key({ modkey,           }, "h",          function () awful.tag.incmwfact( 0.05)          end,
              {description = "increase master width factor", group = "layout"}),
    awful.key({ modkey,           }, "l",          function () awful.tag.incmwfact(-0.05)          end,
              {description = "decrease master width factor", group = "layout"}),
    awful.key({ modkey, "Shift"   }, "h",          function () awful.tag.incnmaster( 1, nil, true) end,
              {description = "increase the number of master clients", group = "layout"}),
    awful.key({ modkey, "Shift"   }, "l",          function () awful.tag.incnmaster(-1, nil, true) end,
              {description = "decrease the number of master clients", group = "layout"}),
    awful.key({ modkey, "Control" }, "h",          function () awful.tag.incncol( 1, nil, true)    end,
              {description = "increase the number of columns", group = "layout"}),
    awful.key({ modkey, "Control" }, "l",          function () awful.tag.incncol(-1, nil, true)    end,
              {description = "decrease the number of columns", group = "layout"}),
    awful.key({ modkey,           }, "space",      function () awful.layout.inc( 1)                end,
              {description = "select next", group = "layout"}),
    awful.key({ modkey, "Shift"   }, "space",      function () awful.layout.inc(-1)                end,
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
    awful.key({ modkey, "Control", "Shift" }, "h", function (c) awful.client.incwfact( 0.05, c)    end,
              {description = "increase client width factor", group = "client"}),
    awful.key({ modkey, "Control", "Shift" }, "l", function (c) awful.client.incwfact(-0.05, c)    end,
              {description = "decrease client width factor", group = "client"}),
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
