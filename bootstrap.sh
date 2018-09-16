#!/bin/bash

############################################################################
# Setup symlinks for .dotfiles
############################################################################

echo "Setting up symlinks..."
mkdir -p ~/.iterm2
mkdir -p ~/Library/Application\ Support/Code/User
ln -sfF ~/dotfiles/.inputrc ~
ln -sfF ~/dotfiles/.vimrc ~
ln -sfF ~/dotfiles/.zshrc ~
ln -sfF ~/dotfiles/.iterm2.plist ~/.iterm2/com.googlecode.iterm2.plist
ln -sfF ~/dotfiles/.code-settings.json ~/Library/Application\ Support/Code/User/settings.json
ln -sfF ~/dotfiles/.code-keybindings.json ~/Library/Application\ Support/Code/User/keybindings.json

############################################################################
# Terminal
############################################################################

echo "Setting User Preferences folder"
defaults write com.googlecode.iterm2 LoadPrefsFromCustomFolder -bool TRUE
defaults write com.googlecode.iterm2 PrefsCustomFolder -string "~/.iterm2"

echo "Don’t display the annoying prompt when quitting iTerm"
defaults write com.googlecode.iterm2 PromptOnQuit -bool FALSE

echo "Installing command line tools..."
xcode-select --install

echo "Installing Homebrew & Homebrew Cask..."
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

echo "Installing zsh utilities..."
brew install git zsh
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.zsh-syntax-highlighting
chsh -s /bin/zsh

read -p "Work Laptop? Answer [y/n] " -n 1 -r
echo
if [[ $REPLY =~ ^[Nn]$ ]]
then
    git config --global credential.helper osxkeychain
    git config --global user.email "schaich.kevin@gmail.com"
    git config --global user.name "kevinschaich"
fi

############################################################################
# Homebrew
############################################################################

echo "Installing apps..."
brew cask install brave iterm2-beta visual-studio-code iina spotify caprine kap alfred

echo "Installing terminal utilities..."
brew install wget unrar python python3 tree node yarn
npm install --global pure-prompt

echo "Installing Fonts..."
brew tap caskroom/fonts
brew cask install font-hack font-fontawesome font-alegreya-sans-sc font-alegreya-sans font-alegreya-sc font-alegreya font-bebas-neue font-cardo font-charter font-code font-crimson-text font-droid-sans font-droid-sans-mono font-droid-serif font-fira-code font-fira-mono font-fira-sans font-fjord font-inconsolata font-josefin-sans font-josefin-slab font-lato font-league-gothic font-league-script font-league-spartan font-liberation-mono-for-powerline font-liberation-sans font-linden-hill font-lobster-two font-lora font-merriweather font-merriweather-sans font-montserrat font-nexa font-open-sans font-open-sans-condensed font-oswald font-playfair-display font-playfair-display-sc font-pt-mono font-pt-sans font-pt-serif font-quicksand font-raleway font-roboto font-roboto-condensed font-roboto-mono font-roboto-slab font-source-code-pro font-source-sans-pro font-source-serif-pro font-work-sans font-karla font-noto-sans font-arimo font-hind

echo "Installing Quick Look Utilities..."
brew cask install qlcolorcode qlstephen qlmarkdown quicklook-json quicklook-csv

################################################################################
# Trackpad, mouse, keyboard, Bluetooth accessories, and input
###############################################################################

echo "Disabling press-and-hold for special keys in favor of key repeat"
defaults write -g ApplePressAndHoldEnabled -bool false
defaults write -g KeyRepeat -int 2
defaults write -g InitialKeyRepeat -int 15

echo "Setting trackpad & mouse speed"
defaults write -g com.apple.trackpad.scaling 3
defaults write -g com.apple.mouse.scaling 3

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
defaults write com.apple.dock expose-animation-duration -float 0.1

echo "Finder: disable window animations and Get Info animations"
defaults write com.apple.finder DisableAllAnimations -bool true

echo "Set Dock to auto-hide and remove the auto-hiding delay"
defaults write com.apple.dock autohide -bool true
defaults write com.apple.dock autohide-delay -float 0
defaults write com.apple.dock autohide-time-modifier -float 0

echo "Disable window animations"
defaults write -g NSAutomaticWindowAnimationsEnabled -bool false

echo "Disable dashboard"
defaults write com.apple.dashboard mcx-disabled -boolean YES

echo "Minimize windows into their application’s icon"
defaults write com.apple.dock minimize-to-application -bool true

echo "Don’t animate opening applications from the Dock"
defaults write com.apple.dock launchanim -bool false

echo "Add delay for dragging windows to new spaces"
defaults write com.apple.dock workspaces-edge-delay -float 1.5

echo "Sort contacts by first name"
defaults write com.apple.AddressBook ABNameSortingFormat sortingFirstName

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

echo "Done!"
