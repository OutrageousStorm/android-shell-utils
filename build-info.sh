#!/bin/bash
# build-info.sh -- Show full Android build and security info
# Usage: adb shell < build-info.sh

echo "=== Android Build Info ==="
echo "Model:           $(getprop ro.product.model)"
echo "Manufacturer:    $(getprop ro.product.manufacturer)"
echo "Device:          $(getprop ro.product.device)"
echo "Board:           $(getprop ro.product.board)"
echo ""
echo "=== Software ==="
echo "Android version: $(getprop ro.build.version.release)"
echo "API level:       $(getprop ro.build.version.sdk)"
echo "Build type:      $(getprop ro.build.type)"
echo "Build tags:      $(getprop ro.build.tags)"
echo "Security patch:  $(getprop ro.build.version.security_patch)"
echo "Build number:    $(getprop ro.build.display.id)"
echo ""
echo "=== Security ==="
echo "Bootloader:      $(getprop ro.boot.verifiedbootstate)"
echo "Encryption:      $(getprop ro.crypto.state)"
echo "SELinux:         $(getenforce 2>/dev/null || echo N/A)"
echo "Knox Warranty:   $(cat /proc/cmdline | grep -o 'knox' || echo 'N/A')"
