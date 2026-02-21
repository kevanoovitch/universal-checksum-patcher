package main

import (
	"flag"
	"fmt"
	"runtime"
)

const (
	eu4exe  = "eu4.exe"
	eu5exe  = "eu5.exe"
	hoi4exe = "hoi4.exe"
	eu4bin  = "eu4"
	eu5bin  = "eu5"
	hoi4bin = "hoi4"
)

var (
	l    *logger
	exes = map[string]bool{
		eu4exe:  true,
		eu5exe:  true,
		hoi4exe: true,
		eu4bin:  true,
		eu5bin:  true,
		hoi4bin: true,
	}
)

func main() {
	l = newLogger()
	searchDir := flag.String("dir", "", "directory to search for game executable(s)")
	flag.Parse()

	func() {
		filesToPatch, err := findFilesToPatch(*searchDir)
		if err != nil {
			l.Error(err)
			return
		}

		if len(filesToPatch) == 0 {
			l.Error(errCantLocate)
			return
		}

		for _, file := range filesToPatch {
			l.Infof("patching %s", file)
			err = applyPatch(file)
			if err != nil {
				l.Error(err)
				l.Info("patch wasn't installed, no file have been changed")
				return
			}
			l.Infof("patch successfully installed, original executable has been backed up in %s.backup", file)
		}

	}()

	if runtime.GOOS != "windows" {
		return
	}

	l.Info("press enter to exit...")
	_, _ = fmt.Scanln()
}
