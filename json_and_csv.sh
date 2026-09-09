#!/usr/bin/sh

# Variable for source folder
SOURCE_DIR="./source"

# Create destination folder
mkdir -p "$SOURCE_DIR"

# Creating a dummy files
touch "$SOURCE_DIR"/a.csv "$SOURCE_DIR"/c.csv "$SOURCE_DIR"/c.json "$SOURCE_DIR"/d.json

# Variable for Destination folder
DEST_DIR="./json_and_CSV"

# Create destination folder
mkdir -p "$DEST_DIR"

# Move all CSV and JSON files
mv "$SOURCE_DIR"/*.csv "$DEST_DIR/" 
mv "$SOURCE_DIR"/*.json "$DEST_DIR/"

echo "CSV and JSON files moved successfully to $DEST_DIR"