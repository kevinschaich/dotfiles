# .zshrc
autoload -U compinit && compinit
autoload -U promptinit; promptinit
prompt pure
zstyle ':completion:*' matcher-list '' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' '+l:|?=** r:|?=**'

source ~/.bash_profile
source ~/.work-alias

# Defaults
export HISTSIZE=5000
export SAVEHIST=5000
export BROWSER=open
export EDITOR=code
export VISUAL=code
export PAGER=less
export LANG=en_US.UTF-8
export HISTFILE=~/.zsh_history

# Aliases
alias -g ...='../..'
alias -g ....='../../..'
alias ls='ls -G'
alias c='code'
alias gs='git status'
alias gd='git diff'
alias l='ls -lahF'
alias mkdir='mkdir -p'
alias please='sudo $(fc -ln -1)'

# Functions
function gpa(){
    git add -A && git commit -m  "$*" && git push;
}
function kp(){
    ps -ef | grep "$@" | awk '{print $2}' | xargs kill
}
function hide(){
    defaults write com.apple.finder AppleShowAllFiles -bool NO
    killall Finder
}
function show(){
    defaults write com.apple.finder AppleShowAllFiles -bool YES
    killall Finder
}

source ~/.zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
