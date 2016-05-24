-- {{{ Key bindings
globalkeys = awful.util.table.join(

-- Awesome manipulation
awful.key({ modkey, "Shift"   }, "r", awesome.restart),
awful.key({ modkey, "Shift"   }, "q", function () os.execute(close_session) end),
awful.key({ modkey            }, "F1", function () mywibox[mouse.screen].visible = false end),
awful.key({ modkey            }, "F2", function () mywibox[mouse.screen].visible = true end),
awful.key({ modkey            }, "d",
function ()
	if mywibox[mouse.screen].visible then
		mywibox[mouse.screen].visible = false
	else
		mywibox[mouse.screen].visible = true
	end
end),
awful.key({ modkey            }, "k", awesome.quit),

-- Tag manipulation
awful.key({ modkey  		  }, "Left", awful.tag.viewprev),
awful.key({ modkey  		  }, "Right", awful.tag.viewnext),
awful.key({ modkey            }, "u", awful.client.urgent.jumpto),

-- Standard programs
awful.key({ modkey            }, "Return", function () awful.util.spawn(terminal) end),
awful.key({ modkey            }, "e", function () awful.util.spawn(explorer_cmd) end),
awful.key({ modkey            }, "l", function () os.execute(lock_cmd) end),
awful.key({ modkey, "Shift"   }, "r", function () awful.util.spawn('gksudo ' .. launcher) end),
awful.key({ modkey            }, "r", function () awful.util.spawn(launcher) end),

-- Music
awful.key({ modkey            }, "i", function () os.execute("mpc prev") end),
awful.key({ modkey            }, "o", function () os.execute("mpc next") end),
awful.key({ modkey            }, "p", function () os.execute("mpc toggle") end),

-- Special keys
awful.key({                   }, "XF86MonBrightnessUp", function () os.execute("light -A 5") end),
awful.key({                   }, "XF86MonBrightnessDown", function () os.execute("light -U 5") end),
awful.key({                   }, "XF86AudioLowerVolume", function ()
	os.execute("pulseaudio-ctl down 3")
	volumewidget.update()
end),
awful.key({                   }, "XF86AudioRaiseVolume", function ()
	os.execute("pulseaudio-ctl up 3")
	volumewidget.update()
end),
awful.key({                   }, "XF86AudioMute", function ()
	os.execute("pulseaudio-ctl mute")
	volumewidget.update()
end),
awful.key({                   }, "XF86Sleep", function () os.execute("systemctl suspend") end),
awful.key({                   }, "XF86Display", function () os.execute("kana-p-screen") end),
awful.key({                   }, "Print", function () os.execute("scrot -e 'mv $f ~/Images/shots/'") end),

-- Layout
awful.key({ modkey            }, "q",     function () awful.tag.incmwfact( 0.05)    end),
awful.key({ modkey            }, "w",     function () awful.tag.incmwfact(-0.05)    end),
awful.key({ modkey            }, "s",     function () awful.tag.incnmaster( 1)      end),
awful.key({ modkey            }, "x",     function () awful.tag.incnmaster(-1)      end),
awful.key({ modkey            }, "f",     function () awful.tag.incncol( 1)         end),
awful.key({ modkey            }, "v",     function () awful.tag.incncol(-1)         end),
awful.key({ modkey            }, "space", function () awful.layout.inc(layouts,  1) end),
awful.key({ modkey, "Shift"   }, "space", function () awful.layout.inc(layouts, -1) end),

-- Client
awful.key({ modkey, "Control" }, "n", awful.client.restore),
awful.key({ modkey, "Shift"   }, "Left", function () awful.client.swap.byidx(  1)	end),
awful.key({ modkey, "Shift"   }, "Right", function () awful.client.swap.byidx( -1)	end)
)

clientkeys = awful.util.table.join(
awful.key({ modkey            }, "a",	  function (c) c.fullscreen = not c.fullscreen  end),
awful.key({ modkey            }, "c",	  function (c) c:kill()						 end),
awful.key({ modkey            }, "f",	  awful.client.floating.toggle					 ),
awful.key({ modkey, "Control" }, "Return", function (c) c:swap(awful.client.getmaster()) end),

awful.key({ modkey            }, "n", function (c) c.minimized = true end),

awful.key({ modkey            }, "m",
function (c)
	c.maximized_horizontal = not c.maximized_horizontal
	c.maximized_vertical   = c.maximized_horizontal
end),

awful.key({ modkey, "Control" }, "Down",
function()
	awful.client.focus.bydirection("down")
	if client.focus then client.focus:raise() end
end),

awful.key({ modkey, "Control" }, "Up",
function()
	awful.client.focus.bydirection("up")
	if client.focus then client.focus:raise() end
end),

awful.key({ modkey, "Control" }, "Left",
function()
	awful.client.focus.bydirection("left")
	if client.focus then client.focus:raise() end
end),

awful.key({ modkey, "Control" }, "Right",
function()
	awful.client.focus.bydirection("right")
	if client.focus then client.focus:raise() end
end)
)
