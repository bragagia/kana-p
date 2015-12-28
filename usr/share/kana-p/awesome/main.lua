local naughty		= require("naughty")
local gears			= require("gears")
local awful			= require("awful")
      awful.rules	= require("awful.rules")
			  		  require("awful.autofocus")
local wibox			= require("wibox")
local beautiful		= require("beautiful")
local lain			= require("lain")

-- Handle runtime errors after startup
do
	local in_error = false
	awesome.connect_signal("debug::error", function (err)
		-- Make sure we don't go into an endless error loop
		if in_error then return end
		in_error = true
		naughty.notify({ preset = naughty.config.presets.critical,
		title = "Oops, an error happened!",
		text = err })
		in_error = false
	end)
end
-- }}}

-- {{{ Variable definitions
-- Themes define colours, icons, font and wallpapers.
beautiful.init("/usr/share/kana-p/awesome/theme.lua")

naughty.config.fg               = beautiful.notif_fg
naughty.config.bg               = beautiful.notif_bg
naughty.config.border_width     = beautiful.notif_border_width
naughty.config.position         = "bottom_right"

-- This is used later as the default terminal.
terminal = "urxvt"
explorer_cmd = "xdg-open " .. os.getenv("HOME")
lock_cmd = "light-locker-command -l"

-- Default modkey.
-- Usually, Mod4 is the key with a logo between Control and Alt.
-- If you do not like this or do not have such a key,
-- I suggest you to remap Mod4 to another key using xmodmap or other tools.
-- However, you can use another modifier like Mod1, but it may interact with others.
modkey = "Mod4"

-- Table of layouts to cover with awful.layout.inc, order matters.
local layouts =
{
	awful.layout.suit.floating,
	lain.layout.uselesstile,
	lain.layout.centerfair
}

lain.layout.centerfair.nmaster = 3
lain.layout.centerfair.ncol = 1

lain.layout.termfair.nmaster = 3
lain.layout.termfair.ncol = 1
-- }}}


-- {{{ Tags
-- Define a tag table which hold all screen tags.
tags = {}
for s = 1, screen.count() do
	-- Each screen has its own tag table.
	tags[s] = awful.tag({ 1, 2, 3, 4, 5, 6, 7, 8}, s, layouts[2])
	tags[s][1].name = 'web'
	tags[s][2].name = 'irc'
	tags[s][3].name = 'skype'
	tags[s][4].name = 'dev I'
	tags[s][5].name = 'dev II'
	tags[s][6].name = 'dev III'
	tags[s][7].name = 'torrent'
	tags[s][8].name = 'music'
end
-- }}}

-- battery warning
local function trim(s)
	return s:find'^%s*$' and '' or s:match'^%s*(.*%S)'
end

local function bat_notification()
	local f_capacity = assert(io.open("/sys/class/power_supply/BAT0/capacity", "r"))
	local f_status = assert(io.open("/sys/class/power_supply/BAT0/status", "r"))
	local bat_capacity = tonumber(f_capacity:read("*all"))
	local bat_status = trim(f_status:read("*all"))

	if (bat_capacity <= 15 and bat_status == "Discharging") then
		naughty.notify({ title      = "Battery Warning"
		, text       = "Battery low ! " .. bat_capacity .."%" .. " left !"
		, fg="#ffffff"
		, bg="#C91C1C"
		, timeout    = 15
	})
end
end

battimer = timer({timeout = 60})
battimer:connect_signal("timeout", bat_notification)
battimer:start()
-- end here for battery warning

local markup	  = lain.util.markup

-- Spacer
widget_spacer = wibox.widget.textbox("?%")
widget_spacer:set_markup(markup(beautiful.info_spacer, " | "))

--- Clock
clockicon = wibox.widget.imagebox(beautiful.widget_clock)
mytextclock = awful.widget.textclock(markup(beautiful.info_value, "%d %B ") .. markup(beautiful.info_spacer, ">") .. markup(beautiful.info_value, " %H:%M "))

