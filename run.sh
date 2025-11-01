#!/usr/bin/env bash

set -euo pipefail  # safer bash options
shopt -s nullglob  # makes *.sh expand to nothing if no match (instead of literal string)

MIGRATIONS_DIR="./migrations"
STATE_DIR="$HOME/.local/state/maxos/migrations"
SCRIPTS=("$MIGRATIONS_DIR"/*.sh)

echo "⏳Installing Updates"
sudo sudo pacman -Syu --noconfirm

echo "⏳Running Migrations"
# Loop through each script and execute it
for script in "${SCRIPTS[@]}"; do
  script_name=$(basename "$script")
  state_file="$STATE_DIR/${script_name%.*}"

  if [[ -e "$state_file" ]]; then
    echo "⏩ Skipping $script_name as it was already applied"
    continue
  fi

  echo "⏳Applying $script_name"
  bash "$script"

  # mark the script as applied
  touch "$state_file"
done

echo "⏳Updating dotfiles"
stow -d dotfiles -S $(exa -d dotfiles/*/ | xargs -n1 basename) -t ~/

echo "✅ Your system has been setup successfully! Please reboot."
