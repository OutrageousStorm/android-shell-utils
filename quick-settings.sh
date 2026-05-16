#!/bin/bash
# quick-settings.sh -- Toggle Android settings via shell
# Usage: adb shell < quick-settings.sh
#        ./quick-settings.sh wifi on|off
#        ./quick-settings.sh bt on|off

get_setting() {
    settings get global "$1"
}

set_wifi() {
    [[ "$1" == "on" ]] && svc wifi enable || svc wifi disable
    echo "WiFi: $(get_setting wifi_on)"
}

set_bt() {
    [[ "$1" == "on" ]] && svc bluetooth enable || svc bluetooth disable
}

set_airplane() {
    [[ "$1" == "on" ]] && settings put global airplane_mode_on 1 || settings put global airplane_mode_on 0
    echo "Airplane: $(get_setting airplane_mode_on)"
}

set_doze() {
    if [[ "$1" == "on" ]]; then
        dumpsys deviceidle step deep
        echo "Doze: activated"
    else
        dumpsys deviceidle disable
        echo "Doze: disabled"
    fi
}

case "$1" in
    wifi)       set_wifi "$2" ;;
    bt|bluetooth) set_bt "$2" ;;
    airplane)   set_airplane "$2" ;;
    doze)       set_doze "$2" ;;
    *)
        echo "Usage: $0 {wifi|bt|airplane|doze} {on|off}"
        echo ""
        echo "Status:"
        echo "  WiFi:     $(get_setting wifi_on)"
        echo "  BT:       $(get_setting bluetooth_on)"
        echo "  Airplane: $(get_setting airplane_mode_on)"
        ;;
esac
