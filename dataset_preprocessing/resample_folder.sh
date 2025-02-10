#!/bin/bash

# Check for the correct number of arguments
if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <input_directory> <output_directory>"
    exit 1
fi

# Assign input and output directories to variables
input_dir="$1"
output_dir="$2"

# Check if the input directory exists
if [ ! -d "$input_dir" ]; then
    echo "Error: Input directory '$input_dir' does not exist."
    exit 1
fi

# Create the output directory if it doesn't exist
if [ ! -d "$output_dir" ]; then
    echo "Output directory '$output_dir' does not exist. Creating it..."
    mkdir -p "$output_dir"
fi

# Resample each WAV file in the input directory
for wav_file in "$input_dir"/*; do
    # Get the filename without the directory part
    filename=$(basename "$wav_file")

    # Define the output file path
    output_file="$output_dir/$filename"

    # Resample the WAV file (default resample to 44100 Hz)
    echo "Resampling $wav_file to $output_file..."
    sox "$wav_file" -r 22050 "$output_file"

    if [ $? -eq 0 ]; then
        echo "Successfully resampled: $filename"
    else
        echo "Error resampling: $filename"
    fi
done

echo "Resampling complete."
