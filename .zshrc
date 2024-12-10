# Load the compinit module
autoload -Uz compinit
compinit

export PATH=~/.npm-global/bin:$PATH
export PYTHON=/opt/homebrew/opt/python@3.9/bin/python3.9

# zsh aliases
alias "szsh"="source ~/.zshrc"
alias "vzsh"="vim ~/.zshrc"
alias "lzsh"="less ~/.zshrc"

# git aliases
alias "gco"="git checkout"
alias "gcb"="git checkout -b"
alias "gaa"="git add ."
alias "gct"="git commit"
alias "gctm"="git commit -m"
alias "gca"="git commit --amend"
alias "gs"="git s"
alias "gls"="git ssl"
alias "gr"="git rebase"
alias "grm"="gco master && git pull && gco - && git rebase master"
alias "grc"="git rebase --continue"
alias "gdiff"="git diff"
alias "gph"="git push"
alias "gpl"="git pull"

# Load the Spaceship prompt theme
source /opt/homebrew/opt/spaceship/spaceship.zsh

# Customize the prompt
SPACESHIP_PROMPT_ORDER=(
  dir           # Current directory section
  git           # Git section (shows repository/branch)
  line_sep      # New line
  char          # Prompt character
)

SPACESHIP_USER_SHOW=always               # Always show the username
SPACESHIP_DIR_TRUNC=0                    # Show the full directory path
SPACESHIP_GIT_BRANCH_COLOR=magenta       # Set the git branch color to magenta
SPACESHIP_PROMPT_ADD_NEWLINE=true        # Add a newline before each prompt