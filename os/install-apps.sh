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
brew install --cask anki
brew install --cask brave-browser
brew install --cask clipgrab
brew install --cask docker
brew install --cask dropbox
brew install --cask evernote
brew install --cask firefox
brew install --cask gas-mask
brew install --cask google-chrome
brew install --cask google-chrome-canary
brew install --cask imagealpha
brew install --cask imageoptim
brew install --cask kap
brew install --cask karabiner-elements
brew install --cask licecap
brew install --cask menumeters
brew install --cask microsoft-edge
brew install --cask microsoft-office
brew install --cask postman
brew install --cask raycast
brew install --cask rectangle
brew install --cask royal-tsx
brew install --cask sequel-ace
brew install --cask skitch
brew install --cask slack
brew install --cask unnaturalscrollwheels
brew install --cask virtualbox
brew install --cask visual-studio-code
brew install --cask vlc

# The following need to be sequential

brew install --cask xquartz
brew install --cask fontforge

# Improve QuickLook in Finder
brew install --cask qlcolorcode qlstephen qlmarkdown quicklook-json
brew install --cask quicklook-csv betterzip qlimagesize webpquicklook suspicious-package

# Other useful apps
brew install rename
brew install ssh-copy-id
brew install bash-completion
brew install jq
brew install the_silver_searcher # ag
brew install lf # list files
brew install iperf # network performance measuring

# cURL with http2 support
brew install curl

# bun
brew tap oven-sh/bun
brew install bun

# Clean up
brew cleanup

# echo "Note: Download MenuMeters manually as the cask version is for macOS <= 10.10"
