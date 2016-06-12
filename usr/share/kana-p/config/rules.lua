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
			maximized_vertical = false,
			maximized_horizontal = false,
			buttons = clientbuttons
		}
	},
	{
		rule = {
			class = "Vlc"
		},
		properties = {
			sticky = true,
			titlebar = none
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
			focus = yes
		}
	},
	{
		rule = {
			class = "Plank"
		}
	}
}
