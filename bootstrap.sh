#!/bin/zsh

# clone this repository
if [ ! -e $HOME/.dotfiles ]; then
  echo "cloning the repository into your machine"
  git clone https://github.com/Amheklerior/dotfiles-repo $HOME/.dotfiles
else
  echo "repo already present, making sure it's up to date"
  cd $HOME/.dotfiles && git pull || exit 1
fi

# run the setup script
cd $HOME/.dotfiles && source ./setup-system.sh
