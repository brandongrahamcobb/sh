#!/bin/bash

# Get the directory of the script
script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
project_root="$script_dir/Lucy"

# Set source and destination directories
src_bat="/home/spawd/Documents/bat/CobbBrandonGraham_Lucy_030824.bat"
dest_bat="$project_root/launch.bat"

src_md="/home/spawd/Documents/md/CobbBrandonGraham_README_030824.md"
dest_md="$project_root/README"

src_license="/home/spawd/Documents/txt/GNU_LICENSE_030824.txt"
dest_license="$project_root/LICENSE"

src_requirements="/home/spawd/Documents/txt/CobbBrandonGraham_requirements_030824.txt"
dest_requirements="$project_root/requirements.txt"

src_png="/home/spawd/Documents/png/*.png"
dest_png="$project_root/resources/"

src_sh="/home/spawd/Documents/sh/CobbBrandonGraham_Lucy_030824.sh"
dest_sh="$project_root/launch.sh"

# Python files
src_py_init="/home/spawd/Documents/py/bot/CobbBrandonGraham__init__030824.py"
dest_py_init="$project_root/bot/__init__.py"

src_py_cogs_init="/home/spawd/Documents/py/bot/cogs/CobbBrandonGraham__init__030824.py"
dest_py_cogs_init="$project_root/bot/cogs/__init__.py"

src_py_utils_init="/home/spawd/Documents/py/bot/utils/CobbBrandonGraham__init__030824.py"
dest_py_utils_init="$project_root/bot/utils/__init__.py"

src_py_main="/home/spawd/Documents/py/bot/CobbBrandonGraham_main_030824.py"
dest_py_main="$project_root/bot/main.py"

src_py_my_cog="/home/spawd/Documents/py/bot/cogs/CobbBrandonGraham_my_cog_030824.py"
dest_py_my_cog="$project_root/bot/cogs/my_cog.py"

src_py_game_cog="/home/spawd/Documents/py/bot/cogs/CobbBrandonGraham_game_cog_030824.py"
dest_py_game_cog="$project_root/bot/cogs/game_cog.py"

src_py_helpers="/home/spawd/Documents/py/bot/utils/CobbBrandonGraham_helpers_030824.py"
dest_py_helpers="$project_root/bot/utils/helpers.py"

# Create destination directories if they do not exist
mkdir -p "$(dirname "$dest_bat")"
mkdir -p "$(dirname "$dest_md")"
mkdir -p "$(dirname "$dest_license")"
mkdir -p "$(dirname "$dest_requirements")"
mkdir -p "$dest_png"
mkdir -p "$(dirname "$dest_sh")"
mkdir -p "$(dirname "$dest_py_init")"
mkdir -p "$(dirname "$dest_py_cogs_init")"
mkdir -p "$(dirname "$dest_py_utils_init")"
mkdir -p "$(dirname "$dest_py_main")"
mkdir -p "$(dirname "$dest_py_my_cog")"
mkdir -p "$(dirname "$dest_py_game_cog")"
mkdir -p "$(dirname "$dest_py_helpers")"

# Copy files
cp "$src_bat" "$dest_bat"
cp "$src_md" "$dest_md"
cp "$src_license" "$dest_license"
cp "$src_requirements" "$dest_requirements"
cp $src_png "$dest_png"
cp "$src_sh" "$dest_sh"

# Copy Python files
cp "$src_py_init" "$dest_py_init"
cp "$src_py_cogs_init" "$dest_py_cogs_init"
cp "$src_py_utils_init" "$dest_py_utils_init"
cp "$src_py_main" "$dest_py_main"
cp "$src_py_my_cog" "$dest_py_my_cog"
cp "$src_py_game_cog" "$dest_py_game_cog"
cp "$src_py_helpers" "$dest_py_helpers"

# Verify and output the results
verify_copy() {
    if [ -f "$2" ]; then
        echo "Copied $1 to $2"
    else
        echo "Failed to copy $1"
    fi
}

verify_copy "$src_bat" "$dest_bat"
verify_copy "$src_md" "$dest_md"
verify_copy "$src_license" "$dest_license"
verify_copy "$src_requirements" "$dest_requirements"
if [ "$(ls -A "$dest_png")" ]; then
    echo "Copied $src_png to $dest_png"
else
    echo "Failed to copy $src_png"
fi
verify_copy "$src_sh" "$dest_sh"

verify_copy "$src_py_init" "$dest_py_init"
verify_copy "$src_py_cogs_init" "$dest_py_cogs_init"
verify_copy "$src_py_utils_init" "$dest_py_utils_init"
verify_copy "$src_py_main" "$dest_py_main"
verify_copy "$src_py_my_cog" "$dest_py_my_cog"
verify_copy "$src_py_game_cog" "$dest_py_game_cog"
verify_copy "$src_py_helpers" "$dest_py_helpers"

# Zip the project root directory
(cd "$script_dir" && zip -r CobbBrandonGraham_Lucy_030824.zip Lucy)

echo "Project has been zipped into CobbBrandonGraham_Lucy_030824.zip"
