# .zshrc
fpath+=$HOME/.zsh/pure
autoload -U promptinit; promptinit
prompt pure

source ~/.bash_profile
source ~/.work-alias

export PATH="/usr/local/sbin:$PATH"

# Anaconda installation of Python 
# export PATH="/usr/local/anaconda3/bin:$PATH"

# Brew installation of Python
export PATH="/usr/local/opt/python@3.9/libexec/bin:$PATH"
alias python='/usr/local/opt/python@3.9/libexec/bin/python'
alias pip='/usr/local/opt/python@3.9/libexec/bin/pip'

export TOKEN=`security find-generic-password -a ${USER} -s PALOMA_TOKEN -w`

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
alias python='python3'
alias pip='pip3'

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
