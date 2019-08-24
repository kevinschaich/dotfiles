# .zshrc
autoload -U compinit && compinit
autoload -U promptinit; promptinit
prompt pure

source ~/.bash_profile
source ~/.work-alias

export PATH="/usr/local/sbin:$PATH"

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
alias -g ....='../../..'
alias -g ...='../..'
alias c='code'
alias cask='brew cask'
alias gd='git diff'
alias gs='git status'
alias gsa='find . -maxdepth 2 -name .git -execdir git rev-parse --show-toplevel \; -execdir git status -s \;'
alias l='ls -lahF'
alias ls='ls -G'
alias man='tldr'
alias mkdir='mkdir -p'
alias please='sudo $(fc -ln -1)'
alias rm='rm -r'

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

zstyle ':completion:*' matcher-list '' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' '+l:|?=** r:|?=**'

source ~/.zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/.zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
