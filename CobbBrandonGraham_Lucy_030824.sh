#!/bin/bash

base_dir="$(dirname "$(readlink -f "$0")")"
bot_dir="$base_dir/bot"
venv_dir="$HOME/Downloads/venv"
requirements_file="$base_dir/requirements.txt"
config_path="$base_dir/config.json"

# Function to set the bot token
set_token() {
    if [ ! -f "$config_path" ]; then
        read -p "Enter your Discord bot token: " token
        mkdir -p "$config_dir"
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

# Check if the script is already in the right directory
if [ "$(basename "$base_dir")" = "sh" ]; then
    echo "Setup script is inside 'sh' directory. Doing nothing."
    exit 0
fi

# Set up the virtual environment
echo "Setting up virtual environment in Downloads directory..."
if [ ! -d "$venv_dir" ]; then
    python3 -m venv "$venv_dir"
fi
source "$venv_dir/bin/activate"
pip install --upgrade pip
pip install -r "$requirements_file"

# Set the bot token
set_token

# Launch the bot
echo "Launching bot..."
python "$bot_dir/main.py"
