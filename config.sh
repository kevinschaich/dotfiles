#!/bin/sh

# config.sh
# Author: Kevin Schaich
# schaich.kevin@gmail.com

# Instructions:
# To Run, execute:
# curl -L https://raw.githubusercontent.com/kevinschaich/dotfiles/master/config.sh | sh

echo "Installing command line tools"
xcode-select --install

echo "Installing Homebrew..."
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

echo "Updating Homebrew..."
brew doctor
brew update

echo "Installing terminal utilities..."
brew install git
brew install zsh
brew install zsh-completions
brew install zsh-history-substring-search
brew install zsh-completions
brew install zsh-syntax-highlighting
brew install wget
brew install unrar
brew install python
brew install python3
brew install flake8
brew install ruby
brew install tree
brew install makedepend
brew install node
brew install sqlite
brew install gcc
brew install caskroom/cask/brew-cask
brew tap caskroom/versions
brew tap caskroom/fonts

pip install pylint
pip install pytest

npm install -g browser-sync

curl https://install.meteor.com/ | sh

git config --global credential.helper osxkeychain
git config --global user.email "schaich.kevin@gmail.com"
git config --global user.name "kevinschaich"

echo "Installing applications/utilities/tools..."
brew cask install java
brew cask install iterm2
brew cask install pandoc
brew cask install google-chrome
brew cask install google-drive
brew cask install adobe-creative-cloud
brew cask install caffeine
brew cask install cyberduck
brew cask install skype
# brew cask install slack
brew cask install spotify
brew cask install mactex
# brew cask install sublime-text3
brew cask install utorrent
brew cask install vlc
brew cask install virtualbox
brew cask install vagrant
# brew cask install packer
brew cask install rstudio

brew cask install qlcolorcode
brew cask install qlstephen
brew cask install qlmarkdown
brew cask install quicklook-json
brew cask install quicklook-csv

brew tap homebrew/science
brew install r

echo "Installing Fonts..."
brew cask install font-hack
brew cask install font-fontawesome
brew cask install font-alegreya-sans-sc
brew cask install font-alegreya-sans
brew cask install font-alegreya-sc
brew cask install font-alegreya
brew cask install font-bebas-neue
brew cask install font-cardo
brew cask install font-charter
brew cask install font-code
brew cask install font-crimson-text
brew cask install font-droid-sans
brew cask install font-droid-sans-mono
brew cask install font-droid-serif
brew cask install font-fira-code
brew cask install font-fira-mono
brew cask install font-fira-sans
brew cask install font-fjord
brew cask install font-inconsolata
brew cask install font-josefin-sans
brew cask install font-josefin-slab
brew cask install font-lato
brew cask install font-league-gothic
brew cask install font-league-script
brew cask install font-league-spartan
brew cask install font-liberation-mono-for-powerline
brew cask install font-liberation-sans
brew cask install font-linden-hill
brew cask install font-lobster-two
brew cask install font-lora
brew cask install font-merriweather
brew cask install font-merriweather-sans
brew cask install font-montserrat
brew cask install font-nexa
brew cask install font-open-sans
brew cask install font-open-sans-condensed
brew cask install font-oswald
brew cask install font-playfair-display
brew cask install font-playfair-display-sc
brew cask install font-pt-mono
brew cask install font-pt-sans
brew cask install font-pt-serif
brew cask install font-quicksand
brew cask install font-raleway
brew cask install font-roboto
brew cask install font-roboto-condensed
brew cask install font-roboto-mono
brew cask install font-roboto-slab
brew cask install font-source-code-pro
brew cask install font-source-sans-pro
brew cask install font-source-serif-pro

echo "Cleaning up..."
brew cleanup

echo "Installing oh-my-zsh..."
curl -L https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh | sh

cd ~/.oh-my-zsh/custom/plugins
git clone git://github.com/zsh-users/zsh-syntax-highlighting.git

cd ~

# Set the colours you can use
black='\033[0;30m'
white='\033[0;37m'
red='\033[0;31m'
green='\033[0;32m'
yellow='\033[0;33m'
blue='\033[0;34m'
magenta='\033[0;35m'
cyan='\033[0;36m'

# Resets the style
reset=`tput sgr0`

# Color-echo. Improved. [Thanks @joaocunha]
# arg $1 = message
# arg $2 = Color
cecho() {
  echo "${2}${1}${reset}"
  return
}

