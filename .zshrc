# ZSH settings
export PYTHONPATH="/Users/kevinschaich"
export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/mysql/bin:/usr/local/ant/bin"
export ZSH=~/.oh-my-zsh
export UPDATE_ZSH_DAYS=5

ZSH_THEME="steeef"
COMPLETION_WAITING_DOTS="true"

plugins=(z git brew meteor osx pip python sudo x vagrant zsh-syntax-highlighting zsh-history-substring-search node npm)

source $ZSH/oh-my-zsh.sh
source ~/dotfiles/.zsh-syntax-highlighting/zsh-syntax-highlighting.plugin.zsh

# source aliases
source ~/dotfiles/.zshalias

# bind UP and DOWN arrow keys
zmodload zsh/terminfo
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
