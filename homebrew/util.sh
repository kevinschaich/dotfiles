#!/bin/bash

echo "Installing terminal utilities..."
brew install wget
brew install unrar
brew install python
brew install python3
brew install flake8
brew install ruby
brew install tree
brew install makedepend
brew install node
npm install -g browser-sync
brew install sqlite
brew install gcc
pip install pylint
pip install pytest
curl https://install.meteor.com/ | sh

echo "Installing Quick Look Utilities..."
brew cask install qlcolorcode
brew cask install qlstephen
brew cask install qlmarkdown
brew cask install quicklook-json
brew cask install quicklook-csv

brew cask install google-chrome
