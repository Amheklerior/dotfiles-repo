#!/bin/zsh

LOG_PREFIX="[system preferences]:"

# -------------------------------------
# Table of Content:
# -------------------------------------
# - Computer Name
# - Software Updates
# - Language / Locale / Formats
# - Timezone
# - Power Management
# - Screen Saver
# - Appearance / UI
# - Screens
# - Audio / Sounds
# - Keyboard
# - Typing
# - Mouse & Trackpad
# - Gestures
# - Login Window
# - Screenshots
# - Disable unused systems
# - Quality of Life
# - Dock
# - Windows / Navigation
# - Desktop
# - Finder
# - APPLY CHANGES

echo "$LOG_PREFIX starting system preferences setup..."

# Close any open System Preferences panes, to prevent them from overriding
# settings we’re about to change
osascript -e 'tell application "System Preferences" to quit'

# Ask for the administrator password upfront
sudo -v

#------------------------------------------------------------------------------------#
#                            • Computer Name •                                       #
#------------------------------------------------------------------------------------#

_prompt_for_confirmation "$LOG_PREFIX Do you want to set the computer name?"
if _has_confirmed; then
	echo "$LOG_PREFIX which name do you want to give to this computer? (amheklerior)" && read
	local name=$REPLY
	if [[ $name == "" ]]; then; name=amheklerior; fi

	# Set computer name
	sudo scutil --set ComputerName $name
	sudo scutil --set HostName $name
	sudo scutil --set LocalHostName $name
	defaults write com.apple.rapport familySyncedName -string $name
fi

#------------------------------------------------------------------------------------#
#                            • Software Updates •                                    #
#------------------------------------------------------------------------------------#
echo "$LOG_PREFIX enabling automatic software updates preferences..."

local updates="/Library/Preferences/com.apple.SoftwareUpdates"

# Automatically check for software updates and download them
sudo defaults write $updates AutomaticCheckEnabled -bool true
sudo defaults write $updates AutomaticDownload -bool true

# Automatically install critical updates
sudo defaults write $updates ConfigDataInstall -bool true
sudo defaults write $updates CriticalUpdateInstall -bool true

#------------------------------------------------------------------------------------#
#                       • Language / Locale / Formats •                              #
#------------------------------------------------------------------------------------#
echo "$LOG_PREFIX setting favorite languages, locales, and formats..."

# Set preferred languages
defaults write -g AppleLanguages -array "en-US" "it-IT"

# Set locale to IT keeping the EN language
# drive formats for date/time, number, currencies, etc
defaults write -g AppleLocale -string "en_IT"
defaults write -g AKLastLocale -string "en_IT"
defaults write com.apple.dock region -string "IT"
defaults write com.apple.iCal NotificationsLastLocale -string "en_IT"
defaults write com.apple.iCal BirthdayEventsGenerationLastLocale -string "en_IT"

# Switch to Fahrenheit as temperature unit (leave unset for Celsius)
# defaults write -g AppleTemperatureUnit -string "Fahrenheit"

# Leave unset to maintain Monday as first day of the week
# defaults delete -g AppleFirstWeekday

# Leave unset to maintain the metric system for units
# NOTE: possible values are:
# ----------------------------------------------------------------
# system            AppleMetricUnits        AppleMeasurementUnits
# ----------------------------------------------------------------
# Metric            leave unset             leave unset
# Imperial (US)     0                       "Inches"
# Imperial (UK)     1                       "Inches"
# ----------------------------------------------------------------
# defaults write -g AppleMetricUnits -int 0
# defaults write -g AppleMeasurementUnits -int "Inches"

# Set 12-hours time format
# defaults write -g AppleICUForce12HourTime -bool true

#------------------------------------------------------------------------------------#
#                                 • Timezone •                                       #
#------------------------------------------------------------------------------------#
echo "$LOG_PREFIX enabling location-based timezone..."

# Enable date and time syncrhorization
sudo systemsetup -setusingnetworktime on

# Set timezone atuomatically based on current location
sudo defaults write /Library/Preferences/com.apple.timezone.auto Active -bool true

# Set system timezone manually (remember to disable the automatic timezone option above)
# NOTE: run `sudo systemsetup -listtimezones` for other values
# sudo systemsetup -settimezone "Europe/Rome" >/dev/null

