#!/bin/bash

WIDTH="$1"
HEIGHT="$2"
HALF_RES="$3"

SRC="$ANDROID_BUILD_TOP/vendor/mk/bootanimation"
OUT="$ANDROID_PRODUCT_OUT/obj/BOOTANIMATION"

if [ "$HEIGHT" -lt "$WIDTH" ]; then
    WIDTH_SIZE="$HEIGHT"
    HEIGHT_SIZE="$WIDTH"
else
    WIDTH_SIZE="$WIDTH"
    HEIGHT_SIZE="$HEIGHT"
fi

if [ "$HALF_RES" = "true" ]; then
    IMAGE_WIDTH_SIZE=$(expr $WIDTH_SIZE / 3)
    IMAGE_HEIGHT_SIZE=$(expr $HEIGHT_SIZE / 3)
else
    IMAGE_WIDTH_SIZE="$WIDTH_SIZE"
    IMAGE_HEIGHT_SIZE="$HEIGHT_SIZE"
fi

RESOLUTION=""$IMAGE_WIDTH_SIZE"x"$IMAGE_HEIGHT_SIZE""

# Create working dir
mkdir -p "$OUT/bootanimation"
cd "$OUT/bootanimation"

# Extract source frames
tar xfp "$SRC/bootanimation.tar"

# Resize
for frame in $OUT/bootanimation/part*/*
do
    convert "$frame" -resize "$RESOLUTION" "$frame"
done

# Create desc.txt
RESOLUTION=$(identify -ping -format '%w %h' $OUT/bootanimation/part0/$(ls $OUT/bootanimation/part0 | head -1))
echo "$RESOLUTION" 30 > "$OUT/bootanimation/desc.txt"
cat "$SRC/desc.txt" >> "$OUT/bootanimation/desc.txt"

# Create bootanimation.zip
zip -qr0 "$OUT/bootanimation.zip" .
