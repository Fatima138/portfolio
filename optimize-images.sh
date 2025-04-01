!/bin/bash

# Create WebP directory if it doesn't exist
mkdir -p images/webp

# Loop through JPG, JPEG, and PNG files using a find + while approach
find images/ -maxdepth 1 -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" \) | while read -r file; do
  filename=$(basename "$file")
  name="${filename%.*}"

  echo "Processing $file → images/webp/$name.webp"

  # Convert to WebP
  magick "$file" -resize "800x800>" -quality 80 -define webp:method=6 "images/webp/$name.webp"

  # Optimize original
  magick "$file" -resize "800x800>" -quality 80 "$file"
done