# Apply timezone changes
# NOTE: it doesn't work due to insufficient permissions. 
# The System Integrity Protection (SIP) prevents the command to be run.
# Simply restarting the system should be enough to achieve the same result.
# sudo launchctl kickstart -k system/com.apple.locationd

#------------------------------------------------------------------------------------#
#                             • Power Management •                                   #
#------------------------------------------------------------------------------------#
echo "$LOG_PREFIX setting up power management preferences..."

# Set sleep times when on AC Power
sudo pmset -c displaysleep 10
sudo pmset -c disksleep 0
sudo pmset -c sleep 0

# Set sleep times when on battery
sudo pmset -b displaysleep 5
sudo pmset -b disksleep 10
sudo pmset -b sleep 10

# Maximize performance on AC Power, but reduce energy usage on battery
sudo pmset -c lowpowermode 0
sudo pmset -b lowpowermode 1

# Slightly dim display on battery
sudo pmset -b lessbright 1

# Enable lid wakeup (lifting the screen lid up wakes the system)
sudo pmset -a lidwake 1

# Enable wakeup when devices with same Cloud ID are near
sudo pmset -a proximitywake 1

# Enable wakup when switching power source
sudo pmset -a acwake 1

# Enable wakup on network access, unless on battery
sudo pmset -a womp 1
sudo pmset -b womp 0


# Hibernate mode:
#  0: Disable hibernation (speeds up sleep/wake operations)
#  3: Copy RAM to disk (can restore state in case of power failure)
# 25: Copy RAM to disk and power it off (better battery life)
#
# NOTE: Here's a table with the implications of each option
# --------------------------------------------------------------------------------
# setting     RAM copy to disk    RAM power during sleep            restore state
# --------------------------------------------------------------------------------
# 0           off                 on                                off
# 3           on                  on (unless a power loss occur)    on
# 25          on                  off                               on
# --------------------------------------------------------------------------------
sudo pmset -a hibernatemode 0

#------------------------------------------------------------------------------------#
#                              • Screen Saver •                                      #
#------------------------------------------------------------------------------------#
echo "$LOG_PREFIX setting up screen saver preferences..."

# Start Screen saver when inactive for 5 minutes
# NOTE: set to 0 to never have screensaver
defaults write com.apple.screensaver idleTime -int 300

# Require password immediately after sleep or screen saver begins
defaults write com.apple.screensaver askForPassword -int 1
defaults write com.apple.screensaver askForPasswordDelay -int 0

#------------------------------------------------------------------------------------#
#                              • Appearance / UI •                                   #
#------------------------------------------------------------------------------------#
echo "$LOG_PREFIX setting up appearance and UI preferences..."

# Switch to Dark theme
# NOTE: other options are:
# - `Light` -> leave both unset
# - `Auto`  -> only set `AppleInterfaceStyleSwithesAutomatically` to 1
defaults write -g AppleInterfaceStyle -string "Dark"
# defaults write -g AppleInterfaceStyleSwitchesAutomatically -int 1

# Set sidebar icon size to (1) small, (2) medium, (3) large
defaults write -g NSTableViewDefaultSizeMode -int 1

# Disable animations for opening windows and getting file/dir info
defaults write com.apple.finder DisableAllAnimations -bool true

# Show scrollbar: `WhenScrolling`, `Automatic`, `Always`
defaults write -g AppleShowScrollBars -string "WhenScrolling"

# Enable wallpaper tinting in windows
defaults write -g AppleReduceDesktopTinting -bool false

# Hide desktop icons when windows are open
defaults write com.apple.WindowManager StandardHideDesktopIcons -bool false

# Widgets appearance: (0) monochrome, (1) in full color, or (2) automatic
defaults write com.apple.widgets widgetAppearance -int 2

# Disable focus ring animation
defaults write -g NSUseAnimatedFocusRing -bool false

# Set the menu bar to autohide on fullscreen only
defaults write -g AppleMenuBarVisibleInFullscreen -bool false
defaults write -g _HIHideMenuBar -bool false

