# .zshrc

source ~/.bash_profile
source ~/.workrc

# Python – Brew 3.11 + Poetry
# export PATH="/Users/kevinschaich/.local/bin:$PATH" # for Poetry
alias python=/opt/homebrew/bin/python3.11
alias python3=/opt/homebrew/bin/python3.11
alias python3.11=/opt/homebrew/bin/python3.11
alias pip=/opt/homebrew/bin/pip3.11
alias pip3=/opt/homebrew/bin/pip3.11
alias pip3.11=/opt/homebrew/bin/pip3.11

# Defaults
export HISTSIZE=10000
export SAVEHIST=10000
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
alias mkdir='mkdir -p'
alias please='sudo $(fc -ln -1)'
alias rm='rm -r'
alias pip='pip3'
alias tree='tree -I "node_modules|cache|test_*|.git" -a'

# Functions
function gpa(){
    git add -A && git commit -m  "$*" && git push;
}
function kp(){
    pkill -f "$@"
}
function hide(){
    defaults write com.apple.finder AppleShowAllFiles -bool NO
    killall Finder
}
function show(){
    defaults write com.apple.finder AppleShowAllFiles -bool YES
    killall Finder
}

eval "$(starship init zsh)"
export PATH="/opt/homebrew/opt/postgresql@15/bin:$PATH"
