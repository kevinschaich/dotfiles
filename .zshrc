# .zshrc
autoload -U compinit && compinit
autoload -U promptinit; promptinit
prompt pure
zstyle ':completion:*' matcher-list '' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' '+l:|?=** r:|?=**'

source ~/.bash_profile
source ~/.work-alias

# Defaults
export BROWSER='open'
export EDITOR='code'
export VISUAL='code'
export PAGER='less'
export LANG='en_US.UTF-8'

# Aliases
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
# ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern cursor root line)
# ZSH_HIGHLIGHT_PATTERNS=('rm -rf *' 'fg=white,bold,bg=red')
# ZSH_HIGHLIGHT_PATTERNS=('ls' 'fg=blue,bg=blue')

# Archive
# alias ga="git add -A"
# alias push="git push"
# alias pull="git pull"
# alias stash="git stash --keep-index"
# alias copy='fc -ln -1 | sed "1s/^[[:space:]]*//" | awk 1 ORS="" | pbcopy '
# alias mv="mv -iv"
# alias cp="cp -iv"
# alias sort="gsort"
# alias du="gdu"
# alias rd="rm -rfv"
# alias hd="head"
# alias tl="tail"
# alias zapem="gs | grep DS_Store | awk '{print $2}' | xargs git checkout"
# alias yarn-work="yarn config delete registry -g"
# alias yarn-public="yarn config set registry "https://registry.yarnpkg.com" -g"
# alias dcu='docker-compose up -d'
# alias dcps='docker-compose ps'
# export PATH="/usr/local/opt/node@8/bin:$PATH"