# Here we go.. ask for the administrator password upfront and run a
# keep-alive to update existing `sudo` time stamp until script has finished
sudo -v
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

###############################################################################
# General UI/UX
###############################################################################

echo "Expanding the save panel by default"
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint -bool true
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint2 -bool true

echo "Automatically quit printer app once the print jobs complete"
defaults write com.apple.print.PrintingPrefs "Quit When Finished" -bool true

echo "Save to disk, rather than iCloud, by default"
defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false

echo "Reveal IP address, hostname, OS version, etc. when clicking the clock in the login window"
sudo defaults write /Library/Preferences/com.apple.loginwindow AdminHostInfo HostName

echo "Check for software updates daily, not just once per week"
defaults write com.apple.SoftwareUpdate ScheduleFrequency -int 1

echo "Removing duplicates in the 'Open With' menu"
/System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister -kill -r -domain local -domain system -domain user

###############################################################################
# General Power and Performance modifications
###############################################################################

# echo "Speeding up wake from sleep"
# http://www.cultofmac.com/221392/quick-hack-speeds-up-retina-macbooks-wake-from-sleep-os-x-tips/
# sudo pmset -a standbydelay 86400

################################################################################
# Trackpad, mouse, keyboard, Bluetooth accessories, and input
###############################################################################

echo "Disabling press-and-hold for special keys in favor of key repeat"
defaults read "Apple Global Domain" | grep -i press
defaults write "Apple Global Domain" ApplePressAndHoldEnabled -bool false

echo "Setting a blazingly fast keyboard repeat rate"
defaults write NSGlobalDomain InitialKeyRepeat -int 15

echo "Setting trackpad & mouse speed to a reasonable number"
defaults write -g com.apple.trackpad.scaling 3
defaults write -g com.apple.mouse.scaling 3

echo "Disable display from automatically adjusting brightness"
# sudo defaults write /Library/Preferences/com.apple.iokit.AmbientLightSensor "Automatic Display Enabled" -bool false

echo "Disable keyboard from automatically adjusting backlight brightness in low light"
# sudo defaults write /Library/Preferences/com.apple.iokit.AmbientLightSensor "Automatic Keyboard Enabled" -bool false

###############################################################################
# Screen
###############################################################################

echo "Disabling subpixel font rendering on non-Apple LCDs"
defaults write NSGlobalDomain AppleFontSmoothing -int 0

echo "Disabling subpixel font/image smoothing in Preview"
defaults write com.apple.Preview PVPDFAntiAliasOption 0

#echo "Enabling HiDPI display modes (requires restart)"
#sudo defaults write /Library/Preferences/com.apple.windowserver DisplayResolutionEnabled -bool true

###############################################################################
# Finder
###############################################################################

echo "Show the ~/Library folder by default"
chflags nohidden ~/Library/

echo "Show icons for hard drives, servers, and removable media on the desktop"
defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool true

echo "Show all filename extensions in Finder by default"
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

echo "Show status bar in Finder by default"
defaults write com.apple.finder ShowStatusBar -bool true

echo "Show path bar in Finder by default"
defaults write com.apple.finder ShowPathBar -bool true

echo "Display full POSIX path as Finder window title"
defaults write com.apple.finder _FXShowPosixPathInTitle -bool true

echo "Disable the warning when changing a file extension"
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

echo "Removing .DS_Store files"
sudo find / -name ".DS_Store"  -exec rm {} \;

echo "Use column view in all Finder windows by default"
defaults write com.apple.finder FXPreferredViewStyle Clmv

echo "Avoid creation of .DS_Store files on network volumes"
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true

echo "Disable disk image verification"
defaults write com.apple.frameworks.diskimages skip-verify -bool true
defaults write com.apple.frameworks.diskimages skip-verify-locked -bool true
defaults write com.apple.frameworks.diskimages skip-verify-remote -bool true

echo "Allowing text selection in Quick Look/Preview in Finder by default"
defaults write com.apple.finder QLEnableTextSelection -bool true

# echo "Remove Image Capture"
# sudo rm -rf /Applications/Image\ Capture.app

echo "Set user folder as the default location for new Finder windows"
defaults write com.apple.finder NewWindowTargetPath -string "file://${HOME}"