# Set accent and highlight colors
# NOTE: you can mix between accent and highlight colors...
# ------------------------------------------------------------------------------
# desired       accent        highlight                             aqua var
# ------------------------------------------------------------------------------
# multicolor    leave unset   leave unset                           leave unset
# blue          4             0.698039 0.843137 1.000000 Blue       1
# purple        5             0.968627 0.831373 1.000000 Purple     1
# pink          6             1.000000 0.749020 0.823529 Pink       1
# red           0             1.000000 0.749020 0.823529 Red        1
# orange        1             1.000000 0.874510 0.701961 Orange     1
# yellow        2             1.000000 0.937255 0.690196 Yellow     1
# green         3             0.752941 0.964706 0.678431 Green      1
# graphite      -1            0.847059 0.847059 0.862745 Graphite   6
# ------------------------------------------------------------------------------
# defaults write -g AppleAccentColor -int 3
# defaults write -g AppleHighlightColor -string "0.752941 0.964706 0.678431 Green"
# defaults write -g AppleAquaColorVariant -int 1

#------------------------------------------------------------------------------------#
#                                • Screens •                                         #
#------------------------------------------------------------------------------------#
echo "$LOG_PREFIX optimizing screen settings for non-Apple LCDs..."

# Enable subpixel font rendering on non-Apple LCDs
# Reference: https://github.com/kevinSuttle/macOS-Defaults/issues/17#issuecomment-266633501
defaults write -g AppleFontSmoothing -int 1

# Enable HiDPI display modes (requires restart)
sudo defaults write /Library/Preferences/com.apple.windowserver DisplayResolutionEnabled -bool true

#------------------------------------------------------------------------------------#
#                             • Audio / Sounds •                                     #
#------------------------------------------------------------------------------------#
echo "$LOG_PREFIX setting up audio and sound preferences..."

# Disable the sound effects on system boot (%00 to reenable it)
sudo nvram StartupMute="%01"

# Play UI sound effects
defaults write -g com.apple.sound.uiaudio.enabled -bool true

# Don't play feedback sound on volume change
defaults write -g com.apple.sound.beep.feedback -bool false
  
# Alerts volume 
# NOTE: it's not the general output volume 
defaults write -g com.apple.sound.beep.volume -float 0.7

# Increase sound quality for Bluetooth headphones/headsets
defaults write com.apple.BluetoothAudioAgent "Apple Bitpool Min (editable)" -int 40

#------------------------------------------------------------------------------------#
#                               • Keyboard •                                         #
#------------------------------------------------------------------------------------#
echo "$LOG_PREFIX setting up keyboard preferences..."

# Enable full keyboard access for all controls (move focus with Tab and Shift+Tab)
defaults write -g AppleKeyboardUIMode -int 2

# Disable press-and-hold for keys in favor of key repeat
# defaults write -g ApplePressAndHoldEnabled -bool false

# Set a blazingly fast keyboard repeat rate
# defaults write -g KeyRepeat -int 1
# defaults write -g InitialKeyRepeat -int 10

# Function keys default behaviour: 
# `true`:   F1, F2, etc. behave as standard function keys
# `false`:  pressing a function key will perform the special feature printed on that key
defaults write -g com.apple.keyboard.fnState -bool false

# Fn/🌐︎ key press behaviour:
# 0: do nothing
# 1: change input source (swhith between keyboard layouts)
# 2: show emojis, symbols, and more
# 3: start dictation
defaults write com.apple.HIToolbox AppleFnUsageType -int 0

# Use large window for emoji and symbols 
defaults write com.apple.CharacterPaletteIM CVStartAsLargeWindow -int 1

#------------------------------------------------------------------------------------#
#                               • Typing •                                           #
#------------------------------------------------------------------------------------#
echo "$LOG_PREFIX optimizing typing experience..."

# Clear replacement dictionary
defaults write -g NSUserDictionaryReplacementItems -array

# Disable autocorrection
defaults write -g NSAutomaticSpellingCorrectionEnabled -bool false

# Disable automatic capitalization
defaults write -g NSAutomaticCapitalizationEnabled -bool false

# Disable automatic dash, period, and quote substitution 
defaults write -g NSAutomaticDashSubstitutionEnabled -bool false
defaults write -g NSAutomaticPeriodSubstitutionEnabled -bool false
defaults write -g NSAutomaticQuoteSubstitutionEnabled -bool false

#------------------------------------------------------------------------------------#
#                           • Mouse & Trackpad •                                     #
#------------------------------------------------------------------------------------#
echo "$LOG_PREFIX setting up mouse and trackpad preferences..."

# Set a high tracking speed
defaults write -g com.apple.trackpad.scaling -float 2.5

# Disable tap-to-click
defaults write com.apple.AppleMultitouchTrackpad Clicking -bool false
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool false

