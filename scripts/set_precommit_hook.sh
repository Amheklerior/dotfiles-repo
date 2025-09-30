#!/bin/zsh

local LOG_PREFIX="[setting dotfiles repo dev env]:"

local PRE_COMMIT_HOOK="$DOTFILES_REPO/.git/hooks/pre-commit"

if [ ! -e $PRE_COMMIT_HOOK ]; then
  echo "$LOG_PREFIX setting up pre-commit hooks..."
  cat $DOTFILES_REPO/bin/pre-commit > $PRE_COMMIT_HOOK
  chmod +x $PRE_COMMIT_HOOK
else
  echo "$LOG_PREFIX pre-commit hook already present!"
  echo "$LOG_PREFIX Do you want to override its content? [y/n]"
  read -r reply

  if [[ "$reply" != [yY] ]]; then
    echo "Cool! Leavin' it as is then!"
    return 0
  fi

  echo "$LOG_PREFIX Overriding the pre-commit hook..."
  cat $DOTFILES_REPO/bin/pre-commit > $PRE_COMMIT_HOOK
fi
