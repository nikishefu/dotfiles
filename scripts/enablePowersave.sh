#!/bin/bash

cpupower frequency-set -g powersave
echo "power" | tee /sys/devices/system/cpu/cpu*/cpufreq/energy_performance_preference
