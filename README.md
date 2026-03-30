# dotfiles

Personal dotfiles for consistent dev environments across machines. Manages shell config, editor settings, tmux, git, and application installation via Homebrew.

## Quick Start

On a new machine, clone and run:

```bash
git clone git@github.com:stephenluc/dotfiles.git ~/dotfiles
cd ~/dotfiles
sh setup.sh
```

`setup.sh` runs everything in order:

1. **link-dotfiles.sh** -- auto-discovers and symlinks all dotfiles (`.zshrc.personal`, `.gitconfig`, `.vimrc`, `.tmux.conf`, etc.) from this repo into `~`, and ensures `~/.zshrc` sources `~/.zshrc.personal`
2. **dev-tools-setup.sh** -- installs Homebrew (if needed), runs `brew bundle` for CLI tools and personal apps, optionally installs work apps from `Brewfile.work`, installs TPM, and auto-installs tmux plugins
3. **github-ssh-setup.sh** -- generates SSH key and uploads to GitHub via `gh` CLI

## Scripts

| Script | Purpose | Interactive? |
|--------|---------|--------------|
| `setup.sh` | Full new-machine setup (runs all scripts below) | Yes |
| `link-dotfiles.sh` | Auto-discover and symlink dotfiles into `~` | No |
| `dev-tools-setup.sh` | Install all tools and apps via Brewfiles, TPM | Yes (prompts for work apps) |
| `github-ssh-setup.sh` | Generate SSH key and upload to GitHub via `gh` | Yes |

## Brewfiles

| File | Contents |
|------|----------|
| `Brewfile` | CLI tools (git, tmux, bun, etc.) and personal apps (Firefox, iTerm2, Raycast, etc.) -- always installed |
| `Brewfile.work` | Work apps (Slack, Cursor, Postman, Linear, etc.) -- installed only if you opt in |

Add new packages by editing the appropriate Brewfile. Run `brew bundle --file=Brewfile` to install.

## Config Files

| File | What it configures |
|------|--------------------|
| `.zshrc.personal` | Zsh shell -- personal aliases, prompt (Spaceship), sourced by `~/.zshrc` |
| `.gitconfig` | Git -- aliases (`gs`, `gls`), editor, colors |
| `.vimrc` | Vim editor settings |
| `.tmux.conf` | Tmux -- prefix `Ctrl-Space`, pane/window nav, opensessions, resurrect/continuum, status bar |
| `iterm_settings.json` / `iterm_settings_v2.json` | iTerm2 profile exports |

## How Symlinks Work

`link-dotfiles.sh` auto-discovers all dotfiles at the repo root (excluding `.git`, `.gitignore`, `.claude`) and symlinks them into `~`. Adding a new dotfile to the repo is all you need -- no script changes required.

`~/.zshrc` is not symlinked -- it's a per-machine file for work-specific config (PATH, NVM, project aliases, tokens). `link-dotfiles.sh` creates it if missing and appends a line to source `~/.zshrc.personal`, which is the symlinked personal config from this repo.

## Key Tmux Bindings

- Prefix: `Ctrl-Space`
- Panes: `j`/`k` to navigate, `=`/`-` to split
- Windows: `h`/`l` to navigate
- Sessions: `Alt-s` to open opensessions sidebar, `Alt-1`-`9` to jump to session by index
- Reload: `prefix + r`
- Session persistence via tmux-resurrect and tmux-continuum (auto-restores on tmux start)

## Resources

- https://dotfiles.github.io/
