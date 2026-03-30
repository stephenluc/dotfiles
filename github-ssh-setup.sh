#!/bin/bash

echo "GitHub SSH Key Setup"
echo "--------------------"

KEY_PATH="$HOME/.ssh/github_ed25519"

# Check if key already exists
if [ -f "$KEY_PATH" ]; then
    echo "SSH key already exists at $KEY_PATH"
    read -p "Skip key generation and just ensure it's on GitHub? (y/n): " skip_gen
    if [[ ! $skip_gen =~ ^[Yy]$ ]]; then
        echo "Exiting to avoid overwriting existing key."
        exit 0
    fi
fi

# Generate SSH key if it doesn't exist
if [ ! -f "$KEY_PATH" ]; then
    read -p "Enter your GitHub email address: " github_email
    ssh-keygen -t ed25519 -C "$github_email" -f "$KEY_PATH"
fi

# Start ssh-agent and add key
if [ -z "$SSH_AUTH_SOCK" ]; then
    eval "$(ssh-agent -s)"
fi
ssh-add --apple-use-keychain "$KEY_PATH"

# Configure SSH for GitHub specifically
SSH_CONFIG="$HOME/.ssh/config"
SSH_CONFIG_CONTENT="
Host github.com
  AddKeysToAgent yes
  UseKeychain yes
  IdentityFile $KEY_PATH"

if [ ! -f "$SSH_CONFIG" ]; then
    echo "$SSH_CONFIG_CONTENT" > "$SSH_CONFIG"
    chmod 600 "$SSH_CONFIG"
    echo "Created SSH config"
elif ! grep -q "github_ed25519" "$SSH_CONFIG"; then
    echo "$SSH_CONFIG_CONTENT" >> "$SSH_CONFIG"
    echo "Updated SSH config"
fi

# Upload key to GitHub via gh CLI
if command -v gh &> /dev/null; then
    # Authenticate if not already
    if ! gh auth status &> /dev/null; then
        echo "Authenticating with GitHub..."
        gh auth login -p ssh -w
    fi

    # Get a title for the key
    KEY_TITLE="$(hostname) $(date +%Y-%m-%d)"
    read -p "Key title [$KEY_TITLE]: " custom_title
    KEY_TITLE="${custom_title:-$KEY_TITLE}"

    echo "Uploading SSH key to GitHub..."
    gh ssh-key add "$KEY_PATH.pub" --title "$KEY_TITLE"

    # Test connection
    echo "Testing connection..."
    ssh -T git@github.com 2>&1
else
    # Fallback: manual instructions
    echo ""
    echo "gh CLI not found. Copying public key to clipboard for manual setup..."
    if [[ "$OSTYPE" == "darwin"* ]]; then
        pbcopy < "$KEY_PATH.pub"
    fi
    echo ""
    echo "Next steps:"
    echo "1. Go to https://github.com/settings/keys"
    echo "2. Click 'New SSH key'"
    echo "3. Paste the key (already in your clipboard)"
    echo "4. Click 'Add SSH key'"
fi

echo "Done!"
