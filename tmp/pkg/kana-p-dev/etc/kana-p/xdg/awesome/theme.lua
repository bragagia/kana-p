-------------------------------
--  "Zenburn" awesome theme  --
--    By Adrian C. (anrxc)   --
-------------------------------

-- Alternative icon sets and widget icons:
--  * http://awesome.naquadah.org/wiki/Nice_Icons

-- {{{ Main
theme = {}
-- }}}

-- {{{ Styles
theme.font      = "Ohsnap 8"

theme.confdir                       = os.getenv("HOME") .. "/.config/awesome/themes/multicolor"

--theme.taglist_squares_sel           = theme.confdir .. "/icons/square_a.png"
--theme.taglist_squares_unsel         = theme.confdir .. "/icons/square_b.png"

theme.layout_tile                   = theme.confdir .. "/icons/tile.png"
theme.layout_tilegaps               = theme.confdir .. "/icons/tilegaps.png"
theme.layout_tileleft               = theme.confdir .. "/icons/tileleft.png"
theme.layout_tilebottom             = theme.confdir .. "/icons/tilebottom.png"
theme.layout_tiletop                = theme.confdir .. "/icons/tiletop.png"
theme.layout_fairv                  = theme.confdir .. "/icons/fairv.png"
theme.layout_fairh                  = theme.confdir .. "/icons/fairh.png"
theme.layout_spiral                 = theme.confdir .. "/icons/spiral.png"
theme.layout_dwindle                = theme.confdir .. "/icons/dwindle.png"
theme.layout_max                    = theme.confdir .. "/icons/max.png"
theme.layout_fullscreen             = theme.confdir .. "/icons/fullscreen.png"
theme.layout_magnifier              = theme.confdir .. "/icons/magnifier.png"
theme.layout_floating               = theme.confdir .. "/icons/floating.png"

-- {{{ Colors
theme.fg_normal = "#dddddd"
theme.fg_focus  = "#ff8c00"
theme.fg_urgent = "#d01e2d"
--theme.fg_urgent = "#E7212A"
theme.bg_normal = "#10101000"
theme.bg_focus  = "#10101000"
theme.bg_urgent = "#10101000"
-- }}}

theme.notif_fg = "#000000"
theme.notif_bg = "#91EBE9"
theme.notif_border_width = 0

theme.info_title = "#888888"
theme.info_music_playing = "#07A301"
theme.info_music = "#005EBC"
theme.info_wifi = "#0075BA"
theme.info_download = "#108896"
theme.info_upload = "#588C75"
theme.info_volume = "#B0C47F"
theme.info_mem = "#F3E395"
theme.info_cpu = "#F3AE73" 
theme.info_battery = "#DA645A" 
theme.info_temp ="#8D4548" 
theme.info_spacer = "#AAAAAA"
theme.info_value = theme.fg_normal

-- {{{ Borders
theme.border_width  = "0"
theme.border_normal  = "#777777"
theme.useless_gap_width = "15"

-- {{{ Titlebars
theme.titlebar_bg_focus  = "#101010"
theme.titlebar_bg_normal = "#101010"
-- }}}

-- There are other variable sets
-- overriding the default one when
-- defined, the sets are:
-- [taglist|tasklist]_[bg|fg]_[focus|urgent]
-- titlebar_[normal|focus]
-- tooltip_[font|opacity|fg_color|bg_color|border_width|border_color]
-- Example:
--theme.taglist_bg_focus = "#CC9393"
-- }}}

-- {{{ Widgets
-- You can add as many variables as
-- you wish and access them by using
-- beautiful.variable in your rc.lua
--theme.fg_widget        = "#AECF96"
--theme.fg_center_widget = "#88A175"
--theme.fg_end_widget    = "#FF5656"
--theme.bg_widget        = "#494B4F"
--theme.border_widget    = "#3F3F3F"
-- }}}

-- {{{ Mouse finder
theme.mouse_finder_color = "#FF0000"
-- mouse_finder_[timeout|animate_timeout|radius|factor]
-- }}}

-- {{{ Misc
theme.menu_submenu_icon      = "/usr/share/awesome/themes/default/submenu.png"
theme.tasklist_floating_icon = "/usr/share/awesome/themes/default/tasklist/floatingw.png"
-- }}}

return theme
