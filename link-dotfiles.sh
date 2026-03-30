#!/bin/bash

DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"
EXCLUDES=(".git" ".gitignore" ".claude")

for file in "$DOTFILES_DIR"/.*; do
    filename="$(basename "$file")"

    # Skip . and ..
    [[ "$filename" == "." || "$filename" == ".." ]] && continue

    # Skip directories
    [[ -d "$file" ]] && continue

    # Skip excluded files
    skip=false
    for exclude in "${EXCLUDES[@]}"; do
        [[ "$filename" == "$exclude" ]] && skip=true && break
    done
    $skip && continue

    ln -sf "$file" "$HOME/$filename"
    echo "Linked $filename"
done

# Ensure ~/.zshrc exists and sources personal config
PERSONAL_SOURCE='[[ -f ~/.zshrc.personal ]] && source ~/.zshrc.personal'
touch "$HOME/.zshrc"
if ! grep -qF '.zshrc.personal' "$HOME/.zshrc"; then
    echo "" >> "$HOME/.zshrc"
    echo "# Load personal config (symlinked from dotfiles repo)" >> "$HOME/.zshrc"
    echo "$PERSONAL_SOURCE" >> "$HOME/.zshrc"
    echo "Added .zshrc.personal source line to ~/.zshrc"
fi
