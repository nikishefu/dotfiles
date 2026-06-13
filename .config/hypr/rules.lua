local laptop_width = {
	default = 0.5,
	rules = {
		firefox = 0.6,
		kitty = 0.4,
	},
}

local ultrawide_width = {
	default = 0.3,
	rules = {
		firefox = 0.5,
		kitty = 0.2,
	},
}

local mon = hl.get_active_monitor()
local ratio = mon.width / mon.height
local width
if ratio > 2.2 then
	width = ultrawide_width
else
	width = laptop_width
end

hl.config({
	scrolling = {
		column_width = width.default,
	},
})

for class, w in pairs(width.rules) do
	hl.window_rule({
		name = class .. "-width",
		match = {
			class = class,
		},
		scrolling_width = w,
	})
end

hl.window_rule({
	name = "keepass-floating",
	match = {
		class = "org.keepassxc.KeePassXC",
	},

	float = true,
	size = { 400, 600 },
})

hl.layer_rule({
	match = { namespace = "waybar" },
	blur = true,
	ignore_alpha = 0.1,
})

hl.layer_rule({
	match = { namespace = "notifications" },
	blur = true,
	ignore_alpha = 0.1,
})
