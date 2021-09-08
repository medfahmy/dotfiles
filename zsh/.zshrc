
export ZSH="/home/mfahmy/.oh-my-zsh"

ZSH_THEME="robbyrussell"

export GOPATH=$HOME/go
export PATH=$PATH:$GOROOT/bin:$GOPATH/bin


# Use vim keys in tab complete menu:
# bindkey -M menuselect 'h' vi-backward-char
# bindkey -M menuselect 'k' vi-up-line-or-history
# bindkey -M menuselect 'l' vi-forward-char
# bindkey -M menuselect 'j' vi-down-line-or-history
# bindkey -v '^?' backward-delete-char

CASE_SENSITIVE="false"
HYPHEN_INSENSITIVE="true"
DISABLE_AUTO_TITLE="true"
ENABLE_CORRECTION="false"
COMPLETION_WAITING_DOTS="true"

plugins=(
  git 
  zsh-navigation-tools
  )

source $ZSH/oh-my-zsh.sh


#. ~/.ghcup/env

# History in cache directory:
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.zsh_history

# Basic auto/tab complete:
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots)		# Include hidden files.

# vi mode
bindkey -v
export KEYTIMEOUT=1

# Use vim keys in tab complete menu:
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -v '^?' backward-delete-char

# Change cursor shape for different vi modes.
function zle-keymap-select {
  if [[ ${KEYMAP} == vicmd ]] ||
     [[ $1 = 'block' ]]; then
    echo -ne '\e[1 q'
  elif [[ ${KEYMAP} == main ]] ||
       [[ ${KEYMAP} == viins ]] ||
       [[ ${KEYMAP} = '' ]] ||
       [[ $1 = 'beam' ]]; then
    echo -ne '\e[5 q'
  fi
}
zle -N zle-keymap-select
zle-line-init() {
    zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
    echo -ne "\e[5 q"
}
zle -N zle-line-init
echo -ne '\e[5 q' # Use beam shape cursor on startup.
preexec() { echo -ne '\e[5 q' ;} # Use beam shape cursor for each new prompt.


# Edit line in vim with ctrl-e:
autoload edit-command-line; zle -N edit-command-line
bindkey '^e' edit-command-line


autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey "^P" up-line-or-beginning-search # Up
bindkey "^N" down-line-or-beginning-search # Down
# bindkey "^[[A" up-line-or-beginning-search # Up
# bindkey "^[[B" down-line-or-beginning-search # Down

# if command -v tmux &> /dev/null && [ -z "$TMUX" ]; then
#     tmux attach -t default || tmux new -s default
# fi



#[ -f "/home/mfahmy/.ghcup/env" ] && source "/home/mf/.ghcup/env" # ghcup-env



#source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
#source /usr/share/zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh

# Load zsh-syntax-highlighting; should be last.
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 2>/dev/null


# Aliases

alias c=clear
alias ls="ls -A --color=auto --group-directories-first"
alias src= "source ~/.zshrc"



alias fm=thunar
alias grep=rg
alias code=vscodium

alias cp='cp -v'                           # Preferred 'cp' implementation
alias mv='mv -v'                           # Preferred 'mv' implementation
alias rm='rm -v'
alias mkdir='mkdir -pv'                     # Preferred 'mkdir' implementation
alias ls='ls --color=auto --group-directories-first -A'                         # Preferred 'ls' implementation
alias tree="tree -I 'node_modules*|target'"
alias wget='wget -c'                        # Preferred 'wget' implementation (resume download)
alias path='echo -e ${PATH//:/\\n}'         # path:         Echo all executable Paths
#alias pbcopy='xsel --clipboard --input'
#alias pbpaste='xsel --clipboard --output'