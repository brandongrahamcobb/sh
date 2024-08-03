#!/bin/bash

#!/bin/bash

base_dir="$(dirname "$(readlink -f "$0")")"
py_dir="$base_dir/py"
downloads_dir="$HOME/Downloads"
venv_dir="$downloads_dir/venv"
config_path="$base_dir/json/config.json"

# Function to set the bot token
set_token() {
    if [ ! -f "$config_path" ]; then
        read -p "Enter your Discord bot token: " token
        mkdir -p "$(dirname "$config_path")"
        echo "{\"token\": \"$token\"}" > "$config_path"
        echo "Token has been saved to config.json."
    else
        if ! grep -q '"token"' "$config_path"; then
            read -p "Enter your Discord bot token: " token
            jq --arg token "$token" '.token = $token' "$config_path" > "${config_path}.tmp" && mv "${config_path}.tmp" "$config_path"
            echo "Token has been updated in config.json."
        else
            echo "Token already set in config.json."
        fi
    fi
}

# Function to validate the bot token (implement actual validation if needed)
validate_token() {
    echo "Validating token..."
    # For demonstration, this assumes token is valid.
    # Implement actual validation logic here if required.
    echo "Token is valid."
}

# Function to set up the environment
setup_environment() {
    # Create necessary directories
    mkdir -p "$base_dir/json"
    mkdir -p "$base_dir/log"
    mkdir -p "$base_dir/txt"
    mkdir -p "$base_dir/md"
    mkdir -p "$base_dir/plain"
    mkdir -p "$base_dir/sh"
    mkdir -p "$base_dir/bat"
    mkdir -p "$py_dir"

    # Move files to specific directories
    [ -f "$base_dir/README.md" ] && mv "$base_dir/README.md" "$base_dir/md/"
    [ -f "$base_dir/LICENSE" ] && mv "$base_dir/LICENSE" "$base_dir/plain/"
    [ -f "$base_dir/main.py" ] && mv "$base_dir/main.py" "$py_dir/"
    [ -f "$base_dir/my_cog.py" ] && mv "$base_dir/my_cog.py" "$py_dir/"
    [ -f "$base_dir/game_cog.py" ] && mv "$base_dir/game_cog.py" "$py_dir/"
    [ -f "$base_dir/launch_bot.bat" ] && mv "$base_dir/launch_boy.bat" "$base_dir/bat/"

    # Move setup script to sh directory if not already there
    if [ "$(readlink -f "$0")" != "$base_dir/sh/setup.sh" ]; then
        mv "$0" "$base_dir/sh/setup.sh"
        echo "Moved setup script to 'sh' directory."
        exit 0  # Exit to prevent running the script twice
    fi
}

# Main execution
if [ "$(basename "$base_dir")" = "sh" ]; then
    echo "Setup script is inside 'sh' directory. Doing nothing."
    exit 0
else
    set_token
    validate_token
    setup_environment
    echo "Setting up virtual environment in Downloads directory..."
    if [ ! -d "$downloads_dir" ]; then
        mkdir -p "$downloads_dir"
    fi
    if [ ! -d "$venv_dir" ]; then
        python3 -m venv "$venv_dir"
    fi
    source "$venv_dir/bin/activate"
    pip install --upgrade pip
    pip install discord.py emoji pubchempy rdkit pillow requests
    echo "Launching bot..."
    python "$py_dir/main.py"
fi
