#!/bin/zsh

local BACKUP_DIR=$(ls $HOME/.dotfiles/backups | fzf)

local _restore_backup() {
  [[ $* != *"-c"* ]] && to="$HOME" || to=$XDG_CONFIG_HOME
  if [ -e $1 ] || [ -L $1 ]; then
    mv $1 $to && echo "$1 restored from backup"
  else
    echo "$1 not found"
  fi
}

# shell dotfiles
_restore_backup $BACKUP_DIR/.zshrc
_restore_backup $BACKUP_DIR/.zprofile
_restore_backup $BACKUP_DIR/.zshenv
_restore_backup $BACKUP_DIR/.zalias
_restore_backup $BACKUP_DIR/.zfunc

# git configs
_restore_backup $BACKUP_DIR/.gitconfig

# ssh configs
_restore_backup $BACKUP_DIR/.ssh

# other config files
_restore_backup $BACKUP_DIR/.config/delta -c 
_restore_backup $BACKUP_DIR/.config/ghostty -c
_restore_backup $BACKUP_DIR/.config/plugins -c
_restore_backup $BACKUP_DIR/.config/.bunfig.toml -c
_restore_backup $BACKUP_DIR/.config/starship.toml -c

# remove the now empty backup dir
rm -d $BACKUP_DIR/.config && rm -d $BACKUP_DIR
echo "Backup dir $BACKUP_DIR deleted"