#!/bin/zsh

local LOG_PREFIX="[Install packages and apps]:"

# install packages, fonts, apps, and vscode extensions from the Brewfile bundle
echo "$LOG_PREFIX installing packages, apps, and vscode extensions from the bundle..."
brew bundle check || brew bundle install --verbose || :

# install utility to monitor plist changes (of great help in automating app prefs)
go install github.com/catilac/plistwatch@latest

# cleanup and check for any warnings/errors
brew cleanup
brew doctor || :
