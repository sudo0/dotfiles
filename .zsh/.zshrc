# Created by newuser for 5.8

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Prompt Start
function get-prompt {
    SEP='\ue0b0'
    RESULT="%K{magenta}%n%k%F{magenta}%K{green}"`echo $SEP`"%f%k%K{green}%~%k"

    BRANCH=`git rev-parse --abbrev-ref HEAD 2>/dev/null`

    if [[ -n ${BRANCH} ]]; then
        RESULT=${RESULT}"%F{green}%K{cyan}"`echo $SEP`"%f%k%K{cyan}\ue725"${BRANCH}"%k%F{cyan}"`echo $SEP`"%f"
    else
        RESULT=${RESULT}"%F{green}"`echo $SEP`"%f"
    fi

    echo "${RESULT}"
}

setopt prompt_subst
PROMPT='`get-prompt`'
# Prompt End

# Completion Start
autoload -U compinit && compinit
zstyle ':completion:*' matcher-list '' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}'
# Completion End

### Added by Zinit's installer
if [[ ! -f $HOME/.zinit/bin/zinit.zsh ]]; then
    print -P "%F{33}▓▒░ %F{220}Installing DHARMA Initiative Plugin Manager (zdharma/zinit)…%f"
    command mkdir -p "$HOME/.zinit" && command chmod g-rwX "$HOME/.zinit"
    command git clone https://github.com/zdharma/zinit "$HOME/.zinit/bin" && \
        print -P "%F{33}▓▒░ %F{34}Installation successful.%f%b" || \
        print -P "%F{160}▓▒░ The clone has failed.%f%b"
fi

source "$HOME/.zinit/bin/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    zinit-zsh/z-a-patch-dl \
    zinit-zsh/z-a-as-monitor \
    zinit-zsh/z-a-bin-gem-node

### End of Zinit's installer chunk
