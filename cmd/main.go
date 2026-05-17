package main

import (
	"flag"
	"fmt"
	"os/exec"
	"strings"
)

func adb(cmd string) string {
	out, _ := exec.Command("bash", "-c", "adb shell "+cmd).Output()
	return strings.TrimSpace(string(out))
}

func main() {
	infCmd := flag.NewFlagSet("info", flag.ExitOnError)
	infCmd.Usage = func() { fmt.Println("Usage: adb-utils info") }

	deviceCmd := flag.NewFlagSet("device", flag.ExitOnError)
	deviceCmd.Usage = func() { fmt.Println("Usage: adb-utils device [model|api|battery]") }

	if len(os.Args) < 2 {
		fmt.Println("Usage: adb-utils [info|device|packages|screenshot]")
		return
	}

	switch os.Args[1] {
	case "info":
		fmt.Printf("Model: %s\n", adb("getprop ro.product.model"))
		fmt.Printf("Android: %s\n", adb("getprop ro.build.version.release"))
		fmt.Printf("API: %s\n", adb("getprop ro.build.version.sdk"))
	case "device":
		if len(os.Args) > 2 {
			switch os.Args[2] {
			case "model":
				fmt.Println(adb("getprop ro.product.model"))
			case "api":
				fmt.Println(adb("getprop ro.build.version.sdk"))
			case "battery":
				fmt.Println(adb("dumpsys battery | grep level"))
			}
		}
	case "packages":
		fmt.Println(adb("pm list packages -3"))
	case "screenshot":
		exec.Command("adb", "exec-out", "screencap", "-p").Output()
		fmt.Println("Screenshot saved")
	}
}
