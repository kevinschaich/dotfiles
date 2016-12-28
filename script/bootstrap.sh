#!/bin/bash

echo "Before continuing, please BACK UP your dotfiles!"
echo

read -p "Install (override) dotfiles and install utilities? Answer [y/n] " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]
then
    # do dangerous stuff

    ############################################################################
    # Setup symlinks for .dotfiles
    ############################################################################

    echo "Setting up symlinks..."

    ln -sfF ~/dotfiles/.iterm2 ~
    ln -sfF ~/dotfiles/.inputrc ~
    ln -sfF ~/dotfiles/.vimrc ~
    ln -sfF ~/dotfiles/.zshrc ~
    ln -sfF ~/dotfiles/.oh-my-zsh ~
    sudo rm -rf ~/Library/Application\ Support/Sublime\ Text\ 3/
    sudo ln -sfF ~/dotfiles/Sublime\ Text\ 3 ~/Library/Application\ Support/
    sudo cp ~/dotfiles/dark.terminal /Applications/Utilities/Terminal.app/Contents/Resources/Initial\ Settings/
    ln -s /Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl /usr/local/bin/subl


    ############################################################################
    # Terminal
    ############################################################################

    echo "Setting User Preferences folder"
    defaults write com.googlecode.iterm2 LoadPrefsFromCustomFolder -bool TRUE
    defaults write com.googlecode.iterm2 PrefsCustomFolder -string "~/.iterm2"

    echo "Don’t display the annoying prompt when quitting iTerm"
    defaults write com.googlecode.iterm2 PromptOnQuit -bool FALSE

    echo "Enabling UTF-8 ONLY in Terminal.app and setting the dark theme by default"
    defaults write com.apple.terminal StringEncodings -array 4
    defaults write com.apple.Terminal "Default Window Settings" -string "Pro"
    defaults write com.apple.Terminal "Startup Window Settings" -string "Pro"


    ############################################################################
    # Settings
    ############################################################################

    read -p "Bootstrap personal settings? Answer [y/n] " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]
    then
        # do dangerous stuff
        bash ~/dotfiles/script/config.sh
    fi


    ############################################################################
    # Git credential helper
    ############################################################################

    read -p "Configure git credential helper (kevinschaich)? Answer [y/n] " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]
    then
        # do dangerous stuff
        git config --global credential.helper osxkeychain
        git config --global user.email "schaich.kevin@gmail.com"
        git config --global user.name "kevinschaich"
    fi


    ############################################################################
    # Install Utilities
    ############################################################################

    # from http://stackoverflow.com/questions/1885525/how-do-i-prompt-a-user-for-confirmation-in-bash-script
    read -p "Install utilities? Answer [y/n] " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]
    then
        # do dangerous stuff
        bash ~/dotfiles/homebrew/util.sh
    fi


    ############################################################################
    # Install Apps
    ############################################################################

    read -p "Install apps? Answer [y/n] " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]
    then
        # do dangerous stuff
        bash ~/dotfiles/homebrew/apps.sh
    fi


    ############################################################################
    # Install Fonts
    ############################################################################

    read -p "Install fonts? Answer [y/n] " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]
    then
        # do dangerous stuff
        bash ~/dotfiles/homebrew/fonts.sh
    fi
fi

echo "Done!"
