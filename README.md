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

Run launcher with default path:
```bash
./patch-hoi4.sh
```

The launcher shows a small menu with:
- auto-detected HOI4 installs (when found)
- custom path entry
- confirmation before patching

Run launcher with custom game path:
```bash
./patch-hoi4.sh "/run/media/<user>/<drive-id>/SteamLibrary/steamapps/common/Hearts of Iron IV"
```

The script calls:
```bash
./universal-checksum-patcher -dir "<hoi4-dir>"
```

and writes a backup next to the executable as `hoi4.backup`.

# Supported games and platforms
|                       | Windows                | Linux(native) | MacOS  |
|-----------------------|------------------------|---------------|--------|
| Europa Universalis IV | Yes :heavy_check_mark: | No :x:        | No :x: |
| Europa Universalis V  | Yes :heavy_check_mark: | No :x:        | No :x: |
| Hearts of Iron IV     | Yes :heavy_check_mark: | Yes :heavy_check_mark: | No :x: |
