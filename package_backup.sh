#!/bin/bash
# package_backup.sh -- Backup and restore installed packages list
# Usage: ./package_backup.sh backup [file]     # save package list
#        ./package_backup.sh restore [file]    # restore packages
#        ./package_backup.sh compare [file]    # what's changed

ACTION="${1:-backup}"
FILE="${2:-packages_$(date +%Y%m%d_%H%M%S).txt}"

case "$ACTION" in
    backup)
        echo "Backing up packages to $FILE..."
        adb shell pm list packages -3 | sed 's/package://' | sort > "$FILE"
        echo "✓ $(wc -l < $FILE) packages backed up"
        ;;
    restore)
        [[ ! -f "$FILE" ]] && echo "File not found: $FILE" && exit 1
        echo "Restoring packages from $FILE..."
        while read -r pkg; do
            echo "  → $pkg"
            adb shell cmd package install-existing "$pkg" 2>/dev/null || true
        done < "$FILE"
        echo "✓ Done"
        ;;
    compare)
        [[ ! -f "$FILE" ]] && echo "File not found: $FILE" && exit 1
        current=$(mktemp)
        adb shell pm list packages -3 | sed 's/package://' | sort > "$current"
        echo "NEW (installed after backup):"
        comm -13 "$FILE" "$current"
        echo ""
        echo "REMOVED:"
        comm -23 "$FILE" "$current"
        rm "$current"
        ;;
esac
