#!/bin/bash
# logcat_filter.sh -- Enhanced logcat with better filtering
# Usage: ./logcat_filter.sh [package|keyword]

PKG="${1:-.}"
adb logcat -v threadtime | grep -E "$PKG|Exception|Error|Warning" --color=auto
