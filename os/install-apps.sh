#!/bin/bash

source '../shell/utils/utils.sh'

ask_for_confirmation "Install Homebrew?"
if answer_is_yes; then
	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# Update brew
brew update

# Upgrade installed formulae
brew upgrade

# Install apps using Cask
brew install --cask anki
brew install --cask altair-graphql-client
brew install --cask claude-code
brew install --cask docker
brew install --cask dropbox
brew install --cask gas-mask
brew install --cask ghostty
brew install --cask google-chrome
brew install --cask google-chrome-canary
brew install --cask kap
brew install --cask menumeters
brew install --cask microsoft-edge
brew install --cask microsoft-office
brew install --cask mysqlworkbench
brew install --cask obsidian
brew install --cask postman
brew install --cask raycast
brew install --cask royal-tsx
brew install --cask sequel-ace
brew install --cask shottr
brew install --cask slack
brew install --cask virtualbox
brew install --cask visual-studio-code
brew install --cask vivaldi
brew install --cask vlc

# Improve QuickLook in Finder
brew install --cask jpc-qlcolorcode qlstephen qlmarkdown quicklook-json
brew install --cask quicklook-csv betterzip suspicious-package

# Other useful apps
brew install asimov #  Ignore node_modules folders in Time Machine backups
brew install f2
brew install rename
brew install ssh-copy-id
brew install bash-completion
brew install jq
brew install the_silver_searcher # ag
brew install lf # list files
brew install fd # list folder contents
brew install iperf # network performance measuring

# cURL with http2 support
brew install curl

# Clean up
brew cleanup
