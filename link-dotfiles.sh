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
