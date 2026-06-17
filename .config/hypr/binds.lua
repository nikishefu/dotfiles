local mainMod = "SUPER"
local terminal = "kitty"

-- ========
-- Exec cmd
-- ========

-- Terminal apps
hl.bind(mainMod .. " + RETURN", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + C", hl.dsp.exec_cmd(terminal .. " -e qalc"))
hl.bind(mainMod .. " + SHIFT + T", hl.dsp.exec_cmd(terminal .. " -e ~/Scripts/timer"))
hl.bind(mainMod .. " + V", hl.dsp.exec_cmd(terminal .. " -e clipse"))
hl.bind(
	mainMod .. " + Z",
	hl.dsp.exec_cmd(terminal .. " -e bash -c \"tmux new-session -s Notes -c ~/Notes 'zk edit -i'\"")
)

-- App launch
hl.bind(mainMod .. " + SPACE", hl.dsp.exec_cmd("rofi -show drun"))
hl.bind(mainMod .. " + B", hl.dsp.exec_cmd("firefox"))
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd("thunar"))
hl.bind(mainMod .. " + T", hl.dsp.exec_cmd("Telegram"))

-- Service commands
hl.bind(mainMod .. " + SHIFT + W", hl.dsp.exec_cmd("killall waybar ; sleep 1 && waybar"))
hl.bind(mainMod .. " + SHIFT + R", hl.dsp.exec_cmd("hyprctl reload && notify-send 'Hyprland reloaded'"))

-- Session commands
hl.bind(mainMod .. " + SHIFT + X", hl.dsp.exec_cmd("hyprshutdown"))
hl.bind(mainMod .. " + DELETE", hl.dsp.exec_cmd("systemctl poweroff"))
hl.bind(mainMod .. " + SHIFT + DELETE", hl.dsp.exec_cmd("systemctl reboot"))

-- Actions
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.exec_cmd('grim -g "$(slurp -w 0 -d )" - | swappy -f -'))
hl.bind(mainMod .. " + SHIFT + P", hl.dsp.exec_cmd("hyprpicker -a"))
hl.bind(mainMod .. " + SHIFT + P", hl.dsp.exec_cmd("hyprpicker -a"))

-- VPN
hl.bind(mainMod .. " + SHIFT + V", hl.dsp.exec_cmd("ip a | grep tun0 && nmcli con down Infra || nmcli con up Infra"))

-- ======
-- Window
-- ======

hl.bind(mainMod .. " + H", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + L", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + K", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + J", hl.dsp.focus({ direction = "down" }))

hl.bind(mainMod .. " + SHIFT + H", hl.dsp.layout("swapcol l"))
hl.bind(mainMod .. " + SHIFT + L", hl.dsp.layout("swapcol r"))
hl.bind(mainMod .. " + SHIFT + K", hl.dsp.window.swap({ direction = "up" }))
hl.bind(mainMod .. " + SHIFT + J", hl.dsp.window.swap({ direction = "down" }))

hl.bind(mainMod .. " + period", hl.dsp.layout("colresize +0.1"))
hl.bind(mainMod .. " + comma", hl.dsp.layout("colresize -0.1"))
hl.bind(mainMod .. " + slash", hl.dsp.layout("consume_or_expel prev"))
hl.bind(mainMod .. " + SHIFT + slash", hl.dsp.layout("consume_or_expel next"))

-- Workspaces
for key = 1, 9 do
	hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = key }))
	hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = key, follow = false }))
end
hl.bind(mainMod .. " + SHIFT + 0", hl.dsp.window.move({ workspace = "special:magic" }))
hl.bind("SUPER + 0", hl.dsp.workspace.toggle_special("magic"))

-- Scroll through existing workspaces with mainMod + scroll
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

hl.bind(mainMod .. " + Q", hl.dsp.window.close())
hl.bind(mainMod .. " + SHIFT + Q", hl.dsp.window.kill())
hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen())
hl.bind(mainMod .. " + SHIFT + F", hl.dsp.window.fullscreen({ mode = "maximized" }))

-- ===============
-- Multimedia keys
-- ===============
--
hl.bind(
	"XF86AudioRaiseVolume",
	hl.dsp.exec_cmd("wpctl set-volume -l 1.2 @DEFAULT_AUDIO_SINK@ 10%+"),
	{ locked = true, repeating = true }
)
hl.bind(
	"XF86AudioLowerVolume",
	hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 10%-"),
	{ locked = true, repeating = true }
)
hl.bind(
	"XF86AudioMute",
	hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),
	{ locked = true, repeating = true }
)
hl.bind(
	"XF86AudioMicMute",
	hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),
	{ locked = true, repeating = true }
)
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set +10%"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 10%-"), { locked = true, repeating = true })
hl.bind(
	mainMod .. " + XF86MonBrightnessUp",
	hl.dsp.exec_cmd("ddcutil setvcp 10 100 && pkill hyprsunset"),
	{ locked = true, repeating = true }
)
hl.bind(
	mainMod .. " + XF86MonBrightnessDown",
	hl.dsp.exec_cmd("ddcutil setvcp 10 0 && hyprsunset -t 4000"),
	{ locked = true, repeating = true }
)
hl.bind(
	mainMod .. " + SHIFT + XF86MonBrightnessDown",
	hl.dsp.exec_cmd("hyprsunset -t 4000"),
	{ locked = true, repeating = true }
)

-- Player
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })
