#!/bin/zsh

local LOG_PREFIX="[setup dev env]:"

echo "$LOG_PREFIX setting up node dev env..."

# create node install dir
mkdir -p $HOME/.fnm && echo "$LOG_PREFIX created node install dir: ~/.fnm"

# install LTS node version
if [[ ! $(fnm list | grep -q lts) ]]; then
  echo "$LOG_PREFIX installing node LTS version..."
  fnm install --lts
else
  echo "$LOG_PREFIX node LTS version already installed on this system"
fi

echo "$LOG_PREFIX node dev env setup complete!"
