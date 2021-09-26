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
            placement = awful.placement.no_overlap+awful.placement.no_offscreen,
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
                "xtightvncviewer",
            },
            name = {
                "Event Tester",  -- xev.
            },
            role = {
                "AlarmWindow",  -- Thunderbird's calendar.
            }
        },
        properties = {
            floating = true,
        }
    },

    -- Add titlebars to normal clients and dialogs
    {
        rule_any = {
            type = {
                "normal",
                "dialog",
            }
        },
        properties = {
            titlebars_enabled = true,
        }
    },

    {
        rule_any = {
            class = {
                "Vlc"
            },
        },
        properties = {
            sticky = true,
            titlebars_enabled = false,
        }
    },
    {
        rule_any = {
            class = {
                "URxvt",
                "XTerm",
            }
        },
        properties = {
            size_hints_honor = false,
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
            titlebars_enabled = false,
        }
    }

    -- Set Firefox to always map on the tag named "2" on screen 1.
    -- { rule = { class = "Firefox" },
    --   properties = { screen = 1, tag = "2" } },
}
