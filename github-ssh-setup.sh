#!/bin/bash

echo "🔑 GitHub SSH Key Setup Script"
echo "-----------------------------"

# Prompt for organization info
read -p "Are you setting this up for a GitHub organization with SAML SSO? (y/n) " -n 1 -r
echo
HAS_SSO=$REPLY

if [[ $HAS_SSO =~ ^[Yy]$ ]]; then
    read -p "Enter your organization name (e.g., 'your-org-name'): " org_name
fi

# Check if ssh-keygen is installed
if ! command -v ssh-keygen &> /dev/null; then
    echo "❌ ssh-keygen is not installed. Please install OpenSSH first."
    exit 1
fi

# Generate SSH key
echo "📝 Generating SSH key..."
read -p "Enter your GitHub email address: " github_email
ssh-keygen -t ed25519 -C "$github_email" -f "$HOME/.ssh/github_ed25519"

# Start ssh-agent and add key
echo "🔑 Starting ssh-agent and adding key..."
if [ -z "$SSH_AUTH_SOCK" ]; then
    eval "$(ssh-agent -s)"
fi
ssh-add --apple-use-keychain "$HOME/.ssh/github_ed25519"

# Configure SSH settings
echo "⚙️ Configuring SSH settings..."
SSH_CONFIG="$HOME/.ssh/config"
SSH_CONFIG_CONTENT="Host *
  AddKeysToAgent yes
  UseKeychain yes
  IdentityFile ~/.ssh/github_ed25519"

if [ ! -f "$SSH_CONFIG" ]; then
    echo "$SSH_CONFIG_CONTENT" > "$SSH_CONFIG"
    chmod 600 "$SSH_CONFIG"
    echo "Created new SSH config file"
else
    if ! grep -q "github_ed25519" "$SSH_CONFIG"; then
        echo -e "\n$SSH_CONFIG_CONTENT" >> "$SSH_CONFIG"
        echo "Updated existing SSH config file"
    fi
fi

# Copy public key to clipboard based on OS
echo "📋 Copying public key to clipboard..."
if [[ "$OSTYPE" == "darwin"* ]]; then
    # macOS
    pbcopy < "$HOME/.ssh/github_ed25519.pub"
elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
    # Linux (requires xclip)
    if command -v xclip &> /dev/null; then
        xclip -selection clipboard < "$HOME/.ssh/github_ed25519.pub"
    else
        echo "❌ xclip not found. Please install xclip or manually copy the key below:"
        cat "$HOME/.ssh/github_ed25519.pub"
    fi
else
    # Other OS - display key
    echo "Please manually copy the key below:"
    cat "$HOME/.ssh/github_ed25519.pub"
fi

echo "
✅ SSH key generated successfully!

Next steps:
1. Go to GitHub Settings: https://github.com/settings/keys
2. Click 'New SSH key'
3. Give your key a title (e.g., 'Work Laptop')
4. Paste the key (it's already in your clipboard)
5. Click 'Add SSH key'"

if [[ $HAS_SSO =~ ^[Yy]$ ]]; then
    echo "
Additional steps for organization access:
6. Find your new key in the SSH keys list
7. Click 'Configure SSO'
8. Click 'Authorize' next to $org_name
9. Complete your organization's SAML SSO authentication if prompted

You can also authorize directly via:
https://github.com/settings/ssh/your-key-id/configure_sso
(Replace 'your-key-id' with the ID shown in your SSH key settings)"
fi

echo "
To test your connection, run:
ssh -T git@github.com"

if [[ $HAS_SSO =~ ^[Yy]$ ]]; then
    echo "
To test organization access, try cloning a private repository:
git clone git@github.com:$org_name/some-private-repo.git"
fi

# Test connection
read -p "Would you like to test the basic GitHub connection now? (y/n) " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    ssh -T git@github.com
fi