echo "Enable AirDrop over Ethernet and on unsupported Macs running Lion"
defaults write com.apple.NetworkBrowser BrowseAllInterfaces -bool true

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
defaults write NSGlobalDomain NSAutomaticWindowAnimationsEnabled -bool false

echo "Disable dashboard"
defaults write com.apple.dashboard mcx-disabled -boolean YES

echo "Minimize windows into their application’s icon"
defaults write com.apple.dock minimize-to-application -bool true

echo "Don’t animate opening applications from the Dock"
defaults write com.apple.dock launchanim -bool false

echo "Add delay for dragging windows to new spaces"
defaults write com.apple.dock workspaces-edge-delay -float 1.5

###############################################################################
# Chrome, Safari, & WebKit
###############################################################################

echo "Privacy: Don’t send search queries to Apple"
defaults write com.apple.Safari UniversalSearchEnabled -bool false
defaults write com.apple.Safari SuppressSearchSuggestions -bool true

echo "Hiding Safari's bookmarks bar by default"
defaults write com.apple.Safari ShowFavoritesBar -bool false

echo "Hiding Safari's sidebar in Top Sites"
defaults write com.apple.Safari ShowSidebarInTopSites -bool false

echo "Enabling Safari's debug menu"
defaults write com.apple.Safari IncludeInternalDebugMenu -bool true

echo "Making Safari's search banners default to Contains instead of Starts With"
defaults write com.apple.Safari FindOnPageMatchesWordStartsOnly -bool false

echo "Removing useless icons from Safari's bookmarks bar"
defaults write com.apple.Safari ProxiesInBookmarksBar "()"

echo "Enabling the Develop menu and the Web Inspector in Safari"
defaults write com.apple.Safari IncludeDevelopMenu -bool true
defaults write com.apple.Safari WebKitDeveloperExtrasEnabledPreferenceKey -bool true
defaults write com.apple.Safari "com.apple.Safari.ContentPageGroupIdentifier.WebKit2DeveloperExtrasEnabled" -bool true

echo "Adding a context menu item for showing the Web Inspector in web views"
defaults write NSGlobalDomain WebKitDeveloperExtras -bool true

echo "Disabling the annoying backswipe in Chrome"
defaults write com.google.Chrome AppleEnableSwipeNavigateWithScrolls -bool false
defaults write com.google.Chrome.canary AppleEnableSwipeNavigateWithScrolls -bool false

#echo "Using the system-native print preview dialog in Chrome"
#defaults write com.google.Chrome DisablePrintPreview -bool true
#defaults write com.google.Chrome.canary DisablePrintPreview -bool true

###############################################################################
# Mail/Contacts
###############################################################################

echo "Setting email addresses to copy as 'foo@example.com' instead of 'Foo Bar <foo@example.com>' in Mail.app"
defaults write com.apple.mail AddressesIncludeNameOnPasteboard -bool false

echo "Sort contacts by first name"
defaults write com.apple.AddressBook ABNameSortingFormat sortingFirstName

###############################################################################
# Time Machine
###############################################################################

echo "Prevent Time Machine from prompting to use new hard drives as backup volume"
defaults write com.apple.TimeMachine DoNotOfferNewDisksForBackup -bool true

###############################################################################
# Activity Monitor                                                            #
###############################################################################

echo "Show the main window when launching Activity Monitor"
defaults write com.apple.ActivityMonitor OpenMainWindow -bool true

echo "Visualize CPU usage in the Activity Monitor Dock icon"
defaults write com.apple.ActivityMonitor IconType -int 5

# echo "Show all processes in Activity Monitor"
# defaults write com.apple.ActivityMonitor ShowCategory -int 0

echo "Sort Activity Monitor results by CPU usage"
defaults write com.apple.ActivityMonitor SortColumn -string "CPUUsage"
defaults write com.apple.ActivityMonitor SortDirection -int 0

###############################################################################
# Better Snap Tool
###############################################################################

