# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Enable colors and change prompt:
autoload -U colors && colors
# Load version control information
autoload -Uz vcs_info
precmd() { vcs_info }

# Format the vcs_info_msg_0_ variable
# zstyle ':vcs_info:git:*' formats 'on branch %b'
zstyle ':vcs_info:git:*' formats '%b'

# Set up the prompt (with git branch name)
setopt PROMPT_SUBST

BRANCH='%F{green}${vcs_info_msg_0_} '
PS1=" %B%F{magenta}%~%f%b $BRANCH%(?.%F{cyan}>.%F{red}[%?] >)%f "
# PROMPT=" %B%F{magenta}%~%f%b %(?.%F{cyan}>.%F{red}[%?] >)%f "

# History in cache directory
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.cache/zsh/history

# Basic auto/tab complete:
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots)		# Include hidden files

# vi mode
bindkey -v
export KEYTIMEOUT=1

# Use vim keys in tab complete menu
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -v '^?' backward-delete-char

# Change cursor shape for different vi modes
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
echo -ne '\e[5 q' # Use beam shape cursor on startup
preexec() { echo -ne '\e[5 q' ;} # Use beam shape cursor for each new prompt

autoload -U history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end

bindkey -s "^F" "tmux-sessionizer\n"

# cdf() {
#     find ~/personal -type d | fzf
# }
# zle -N cdf
# bindkey "^F" cdf

# bindkey '^P' history-beginning-search-backward
# bindkey '^N' history-beginning-search-forward
# bindkey '^P' up-line-or-search
# bindkey '^n' down-line-or-search

# Edit line in vim with ctrl-e:
autoload edit-command-line; zle -N edit-command-line
bindkey '^e' edit-command-line

function clear-scrollback-buffer {
  clear && printf '\e[3J'
  zle && zle .reset-prompt && zle -R
}

zle -N clear-scrollback-buffer
bindkey '^L' clear-scrollback-buffer

alias cp='cp -v'
alias mv='mv -v'
alias rm='rm -v'
alias mkdir='mkdir -v'
alias rmdir='rmdir -v'

alias ls='exa -aF --color=auto --group-directories-first'
alias cat='bat'
alias py='python'

alias gs='git status -s'
alias gl='git log --oneline'
alias ga='git add'
alias gr='git remote'
alias grs='git restore'
alias gc='git commit'
alias gp='git push'
alias gpl='git pull'
alias gd='git diff'
alias gsw='git switch'

# path
LOCAL_BIN="$HOME/.local/bin"
LOCAL_SCRIPTS="$HOME/.local/scripts"
CARGO_HOME="$HOME/.cargo/bin"
CARGO="$HOME/.cargo/bin/cargo"
PYTHON="/usr/local/opt/python@3.10/libexec/bin"
POETRY="$HOME/.local/share/poetry/bin"
OPENCV="/usr/local/Cellar/opencv/4.7.0_2/lib/pkgconfig/opencv4.pc"
DENO="/Users/fahmymohamed/.deno/bin:$PATH"


export PATH=$PATH:$LOCAL_BIN:$LOCAL_SCRIPTS:$CARGO_HOME:$PYTHON:$POETRY:$DENO

export RUST_BACKTRACE=1
export HOMEBREW_NO_ENV_HINTS=1
export PATH="/usr/local/opt/postgresql@15/bin:$PATH"

export PKG_CONFIG_PATH="/usr/local/opt/opencv@2/lib/pkgconfig"
