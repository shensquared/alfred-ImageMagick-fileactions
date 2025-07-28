# Alfred ImageMagick File Actions

<div align="center">
  <img src="icon.png" alt="Alfred ImageMagick Workflow" width="200">
</div>

An Alfred workflow for quick image manipulation using ImageMagick. This workflow provides file actions to crop whitespace and create square images from your image files.

## Requirements

- **[Alfred 4+](https://www.alfredapp.com/)** with Powerpack
- **[ImageMagick](https://imagemagick.org/)** (must be installed and accessible via command line)

### Installing ImageMagick

#### macOS (using Homebrew)
```bash
brew install imagemagick
```

#### macOS (using MacPorts)
```bash
sudo port install ImageMagick
```

#### Manual Installation
Download from [ImageMagick's official website](https://imagemagick.org/script/download.php#macosx)

## Installation

1. Download the workflow file (`.alfredworkflow`)
2. Double-click to install in Alfred
3. Ensure ImageMagick is installed and accessible via `magick` command

## Features

### Crop Whitespace
- Removes surrounding whitespace from images
- Uses 5% fuzz factor for intelligent edge detection
- Preserves original aspect ratio

### Crop Whitespace + Square
- First crops whitespace from the image
- Then pads the image to a perfect square
- Uses white background for padding
- Centers the image content

## Usage

1. **Select an image file** in Finder
2. **Right-click** and choose "Services" → "Make Tight"
3. **Choose your action**:
   - **Crop Whitespace**: Removes surrounding whitespace
   - **Crop Whitespace + Square**: Removes whitespace and makes it square

## Supported File Types

- PNG
- JPEG/JPG
- GIF
- TIFF
- HEIC
- SVG

## Configuration

The workflow includes several configurable options:

- **Target Folder**: Specify where to save processed images (defaults to source location)
- **Image Suffix**: Add a suffix to processed image filenames
- **Open/Reveal**: Choose what happens after processing (open, reveal, both, or nothing)

## How It Works

The workflow uses ImageMagick's `magick` command with the following operations:

- **Trim**: Removes surrounding whitespace using fuzz factor
- **Extent**: Pads images to square dimensions
- **Gravity**: Centers content when padding

## Troubleshooting

### ImageMagick Not Found
If you get an error about ImageMagick not being found:

1. Verify ImageMagick is installed: `magick --version`
2. Ensure it's in your PATH
3. Restart Alfred after installing ImageMagick

### Permission Issues
If you encounter permission issues:

1. Grant Alfred full disk access in System Preferences → Security & Privacy → Privacy → Full Disk Access
2. Ensure the target folder is writable

## Development

This workflow is built using Alfred's workflow editor and includes:

- File action trigger for image files
- List filter for action selection
- External bash script (`tight-square.sh`) for ImageMagick operations
- Argument utility for file path handling

### Standalone Script Usage

The `tight-square.sh` script can be used independently of Alfred:

```bash
# Make the script executable (if not already)
chmod +x tight-square.sh

# Crop whitespace from an image
./tight-square.sh crop /path/to/image.png

# Crop whitespace and make square
./tight-square.sh crop_square /path/to/image.png
```

The script includes proper error handling and validation for:
- Missing arguments
- Invalid file paths
- ImageMagick availability
- Invalid action types

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## Version

Current version: 0.8

---

**Created by:** Shen Shen  
**GitHub:** [shensquared/alfred-ImageMagick-actions](https://github.com/shensquared/alfred-ImageMagick-actions)

## Credits

Inspired by [@Acidham/alfred-image-shrinker](https://github.com/Acidham/alfred-image-shrinker) - an excellent Alfred workflow for image optimization and resizing. 