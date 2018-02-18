#!/bin/bash

# Update brew
brew update

# Upgrade installed formulae
brew upgrade


# Install Cask
brew tap caskroom/cask

# Install Cask Versions (alternate versions of apps)
brew tap caskroom/versions

# Install apps using Cask
brew cask install android-studio
brew cask install anki
brew cask install aptanastudio
brew cask install clipgrab
brew cask install diffmerge
brew cask install dropbox
brew cask install evernote
brew cask install filezilla
brew cask install firefox
brew cask install gas-mask
brew cask install google-chrome
brew cask install google-chrome-canary
brew cask install imagealpha
brew cask install imageoptim
brew cask install kap
brew cask install licecap
brew cask install macdown
brew cask install menumeters
brew cask install postman
brew cask install sequel-pro
brew cask install sketch
brew cask install skitch
brew cask install skyfonts
brew cask install skype
brew cask install slack
brew cask install spectacle
brew cask install toggl
brew cask install virtualbox
brew cask install visual-studio-code
brew cask install vlc

# The following need to be sequential

brew cask install xquartz
brew cask install fontforge

# Improve QuickLook in Finder
brew cask install qlcolorcode qlstephen qlmarkdown quicklook-json qlprettypatch
brew cask install quicklook-csv betterzipql qlimagesize webpquicklook suspicious-package

# Other useful apps
brew install rename
brew install ssh-copy-id

# cURL with http2 support
brew install curl --with-nghttp2

# Clean up
brew cleanup
