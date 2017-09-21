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
    mkdir ~/Library/Application\ Support/Code\ -\ Insiders/
    ln -sfF ~/dotfiles/vscode ~/Library/Application\ Support/Code\ -\ Insiders/User

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

    echo "Bootstrapping personal settings"
    bash ~/dotfiles/script/config.sh

    ############################################################################
    # Install Utilities
    ############################################################################

    echo "Bootstrapping base terminal config..."
    bash ~/dotfiles/homebrew/base.sh

    echo "Installing Terminal Utilities"
    bash ~/dotfiles/homebrew/util.sh

    ############################################################################
    # Install Apps
    ############################################################################

    read -p "Work Laptop? Answer [y/n] " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Nn]$ ]]
    then
        # do dangerous stuff
        bash ~/dotfiles/homebrew/apps.sh

        git config --global credential.helper osxkeychain
        git config --global user.email "schaich.kevin@gmail.com"
        git config --global user.name "kevinschaich"
    fi


    ############################################################################
    # Install Fonts
    ############################################################################

    echo "Installing Fonts"
    bash ~/dotfiles/homebrew/fonts.sh
fi

echo "Done!"
