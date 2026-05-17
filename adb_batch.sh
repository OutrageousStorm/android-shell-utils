#!/bin/bash
# adb_batch.sh -- Run ADB command on all connected devices
# Usage: ./adb_batch.sh "adb shell cmd"
#        ./adb_batch.sh "settings put system screen_brightness 150"

CMD="${1:-adb devices}"
devices=$(adb devices | grep -E '^\s*[a-zA-Z0-9]' | awk '{print $1}')

if [ -z "$devices" ]; then
    echo "No devices connected."
    exit 1
fi

count=$(echo "$devices" | wc -l)
echo "Running on $count device(s):"
echo "$devices" | while read -r device; do
    [[ -z "$device" ]] && continue
    echo ""
    echo "[$device]"
    adb -s "$device" shell $CMD
done
