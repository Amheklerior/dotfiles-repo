# System setup guide

This is a step-by-step guide for me to use as a reference in setting up a brand new machine.

## High level overview

1. [Complete the Apple's welcome journey](./setup-guide.md#complete-the-apples-welcome-journey)
2. [Install CLI dev tools](./setup-guide.md#install-cli-dev-tools)
3. [Install dotfiles](./setup-guide.md#install-dotfiles)
4. [Setup system prefs](./setup-guide.md#setup-system-preferences)
5. [Connect internet accounts](./setup-guide.md#connect-internet-accounts)
6. [Setup touch id](./setup-guide.md#setup-touch-id)
7. [Setup Apple Wallet](./setup-guide.md#setup-apple-wallet)
8. [Enable FileVault disk encryption](./setup-guide.md#enable-filevault-disk-encryption)
9. [Setup apps prefs](./setup-guide.md#setup-apps-preferences)
10. [Finishing touches](./setup-guide.md#finishing-touches-notification-settings--login-items--apple-intelligence--etc)

## Complete the Apple's welcome journey

Follow the steps presented to you, making sure you skip migration assistant and do the following instead:

- set fav languages to: `en-US` and `it`
- set country to: `Italy`
- set keyboard input lang to: `en-US`
- connect apple account via the personal apple-id
- create a computer account: `Andrea Amato` (`amheklerior`)
- check the _allow my apple account to reset this password_ checkbox
- keep FileVault disabled (will be [enabled afterwards](./setup-guide.md#enable-filevault-disk-encryption))
- after completion, update the mac to the lates OS version available

_**NOTE**. Leave the rest as is (accessibility settings, services, payment cards, etc..)_

## Install CLI dev tools

Open a new terminal window and run the following shell command:

```sh
xcode-select --install 
```

_**NOTE**. an installation window will popup. Follow the instructions._

## Install dotfiles

Open a new terminal window and run the following shell command:

```sh
# clone this repo via http protocol
git clone https://github.com/Amheklerior/dotfiles-repo $HOME/.dotfiles

# run the setup script into the current shell
source $HOME/.dotfiles/bootstrap.sh

# optionally: setup the computer for work
source $HOME/.dotfiles/scripts/setup_work.sh
```

## Setup system preferences

Open a new terminal window and run the following shell command:

```sh
source $HOME/.dotfiles/scripts/load_sys_prefs.sh
```

Restart the system to make sure all new preferences get loaded.

## Connect internet accounts

Go to `System Settings` > `Internet Accounts` and add the following accounts:

- my main personal google account for email and calendar
- my secondary yahoo account for emails only
- my work google account for calendar only

## Setup touch id

Go to `System Settings` > `Touch ID & Password`, and register 3 alternative fingerprints.

_**NOTE**. This is only relevant on laptop devices (i.e. it's not applicable to mac mini)_

## Setup Apple Wallet

Open the Apple Wallet app and register all payment cards, one by one.

Make sure to enable `hide-my-email` for payments via Apple Wallet.  

_**NOTE**. This is only relevant on laptop devices (it requires a magic keyboard to be setup on mac mini)_

## Enable FileVault disk encryption

Go to `System Settings` > `Privacy & Security` > `FileVault`, and turn it on.

Make sure to save the recovery-key on the [dotfiles repo's `/secrets` dir](../secrets/).

## Setup apps preferences

First, [disable System Integrity Protection (SIP)](./setup-guide.md#enablingdisabling-sip-system-integrity-protection-on-macos) (This is necessary to be able to setup Apple apps preferences via scripts).

Then, open a new terminal window and run the following shell commands:

```sh
source $HOME/.dotfiles/scripts/load_app_prefs.sh
```

[Re-eneble the SIP](./setup-guide.md#enablingdisabling-sip-system-integrity-protection-on-macos) and restart.

### Raycast

Open **Raycast** app and complete the welcome journey, making sure to:

- not install any extension
- set it to open at login
- set it to replace the macos emoji picker
- grant it full access to _calendar_ / _contacts_ / _file system_ / _accessibility_

Then [import raycast settings](./prefs.md#raycast). Finally, go to `Settings` > `Keyboard` > `Keyboard Shortcuts...` > `Spotlight` and remove the shortcut for Spotlight.

### Mail

Open **Apple Mail** app to connect with the accounts and sync all mails. Then do the following:

- Order the mail boxes as: _main_ - _secondary_ - _work_
- Move the _Newsletter_ mail folder within the favorites list
- Go to `Settings` > `Fonts & colors` and opt for warmer tones (Cantalupe / Salmon / Honeydew)

### Notes

Open **Apple Notes** app to sync all notes from iCloud. Then do the following:

- Set gallery view over list view
- Go to `Settings` and sort notes by title
- Go to `Settings` and enable touch-id to unlock notes

### Calendar

Open **Apple Calendar** app to connect with the accounts. Then do the following:

- Select the wanted calendars
- Go to `Settings` > `General` and set _start-time_ to _8:00_ and _end-time_ to _22:00_
- Go to `Settings` > `General` and set the view to a _14 hours_ window
- Go to `Settings` > `Alerts` and set to NOT show invitation messages in notification center
- Go to `Settings` > `Alerts` and remove all default alerts (making sure it's the same for all calendars)
- Go to `Settings` > `Advanced` and set to show events in year view
- Go to `Settings` > `Advanced` and set to show week numbers

### Contacts

Open **Apple Contact** app to sync all contacts from iCloud. Then do the following:

- Go to `Settings` > `General` and make sure the address format is set to "Italy"
- Go to `Settings` > `Template` and add _Nickname_ and _Job Title_, and remove _Pronouns_ and _External links_

### Safari

Open **Apple Safari** browser and make sure the start page does not have the _recently closed tabs_, _suggestions_, and _privacy report_ sections.

### Finder

Open a **Finder** window and do the following:

- Go to `Settings` > `Sidebar` and remove _recent_, _applications_, and add the _home dir_
- Go to `Settings` > `Tags` and delete all tags
- From the sidebar, add _Inbox_, _Ongoing/Tmp_, _Recources_, and _Archive_ iCloud dirs
- From the sidebar, set the following order: _home_, _desktop_, _documents_, _downloads_, _airdrop_

### Telegram

Open **Telegram** app and log in with QR code via the iPhone, and then do the following:

- Enable mic and cam access
- Go to `Settings` > `General` and disable large emoji
- Go to `Settings` > `Notifications` and set to not include channels in notification badge
- Go to `Settings` > `Data & storage` and enable adult content
- Go to `Settings` > `Appearance` and set theme from _night accent_ to _system_
- Go to `Settings` > `Appearance` and set app icon to _flat B/W_

### Other Apps

- Open **Apple Messages** app to sync all messages from iCloud.
- Open **Apple Photos** app to sync all photos from iCloud.
- Open **Keyclu** and grant it accessibility access rights.
- Open **AltTab** and grant it accessibility access rights only (no screen recording).
- Open **Hiddenbar** and declutter the menu bar.
- Open **Cloudflare Warp** and switch to use `1.1.1.1` DNS resolution only (instead of `1.1.1.1` DNS + `WARP` Tunneling)

## Finishing touches: notification settings / login items / Apple Intelligence / etc

- Enable and configure **Apple Intelligence**
- Go to `Settings` > `General` > `Login Items and Extensions` and add **Raycast**, **AltTab**, **HiddenBar**, **Chai**, and **KeyClu**.
- Go to `Settings` > `Displays` and set an appropriate display resolution (_more space_ on macbook air)
- Go to `Settings` > `Wallpaper`, add the wallpaper directory and set wallpaper rotation.
- Go to `Settings` > `Screen Saver` and disable screen saver.
- Go to `Settings` > `Accessibility` > `Display` and enable grayscale color filtering (second notch).
- Go to `Settings` > `Notification` and set system and apps notifications.

## Enabling/Disabling SIP (System Integrity Protection) on MacOS

To disable SIP, reboot the machine in recovery mode and run `csrutil disable` from a terminal window.

To reenable SIP, reboot the machine in recovery mode and run `csrutil enable` from a terminal window.

_**NOTE**. To [reboot the machine in recovery mode](https://support.apple.com/en-gb/guide/mac-help/mchl82829c17/mac), completely shut down the machine, then hold the power button until you see "loading options..." on screen. Then select "recovery mode"._
