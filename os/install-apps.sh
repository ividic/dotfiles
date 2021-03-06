#!/bin/bash

source '../shell/utils/utils.sh'

ask_for_confirmation "Install Homebrew?"
if answer_is_yes; then
	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
fi

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
brew cask install brave-browser
brew cask install clipgrab
brew cask install cyberduck
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
brew cask install microsoft-edge
brew cask install microsoft-office
brew cask install nightowl
brew cask install postman
brew cask install rectangle
brew cask install royal-tsx
brew cask install sequel-pro
brew cask install sizzy
brew cask install sketch
brew cask install skitch
brew cask install skype
brew cask install slack
brew cask install toggl
brew cask install unnaturalscrollwheels
brew cask install virtualbox
brew cask install visual-studio-code
brew cask install vlc

# The following need to be sequential

brew cask install xquartz
brew cask install fontforge

# Improve QuickLook in Finder
brew cask install qlcolorcode qlstephen qlmarkdown quicklook-json qlprettypatch
brew cask install quicklook-csv betterzip qlimagesize webpquicklook suspicious-package

# Other useful apps
brew install rename
brew install ssh-copy-id
brew install bash-completion

# cURL with http2 support
brew install curl

# Clean up
brew cleanup

echo "Note: Download MenuMeters manually as the cask version is for macOS <= 10.10"