--- Wifi
wifi_signal_widget = wibox.widget.textbox("?%")
function wifiInfo()
	local wifiStrength = awful.util.pread("awk 'NR==3 {printf \"%.0f\\n\",($3/70)*100}' /proc/net/wireless")
	local title = markup(beautiful.info_wifi, "w ")
	if wifiStrength == "" then
		wifi_signal_widget:set_markup(title .. markup(beautiful.info_value, "x"))
	else
		wifi_signal_widget:set_markup(title .. markup(beautiful.info_value, wifiStrength))
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

-- CPU
cpuwidget = lain.widgets.cpu({
	settings = function()
		widget:set_markup(markup(beautiful.info_cpu, "c ") .. markup(beautiful.info_value, cpu_now.usage))
	end
})

-- Coretemp
tempicon = wibox.widget.imagebox(beautiful.widget_temp)
tempwidget = lain.widgets.temp({
	settings = function()
		widget:set_markup(markup("#f1af5f", coretemp_now))
	end
})

-- Net usage
netdowninfo = wibox.widget.textbox()

netupinfo = lain.widgets.net({
	settings = function()
		widget:set_markup(markup(beautiful.info_upload, "u ") .. markup(beautiful.info_value, net_now.sent))
		netdowninfo:set_markup(markup(beautiful.info_download, "d ") .. markup(beautiful.info_value, net_now.received))
	end
})

-- Battery
batwidget = lain.widgets.bat({
	settings = function()
		if bat_now.perc == "N/A" then
			bat_now.perc = "AC"
		else
			bat_now.perc = bat_now.perc
		end
		widget:set_markup(markup(beautiful.info_battery, "b ") .. markup(beautiful.info_value, bat_now.perc))
	end
})

-- MEM
memwidget = lain.widgets.mem({
	settings = function()
		widget:set_markup(markup(beautiful.info_mem, "r ") .. markup(beautiful.info_value, mem_now.used))
	end
})

-- MPD
mpdwidget = lain.widgets.mpd({
	settings = function()
		mpd_notification_preset = {
			text = string.format("%s [%s] - %s\n%s", mpd_now.artist,
			mpd_now.album, mpd_now.date, mpd_now.title)
		}

		if mpd_now.state == "play" then
			name = markup(beautiful.info_music_playing, "m ")
			artist = mpd_now.artist
			middle = " > "
			title  = mpd_now.title
		elseif mpd_now.state == "pause" then
			name = markup(beautiful.info_music, "m ")
			artist = mpd_now.artist
			middle = " > "
			title  = mpd_now.title
		else
			name = markup(beautiful.info_music, "m ")
			artist = "x"
			middle = ""
			title  = ""
		end
		widget:set_markup(markup(beautiful.info_music, name) .. markup(beautiful.info_value, artist) .. markup(beautiful.info_spacer, middle) .. markup(beautiful.info_spacer, title))
	end
})

-- SPACER
spacer = wibox.widget.textbox(" ")

-- Create a wibox for each screen and add it
mywibox = {}
mylayoutbox = {}
mytaglist = {}
mytaglist.buttons = awful.util.table.join(
awful.button({ }, 1, awful.tag.viewonly),
awful.button({ modkey }, 1, awful.client.movetotag),
awful.button({ }, 3, awful.tag.viewtoggle),
awful.button({ modkey }, 3, awful.client.toggletag),
awful.button({ }, 4, function(t) awful.tag.viewnext(awful.tag.getscreen(t)) end),
awful.button({ }, 5, function(t) awful.tag.viewprev(awful.tag.getscreen(t)) end)
)
mysystray = {}
globalsystray = wibox.widget.systray()
--globalsystray:set_bg("#00000000")
mytasklist = {}
mytasklist.buttons = awful.util.table.join(
awful.button({ }, 1, function (c)
	if c == client.focus then
		c.minimized = true
	else
		-- Without this, the following
		-- :isvisible() makes no sense
		c.minimized = false
		if not c:isvisible() then
			awful.tag.viewonly(c:tags()[1])
		end
		-- This will also un-minimize
		-- the client, if needed
		client.focus = c
		c:raise()
	end
end),
awful.button({ }, 3, function ()
	if instance then
		instance:hide()
		instance = nil
	else
		instance = awful.menu.clients({
			theme = { width = 250 }
		})
	end
end),
awful.button({ }, 4, function ()
	awful.client.focus.byidx(1)
	if client.focus then client.focus:raise() end
end),
awful.button({ }, 5, function ()
	awful.client.focus.byidx(-1)
	if client.focus then client.focus:raise() end
end))

