#!/bin/zsh

local LOG_PREFIX="[applications preferences]:"

local _load_settings() {
  echo "$LOG_PREFIX loading preferences for $1 app..."
  # silence any 'Domain XXX not found' errors (prefs get set anyway)
  # NOTE: the error is only thrown when using defaults via this script,
  # not when executing directly the commands on the shell prompt.
  source $HOME/.dotfiles/prefs/apps/$1-settings.sh 2> /dev/null
}

_load_settings apple-mail
_load_settings apple-notes
_load_settings apple-saffari
_load_settings apple-passwords
_load_settings apple-contacts
_load_settings vscode
_load_settings alt-tab
_load_settings keyclu
_load_settings hiddenbar