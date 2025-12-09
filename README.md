# dotfiles repo

This is my personal dotfiles repo. Feel free to explore it, copy bits and pieces for your own dotfiles, or fork the whole repo.

> **! NOTE**\
> These dotfiles are tailored to my liking. If you want to use them, fork the repo, review the code, remove anything you don't want or need, and enjoy.

## Platform Compatibility ⚠

The dotfiles and setup automation scripts in this repository are designed with macOS systems in mind.

## Installation process

The installation process is largely automated, with only a few manual steps involved.

In a nutshell, to install the dotfiles on a brand new system, simply run the following shell commands:

```sh
# install the command line dev tools
xcode-select --install 

# clone this repo via http protocol
git clone https://github.com/Amheklerior/dotfiles-repo $HOME/.dotfiles

# run the setup script into the current shell
source $HOME/.dotfiles/bootstrap.sh
```

## Repository Overview

Here's an high level overview of the repository structure

```sh
dotfiles-repo/
⋮
├── dotfiles/
│   └── # home of the actual dotfiles 
├── prefs/
│   └── # where all system and apps preferences are stored
├── scripts/
│   └── # scripts used by the automated setup process
⋮
├── bootstrap.sh # the setup script
├── Brewfile # the bundle of all system packages, apps, and vscode extensions to be installed
└── README.md # this readme file
```

[`bootstrap.sh`](./bootstrap.sh) is the setup script. It's designed to be [**idempotent**](https://en.wikipedia.org/wiki/Idempotence), which means you can safely run it multiple times and expect operations to be done only once.

It runs the setup scripts in the [`scripts/`](./scripts/) directory.

It uses [`homebrew`](https://brew.sh) as the system package manager, which gets first installed and then leveraged to install all system packages, apps, fonts, and vscode extensions defined in the [`Brewfile`](./Brewfile).

The actual dotfiles are located in the [`dotfiles/`](./dotfiles/) directory. They are symlinked into the user's `$HOME` dir using [`GNU stow`](https://www.gnu.org/software/stow/). This makes it easy to update them without having to manually synk them between the system and the repo.

The process will also load all settings and preferences for the MacOS system and the installed apps. You can find the  [`prefs/macos/defaults.sh`](./prefs/macos/defaults.sh) is the script that sets all system preferences, the apps prefs occupy the rest of the [`prefs/`](./prefs/) direcotry.

## Feedback

If you have any suggestion/improvement [be my guest](https://github.com/Amheklerior/dotfiles/issues)!

## Credits

Special thanks to:

- the [github's dotfiles community](https://dotfiles.github.io/) which has been a great source of ideas and inspiration
- [Michael Paulson (aka The Primeagen)](https://www.youtube.com/c/ThePrimeagen) for his [_developer productivity_ course](https://frontendmasters.com/courses/developer-productivity/)
- [Patrick Mcdonald](https://twitter.com/eieioxyz) for his [_dotfiles from start to finish-ish_ course](https://www.udemy.com/course/dotfiles-from-start-to-finish-ish/)
- [Mathia's macos sensible default settings](https://github.com/mathiasbynens/dotfiles/blob/main/.macos), and [macos-defaults.com](https://macos-defaults.com/), used as reference for automating macos system settings, and [`plistwatch`](https://github.com/catilac/plistwatch) which made it easier to experiment with, and iterate over, system and app's settings.