echo "Set up personal preferences for BetterSnapTool"
defaults write com.hegenberg.BetterSnapTool BSTAllowInsideDragSnap 1
defaults write com.hegenberg.BetterSnapTool BSTCornerRoundness 10
defaults write com.hegenberg.BetterSnapTool BSTDidAlreadyLaunchOnElCapitan 1
defaults write com.hegenberg.BetterSnapTool BSTDidAlreadyLaunchOnce 1
defaults write com.hegenberg.BetterSnapTool BSTDidUnhideLoginItem 1
defaults write com.hegenberg.BetterSnapTool BSTMemorySaver 1
defaults write com.hegenberg.BetterSnapTool NSColorPanelMode 6
defaults write com.hegenberg.BetterSnapTool 'NSToolbar Configuration com.apple.NSColorPanel' '{"TB Is Shown" = 1; }'
defaults write com.hegenberg.BetterSnapTool 'NSWindow Frame NSColorPanel' '780 505 224 325 0 0 2560 1417 '
defaults write com.hegenberg.BetterSnapTool launchOnStartup 1
defaults write com.hegenberg.BetterSnapTool maximizedDontRestore 1
defaults write com.hegenberg.BetterSnapTool noPaddingForMaximize 1
defaults write com.hegenberg.BetterSnapTool previewAnimationDuration "0.05"
defaults write com.hegenberg.BetterSnapTool previewBorderWidth 2
defaults write com.hegenberg.BetterSnapTool previewWindowBackgroundColor '<62706c69 73743030 d4010203 04050615 16582476 65727369 6f6e5824 6f626a65 63747359 24617263 68697665 72542474 6f701200 0186a0a3 07080f55 246e756c 6cd3090a 0b0c0d0e 554e5352 47425c4e 53436f6c 6f725370 61636556 24636c61 73734f10 20302030 2e363235 32393936 34363320 302e3739 38313633 34343920 302e3135 00100180 02d21011 12135a24 636c6173 736e616d 65582463 6c617373 6573574e 53436f6c 6f72a212 14584e53 4f626a65 63745f10 0f4e534b 65796564 41726368 69766572 d1171854 726f6f74 80010811 1a232d32 373b4148 4e5b6285 87898e99 a2aaadb6 c8cbd000 00000000 00010100 00000000 00001900 00000000 00000000 00000000 0000d2>'
defaults write com.hegenberg.BetterSnapTool recognitionArea 100
defaults write com.hegenberg.BetterSnapTool showMenubarIcon 0

###############################################################################
# Setup symlinks for .dotfiles
###############################################################################

echo "Setting up symlinks..."
cd ~ && git clone --recursive https://github.com/kevinschaich/dotfiles/ && cd dotfiles

ln -sfF ~/dotfiles/.bashrc ~
ln -sfF ~/dotfiles/.bash_profile ~
ln -sfF ~/dotfiles/.iterm2 ~
ln -sfF ~/dotfiles/.inputrc ~
ln -sfF ~/dotfiles/.vimrc ~
ln -sfF ~/dotfiles/.zshrc ~
sudo rm -rf ~/Library/Application\ Support/Sublime\ Text\ 3/
sudo ln -sfF ~/dotfiles/Sublime\ Text\ 3 ~/Library/Application\ Support/
sudo cp ~/dotfiles/dark.terminal /Applications/Utilities/Terminal.app/Contents/Resources/Initial\ Settings/
ln -s /Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl /usr/local/bin/subl

###############################################################################
# iTerm 2
###############################################################################

echo "Setting User Preferences folder"
defaults write com.googlecode.iterm2 LoadPrefsFromCustomFolder -bool TRUE
defaults write com.googlecode.iterm2 PrefsCustomFolder -string "~/.iterm2"

echo "Don’t display the annoying prompt when quitting iTerm"
defaults write com.googlecode.iterm2 PromptOnQuit -bool FALSE

###############################################################################
# Terminal
###############################################################################

echo "Enabling UTF-8 ONLY in Terminal.app and setting the dark theme by default"
defaults write com.apple.terminal StringEncodings -array 4
defaults write com.apple.Terminal "Default Window Settings" -string "Pro"
defaults write com.apple.Terminal "Startup Window Settings" -string "Pro"

###############################################################################
# Kill affected applications
###############################################################################

cecho "Done!" $cyan
cecho "################################################################################" $white
cecho "Note that some of these changes require a logout/restart to take effect." $red
cecho "Killing some open applications in order to take effect." $red

find ~/Library/Application\ Support/Dock -name "*.db" -maxdepth 1 -delete
for app in "Activity Monitor" "Address Book" "Calendar" "Contacts" "cfprefsd" \
  "Dock" "Finder" "Mail" "Messages" "Safari" "SystemUIServer" \
  "Transmission"; do
  killall "${app}" > /dev/null 2>&1
done
