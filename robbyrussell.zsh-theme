eval purple='$FG[012]'
eval blue='$FG[111]'

local ret_status="%(?:%{$fg[green]%}➜ :%{$fg[red]%}➜ )"
PROMPT='${ret_status} $purple%c $(git_prompt_info)%{$purple%}»%{$reset_color%} '

ZSH_THEME_GIT_PROMPT_PREFIX="%{$purple%}[%{$blue%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$purple%}] "
ZSH_THEME_GIT_PROMPT_DIRTY=" %{$fg[red]%}●"
ZSH_THEME_GIT_PROMPT_CLEAN=" %{$fg[green]%}●"
