#!/bin/bash

# Alfred ImageMagick File Actions - Remove White Background Script
# This script removes white backgrounds and saves as tight PNG with transparency
# Usage: ./remove-white-bg.sh <file_path>

set -e  # Exit on any error

# === Arguments ===
file="$1"              # path to the selected file

# === Helper: Copy image to clipboard ===
copy_to_clipboard() {
    local image_path="$1"
    
    if [[ -f "$image_path" ]]; then
        # Use AppleScript to copy image to clipboard
        osascript -e "
        set the clipboard to (read (POSIX file \"$image_path\") as JPEG picture)
        " 2>/dev/null || {
            # Fallback: try to copy as file reference
            osascript -e "
            set the clipboard to POSIX file \"$image_path\"
            " 2>/dev/null || {
                echo "Warning: Could not copy image to clipboard" >&2
                return 1
            }
        }
        echo "Image copied to clipboard: $image_path" >&2
        return 0
    else
        echo "Error: Image file not found: $image_path" >&2
        return 1
    fi
}

# === Helper: Remove white background and save as tight PNG ===
remove_white_background() {
    local input="$1"
    local fuzz="${2:-10}"  # Default fuzz value of 10%

    if [[ -z "$input" || ! -f "$input" ]]; then
        echo "Error: Invalid input file" >&2
        return 1
    fi

    local input_dir
    local input_filename
    local input_name

    input_dir=$(dirname "$input")
    input_filename=$(basename "$input")
    input_name="${input_filename%.*}"

    # Output will always be PNG with transparency
    local output="${input_dir}/${input_name}_no_bg.png"

    # Remove white background and trim to tight bounds
    magick "$input" \
        -fuzz "${fuzz}%" \
        -transparent white \
        -trim \
        +repage \
        -background transparent \
        "$output"

    echo "$output"
}

# === Input validation ===
if [[ -z "$file" ]]; then
    echo "Error: No file path specified" >&2
    echo "Usage: $0 <file_path>" >&2
    exit 1
fi

if [[ ! -f "$file" ]]; then
    echo "Error: File does not exist: $file" >&2
    exit 1
fi

# Check if ImageMagick is available
if ! command -v magick &> /dev/null; then
    echo "Error: ImageMagick is not installed or not in PATH" >&2
    echo "Install with: brew install imagemagick" >&2
    exit 1
fi

# === Main logic ===
result_path=$(remove_white_background "$file" 10)

# Copy the resulting image to clipboard
if [[ -n "$result_path" ]]; then
    copy_to_clipboard "$result_path" >&2  # Send clipboard message to stderr
    printf "%s" "$result_path"  # Output file path without newline
else
    echo "Error: No result path generated" >&2
    exit 1
fi 