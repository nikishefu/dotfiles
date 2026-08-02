#!/usr/bin/env bash

# Exit immediately if a command exits with a non-zero status
set -e

USAGE="Usage: $0 {enable|disable}"

if [ $# -ne 1 ]; then
    echo "Error: Argument required."
    echo "$USAGE"
    exit 1
fi

case "$1" in
    enable)
        echo "Enabling night mode..."
        ddcutil setvcp 10 50
        hyprsunset -t 4000 &
        ;;
    disable)
        echo "Disabling night mode..."
        ddcutil setvcp 10 100
        pkill hyprsunset || true
        ;;
    *)
        echo "Error: Invalid argument '$1'"
        echo "$USAGE"
        exit 1
        ;;
esac