for s = 1, screen.count() do
	-- Create an imagebox widget which will contains an icon indicating which layout we're using.
	-- We need one layoutbox per screen.
	mylayoutbox[s] = awful.widget.layoutbox(s)
	mylayoutbox[s]:buttons(awful.util.table.join(
	awful.button({ }, 1, function () awful.layout.inc(layouts, 1) end),
	awful.button({ }, 3, function () awful.layout.inc(layouts, -1) end)))
	-- Create a taglist widget
	mytaglist[s] = awful.widget.taglist(s, awful.widget.taglist.filter.all, mytaglist.buttons)

	-- Create the wibox
	mywibox[s] = awful.wibox({ position = "top", screen = s, height = 20 })

	mysystray[s] = {}
	mysystray[s].stupid_bug = drawin({})
	mysystray[s].container = wibox.layout.constraint()
	mysystray[s].widget = wibox.widget.textbox("")

	mysystray[s].show = function ()
		for d = 1, screen.count() do
			if d ~= s then
				mysystray[d].hide()
			end
		end
		mysystray[s].container:set_strategy("min")
		mysystray[s].container:set_widget(globalsystray)
		mysystray[s].visible = true
		mysystray[s].widget:set_markup(markup(beautiful.info_spacer, " > "))
	end

	mysystray[s].hide = function ()
		awesome.systray(mysystray[s].stupid_bug, 0, 0, 10, true, "#000000")
		mysystray[s].container:set_widget(nil)
		mysystray[s].container:set_strategy("exact")
		mysystray[s].visible = false
		mysystray[s].widget:set_markup(markup(beautiful.info_spacer, " &lt; "))
	end

	mysystray[s].hide()

	mysystray[s].widget:buttons(awful.util.table.join(
	awful.button({ }, 1, function ()
		if mysystray[s].visible == true then
			mysystray[s].hide()
		else
			mysystray[s].show()
		end
	end)
	))

	-- Widgets that are aligned to the left
	local left_layout = wibox.layout.fixed.horizontal()
	left_layout:add(spacer)
	left_layout:add(spacer)
	left_layout:add(mytaglist[s])

	-- Widgets that are aligned to the right
	local right_layout = wibox.layout.fixed.horizontal()
	right_layout:add(mysystray[s].container)
	right_layout:add(mysystray[s].widget)

	right_layout:add(mpdwidget)
	right_layout:add(widget_spacer)

	right_layout:add(wifi_signal_widget)
	right_layout:add(widget_spacer)

	right_layout:add(netdowninfo)
	right_layout:add(widget_spacer)

	right_layout:add(netupinfo)
	right_layout:add(widget_spacer)

	right_layout:add(volumewidget)
	right_layout:add(widget_spacer)

	right_layout:add(memwidget)
	right_layout:add(widget_spacer)

	right_layout:add(cpuwidget)
	right_layout:add(widget_spacer)

	right_layout:add(batwidget)
	right_layout:add(widget_spacer)

	--right_layout:add(yawn.widget)
	--right_layout:add(widget_spacer)

	right_layout:add(mytextclock)

	-- Now bring it all together (with the tasklist in the middle)
	local layout = wibox.layout.align.horizontal()
	layout:set_left(left_layout)
	layout:set_right(right_layout)

	mywibox[s]:set_widget(layout)

	--mysystray[s].container.set_strategy("min")
	--mysystray[s].container.set_width(4)
	-- TaskBox
	--mytaskbox[s] = awful.wibox({ position = "bottom", screen = s})
	--mytaskbox[s].visible = false

	mytasklist[s] = awful.widget.tasklist(s, awful.widget.tasklist.filter.currenttags, mytasklist.buttons)

	--local layout2 = wibox.layout.align.horizontal()
	--if s == 1 then
	--	layout2:set_left(wibox.widget.systray())
	--end
	--layout2:set_middle(mytasklist[s])
	--layout2:set_right(mylayoutbox[s])

	--mytaskbox[s]:set_widget(layout2)
