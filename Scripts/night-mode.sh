#!/usr/bin/env bash
# Night mode: warm colour temperature (hyprsunset) + dimmed monitor (ddcutil).
# State is "hyprsunset is running".
#
#   night-mode.sh enable|disable|toggle   switch explicitly
#   night-mode.sh auto                    on between NIGHT_START and NIGHT_END, off otherwise
#   night-mode.sh status                  JSON for the waybar module
#
# The systemd timer (~/.config/systemd/user/night-mode.timer) fires at the same
# times — keep them in sync.

NIGHT_START="21:00"
NIGHT_END="07:00"
TEMPERATURE=4000
BRIGHTNESS_NIGHT=50
BRIGHTNESS_DAY=100
WAYBAR_SIGNAL=8

USAGE="Usage: $0 {enable|disable|toggle|auto|status}"

is_on() {
    pgrep -x hyprsunset >/dev/null
}

refresh_waybar() {
    sleep 0.3  # let hyprsunset appear/disappear first
    pkill -RTMIN+"$WAYBAR_SIGNAL" -x waybar || true
}

enable() {
    is_on && return
    echo "Enabling night mode"
    # Spawn through Hyprland so hyprsunset outlives whoever called us
    # (systemd oneshot, waybar click handler, ...)
    hyprctl dispatch "hl.dsp.exec_cmd('hyprsunset -t $TEMPERATURE')" >/dev/null 2>&1 \
        || setsid -f hyprsunset -t "$TEMPERATURE" >/dev/null 2>&1
    refresh_waybar
    ddcutil setvcp 10 "$BRIGHTNESS_NIGHT"
}

disable() {
    is_on || return
    echo "Disabling night mode"
    pkill -x hyprsunset
    refresh_waybar
    ddcutil setvcp 10 "$BRIGHTNESS_DAY"
}

is_night_time() {
    local now start end
    now=$((10#$(date +%H%M)))
    start=$((10#${NIGHT_START/:/}))
    end=$((10#${NIGHT_END/:/}))
    if [ "$start" -le "$end" ]; then
        [ "$now" -ge "$start" ] && [ "$now" -lt "$end" ]
    else
        # Wraps past midnight
        [ "$now" -ge "$start" ] || [ "$now" -lt "$end" ]
    fi
}

status() {
    if is_on; then
        printf '{"text": "", "class": "on", "tooltip": "Night mode on (%sK)\\nAuto: %s – %s"}\n' \
            "$TEMPERATURE" "$NIGHT_START" "$NIGHT_END"
    else
        printf '{"text": "", "class": "off", "tooltip": "Night mode off\\nAuto: %s – %s"}\n' \
            "$NIGHT_START" "$NIGHT_END"
    fi
}

if [ $# -ne 1 ]; then
    echo "$USAGE" >&2
    exit 1
fi

case "$1" in
    enable)  enable ;;
    disable) disable ;;
    toggle)  if is_on; then disable; else enable; fi ;;
    auto)    if is_night_time; then enable; else disable; fi ;;
    status)  status ;;
    *)
        echo "Error: invalid argument '$1'" >&2
        echo "$USAGE" >&2
        exit 1
        ;;
esac
