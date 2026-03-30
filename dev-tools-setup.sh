#!/bin/bash

echo "Installing developer tools..."

if [[ "$OSTYPE" != "darwin"* ]]; then
    echo "Unsupported operating system"
    exit 1
fi

# Install Homebrew if not installed
if ! command -v brew &> /dev/null; then
    echo "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

brew update

# Install tools and personal apps from Brewfile
echo "Installing packages from Brewfile..."
brew bundle --file=Brewfile

# Prompt for work apps
read -p "Do you want to install work applications? (y/n): " install_work
if [[ $install_work =~ ^[Yy]$ ]]; then
    echo "Installing work applications..."
    brew bundle --file=Brewfile.work
else
    echo "Skipping work applications."
fi

# Install nvm
if [ ! -d "$HOME/.nvm" ]; then
    echo "Installing nvm..."
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash
else
    echo "nvm already installed"
fi

# Install TPM (Tmux Plugin Manager)
if [ ! -d "$HOME/.tmux/plugins/tpm" ]; then
    echo "Installing TPM..."
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
else
    echo "TPM already installed"
fi

# Auto-install tmux plugins (opensessions, etc.)
if [ -x "$HOME/.tmux/plugins/tpm/bin/install_plugins" ]; then
    echo "Installing tmux plugins..."
    "$HOME/.tmux/plugins/tpm/bin/install_plugins"
fi

echo "Setup complete!"
