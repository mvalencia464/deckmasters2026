---
description: Convert images to WebP format for better performance
---

# WebP Image Conversion Workflow

This workflow explains how to convert images to WebP format for optimal web performance.

## Why WebP?

- **74-82% smaller** file sizes compared to PNG
- **Faster page loads** and better SEO
- **Better Core Web Vitals** scores
- **95%+ browser support**

## Quick Conversion

### Single Image
```bash
./scripts/convert-to-webp.sh path/to/image.png
```

### Custom Quality (default is 85)
```bash
./scripts/convert-to-webp.sh path/to/image.png 90
```

## Manual Conversion

If you prefer to convert manually:

```bash
# Convert PNG to WebP
cwebp -q 85 input.png -o output.webp

# Convert JPG to WebP
cwebp -q 85 input.jpg -o output.webp
```

## For AI-Generated Images

When generating images for the site:

1. **Generate the image** (using AI tools or design software)
2. **Save as PNG** initially (for quality)
3. **Convert to WebP** using the script:
   ```bash
   ./scripts/convert-to-webp.sh public/images/your-image.png
   ```
4. **Update code** to reference `.webp` instead of `.png`
5. **Delete the PNG** (optional, to save space)

## Batch Conversion

To convert all PNG images in a directory:

```bash
for file in public/images/*.png; do
  ./scripts/convert-to-webp.sh "$file"
done
```

## Quality Guidelines

- **85** - Default, good balance (recommended)
- **90-95** - Higher quality for hero images
- **75-80** - Smaller files for thumbnails

## Example: Deck Installation Images

Recent conversion results:
- Thumbnail: 988KB → 250KB (74% reduction)
- 24-hour image: 793KB → 146KB (82% reduction)

## Troubleshooting

If `cwebp` is not installed:
```bash
brew install webp
```
