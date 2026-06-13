hl.window_rule({
	name = "firefox-width",
	match = {
		class = "firefox",
	},
	scrolling_width = 0.5,
})

hl.window_rule({
	name = "kitty-width",
	match = {
		class = "kitty",
	},
	scrolling_width = 0.2,
})

hl.window_rule({
	name = "keepass-floating",
	match = {
		class = "org.keepassxc.KeePassXC",
	},

	float = true,
	size = { 400, 600 },
})
