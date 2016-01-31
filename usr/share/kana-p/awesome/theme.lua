-- {{{ Main
theme = {}
-- }}}

-- {{{ Styles
theme.font      = "Ohsnap 8"

theme.confdir                       = "/usr/share/kana-p/awesome"

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
theme.fg_normal = "#898f9a"
theme.fg_focus  = "#ffffff"
theme.fg_urgent = "#d01e2d"
--theme.fg_urgent = "#E7212A"
theme.bg_normal = "#101010A0"
theme.bg_focus  = "#10101000"
theme.bg_urgent = "#10101000"
-- }}}

theme.bg_systray = "#505050"

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
theme.info_spacer = "#808080"
theme.info_value = "#dadada"

-- {{{ Borders
theme.border_width  = "0"
theme.border_normal  = "#777777"
theme.border_focus  = "#C34040"
theme.useless_gap_width = "15"

-- {{{ Titlebars
theme.titlebar_bg_focus  = "#2F343F"
theme.titlebar_bg_normal = "#2F343F"
--theme.titlebar_bg_focus  = "#202020"
--theme.titlebar_bg_normal = "#202020"
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
theme.mouse_finder_animate_timeout = 4
-- mouse_finder_[timeout|animate_timeout|radius|factor]
-- }}}

-- Define the image to load
theme.titlebar_close_button_normal = "/usr/share/kana-p/awesome/titlebar/close.png"
theme.titlebar_close_button_focus  = "/usr/share/kana-p/awesome/titlebar/close.png"

theme.titlebar_ontop_button_normal_inactive = "/usr/share/awesome/themes/default/titlebar/ontop_normal_inactive.png"
theme.titlebar_ontop_button_focus_inactive  = "/usr/share/awesome/themes/default/titlebar/ontop_focus_inactive.png"
theme.titlebar_ontop_button_normal_active = "/usr/share/awesome/themes/default/titlebar/ontop_normal_active.png"
theme.titlebar_ontop_button_focus_active  = "/usr/share/awesome/themes/default/titlebar/ontop_focus_active.png"

theme.titlebar_sticky_button_normal_inactive = "/usr/share/awesome/themes/default/titlebar/sticky_normal_inactive.png"
theme.titlebar_sticky_button_focus_inactive  = "/usr/share/awesome/themes/default/titlebar/sticky_focus_inactive.png"
theme.titlebar_sticky_button_normal_active = "/usr/share/awesome/themes/default/titlebar/sticky_normal_active.png"
theme.titlebar_sticky_button_focus_active  = "/usr/share/awesome/themes/default/titlebar/sticky_focus_active.png"

theme.titlebar_floating_button_normal_inactive = "/usr/share/awesome/themes/default/titlebar/floating_normal_inactive.png"
theme.titlebar_floating_button_focus_inactive  = "/usr/share/awesome/themes/default/titlebar/floating_focus_inactive.png"
theme.titlebar_floating_button_normal_active = "/usr/share/awesome/themes/default/titlebar/floating_normal_active.png"
theme.titlebar_floating_button_focus_active  = "/usr/share/awesome/themes/default/titlebar/floating_focus_active.png"

theme.titlebar_maximized_button_normal_inactive = "/usr/share/awesome/themes/default/titlebar/maximized_normal_inactive.png"
theme.titlebar_maximized_button_focus_inactive  = "/usr/share/awesome/themes/default/titlebar/maximized_focus_inactive.png"
theme.titlebar_maximized_button_normal_active = "/usr/share/awesome/themes/default/titlebar/maximized_normal_active.png"
theme.titlebar_maximized_button_focus_active  = "/usr/share/awesome/themes/default/titlebar/maximized_focus_active.png"

-- {{{ Misc
theme.menu_submenu_icon      = "/usr/share/awesome/themes/default/submenu.png"
theme.tasklist_floating_icon = "/usr/share/awesome/themes/default/tasklist/floatingw.png"
-- }}}

return theme
