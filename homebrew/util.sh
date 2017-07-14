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
brew install yarn
brew install mysql
brew install mongodb
pip install pylint
pip install pytest

echo "Installing Quick Look Utilities..."
brew cask install qlcolorcode
brew cask install qlstephen
brew cask install qlmarkdown
brew cask install quicklook-json
brew cask install quicklook-csv

# brew cask install google-chrome-beta
# brew cask install firefox
