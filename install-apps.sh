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
    "arc"
    "flycut"
    "rectangle"
    "iterm2"
    "raycast"
    "keeper-password-manager"
    "messenger"
    "spotify"
)

work_apps=(
    "cursor"
    "slack"
    "mongodb-compass"
    "postman"
    "obsidian"
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

# Install work apps
echo "💼 Installing work applications..."
for app in "${work_apps[@]}"; do
    install_app "$app"
done

echo "Installation complete! 🎉"
