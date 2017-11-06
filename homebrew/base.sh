#!/bin/bash

echo "Installing command line tools..."
xcode-select --install

echo "Installing Homebrew & Homebrew Cask..."
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew doctor
brew update
brew tap caskroom/versions
brew install caskroom/cask/brew-cask

echo "Installing zsh utilities..."
brew install git
brew install zsh
git clone --recursive git@github.com:kevinschaich/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"

setopt EXTENDED_GLOB
for rcfile in "${ZDOTDIR:-$HOME}"/.zprezto/runcoms/^README.md(.N); do
  ln -s "$rcfile" "${ZDOTDIR:-$HOME}/.${rcfile:t}"
done

chsh -s /bin/zsh

echo "Installing iTerm2..."
brew cask install iterm2-beta

echo "Installing VS Code insiders build..."
brew cask install visual-studio-code-insiders

code-insiders --install-extension PeterJausovec.vscode-docker
code-insiders --install-extension Zarel.sublime-commands
# code-insiders --install-extension christian-kohler.npm-intellisense
# code-insiders --install-extension christian-kohler.path-intellisense
code-insiders --install-extension eamodio.gitlens
code-insiders --install-extension eg2.tslint
code-insiders --install-extension esbenp.prettier-vscode
code-insiders --install-extension ms-vscode.atom-keybindings
code-insiders --install-extension msjsdiag.debugger-for-chrome
# code-insiders --install-extension rafaelmaiolla.remote-vscode
code-insiders --install-extension stringham.move-ts
# code-insiders --install-extension wmaurer.vscode-jumpy
code-insiders --install-extension zhuangtongfa.Material-theme

echo "Installing IINA"
brew cask install iina

echo "Installing Spotify"
brew cask install spotify

echo "Cleaning Up..."
brew cleanup
