#!/bin/bash

############################################################################
# Setup symlinks for .dotfiles
############################################################################

cd ~
echo "Setting up symlinks..."
touch ~/.work-alias
touch ~/.bash_profile
mkdir -p ~/.iterm2
mkdir -p ~/Library/Application\ Support/Code/User
ln -sfF ~/dotfiles/.inputrc ~
ln -sfF ~/dotfiles/.vimrc ~
ln -sfF ~/dotfiles/.zshrc ~
ln -sfF ~/dotfiles/.iterm2.plist ~/.iterm2/com.googlecode.iterm2.plist
ln -sfF ~/dotfiles/.code-settings.jsonc ~/Library/Application\ Support/Code/User/settings.json
ln -sfF ~/dotfiles/.code-keybindings.jsonc ~/Library/Application\ Support/Code/User/keybindings.json

############################################################################
# Shell
############################################################################

echo "Installing Homebrew & Homebrew Cask..."
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew tap caskroom/versions

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
brew tap homebrew/cask-drivers

brew cask install 1password
brew cask install adobe-creative-cloud
brew cask install adobe-dng-converter
brew cask install alfred
brew cask install bitbar
brew cask install caprine
brew cask install cyberduck
brew cask install geekbench
brew cask install google-chrome
brew cask install google-drive-file-stream
brew cask install iina
brew cask install iterm2
brew cask install kap
brew cask install keepingyouawake
brew cask install microsoft-teams
brew cask install postman
brew cask install private-internet-access
brew cask install proxyman
brew cask install quip
brew cask install screens
brew cask install screens-connect
brew cask install sketch
brew cask install slack
brew cask install sonos
brew cask install spotify
brew cask install steam
brew cask install timestamp
brew cask install transmission
brew cask install visual-studio-code
brew cask install webex-meetings

echo "Installing terminal utilities..."
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

npm config set strict-ssl false -g
npm install --global pure-prompt
npm config set strict-ssl true -g
npm install --global mintable

echo "Installing Quick Look Utilities..."
# glance on mac app store?
brew cask install betterzip qlcolorcode qlstephen qlmarkdown quicklook-json quicklook-csv qlimagesize qlvideo

################################################################################
# Trackpad, mouse, keyboard, Bluetooth accessories, and input
###############################################################################

echo "Disabling press-and-hold for special keys in favor of key repeat"
defaults write -g ApplePressAndHoldEnabled -bool false
defaults write -g KeyRepeat -int 2
defaults write -g InitialKeyRepeat -int 15

echo "Setting trackpad & mouse speed"
defaults write -g com.apple.trackpad.scaling 0.875
defaults write -g com.apple.mouse.scaling 0.875

echo "Disable display from automatically adjusting brightness"
sudo defaults write /Library/Preferences/com.apple.iokit.AmbientLightSensor "Automatic Display Enabled" -bool false

###############################################################################
# Screen
###############################################################################

echo "Disabling subpixel font rendering on non-Apple LCDs"
defaults write -g AppleFontSmoothing -int 0

echo "Disabling subpixel font/image smoothing in Preview"
defaults write com.apple.Preview PVPDFAntiAliasOption 0

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

echo "Setting the icon size of Dock items to 36 pixels for optimal size/screen-realestate"
defaults write com.apple.dock tilesize -int 50

echo "Speeding up Mission Control animations and grouping windows by application"
defaults write com.apple.dock expose-animation-duration -float 0.2

echo "Finder: disable window animations and Get Info animations"
defaults write com.apple.finder DisableAllAnimations -bool true

echo "Set Dock to auto-hide and remove the auto-hiding delay"
defaults write com.apple.dock autohide -bool true
defaults write com.apple.dock autohide-time-modifier -float 0.2
defaults write com.apple.dock autohide-delay -float 0.05

echo "Disable window animations"
defaults write -g NSAutomaticWindowAnimationsEnabled -bool true

echo "Disable dashboard"
defaults write com.apple.dashboard mcx-disabled -boolean YES

echo "Minimize windows into their application’s icon"
defaults write com.apple.dock minimize-to-application -bool true

echo "Don’t animate opening applications from the Dock"
defaults write com.apple.dock launchanim -bool false

# Doesn't work > Mojave
# echo "Add delay for dragging windows to new spaces"
# defaults write com.apple.dock workspaces-edge-delay -float 1.5

echo "Sort contacts by first name"
defaults write com.apple.AddressBook ABNameSortingFormat sortingFirstName

###############################################################################
# Editor & Terminal
###############################################################################

echo "Setting User Preferences folder"
defaults write com.googlecode.iterm2 LoadPrefsFromCustomFolder -bool TRUE
defaults write com.googlecode.iterm2 PrefsCustomFolder -string "~/.iterm2"

defaults write com.runningwithcrayons.Alfred-Preferences syncfolder ~/dotfiles
defaults write com.runningwithcrayons.Alfred-Preferences-3 syncfolder ~/dotfiles

echo "Don’t display the annoying prompt when quitting iTerm"
defaults write com.googlecode.iterm2 PromptOnQuit -bool FALSE

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
