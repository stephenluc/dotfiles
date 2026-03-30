# AGENTS.md

This is a macOS dotfiles repo. All config files live at the repo root and are symlinked into `~` by `link-dotfiles.sh`.

## Repo Structure

- **Dotfiles**: `.zshrc.personal`, `.gitconfig`, `.vimrc`, `.tmux.conf.personal` -- symlinked to `~` automatically
- **Brewfiles**: `Brewfile` (tools + personal apps), `Brewfile.work` (work apps, optional)
- **Scripts**: `setup.sh` (entrypoint), `link-dotfiles.sh`, `dev-tools-setup.sh`, `github-ssh-setup.sh`
- **iTerm**: `iterm_settings.json`, `iterm_settings_v2.json`, `iterm2/` -- exported iTerm2 profiles

## Rules

- macOS only -- scripts use Homebrew and assume darwin
- Config files live at repo root, not in subdirectories
- `link-dotfiles.sh` auto-discovers dotfiles -- adding a new dotfile to the repo root is enough, no script changes needed
- Excluded from symlinking: `.git`, `.gitignore`, `.claude`, and directories
- All packages (CLI tools and GUI apps) are declared in `Brewfile` or `Brewfile.work` -- installed via `brew bundle`
- Shell is zsh with Spaceship prompt
- `~/.zshrc` is work-specific (PATH, NVM, project aliases, tokens) -- not tracked, managed per machine
- `.zshrc.personal` in the repo is personal config (git aliases, prompt theme) -- symlinked to `~/.zshrc.personal`
- `~/.tmux.conf` is work-specific (overrides like SESSIONIZER_DIR) -- not tracked, managed per machine
- `.tmux.conf.personal` in the repo is personal tmux config -- symlinked to `~/.tmux.conf.personal`
- Both `~/.zshrc` and `~/.tmux.conf` source their `.personal` counterpart at the top; `link-dotfiles.sh` prepends the source line if missing
- Work-specific settings go after the source line so they take precedence (last setting wins)
- Tmux prefix is `Ctrl-Space`, uses TPM for plugins
- Tmux plugins: opensessions (Ataraxy-Labs/opensessions, requires bun), tmux-resurrect, tmux-continuum
- SSH setup uses `gh` CLI to upload keys to GitHub automatically

## When editing

- Adding a new dotfile: just place it at the repo root (starts with `.`) -- `link-dotfiles.sh` picks it up automatically
- Adding a CLI tool or personal app: add to `Brewfile`
- Adding a work app: add to `Brewfile.work`
- Keep scripts idempotent -- they should be safe to re-run
