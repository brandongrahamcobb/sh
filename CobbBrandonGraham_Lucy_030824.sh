#!/bin/bash

# Define the project directory
PROJECT_DIR="$HOME/Downloads/my_discord_bot"

# Check if the setup has already been run
if [ -d "$PROJECT_DIR/venv" ]; then
    echo "Setup already completed. Running the bot..."
    python "$PROJECT_DIR/main.py"
    exit 0
fi

# Create project directory if it doesn't exist
mkdir -p "$PROJECT_DIR"
cd "$PROJECT_DIR"

# Create a virtual environment
python3 -m venv venv

# Upgrade pip
source venv/bin/activate
pip install --upgrade pip

# Install requirements
pip install requests rdkit pubchempy pillow

# Reorganize the project
# Move files as required (customize these lines based on your project structure)
# mv my_cog.py py/
# mv game_cog.py py/

# Run the bot
python main.py