# Click threshold: (0) Light, (1) Medium, (2) Firm
defaults write com.apple.AppleMultitouchTrackpad FirstClickThreshold -int 1
defaults write com.apple.AppleMultitouchTrackpad SecondClickThreshold -int 1

# Prefer sublte clicking sound
defaults write com.apple.AppleMultitouchTrackpad ActuationStrenght -int 0

# Disable force-click and haptic feedback
defaults write com.apple.AppleMultitouchTrackpad ActuateDetents -int 0
defaults write com.apple.AppleMultitouchTrackpad ForceSuppressed -bool true

# Disable builtin trackpad when an external mouse/trackpad is connected
defaults write com.apple.AppleMultitouchTrackpad USBMouseStopsTrackpad -int 1
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad USBMouseStopsTrackpad -int 1

# Click the scroll bar to jump to:
# 0: the next page or
# 1: the spot that's clicked
defaults write -g AppleScrollerPagingBehavior -int 1

# Prefer natural direction (content follows fingers direction)
defaults write -g com.apple.swipescrolldirection -int 1

#------------------------------------------------------------------------------------#
#                              • Gestures •                                          #
#------------------------------------------------------------------------------------#
echo "$LOG_PREFIX setting up gestures..."

# NOTE: A lot of gestures have been disabled to push myself towards a keyboard-only workflow

# Secondary click with: two-fingers click
defaults write -g ContextMenuGesture -int 1
defaults write com.apple.AppleMultitouchTrackpad TrackpadRightClick -bool true
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadRightClick -bool true

# Pinch to zoom
defaults write com.apple.AppleMultitouchTrackpad TrackpadPinch -bool true
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadPinch -bool true

# Double-tap with two fingers to zoom 
defaults write com.apple.AppleMultitouchTrackpad TrackpadTwoFingerDoubleTapGesture -bool true
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadTwoFingerDoubleTapGesture -bool true

# Rotate with two fingers
defaults write com.apple.AppleMultitouchTrackpad TrackpadRotate -bool true
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadRotate -bool true

# Swipe between pages with two-fingers horizonal scroll
defaults write -g AppleEnableSwipeNavigateWithScrolls -bool true

# Swipe between spaces with three-fingers horizontal scroll
defaults write com.apple.AppleMultitouchTrackpad TrackpadThreeFingerHorizSwipeGesture -int 0
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadThreeFingerHorizSwipeGesture -int 0

# Open notification center with two-finger left-scroll from the right edge
defaults write com.apple.AppleMultitouchTrackpad TrackpadTwoFingerFromRightEdgeSwipeGesture -int 3
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadTwoFingerFromRightEdgeSwipeGesture -int 3
 
# Disable gestures: Mission Control, App Expose
defaults write com.apple.dock showMissionControlGestureEnabled -bool false
defaults write com.apple.dock showAppExposeGestureEnabled -bool false
defaults write com.apple.AppleMultitouchTrackpad TrackpadThreeFingerVertSwipeGesture -int 0
defaults write com.apple.AppleMultitouchTrackpad TrackpadFourFingerVertSwipeGesture -int 0
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadThreeFingerVertSwipeGesture -int 0
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadFourFingerVertSwipeGesture -int 0

# Disable festures: App Launchpad, Desktop Reveal
defaults write com.apple.dock showLaunchpadGestureEnabled -bool false
defaults write com.apple.dock showDesktopGestureEnabled -bool false 
defaults write com.apple.AppleMultitouchTrackpad TrackpadFourFingerPinchGesture -int 0
defaults write com.apple.AppleMultitouchTrackpad TrackpadFiveFingerPinchGesture -int 0
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadFourFingerPinchGesture -int 0
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadFiveFingerPinchGesture -int 0

#------------------------------------------------------------------------------------#
#                              • Login Window •                                      #
#------------------------------------------------------------------------------------#
echo "$LOG_PREFIX setting up login window screen appearance..."

local loginwindow=/Library/Preferences/com.apple.loginwindow

# Hide user name and avatar
sudo defaults write $loginwindow HideUserAvatarAndName -bool true

# Don't show a custom message
sudo defaults write $loginwindow LoginwindowText -string ""

# Don't show password hint
sudo defaults write $loginwindow RetriesUntilHint -int 0

# Show the Sleep, Restart and Shutdown buttons
sudo defaults write $loginwindow PowerOffDisabled -bool false

# Reveal IP address, hostname, OS version, etc. when clicking the clock in the login window
sudo defaults write $loginwindow AdminHostInfo HostName

