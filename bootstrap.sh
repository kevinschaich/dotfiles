#!/bin/bash

############################################################################
# Setup symlinks for .dotfiles
############################################################################

cd ~
echo "Setting up symlinks..."
touch ~/.workrc
touch ~/.bash_profile
mkdir -p ~/Library/Application\ Support/Code/User
ln -sfF ~/dotfiles/.inputrc ~
ln -sfF ~/dotfiles/.vimrc ~
ln -sfF ~/dotfiles/.zshrc ~
ln -sfF ~/dotfiles/.zprofile ~
ln -sfF ~/dotfiles/.code-settings.jsonc ~/Library/Application\ Support/Code/User/settings.json
ln -sfF ~/dotfiles/.code-keybindings.jsonc ~/Library/Application\ Support/Code/User/keybindings.json

############################################################################
# Shell
############################################################################

echo "Installing Homebrew & Homebrew Cask..."
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
brew tap caskroom/versions
eval "$(/opt/homebrew/bin/brew shellenv)"

echo "Installing zsh utilities..."
brew install git zsh
# git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.zsh-syntax-highlighting
# git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh-autosuggestions
chsh -s /bin/zsh

git config --global credential.helper osxkeychain
git config --global user.email "schaich.kevin@gmail.com"
git config --global user.name "kevinschaich"

############################################################################
# Homebrew
############################################################################

echo "Installing apps..."

# brew install ableton-live-suite # doesn't work
# brew install adobe-creative-cloud
# brew install adobe-dng-converter
# brew install screens
# brew install screens-connect
# brew install sketch # need older version

brew install bitbar
brew install cyberduck
brew install figma
brew install geekbench
brew install google-chrome
brew install google-drive
brew install kap
brew install messenger
brew install mongodb-community
brew install mongodb-compass
brew install mongodb-database-tools
brew install native-access
brew install notion
brew install postman
brew install proxyman
brew install rocket
brew install signal
brew install slack
brew install sonos
brew install spotify
brew install starship
brew install steam
brew install transmission
brew install visual-studio-code
brew install warp
brew install whatsapp

echo "Installing terminal utilities..."

brew install ag
brew install mas
brew install tree
brew install tldr
brew install unrar
brew install wget

# need to test
# brew install anaconda
# brew install node
# brew install python
# brew install python3
# brew install yarn

mkdir -p "$HOME/.zsh"

# npm config set strict-ssl true -g
# npm install --global mintable

# mkdir ~/bitbar
# wget https://raw.githubusercontent.com/matryer/bitbar-plugins/39e8f252ed69d0dd46bbe095299e52279e86d737/Finance/mintable.1h.zsh --output-document ~/bitbar/mintable.1h.zsh
# chmod u+x ~/bitbar/mintable.1h.zsh

################################################################################
# Trackpad, mouse, keyboard, Bluetooth accessories, and input
###############################################################################

echo "Disabling press-and-hold for special keys in favor of key repeat"
defaults write -g ApplePressAndHoldEnabled -bool false
defaults write -g KeyRepeat -int 2
defaults write -g InitialKeyRepeat -int 15

###############################################################################
# Finder
###############################################################################

echo "Show the ~/Library folder by default"
chflags nohidden ~/Library/

echo "Show all filename extensions in Finder by default"
defaults write -g AppleShowAllExtensions -bool true

echo "Show status bar in Finder by default"
defaults write com.apple.finder ShowStatusBar -bool true

echo "Show path bar in Finder by default"
defaults write com.apple.finder ShowPathBar -bool true

echo "Display full POSIX path as Finder window title"
defaults write com.apple.finder _FXShowPosixPathInTitle -bool true

echo "Disable the warning when changing a file extension"
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

echo "Allowing text selection in Quick Look/Preview in Finder by default"
defaults write com.apple.finder QLEnableTextSelection -bool true

echo "Set user folder as the default location for new Finder windows"
defaults write com.apple.finder NewWindowTargetPath -string "file://${HOME}"

###############################################################################
# VSCode
###############################################################################

echo "Installing VSCode Extensions"

code --install-extension zhuangtongfa.material-theme
code --install-extension eriklynd.json-tools
code --install-extension esbenp.prettier-vscode
code --install-extension ms-python.python
code --install-extension ms-vscode.sublime-keybindings
code --install-extension streetsidesoftware.code-spell-checker
code --install-extension eamodio.gitlens

###############################################################################
# MAS-only Apps
###############################################################################

read -p "Logged into Mac App Store? Answer [y/n] " -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]
then
  # Things 3
  mas install 904280696
  # Magnet
  mas install 441258766
  # Blackmagic Disk Speed Test
  mas install 425264550
  # Ookla Speedtest
  mas install 1153157709
  # The Unarchiver
  mas install 425424353
  # Amphetamine
  mas install 937984704
  # Affinity Photo
  mas install 824183456
  # Infuse
  mas install 1136220934
  # Wifi Explorer
  mas install 494803304
fi

echo "Done!"
