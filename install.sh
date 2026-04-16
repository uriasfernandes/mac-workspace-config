#!/bin/bash

REPO_DIR="$(cd "$(dirname "$0")" && pwd)"

echo "Installing Hammerspoon config..."

if [ -d "$HOME/.hammerspoon" ]; then
    echo "Backing up existing ~/.hammerspoon"
    mv "$HOME/.hammerspoon" "$HOME/.hammerspoon.backup.$(date +%s)"
fi

ln -s "$REPO_DIR/hammerspoon" "$HOME/.hammerspoon"

echo "Done!"
echo "Reload Hammerspoon config."
