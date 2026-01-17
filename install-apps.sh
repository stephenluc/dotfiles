#!/bin/bash

echo "Starting application installation..."

# Function to install an application
install_app() {
    if brew list --cask | grep -q "^$1\$"; then
        echo "✅ $1 is already installed"
    else
        echo "Installing $1..."
        if brew install --cask $1; then
            echo "✅ Successfully installed $1"
        else
            echo "❌ Failed to install $1"
        fi
    fi
}

# Rest of your arrays and code remains the same...
personal_apps=(
    "firefox"
    "flycut"
    "font-meslo-lg-nerd-font"
    "iterm2"
    "1password"
    "raycast"
    "rectangle"
    "spotify"
)

work_apps=(
    "cloudflare-warp"
    "cursor"
    "drata-agent"
    "linear-linear"
    "mongodb-compass" 
    "obsidian"
    "postman"
    "slack"
    "tandem"
    "zoom"
)

# Check if Homebrew is installed
if ! command -v brew &> /dev/null; then
    echo "Homebrew is not installed. Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# Update Homebrew
echo "Updating Homebrew..."
brew update

# Install personal apps
echo "📱 Installing personal applications..."
for app in "${personal_apps[@]}"; do
    install_app "$app"
done

# Prompt for work apps installation
read -p "Do you want to install work applications? (y/n): " install_work_apps

if [[ $install_work_apps =~ ^[Yy]$ ]]; then
    echo "💼 Installing work applications..."
    for app in "${work_apps[@]}"; do
        install_app "$app"
    done
else
    echo "Skipping work applications installation."
fi

echo "Installation complete! 🎉"
