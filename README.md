# Fork reason 🏁
I have to figure out a way to make this linux compatible.

# Paradox games checksum patcher

This is a patcher, that forces game ignore checksum on starting and loading ironman game.
It gives you ability to use mods, that change checksum, and still get achievements.
Patcher DON'T give you ability to use console or use achievement-disabler game rules and earn achievements.

# IMPORTANT
Patcher modifying only currently existing game executable, if Paradox release new version of game, you need to run patcher again.

# Installation

1. Download latest binary of patcher from releases (or build it from source if you know what you doing)
2. Unzip it in game directory (right click on game on steam > Manage > Browse local files). `universal-checksum-patcher.exe` should be next to your `eu4.exe` or `hoi4.exe`
3. Run `universal-checksum-patcher.exe`

# Linux usage (native HOI4)

Build binary:
```bash
go build -o universal-checksum-patcher .
```

Run binary (interactive menu is default):
```bash
./universal-checksum-patcher
```

Interactive mode shows:
- auto-detected HOI4 installs (when found)
- selection of executable to patch
- confirmation prompt before patching

CLI fallback mode:
```bash
./universal-checksum-patcher -dir "/run/media/<user>/<drive-id>/SteamLibrary/steamapps/common/Hearts of Iron IV"
```

and writes a backup next to the executable as `hoi4.backup`.

# Supported games and platforms
|                       | Windows                | Linux(native) | MacOS  |
|-----------------------|------------------------|---------------|--------|
| Europa Universalis IV | Yes :heavy_check_mark: | No :x:        | No :x: |
| Europa Universalis V  | Yes :heavy_check_mark: | No :x:        | No :x: |
| Hearts of Iron IV     | Yes :heavy_check_mark: | Yes :heavy_check_mark: | No :x: |
