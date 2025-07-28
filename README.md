# Alfred ImageMagick File Actions

<div align="center">
  <img src="icon.png" alt="Alfred ImageMagick Workflow" width="300">
</div>

An Alfred workflow for quick image manipulation using ImageMagick. Crop whitespace, create square images, and remove white backgrounds from your image files.

## Requirements

- **[Alfred 4+](https://www.alfredapp.com/)** with Powerpack (required for List Filter functionality)
- **[ImageMagick](https://imagemagick.org/)** - Install with `brew install imagemagick`

> **Note:** Without Powerpack, you can use the standalone scripts directly (see Development section).

## Installation

1. Download the `.alfredworkflow` file
2. Double-click to install in Alfred
3. Ensure ImageMagick is accessible via `magick` command

## Features

### 🎯 Make TightLayout
- **Crop Whitespace**: Removes surrounding whitespace (5% fuzz factor)
- **Crop Whitespace + Square**: Crops whitespace then pads to perfect square

### 🎨 Remove Background
- Removes white backgrounds and converts to transparent PNG
- Uses 10% fuzz factor for intelligent detection
- Trims to tight bounds around the subject

**All operations automatically copy results to clipboard.**

## Usage

1. **Select an image file** in Finder
2. **Right-click** and choose from Services:
   - **"Make TightLayout"** → Choose crop or crop+square
   - **"Remove Background"** → Remove white background

## Supported Formats

PNG, JPEG, GIF, TIFF, HEIC, SVG

## Configuration

- **Target Folder**: Where to save processed images (defaults to source location)
- **Image Suffix**: Add suffix to processed filenames
- **Open/Reveal**: Choose post-processing action (open, reveal, both, ask, or nothing)

## Output Files

- **TightLayout**: Creates `_cropped` and `_squared` variants
- **Background Removal**: Creates `_no_bg.png` with transparency

## Troubleshooting

### ImageMagick Not Found
```bash
brew install imagemagick
magick --version  # Verify installation
```

### Permission Issues
- Grant Alfred full disk access in System Preferences
- Ensure target folder is writable

## Development

### Standalone Script Usage

```bash
chmod +x tight-square.sh remove-white-bg.sh

# Crop whitespace
./tight-square.sh crop /path/to/image.png

# Crop and make square
./tight-square.sh crop_square /path/to/image.png

# Remove background
./remove-white-bg.sh /path/to/image.png
```

## License

MIT License - see [LICENSE](LICENSE) file.

## Version

Current version: 0.9

---


## Credits

Inspired by [@Acidham/alfred-image-shrinker](https://github.com/Acidham/alfred-image-shrinker) - an excellent Alfred workflow for image optimization and resizing. 