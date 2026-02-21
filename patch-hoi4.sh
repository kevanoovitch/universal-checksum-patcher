#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BIN="$SCRIPT_DIR/universal-checksum-patcher"

DEFAULT_PATH_1="$HOME/.local/share/Steam/steamapps/common/Hearts of Iron IV"
DEFAULT_PATH_2="$HOME/.steam/steam/steamapps/common/Hearts of Iron IV"

if [[ ! -x "$BIN" ]]; then
  echo "Missing executable: $BIN"
  echo "Build it first: go build -o universal-checksum-patcher ."
  exit 1
fi

validate_hoi4_dir() {
  local dir="$1"
  [[ -d "$dir" && -f "$dir/hoi4" ]]
}

run_patch() {
  local dir="$1"
  echo "Target: $dir"
  read -r -p "Proceed with patching? [y/N]: " confirm
  if [[ "${confirm,,}" != "y" ]]; then
    echo "Cancelled."
    exit 0
  fi
  "$BIN" -dir "$dir"
}

if [[ "${1:-}" != "" ]]; then
  HOI4_DIR="$1"
  if ! validate_hoi4_dir "$HOI4_DIR"; then
    echo "Invalid HOI4 directory: $HOI4_DIR"
    echo "Usage: ./patch-hoi4.sh \"/path/to/Hearts of Iron IV\""
    exit 1
  fi
  run_patch "$HOI4_DIR"
  exit 0
fi

declare -a CANDIDATES=()
for p in "$DEFAULT_PATH_1" "$DEFAULT_PATH_2"; do
  if validate_hoi4_dir "$p"; then
    CANDIDATES+=("$p")
  fi
done

# Generic mounted-drive scan for SteamLibrary paths (no user-specific hardcoding).
for p in /run/media/*/*/SteamLibrary/steamapps/common/Hearts\ of\ Iron\ IV \
         /media/*/*/SteamLibrary/steamapps/common/Hearts\ of\ Iron\ IV \
         /mnt/*/SteamLibrary/steamapps/common/Hearts\ of\ Iron\ IV; do
  if validate_hoi4_dir "$p"; then
    CANDIDATES+=("$p")
  fi
done

echo "HOI4 Patcher"
echo "------------"

if [[ "${#CANDIDATES[@]}" -eq 0 ]]; then
  echo "No known HOI4 installs found automatically."
else
  echo "Detected installs:"
  i=1
  for p in "${CANDIDATES[@]}"; do
    echo "  $i) $p"
    ((i++))
  done
fi

echo "  c) Enter custom path"
echo "  q) Quit"

read -r -p "Select option: " choice

if [[ "$choice" == "q" || "$choice" == "Q" ]]; then
  echo "Cancelled."
  exit 0
fi

if [[ "$choice" == "c" || "$choice" == "C" ]]; then
  read -r -p "Enter HOI4 directory: " custom_path
  if ! validate_hoi4_dir "$custom_path"; then
    echo "Invalid HOI4 directory: $custom_path"
    exit 1
  fi
  run_patch "$custom_path"
  exit 0
fi

if [[ "$choice" =~ ^[0-9]+$ ]]; then
  idx=$((choice - 1))
  if (( idx < 0 || idx >= ${#CANDIDATES[@]} )); then
    echo "Invalid selection."
    exit 1
  fi
  run_patch "${CANDIDATES[$idx]}"
  exit 0
fi

echo "Invalid selection."
exit 1
