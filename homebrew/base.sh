#!/bin/bash

echo "Installing command line tools..."
xcode-select --install

echo "Installing Homebrew..."
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew doctor
brew update
brew tap caskroom/versions
brew install caskroom/cask/brew-cask

echo "Installing zsh utilities..."
brew install git
brew install zsh
brew install zsh-completions
brew install zsh-history-substring-search
brew install zsh-completions
brew install zsh-syntax-highlighting

echo "Installing iTerm2..."
brew cask install iterm2

echo "Installing Sublime Text dev build..."
brew cask install sublime-text-dev

echo "Cleaning Up..."
brew cleanup