# ZSH settings

export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/mysql/bin:/usr/local/ant/bin"
export ZSH=~/.oh-my-zsh
export UPDATE_ZSH_DAYS=5
export SCRAPING_HOME="/Volumes/shopkick_repo/shopkick/tools/grocery_circulars/scraping"

ZSH_THEME="steeef"
COMPLETION_WAITING_DOTS="false"

plugins=(git brew pip python sudo vagrant zsh-syntax-highlighting zsh-history-substring-search)

source $ZSH/oh-my-zsh.sh

# User configuration

function kp { ps -ef | grep "$@" | awk '{print $2}' | xargs sudo kill }

# Git aliases
alias gs="git status"
alias status="git status"
alias gsa="clustergit --recursive -d ."
alias gd="git diff"
alias ga="git add -A"
alias add="git add -A"
alias gc="git commit"
alias commit="git commit"
alias gca="git commit --amend"
alias gp="git push"
alias push="git push"
alias pull="git pull"
gpa() { git add -A && git commit -m  "$*" && git push; }
alias zapem="gs | grep DS_Store | awk '{print $2}' | xargs git checkout"

# Path aliases
alias jun2015="cd ~/Dropbox/jun2016"
alias foray="cd ~/Dropbox/Programming/HTML/foray"
alias cdp="cd ~/inf_portal_api/portal"
alias cdi="cd ~/inf_iaas_api/iaas"
alias portal="cd ~/inf_portal_api/portal/cli.py"
alias crack="cd ~/Dropbox/Programming/cracking_coding_interview_6e"
alias io="cd ~/Dropbox/Programming/HTML/kevinschaich.io"
alias cs3410="cd ~/Dropbox/jun2016/cs3410/"
alias info3300="cd ~/Dropbox/jun2016/info3300"
alias cs4820="cd ~/Dropbox/jun2016/cs4820"
alias cs4410="cd ~/Dropbox/jun2016/cs4410"
alias p2="cd ~/Dropbox/jun2016/info3300/projects/p2/billboard-top-100-lyrics"
alias cps="cd ~/Google\ Drive/Programming/cornell_photo_society/"
alias cs4410="cd ~/Google\ Drive/school/sen2017/cs4410/"

# General aliases
alias copy='fc -ln -1 | sed "1s/^[[:space:]]*//" | awk 1 ORS="" | pbcopy '
alias serve="python ~/inf_portal_api/portal/main.py"
alias iaas="python ~/inf_iaas_api/iaas/main.py"
alias edit="atom ~/inf_portal_api ~/inf_iaas_api"
alias mkdir="mkdir -p"
alias mv="mv -iv"
alias cp="cp -iv"
alias del="mv $1 ~/.unixtrash"
alias rd="rm -rfv"
alias hd="head"
alias tl="tail"
alias zshconfig="vim ~/.zshrc"
alias ohmyzsh="vim ~/.oh-my-zsh"
alias bashconfig="vim ~/.bash_profile"
alias hook="scp -p -P 29418 kevin.schaich@gerrit.workday.com:hooks/commit-msg .git/hooks/"
alias a="atom-beta"
function hide(){
    defaults write com.apple.finder AppleShowAllFiles -bool NO
    killall Finder
}
function show(){
    defaults write com.apple.finder AppleShowAllFiles -bool YES
    killall Finder
}

# bind UP and DOWN arrow keys
zmodload zsh/terminfo
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