#------------------------------------------------------------------------------------#
#                             • Screenshots •                                        #
#------------------------------------------------------------------------------------#
echo "$LOG_PREFIX configuring screenshots format and location..."

# Screenshots format: `png`, `bmp`, `gif`, `jpg`, `pdf`, `tiff`, `psd`, `tga`, 
defaults write com.apple.screencapture type -string "png"

# Save screenshots to the desktop
defaults write com.apple.screencapture location -string "${HOME}/Desktop"

# Include date and time on screenshot name
defaults write com.apple.screencapture include-date -bool true

# Disable shadow in screenshots
defaults write com.apple.screencapture disable-shadow -bool true

#------------------------------------------------------------------------------------#
#                        • Disable unused systems •                                  #
#------------------------------------------------------------------------------------#
echo "$LOG_PREFIX disabling Siri, Spotlight, Notification center, and other unused systems..."

# Disable Siri
defaults write com.apple.assistant.support "Assistant Enabled" -bool false
defaults write com.apple.Siri StatusMenuVisible -bool false
defaults write com.apple.Siri VoiceTriggerUserEnabled -bool false
defaults write com.apple.Siri SiriPrefStashedStatusMenuVisible -bool false

# Disable all hot-corners operations
defaults write com.apple.dock wvous-tl-corner -int 0
defaults write com.apple.dock wvous-tl-modifier -int 0
defaults write com.apple.dock wvous-tr-corner -int 0
defaults write com.apple.dock wvous-tr-modifier -int 0
defaults write com.apple.dock wvous-bl-corner -int 0
defaults write com.apple.dock wvous-bl-modifier -int 0
defaults write com.apple.dock wvous-br-corner -int 0
defaults write com.apple.dock wvous-br-modifier -int 0

# Disable spotlight indexing for all volumes,
# sudo mdutil -a -i off &> /dev/null
# ...clear index dirs on the main volume,
# sudo mdutil -X / &> /dev/null
# ...and remove spotlight keyboard shortcut
# /usr/libexec/PlistBuddy -c "Set :AppleSymbolicHotKeys:64:enabled 0" \
# "$HOME/Library/Preferences/com.apple.symbolichotkeys.plist"

# Disable local Time Machine backups
# hash tmutil &> /dev/null && sudo tmutil disable local

# Disable Notification Center
# launchctl unload -w /System/Library/LaunchAgents/com.apple.notificationcenterui.plist 2> /dev/null

# Disable the “Are you sure you want to open this application?” dialog
# defaults write com.apple.LaunchServices LSQuarantine -bool false

# Disable the crash reporter
# defaults write com.apple.CrashReporter DialogType -string "none"

# Disable automatic termination of inactive apps
defaults write -g NSDisableAutomaticTermination -bool true

#------------------------------------------------------------------------------------#
#                           • Quality of Life •                                      #
#------------------------------------------------------------------------------------#
echo "$LOG_PREFIX setting up quality of life preferences..."

# Show notification previews: (1) never, (2) when unlocked, (3) always
defaults write com.apple.ncprefs content_visibility -int 2

# Close all windows when quitting an app (no restore when reopening)
defaults write com.apple.systempreferences NSQuitAlwaysKeepsWindows -bool false

# Share focus across devices (activating it on one device, activates it for all)
defaults write com.apple.donotdisturb disableCloudSync -bool false

# Use iPhone widgets
defaults write com.apple.chronod remoteWidgetsEnabled -bool true

# Prevent Photos from opening automatically when devices are plugged in
defaults -currentHost write com.apple.ImageCapture disableHotPlug -bool true

# Allow text selection in images
defaults write -g AppleLiveTextEnabled -bool true

# Double-click a window's title bar to: 'Maximize', 'Minimize', 'None' (do nothing)
defaults write -g AppleActionOnDoubleClick -string "None"

# Prevent Time Machine from prompting to use new hard drives as backup volume
defaults write com.apple.TimeMachine DoNotOfferNewDisksForBackup -bool true

# Save to disk (not to iCloud) by default
defaults write -g NSDocumentSaveNewDocumentsToCloud -bool false

#------------------------------------------------------------------------------------#
#                                   • Dock •                                         #
#------------------------------------------------------------------------------------#
echo "$LOG_PREFIX configuring the Dock..."

# Dock position on screen: `bottom`, `left`, `right`
defaults write com.apple.dock orientation -string "bottom"

