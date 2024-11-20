#!/bin/bash

echo "Installing developer tools..."

# Check if running on macOS
if [[ "$OSTYPE" == "darwin"* ]]; then
    # Install Homebrew if not installed
    if ! command -v brew &> /dev/null; then
        echo "Installing Homebrew..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    fi

    # Install developer tools using Homebrew
    brew install git
    brew install wget
    brew install curl
    brew install tree
    brew install spaceship
    brew install mongosh
    brew install withgraphite/tap/graphite # TODO: Find out if it's useful
    
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash

else
    echo "Unsupported operating system"
    exit 1
fi

echo "Developer tools installation complete!"

echo "Repository setup complete!"