#!/bin/bash

# Alfred ImageMagick File Actions - Tight Square Script
# This script crops whitespace and optionally makes images square
# Usage: ./tight-square.sh <action> <file_path>
# Actions: crop, crop_square

set -e  # Exit on any error

# === Arguments ===
query="$1"             # crop or crop_square
file="$2"              # path to the selected file

# === Helper: Crop whitespace with ImageMagick ===
# Takes input path, output path (optional), fuzz %
crop_whitespace() {
    local input="$1"
    local output="$2"
    local fuzz="${3:-5}"

    if [[ -z "$input" || ! -f "$input" ]]; then
        echo "Error: Invalid input file" >&2
        return 1
    fi

    local input_dir
    local input_filename
    local input_name
    local input_ext

    input_dir=$(dirname "$input")
    input_filename=$(basename "$input")
    input_name="${input_filename%.*}"
    input_ext="${input_filename##*.}"

    if [[ -z "$output" ]]; then
        output="${input_dir}/${input_name}_cropped.${input_ext}"
    fi

    magick "$input" -fuzz "${fuzz}%" -trim +repage "$output"
    echo "$output"
}

# === Input validation ===
if [[ -z "$query" ]]; then
    echo "Error: No action specified. Use 'crop' or 'crop_square'" >&2
    echo "Usage: $0 <action> <file_path>" >&2
    exit 1
fi

if [[ -z "$file" ]]; then
    echo "Error: No file path specified" >&2
    echo "Usage: $0 <action> <file_path>" >&2
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
if [[ "$query" == "crop_square" ]]; then
    # Step 1: Crop whitespace
    cropped_path=$(crop_whitespace "$file" "" 5)

    # Step 2: Pad to square
    if [[ -n "$cropped_path" && -f "$cropped_path" ]]; then
        dimensions=$(magick "$cropped_path" -format '%wx%h' info:)
        width=$(echo "$dimensions" | cut -d'x' -f1)
        height=$(echo "$dimensions" | cut -d'x' -f2)

        if (( width > height )); then
            square_size=$width
        else
            square_size=$height
        fi

        input_dir=$(dirname "$cropped_path")
        input_filename=$(basename "$cropped_path")
        name_without_ext="${input_filename%.*}"
        ext="${input_filename##*.}"
        squared_path="${input_dir}/${name_without_ext}_squared.${ext}"

        magick "$cropped_path" \
            -background white \
            -gravity center \
            -extent "${square_size}x${square_size}" \
            "$squared_path"

        echo "$squared_path"
    else
        echo "$file"
    fi
elif [[ "$query" == "crop" ]]; then
    # Just crop whitespace
    crop_whitespace "$file" "" 5
else
    echo "Error: Invalid action '$query'. Use 'crop' or 'crop_square'" >&2
    exit 1
fi 