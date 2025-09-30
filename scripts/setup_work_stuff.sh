#!/bin/zsh

local LOG_PREFIX="[Setup work-related stuff]:"

local SSH_KEYNAME=work-server
local HH_NPM_REGISTRY="https://npm.pkg.github.com"

# decrypt and copy the github access token into the system clipboard for later use
echo "$LOG_PREFIX Please enter the decryption password for copying the github access token"
local GITHUB_TOKEN=$(ansible-vault decrypt $DOTFILES_REPO/secrets/github-access-token --output -)

# setup work ssh key-pair for accessing the production server
if [ -e "$HOME/.ssh/$SSH_KEYNAME" ]; then
  echo "$LOG_PREFIX ssh keys to access work production server are already set up"
else
  echo "$LOG_PREFIX setting up work-related ssh keys"
  cp $DOTFILES_REPO/ssh-keys/$SSH_KEYNAME $DOTFILES_REPO/ssh-keys/$SSH_KEYNAME.pub $HOME/.ssh
  echo "$LOG_PREFIX Please enter the decryption password for decrypting the private ssh keys"
  ansible-vault decrypt $HOME/.ssh/$SSH_KEYNAME && echo "$LOG_PREFIX work ssh keys setup complete"
fi

# login into the Heritage Holdings npm registry hosted on Github
if [[ $(npm whoami --registry=$HH_NPM_REGISTRY 2>/dev/null) == "Amheklerior" ]]; then
  echo "$LOG_PREFIX already logged in to HH npm registry via GitHub account"
else
  cat $GITHUB_TOKEN | pbcopy
  echo "$LOG_PREFIX token successfully copied on your clipboard!"

  # logging in to the HH npm registry
  echo "$LOG_PREFIX logging in to HH npm registry $HH_NPM_REGISTRY!
    When prompted, instert GitHub username (lowercase) as username
    and paste the TOKEN copied above as password..."
  npm login --scope=@heritageholdings --registry=$HH_NPM_REGISTRY
fi

# setup work laptop via automation script
curl -fsSL -H "Authorization: token $GITHUB_TOKEN" "https://raw.githubusercontent.com/heritageholdings/dev-onboarding/refs/heads/main/setup.sh" | /bin/bash
