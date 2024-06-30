#!/bin/bash

source '../shell/utils/utils.sh'

ask_for_confirmation "Install zsh? Make sure brew is installed first!"
if answer_is_yes; then
	# Install and configure zsh
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

  brew install powerlevel10k
  echo "source $(brew --prefix)/share/powerlevel10k/powerlevel10k.zsh-theme" >>~/.zshrc

  brew install zsh-autosuggestions
  echo "source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh" >> ~/.zshrc
fi
