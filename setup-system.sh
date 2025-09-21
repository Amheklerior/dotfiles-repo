#!/bin/zsh

local LOG_PREFIX="[system bootstrap]:"

local DOTFILES_REPO="$HOME/.dotfiles"
local SCRIPTS="$DOTFILES_REPO/scripts"
local XDG_CONFIG_HOME="$HOME/.config"
local XDG_DATA_HOME="$HOME/.local/share"

local _run() {
  local script="$SCRIPTS/$1.sh"
  if [ -e $script ]; then
    source $script
  else
    echo "ERROR: script $script not found!"
    exit 1
  fi
}

# ensure the process exits on any error
set -e

# load utility functions
source "$SCRIPTS/utils.sh"

# create dir for temporary files
mkdir -p $XDG_DATA_HOME

echo "$LOG_PREFIX Sit down and relax, system is going to be ready soon..."

# system bootstrap steps
_run check_sys_requirements
_run remove_current_dotfiles
_run install_and_setup_homebrew
_run install_packages
_run setup_ssh_keys
_run setup_github_account
_run setup_shell
_run install_shell_plugins
_run link_dotfiles
_run enable-touchid-for-sudo-access
_run set_precommit_hook
_run setup_dev_env

# switch dotfiles repo from https protocol to SSH
cd $DOTFILES_REPO && git remote set-url origin git@github.com:Amheklerior/dotfiles-repo.git

# setup machine for work
_prompt_for_confirmation "$LOG_PREFIX Do you want to setup this machine as a work machine?"
if _has_confirmed; then
  _run setup_work_stuff
fi

# cofigure system's settings to my liking
_prompt_for_confirmation "$LOG_PREFIX Do you want to load system preferences"
if _has_confirmed; then 
  _run load_sys_prefs
fi

# configure applications' settings to my liking
_prompt_for_confirmation "$LOG_PREFIX Do you want to load apps preferences"
if _has_confirmed; then 
  _run load_app_prefs
fi

echo "$LOG_PREFIX Done! You're ready to rock \m/"