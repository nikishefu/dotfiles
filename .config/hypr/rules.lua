local ULTRAWIDE_RATIO = 2.2

local profiles = {
	laptop = {
		default = 0.5,
		rules = {
			firefox = 0.6,
			kitty = 0.4,
		},
	},
	ultrawide = {
		default = 0.3,
		rules = {
			firefox = 0.5,
			kitty = 0.2,
		},
	},
}

-- Rules for every profile are registered up front and toggled later, so nothing
-- here depends on a monitor existing while the config is being parsed
local width_rules = {}
for profile, width in pairs(profiles) do
	width_rules[profile] = {}
	for class, w in pairs(width.rules) do
		local rule = hl.window_rule({
			name = class .. "-width-" .. profile,
			match = {
				class = class,
			},
			scrolling_width = w,
		})
		rule:set_enabled(false)
		table.insert(width_rules[profile], rule)
	end
end

local current_profile

---@param mon HL.Monitor|nil
local function apply_widths(mon)
	mon = mon or hl.get_active_monitor()
	if not mon or mon.height == 0 then
		return
	end

	local profile = mon.width / mon.height > ULTRAWIDE_RATIO and "ultrawide" or "laptop"
	if profile == current_profile then
		return
	end
	current_profile = profile

	hl.config({
		scrolling = {
			column_width = profiles[profile].default,
		},
	})
	for name, rules in pairs(width_rules) do
		for _, rule in ipairs(rules) do
			rule:set_enabled(name == profile)
		end
	end
end

-- Works on reload; at boot the monitor may not be there yet, the events below cover that
apply_widths()

hl.on("hyprland.start", function()
	apply_widths()
end)
hl.on("monitor.focused", apply_widths)
for _, event in ipairs({ "monitor.added", "monitor.removed", "monitor.layout_changed" }) do
	-- The event's monitor is not necessarily the focused one, so look it up
	hl.on(event, function()
		apply_widths()
	end)
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

hl.window_rule({
    name = "floating-thunar-rename",
    match = {
        class = "Thunar",
        title = "^Rename .*"
    },

	float = true,
	size = { 500, 100 },
})
