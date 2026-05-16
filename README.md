# ⚡ Android Shell Utils

Lightweight shell scripts for Android — zero dependencies, pure ADB shell.

## Scripts

| Script | What it does |
|--------|-------------|
| `quick-settings.sh` | Toggle WiFi, BT, airplane mode, doze via ADB |
| `app-usage.sh` | Show per-app screen-on time and usage stats |
| `network-stats.sh` | Real-time bandwidth usage by UID |
| `thermal-monitor.sh` | Monitor CPU temperature and throttling |
| `build-info.sh` | Full device build and security patch info |

## Usage
```bash
adb shell < quick-settings.sh              # Show all toggles
./quick-settings.sh wifi on                # Enable WiFi
./network-stats.sh com.example.app         # Watch specific app traffic
```

No installation needed — just execute directly via ADB.
