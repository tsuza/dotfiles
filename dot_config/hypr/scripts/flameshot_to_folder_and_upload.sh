#!/bin/bash

# Set the base directory for screenshots
BASE_DIR="$HOME/Pictures/Screenshots"

# Get current year and month in format YYYY-MM
FOLDER_NAME=$(date "+%Y-%m")
TARGET_DIR="$BASE_DIR/$FOLDER_NAME"

# Create the directory if it doesn't exist
mkdir -p "$TARGET_DIR"

# Generate filename with date and time
FILENAME="screenshot_$(date '+%Y-%m-%d_%H-%M-%S').png"

# Full path to save the screenshot
FILEPATH="$TARGET_DIR/$FILENAME"

# Run flameshot in GUI mode and save to the path
XDG_CURRENT_DESKTOP=sway flameshot gui -u -p "$FILEPATH"

