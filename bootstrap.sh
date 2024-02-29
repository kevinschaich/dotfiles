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
brew tap homebrew/cask-fonts
eval "$(/opt/homebrew/bin/brew shellenv)"

echo "Installing zsh utilities..."
brew install git zsh
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

# brew install bitbar
# brew install cyberduck
brew install arc
brew install figma
brew install geekbench
brew install google-drive
brew install kap
brew install messenger
# brew install mongodb-community
# brew install mongodb-compass
# brew install mongodb-database-tools
brew install notion
# brew install postman
# brew install proxyman
# brew install rocket
brew install signal
brew install slack
brew install spotify
brew install starship
# brew install steam
# brew install transmission
brew install visual-studio-code
brew install warp
brew install whatsapp
brew install homebrew/cask/docker
brew install stats

echo "Installing terminal utilities..."

brew install ag
brew install mas
brew install tree
brew install tldr
brew install unrar
brew install wget

brew install node
brew install yarn
brew install python@3.11
brew install ngrok/ngrok/ngrok

mkdir -p "$HOME/.zsh"

brew install font-hack

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
code --install-extension bungcip.better-toml
code --install-extension dvirtz.parquet-viewer
code --install-extension eamodio.gitlens
code --install-extension eriklynd.json-tools
code --install-extension esbenp.prettier-vscode
code --install-extension GitHub.copilot
code --install-extension GitHub.copilot-chat
code --install-extension GitHub.github-vscode-theme
code --install-extension JannisX11.batch-rename-extension
code --install-extension kamikillerto.vscode-colorize
code --install-extension mikestead.dotenv
code --install-extension ms-azuretools.vscode-docker
code --install-extension ms-python.isort
code --install-extension ms-python.python
code --install-extension ms-python.vscode-pylance
code --install-extension ms-vscode.sublime-keybindings
code --install-extension Prisma.prisma
code --install-extension richie5um2.vscode-sort-json
code --install-extension streetsidesoftware.code-spell-checker
code --install-extension yoavbls.pretty-ts-errors

###############################################################################
# MAS-only Apps
###############################################################################

read -p "Logged into Mac App Store? Answer [y/n] " -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]
then
  # Things 3
  # mas install 904280696
  # Magnet
  mas install 441258766
  # Blackmagic Disk Speed Test
  mas install 425264550
  # Ookla Speedtest
  mas install 1153157709
  # The Unarchiver
  # mas install 425424353
  # Affinity Photo
  # mas install 824183456
  # Infuse
  mas install 1136220934
  # Wifi Explorer
  mas install 494803304
fi

echo "Done!"
