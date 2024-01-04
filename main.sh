#!/bin/bash

# Receive Cinema 4D path, project file path, and output folder name as arguments
cinema4DPath="$1"
projectFilePath="$2"
outputFolderName="$3"

# Define the path to the Textures folder
textures_folder="./Textures"

# Determine the project directory
projectDir=$(dirname "$projectFilePath")

# Set the output base folder to be in the project directory with the user-defined name
output_base_folder="$projectDir/$outputFolderName"

# Loop through each .png file in the Textures folder
for texture_file in "$textures_folder"/*.png; do
    base_name=$(basename "$texture_file" .png)
    cp "$texture_file" currentText.png

    # Create the output folder structure in the project directory
    mkdir -p "$output_base_folder/$base_name"

    # Use the arguments for Cinema 4D path and project file path
    "$cinema4DPath/Contents/MacOS/CINEMA 4D" -nogui -render "$projectFilePath" -frame 0 1 1 -oimage "$output_base_folder/$base_name/frame_####.png" -oformat PNG
done

# Restore the original currentText.png if necessary
# cp path/to/original/currentText.png currentText.png
