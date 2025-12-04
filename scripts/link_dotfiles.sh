#!/bin/zsh

local LOG_PREFIX="[link dotfiles]:"

local DOTFILES="$DOTFILES_REPO/dotfiles"

# first, create the folder structure
# NOTE: this is necessary to prevent GNU stow from linking the directories
# rather than their content.
mkdir -p $XDG_CONFIG_HOME
mkdir -p $HOME/.ssh

# if dotfiles are already present relink them
# NOTE: using .zshrc as a proxy for all dotfiles, since they are all linked 
# in a single atomic action
if [ -e $HOME/.zshrc ]; then
  echo "$LOG_PREFIX dotfiles already present, relinking them..."
  stow -d $DOTFILES -t $HOME . -R
else
  echo "$LOG_PREFIX linking dotfiles..."
  stow -d $DOTFILES -t $HOME . -S
fi

# load dotfiles into current shell
source $HOME/.zshenv
source $HOME/.zprofile
source $HOME/.zshrc

echo "$LOG_PREFIX dotfiles linked successfully"
