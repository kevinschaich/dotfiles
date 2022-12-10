#!/bin/bash

############################################################################
# Setup symlinks for .dotfiles
############################################################################

cd ~
echo "Setting up symlinks..."
touch ~/.work-alias
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
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh-autosuggestions
chsh -s /bin/zsh

read -p "Personal Computer? Answer [y/n] " -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]
then
  git config --global credential.helper osxkeychain
  git config --global user.email "schaich.kevin@gmail.com"
  git config --global user.name "kevinschaich"
fi

############################################################################
# Homebrew
############################################################################

echo "Installing apps..."

# brew install ableton-live-suite
# brew install adobe-creative-cloud
# brew install adobe-dng-converter
# brew install screens
# brew install screens-connect
# brew install sketch
# brew install slack
# brew install spitfire-audio
# brew install timestamp

brew install bitbar
brew install cyberduck
brew install geekbench
brew install google-chrome
brew install google-drive
brew install warp
brew install starship
brew install kap
brew install messenger
brew install native-access
brew install postman
brew install private-internet-access
brew install proxyman
brew install quip
brew install rocket
brew install sonos
brew install spotify
brew install steam
brew install transmission
brew install visual-studio-code

echo "Installing terminal utilities..."

# brew install anaconda
brew install ag
brew install mas
brew install node
brew install python
brew install python3
brew install tldr
brew install tree
brew install unrar
brew install wget
brew install yarn

mkdir -p "$HOME/.zsh"

npm config set strict-ssl true -g
npm install --global mintable

mkdir ~/bitbar
wget https://raw.githubusercontent.com/matryer/bitbar-plugins/39e8f252ed69d0dd46bbe095299e52279e86d737/Finance/mintable.1h.zsh --output-document ~/bitbar/mintable.1h.zsh
chmod u+x ~/bitbar/mintable.1h.zsh

echo "Installing Quick Look Utilities..."
# glance on mac app store?
# brew install betterzip qlcolorcode qlstephen qlmarkdown quicklook-json quicklook-csv qlimagesize qlvideo

################################################################################
# Trackpad, mouse, keyboard, Bluetooth accessories, and input
###############################################################################

echo "Disabling press-and-hold for special keys in favor of key repeat"
defaults write -g ApplePressAndHoldEnabled -bool false
defaults write -g KeyRepeat -int 2
defaults write -g InitialKeyRepeat -int 15

# echo "Setting trackpad & mouse speed"
# defaults write -g com.apple.trackpad.scaling 0.875
# defaults write -g com.apple.mouse.scaling 0.875

# echo "Disable display from automatically adjusting brightness"
# sudo defaults write /Library/Preferences/com.apple.iokit.AmbientLightSensor "Automatic Display Enabled" -bool false

###############################################################################
# Screen
###############################################################################

# echo "Disabling subpixel font rendering on non-Apple LCDs"
# defaults write -g AppleFontSmoothing -int 0

# echo "Disabling subpixel font/image smoothing in Preview"
# defaults write com.apple.Preview PVPDFAntiAliasOption 0

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
# Dock & Mission Control
###############################################################################

# echo "Setting the icon size of Dock items to 36 pixels for optimal size/screen-realestate"
# defaults write com.apple.dock tilesize -int 50

# echo "Speeding up Mission Control animations and grouping windows by application"
# defaults write com.apple.dock expose-animation-duration -float 0.2

# echo "Finder: disable window animations and Get Info animations"
# defaults write com.apple.finder DisableAllAnimations -bool true

# echo "Set Dock to auto-hide and remove the auto-hiding delay"
# defaults write com.apple.dock autohide -bool true
# defaults write com.apple.dock autohide-time-modifier -float 0.2
# defaults write com.apple.dock autohide-delay -float 0.05

# echo "Disable window animations"
# defaults write -g NSAutomaticWindowAnimationsEnabled -bool true

# echo "Disable dashboard"
# defaults write com.apple.dashboard mcx-disabled -boolean YES

# echo "Minimize windows into their application’s icon"
# defaults write com.apple.dock minimize-to-application -bool true

# echo "Don’t animate opening applications from the Dock"
# defaults write com.apple.dock launchanim -bool false

# Doesn't work > Mojave
# echo "Add delay for dragging windows to new spaces"
# defaults write com.apple.dock workspaces-edge-delay -float 1.5

# echo "Sort contacts by first name"
# defaults write com.apple.AddressBook ABNameSortingFormat sortingFirstName

###############################################################################
# Editor & Terminal
###############################################################################

echo "Setting User Preferences folder"
defaults write com.runningwithcrayons.Alfred-Preferences syncfolder ~/dotfiles
defaults write com.runningwithcrayons.Alfred-Preferences-3 syncfolder ~/dotfiles

code --install-extension zhuangtongfa.material-theme
code --install-extension eriklynd.json-tools
code --install-extension esbenp.prettier-vscode
code --install-extension ms-python.python
code --install-extension ms-vscode.sublime-keybindings
code --install-extension streetsidesoftware.code-spell-checker

###############################################################################
# Kill affected applications
###############################################################################

echo "Killing affected applications..."

find ~/Library/Application\ Support/Dock -name "*.db" -maxdepth 1 -delete
for app in "Activity Monitor" "Address Book" "Calendar" "Contacts" "cfprefsd" \
  "Dock" "Finder" "Mail" "Messages" "Safari" "SystemUIServer" \
  "Transmission"; do
  killall "${app}" > /dev/null 2>&1
done

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
  # Streaks
  mas install 1493327990
  # The Unarchiver
  mas install 425424353
  # Amphetamine
  mas install 937984704
fi

echo "Done!"
