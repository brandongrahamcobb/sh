#!/bin/bash

CONFIG_PATH="config.json"

# Function to prompt for input with a default value
prompt_for_values() {
    local prompt_message=$1
    local default_value=$2
    local input_value

    read -p "$prompt_message [$default_value]: " input_value
    echo "${input_value:-$default_value}"
}

# Function to update the config.json file
update_config() {
    local token=$1
    local google_json_key=$2
    local bible_key=$3
    local user_agent=$4

    if [ -f "$CONFIG_PATH" ]; then
        jq --arg token "$token" \
           --arg google_json_key "$google_json_key" \
           --arg bible_key "$bible_key" \
           --arg user_agent "$user_agent" \
           '.token = $token | .google_json_key = $google_json_key | .bible_key = $bible_key | .user_agent = $user_agent' \
           "$CONFIG_PATH" > temp_config.json && mv temp_config.json "$CONFIG_PATH"
    else
        jq -n --arg token "$token" \
              --arg google_json_key "$google_json_key" \
              --arg bible_key "$bible_key" \
              --arg user_agent "$user_agent" \
              '{token: $token, google_json_key: $google_json_key, bible_key: $bible_key, user_agent: $user_agent}' > "$CONFIG_PATH"
    fi
}

# Function to check for updates to the configuration file
check_for_updates() {
    local config_path="config.json"

    if [ -f "$config_path" ]; then
        current_token=$(jq -r '.token' "$config_path")
        current_google_json_key=$(jq -r '.google_json_key' "$config_path")
        current_bible_key=$(jq -r '.bible_key' "$config_path")
        current_user_agent=$(jq -r '.user_agent' "$config_path")

        TOKEN=$(prompt_for_values "Enter the bot token" "$current_token")
        GOOGLE_JSON_KEY=$(prompt_for_values "Enter the Google JSON API key" "$current_google_json_key")
        BIBLE_KEY=$(prompt_for_values "Enter the Bible API key" "$current_bible_key")
        USER_AGENT=$(prompt_for_values "Enter the User-Agent header" "$current_user_agent")
    else
        TOKEN=$(prompt_for_values "Enter the bot token" "")
        GOOGLE_JSON_KEY=$(prompt_for_values "Enter the Google JSON API key" "")
        BIBLE_KEY=$(prompt_for_values "Enter the Bible API key" "")
        USER_AGENT=$(prompt_for_values "Enter the User-Agent header" "MyBot/1.0")
    fi
}

# Function to increment the version number in version.txt
increment_version() {
    local version_file="version.txt"

    if [ ! -f "$version_file" ]; then
        echo "1.0.0" > "$version_file"
    fi

    current_version=$(cat "$version_file")
    IFS='.' read -r major minor patch <<< "$current_version"

    patch=$((patch + 1))

    if [ "$patch" -ge 10 ]; then
        patch=0
        minor=$((minor + 1))
    fi

    if [ "$minor" -ge 10 ]; then
        minor=0
        major=$((major + 1))
    fi

    new_version="$major.$minor.$patch"
    echo "$new_version" > "$version_file"
}

# Check for updates and update the config.json file
check_for_updates

# Update the config.json file with the new values
update_config "$TOKEN" "$GOOGLE_JSON_KEY" "$BIBLE_KEY" "$USER_AGENT"

# Increment the version number
increment_version

# Run the bot
python3 bot/main.py
