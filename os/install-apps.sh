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
brew cask install aptanastudio
brew cask install camtasia
brew cask install clipgrab
brew cask install diffmerge
brew cask install dropbox
brew cask install evernote
brew cask install filezilla
brew cask install firefox
brew cask install fontforge
brew cask install gas-mask
brew cask install google-chrome
brew cask install google-chrome-canary
brew cask install imagealpha
brew cask install imageoptim
brew cask install LICEcap
brew cask install menumeters
brew cask install sequel-pro
brew cask install sketch
brew cask install skype
brew cask install slack
brew cask install virtualbox
brew cask install vlc
brew cask install xquartz
