#!/bin/bash

cpupower frequency-set -g performance
echo "performance" | tee /sys/devices/system/cpu/cpu*/cpufreq/energy_performance_preference