end
-- }}}

-- {{{ Key bindings
globalkeys = awful.util.table.join(

-- Awesome manipulation
awful.key({ modkey, "Shift"   }, "r", awesome.restart),
awful.key({ modkey, "Shift"   }, "q", awesome.quit),
--awful.key({ modkey, "Shift"   }, "w", function () mytaskbox[mouse.screen].visible = not mytaskbox[mouse.screen].visible end),

-- Tag manipulation
awful.key({ modkey,			  }, "Left", awful.tag.viewprev),
awful.key({ modkey,			  }, "Right", awful.tag.viewnext),
awful.key({ modkey,           }, "u", awful.client.urgent.jumpto),

-- Standard programs
awful.key({ modkey,           }, "Return", function () awful.util.spawn(terminal) end),
awful.key({ modkey,           }, "e", function () awful.util.spawn(explorer_cmd) end),
awful.key({ modkey            }, "l", function () os.execute(lock_cmd) end),
awful.key({ modkey            }, "r", function () awful.util.spawn("rofi -show run") end),

-- Music
awful.key({ modkey,           }, "i", function () os.execute("mpc prev") end),
awful.key({ modkey,           }, "o", function () os.execute("mpc next") end),
awful.key({ modkey,           }, "p", function () os.execute("mpc toggle") end),

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
awful.key({                   }, "Print", function () awful.util.spawn("scrot -e 'mv $f ~/Images/shots/'") end),

-- Layout
awful.key({ modkey,           }, "space", function () awful.layout.inc(layouts,  1) end),
awful.key({ modkey, "Shift"   }, "space", function () awful.layout.inc(layouts, -1) end),

-- Client
awful.key({ modkey, "Control" }, "n", awful.client.restore),
awful.key({ modkey, "Shift"   }, "Left", function () awful.client.swap.byidx(  1)	end),
awful.key({ modkey, "Shift"   }, "Right", function () awful.client.swap.byidx( -1)	end)
)

clientkeys = awful.util.table.join(
awful.key({ modkey,           }, "a",	  function (c) c.fullscreen = not c.fullscreen  end),
awful.key({ modkey,           }, "c",	  function (c) c:kill()						 end),
awful.key({ modkey,           }, "f",	  awful.client.floating.toggle					 ),
awful.key({ modkey, "Control" }, "Return", function (c) c:swap(awful.client.getmaster()) end),

awful.key({ modkey,           }, "n", function (c) c.minimized = true end),

awful.key({ modkey,		   }, "m",
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

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it works on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 9 do
	globalkeys = awful.util.table.join(globalkeys,
	-- View tag only.
	awful.key({ modkey }, "#" .. i + 9,
	function ()
		local screen = mouse.screen
		local tag = awful.tag.gettags(screen)[i]
		if tag then
			awful.tag.viewonly(tag)
		end
	end),
	-- Toggle tag.
	awful.key({ modkey, "Control" }, "#" .. i + 9,
	function ()
		local screen = mouse.screen
		local tag = awful.tag.gettags(screen)[i]
		if tag then
			awful.tag.viewtoggle(tag)
		end
	end),
	-- Move client to tag.
	awful.key({ modkey, "Shift" }, "#" .. i + 9,
	function ()
		if client.focus then
			local tag = awful.tag.gettags(client.focus.screen)[i]
			if tag then
				awful.client.movetotag(tag)
			end
		end
	end),
	-- Toggle tag.
	awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
	function ()
		if client.focus then
			local tag = awful.tag.gettags(client.focus.screen)[i]
			if tag then
				awful.client.toggletag(tag)
			end
		end
	end))
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
	{ rule = { },
	properties = { border_width = beautiful.border_width,
	border_color = beautiful.border_normal,
	focus = awful.client.focus.filter,
	raise = true,
	keys = clientkeys,
	maximized_vertical = false,
	maximized_horizontal = false,
	buttons = clientbuttons } },
	{ rule = { class = "Vlc" },
	properties = { sticky = true, titlebar = none } },
	{ rule_any = { class = {"URxvt", "XTerm"} },
	properties = { size_hints_honor = false} },
	{ rule = { instance = "weechat" },
	properties = { tag = tags[1][2] } },
	{ rule = { class = "Skype" },
	properties = { tag = tags[1][3] } },
	{ rule = { instance = "tag dev" },
	properties = { tag = tags[1][5] } },
	{ rule = { class = "Ktorrent" },
	properties = { tag = tags[1][8], urgent = false } },
	{ rule = { instance = "ncmpcpp" },
	properties = { tag = tags[1][9] } },
	{ rule = { class = "gimp" },
	properties = { floating = true } },
	{ rule = { instance = "plugin-container" },
	properties = { floating = true, focus = yes } },
	{ rule_any = { class = {"Firefox", "Chromium"} },
	properties = { tag = tags[1][1] } }
}
-- }}}

