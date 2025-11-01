#!/usr/bin/env bash

set -euo pipefail  # safer bash options
shopt -s nullglob  # makes *.sh expand to nothing if no match (instead of literal string)

MIGRATIONS_DIR="./migrations"
STATE_DIR="$HOME/.local/state/maxos/migrations"
SCRIPTS=("$MIGRATIONS_DIR"/*.sh)

echo "------------------------------------------"
echo "Installing Updates"
echo "------------------------------------------"
sudo sudo pacman -Syu --noconfirm

echo "------------------------------------------"
echo "Running migrations"
echo "------------------------------------------"

# Loop through each script and execute it
for script in "${SCRIPTS[@]}"; do
  script_name=$(basename "$script")
  state_file="$STATE_DIR/$script_name"

  if [[ -e "$state_file" ]]; then
    echo "⏩ Skipping $script_name as it was already applied"
    continue
  fi

  bash "$script"
  echo "✅ Applied $script_name"

  # mark the script as applied
  touch "$state_file"
done

stow -v -d ./dotfiles -t ~ */
echo "✅ Updated dotfiles"

echo "All migrations executed successfully! Please reboot your system."