# Automatically hide and show the Dock
defaults write com.apple.dock autohide -bool true

# Autohide animation properties: in seconds (requires autohide)
# NOTE: Impractically slow to force myself not using it at all
defaults write com.apple.dock autohide-delay -float 1000

# Set dock icons size in pixels
defaults write com.apple.dock tilesize -int 36

# Set dock icons to grow on hover
defaults write com.apple.dock magnification -bool true
defaults write com.apple.dock largesize -int 48

# Animate opening apps
defaults write com.apple.dock launchanim -bool true

# Show indicator lights for running apps
defaults write com.apple.dock show-process-indicators -bool true

# Minimize windows into their application’s icon
defaults write com.apple.dock minimize-to-application -bool true

# Change minimize/maximize window animation effect: `genie`, `scale`, `suck`
defaults write com.apple.dock mineffect -string "scale"

# Show suggested and recent apps on the dock
defaults write com.apple.dock show-recents -bool false

# Wipe all (default) apps from the Dock, then add the favourite apps
defaults write com.apple.dock persistent-apps -array

#------------------------------------------------------------------------------------#
#                          • Windows / Navigation •                                  #
#------------------------------------------------------------------------------------#
echo "$LOG_PREFIX setting up window and navigation preferences..."

# Prefer tabs when opening documents: 'always', 'manual', or when in 'fullscreen'
defaults write -g AppleWindowTabbingMode -string "fullscreen"

# Reveal desktop when clicking the wallpaper
defaults write com.apple.WindowManager EnableStandardClickToShowDesktop -bool true 

# When switching to an app, go to space with open windows of that app
defaults write -g AppleSpacesSwitchOnActivate -bool true

# Group windows by application in Mission Control
defaults write com.apple.dock expose-group-apps -bool true

# Don’t automatically rearrange Spaces based on most recent use
defaults write com.apple.dock mru-spaces -bool false

# Displays have separate spaces
defaults write com.apple.spaces spans-displays -bool false

#------------------------------------------------------------------------------------#
#                               • Desktop •                                          #
#------------------------------------------------------------------------------------#
echo "$LOG_PREFIX configuring the Desktop..."

# Set a custom wallpaper image. `DefaultDesktop.jpg` is already a symlink, and
# all wallpapers are in `/Library/Desktop Pictures/`.
# rm -rf ~/Library/Application Support/Dock/desktoppicture.db
# sudo rm -rf /System/Library/CoreServices/DefaultDesktop.jpg
# sudo ln -s $HOME/.dotfiles/wallpapers/sunrise-deer.jpeg /System/Library/CoreServices/DefaultDesktop.jpg

# Hide all icons
defaults write com.apple.finder CreateDesktop -bool false

# Group directories on top, regardless of sort type
defaults write com.apple.finder _FXSortFoldersFirstOnDesktop -bool "true"

# Don't show hard drives, removable media, and connected servers on Desktop
defaults write com.apple.finder ShowHardDrivesOnDesktop -bool false
defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool false
defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool false
defaults write com.apple.finder ShowMountedServersOnDesktop -bool false

# Show item info near icons
# /usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:showItemInfo true" ~/Library/Preferences/com.apple.finder.plist

# Enable snap-to-grid for icons
# /usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist

# Set size and grid spacing for icons
# /usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:iconSize 64" ~/Library/Preferences/com.apple.finder.plist
# /usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:gridSpacing 80" ~/Library/Preferences/com.apple.finder.plist

#------------------------------------------------------------------------------------#
#                               • Finder •                                           #
#------------------------------------------------------------------------------------#
echo "$LOG_PREFIX configuring Finder..."

# Set Home as the default location for new Finder windows
defaults write com.apple.finder NewWindowTarget -string "PfLo"
defaults write com.apple.finder NewWindowTargetPath -string "file://${HOME}/"

# Don't allow quitting Finder via ⌘ + Q
defaults write com.apple.finder QuitMenuItem -bool false

# Show path bar
defaults write com.apple.finder ShowPathbar -bool true

# Finder: show status bar
defaults write com.apple.finder ShowStatusBar -bool true

# Display full POSIX path as Finder window title
# defaults write com.apple.finder _FXShowPosixPathInTitle -bool true

# Open dirs in new windows
defaults write com.apple.finder FinderSpawnTab -bool false

# Remove all tags
defaults write com.apple.finder FavoriteTagNames -array
defaults write com.apple.finder FavoriteTags -array

