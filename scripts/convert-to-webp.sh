#!/bin/bash

# WebP Image Conversion Script
# Automatically converts PNG/JPG images to WebP format
# Usage: ./scripts/convert-to-webp.sh <input-file> [quality]

set -e

# Default quality setting (85 is a good balance of size/quality)
QUALITY=${2:-85}

# Check if cwebp is installed
if ! command -v cwebp &> /dev/null; then
    echo "Error: cwebp is not installed"
    echo "Install with: brew install webp"
    exit 1
fi

# Check if input file is provided
if [ -z "$1" ]; then
    echo "Usage: $0 <input-file> [quality]"
    echo "Example: $0 image.png 85"
    exit 1
fi

INPUT_FILE="$1"

# Check if file exists
if [ ! -f "$INPUT_FILE" ]; then
    echo "Error: File '$INPUT_FILE' not found"
    exit 1
fi

# Get file extension and base name
EXTENSION="${INPUT_FILE##*.}"
BASENAME="${INPUT_FILE%.*}"
OUTPUT_FILE="${BASENAME}.webp"

# Convert to WebP
echo "Converting $INPUT_FILE to WebP format..."
echo "Quality: $QUALITY"

cwebp -q "$QUALITY" "$INPUT_FILE" -o "$OUTPUT_FILE"

# Show file sizes
ORIGINAL_SIZE=$(ls -lh "$INPUT_FILE" | awk '{print $5}')
WEBP_SIZE=$(ls -lh "$OUTPUT_FILE" | awk '{print $5}')

echo ""
echo "✅ Conversion complete!"
echo "Original: $ORIGINAL_SIZE ($INPUT_FILE)"
echo "WebP:     $WEBP_SIZE ($OUTPUT_FILE)"
echo ""

# Calculate savings
ORIGINAL_BYTES=$(stat -f%z "$INPUT_FILE")
WEBP_BYTES=$(stat -f%z "$OUTPUT_FILE")
SAVINGS=$((100 - (WEBP_BYTES * 100 / ORIGINAL_BYTES)))

echo "💾 File size reduction: ${SAVINGS}%"
