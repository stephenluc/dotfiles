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

# Symlink nvim config directory
mkdir -p "$HOME/.config"
ln -sf "$DOTFILES_DIR/nvim" "$HOME/.config/nvim"
echo "Linked nvim config"

# Helper: prepend a source line to a file if not already present
prepend_source() {
    local source_line="$1"
    local target_file="$2"
    local comment="$3"

    touch "$target_file"
    if ! grep -qF "$source_line" "$target_file"; then
        local tmp
        tmp=$(mktemp)
        echo "$comment" > "$tmp"
        echo "$source_line" >> "$tmp"
        echo "" >> "$tmp"
        cat "$target_file" >> "$tmp"
        mv "$tmp" "$target_file"
        echo "Prepended ${source_line##* } source line to $target_file"
    fi
}

# Ensure ~/.zshrc sources personal config (at top so work overrides take precedence)
prepend_source \
    '[[ -f ~/.zshrc.personal ]] && source ~/.zshrc.personal' \
    "$HOME/.zshrc" \
    '# Load personal config (symlinked from dotfiles repo)'

# Ensure ~/.tmux.conf sources personal config (at top so work overrides take precedence)
prepend_source \
    'source-file ~/.tmux.conf.personal' \
    "$HOME/.tmux.conf" \
    '# Load personal config (symlinked from dotfiles repo)'