# Expand the following File Info panes:
# “General”, “Open with”, and “Sharing & Permissions”
defaults write com.apple.finder FXInfoPanesExpanded -dict \
	General -bool true \
	OpenWith -bool true \
	Privileges -bool true

# Disable disk image verification
defaults write com.apple.frameworks.diskimages skip-verify -bool true
defaults write com.apple.frameworks.diskimages skip-verify-locked -bool true
defaults write com.apple.frameworks.diskimages skip-verify-remote -bool true

# Automatically open a new Finder window when a volume is mounted
defaults write com.apple.frameworks.diskimages auto-open-ro-root -bool true
defaults write com.apple.frameworks.diskimages auto-open-rw-root -bool true
defaults write com.apple.finder OpenWindowForNewRemovableDisk -bool true

# Enable AirDrop over Ethernet and on unsupported Macs running Lion
defaults write com.apple.NetworkBrowser BrowseAllInterfaces -bool true

# View style in all Finder windows by default:
# `icnv` -> Icon view
# `clmv` -> Column view
# `glyv` -> Gallery view
# `Nlsv` -> List view
defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"

# Show hidden files by default (Toggle with ⌘ + SHIFT + .)
defaults write com.apple.finder AppleShowAllFiles -bool true

# Show /Volumes and /Library dirs
# sudo chflags nohidden /Volumes
# chflags nohidden ~/Library && xattr -d com.apple.FinderInfo ~/Library

# Group directories on top, regardless of sort type
defaults write com.apple.finder _FXSortFoldersFirst -bool true

# Always show file extensions
defaults write -g AppleShowAllExtensions -bool true

# Disable the warning when changing a file extension
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

# When performing a search, search the current directory by default
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"

# Enable spring loading for directories, with no delay
defaults write -g com.apple.springing.enabled -bool true
defaults write -g com.apple.springing.delay -float 0

# Avoid creating .DS_Store files on network or USB volumes
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true

# Show item info near icons
# /usr/libexec/PlistBuddy -c "Set :FK_StandardViewSettings:IconViewSettings:showItemInfo true" ~/Library/Preferences/com.apple.finder.plist
# /usr/libexec/PlistBuddy -c "Set :StandardViewSettings:IconViewSettings:showItemInfo true" ~/Library/Preferences/com.apple.finder.plist

# Enable snap-to-grid for icons
# /usr/libexec/PlistBuddy -c "Set :FK_StandardViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist
# /usr/libexec/PlistBuddy -c "Set :StandardViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist

# Set the size of icons
# /usr/libexec/PlistBuddy -c "Set :FK_StandardViewSettings:IconViewSettings:iconSize 64" ~/Library/Preferences/com.apple.finder.plist
# /usr/libexec/PlistBuddy -c "Set :StandardViewSettings:IconViewSettings:iconSize 64" ~/Library/Preferences/com.apple.finder.plist

# Set grid spacing for icons
# /usr/libexec/PlistBuddy -c "Set :FK_StandardViewSettings:IconViewSettings:gridSpacing 80" ~/Library/Preferences/com.apple.finder.plist
# /usr/libexec/PlistBuddy -c "Set :StandardViewSettings:IconViewSettings:gridSpacing 80" ~/Library/Preferences/com.apple.finder.plist

# Remove Dropbox’s green checkmark icons in Finder
# file=/Applications/Dropbox.app/Contents/Resources/emblem-dropbox-uptodate.icns
# [ -e "${file}" ] && mv -f "${file}" "${file}.bak"

#------------------------------------------------------------------------------------#
#                           • APPLY CHANGES •                                        #
#------------------------------------------------------------------------------------#
echo "$LOG_PREFIX applying changes to the system..."

# Cleanup current Dock state
find "${HOME}/Library/Application Support/Dock" -name "*-*.db" -maxdepth 1 -delete &> /dev/null

# Restart affected applications and apply changes...
for app in "Activity Monitor" "cfprefsd" "Dock" "Finder" "SystemUIServer"; do
	killall "${app}" &> /dev/null
done

# Restart the system
echo "$LOG_PREFIX done! Some settings may require a logout/restart to take effect."
_prompt_for_confirmation "$LOG_PREFIX Do you want to restart now?"
if _has_confirmed; then
	echo "$LOG_PREFIX restarting now..."
	sudo shutdown -r now
fi