-- {{{ Signals
-- Signal function to execute when a new client appears.
client.connect_signal("manage", function (c, startup)
	-- Enable sloppy focus
	--	c:connect_signal("mouse::enter", function(c)
	--		if awful.layout.get(c.screen) ~= awful.layout.suit.magnifier
	--			and awful.client.focus.filter(c) then
	--			client.focus = c
	--		end
	--	end)

	if not startup then
		-- Set the windows at the slave,
		-- i.e. put it at the end of others instead of setting it master.
		-- awful.client.setslave(c)

		-- Put windows in a smart way, only if they does not set an initial position.
		if not c.size_hints.user_position and not c.size_hints.program_position then
			awful.placement.no_overlap(c)
			awful.placement.no_offscreen(c)
		end
	end

	if startup then
		awful.client.urgent.delete(c)
	end

	local titlebars_enabled = true
	if titlebars_enabled and not (c.class == "Vlc") and (c.type == "normal" or c.type == "dialog") then
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

		-- Widgets that are aligned to the left
		local left_layout = wibox.layout.fixed.horizontal()
		-- left_layout:add(awful.titlebar.widget.iconwidget(c))
		left_layout:buttons(buttons)

		-- Widgets that are aligned to the right
		local right_layout = wibox.layout.fixed.horizontal()
		--right_layout:add(awful.titlebar.widget.floatingbutton(c))
		--right_layout:add(awful.titlebar.widget.maximizedbutton(c))
		--right_layout:add(awful.titlebar.widget.stickybutton(c))
		--right_layout:add(awful.titlebar.widget.ontopbutton(c))
		right_layout:add(awful.titlebar.widget.closebutton(c))

		-- The title goes in the middle
		local middle_layout = wibox.layout.flex.horizontal()
		local spacer = wibox.widget.textbox(" ")
		local title = awful.titlebar.widget.titlewidget(c)
		title:set_align("center")

		left_layout:add(spacer)
		left_layout:add(title)
		middle_layout:buttons(buttons)

		-- Now bring it all together
		local layout = wibox.layout.align.horizontal()
		layout:set_left(left_layout)
		layout:set_right(right_layout)
		layout:set_middle(middle_layout)

		awful.titlebar(c, { size = "18" }):set_widget(layout)
	end
end)
-- }}}
