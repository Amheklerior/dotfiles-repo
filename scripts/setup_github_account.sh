#!/bin/zsh

local LOG_PREFIX="[setup github account]:"

if gh auth status >/dev/null 2>&1; then
  echo "$LOG_PREFIX github already setup"
  return
fi

echo "$LOG_PREFIX setting up github cli"

# decrypt and copy the github ACCESS_TOKEN to the clipboard
gpg --decrypt $DOTFILES_REPO/secrets/github-access-token | pbcopy
echo "$LOG_PREFIX token successfully copeid on your clipboard! Paste it during the installation process..."

# login to the github account
gh auth login

# cleanup temporary files
rm $XDG_DATA_HOME/gh-login-token

echo "$LOG_PREFIX github cli setup complete!"