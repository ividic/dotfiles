#!/bin/bash

# Inspiration:
# https://github.com/alrra/dotfiles/blob/master/src/os/preferences/macos
# https://github.com/mathiasbynens/dotfiles/blob/master/.macos
# http://www.defaults-write.com

cd "$(dirname "$BASH_SOURCE")" \
    && source '../shell/utils/utils.sh'


# ---------------------------


print_in_purple "\n   Close System Preferences Pane\n\n"

osascript -e 'tell application "System Preferences" to quit'


ask_for_sudo

# Disable the sound effects on boot
sudo nvram SystemAudioVolume=" "


# ---------------------------


print_in_purple "\n   Computer Name\n\n"

ask_for_confirmation "Change computer name?"
if answer_is_yes; then
    ask "What would you like it to be? "
    computer_name="$(get_answer)"
    execute "sudo defaults write /Library/Preferences/SystemConfiguration/com.apple.smb.server NetBIOSName -string '$computer_name' && \
             sudo scutil --set ComputerName '$computer_name' && \
             sudo scutil --set HostName '$computer_name' && \
             sudo scutil --set LocalHostName '$computer_name'" \
        "Set computer name"
fi


# ---------------------------


print_in_purple "\n   App Store\n\n"

execute "defaults write com.apple.appstore WebKitDeveloperExtras -bool true" \
    "Enable the WebKit Developer Tools"

execute "defaults write com.apple.appstore ShowDebugMenu -bool true" \
    "Enable debug menu"

execute "defaults write com.apple.commerce AutoUpdate -bool true" \
    "Turn on auto-update"

execute "defaults write com.apple.SoftwareUpdate AutomaticCheckEnabled -bool true" \
    "Enable automatic update check"

execute "defaults write com.apple.SoftwareUpdate AutomaticDownload -int 1" \
    "Download newly available updates in background"

execute "defaults write com.apple.SoftwareUpdate CriticalUpdateInstall -int 1" \
    "Install System data files and security updates"

killall "App Store" &> /dev/null


# ---------------------------


print_in_purple "\n   Chrome\n\n"

execute "defaults write com.google.Chrome AppleEnableSwipeNavigateWithScrolls -bool false && \
         defaults write com.google.Chrome AppleEnableMouseSwipeNavigateWithScrolls -bool false" \
    "Disable backswipe (Chrome)"

execute "defaults write com.google.Chrome.canary AppleEnableSwipeNavigateWithScrolls -bool false && \
         defaults write com.google.Chrome.canary AppleEnableMouseSwipeNavigateWithScrolls -bool false" \
    "Disable backswipe (Chrome Canary)"

execute "defaults write com.google.Chrome PMPrintingExpandedStateForPrint2 -bool true" \
    "Expand print dialog by default"

# execute "defaults write com.google.Chrome DisablePrintPreview -bool true" \
#     "Use system-native print preview dialog"

killall "Google Chrome" &> /dev/null


# ---------------------------


print_in_purple "\n   Dock\n\n"

# execute "defaults write com.apple.dock autohide -bool true" \
#     "Automatically hide/show the Dock"

# execute "defaults write com.apple.dock mineffect -string 'scale'" \
#     "Change minimize/maximize window effect"

# execute "defaults write com.apple.dock minimize-to-application -bool true" \
#     "Reduce clutter by minimizing windows into their application icons"

execute "defaults write com.apple.dock mru-spaces -bool false" \
    "Do not automatically rearrange spaces based on most recent use"

execute "defaults write com.apple.dock orientation -string left" \
    "Position dock on the left of the screen"

execute "defaults write com.apple.dock show-process-indicators -bool true" \
    "Show indicator lights for open applications"

execute "defaults write com.apple.dock showhidden -bool true" \
    "Make icons of hidden applications translucent"

execute "defaults write com.apple.dock tilesize -int 27" \
    "Set icon size"

execute "defaults write com.apple.dock show-recents -bool false" \
    "Disable recent applications in dock"

execute "defaults write com.apple.dock wvous-br-corner -int 0" \
    "Disable quick note hot corner"

execute "defaults write NSGlobalDomain AppleMiniaturizeOnDoubleClick -bool true && \
         defaults write NSGlobalDomain AppleActionOnDoubleClick -string 'Maximize'" \
    "Maximize on Window Title double-click"


# ---------------------------


print_in_purple "\n   Finder\n\n"

execute "defaults write com.apple.frameworks.diskimages auto-open-ro-root -bool true && \
         defaults write com.apple.frameworks.diskimages auto-open-rw-root -bool true && \
         defaults write com.apple.finder OpenWindowForNewRemovableDisk -bool true" \
    "Automatically open a new Finder window when a volume is mounted"

execute "defaults write com.apple.finder _FXShowPosixPathInTitle -bool true" \
    "Use full POSIX path as window title"

execute "defaults write com.apple.finder DisableAllAnimations -bool true" \
    "Disable window and Get Info animations"

execute "defaults write com.apple.finder WarnOnEmptyTrash -bool false" \
    "Disable the warning before emptying the Trash"

execute "defaults write com.apple.finder FXDefaultSearchScope -string 'SCcf'" \
    "Search the current directory by default"

execute "defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false" \
    "Disable warning when changing a file extension"

execute "defaults write com.apple.finder FXPreferredViewStyle -string 'clmv'" \
    "Use column view in all Finder windows by default" # Other modes: `icnv`, `Nlsv`, `Flwv`

execute "defaults write com.apple.finder NewWindowTarget -string 'PfLo' && \
         defaults write com.apple.finder NewWindowTargetPath -string 'file://$HOME/Downloads/'" \
    "Set 'Downloads' as the default location for new Finder windows"

execute "defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool true && \
         defaults write com.apple.finder ShowHardDrivesOnDesktop -bool false && \
         defaults write com.apple.finder ShowMountedServersOnDesktop -bool false && \
         defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool true" \
    "Show icons for hard drives and removable media on the desktop, hide servers"

execute "defaults write com.apple.finder ShowRecentTags -bool false" \
    "Do not show recent tags"

execute "defaults write -g AppleShowAllExtensions -bool true" \
    "Show all filename extensions"

execute "/usr/libexec/PlistBuddy -c 'Set :DesktopViewSettings:IconViewSettings:iconSize 64' ~/Library/Preferences/com.apple.finder.plist && \
         /usr/libexec/PlistBuddy -c 'Set :StandardViewSettings:IconViewSettings:iconSize 64' ~/Library/Preferences/com.apple.finder.plist && \
         /usr/libexec/PlistBuddy -c 'Set :FK_StandardViewSettings:IconViewSettings:showItemInfo true' ~/Library/Preferences/com.apple.finder.plist" \
    "Set icon size"

execute "/usr/libexec/PlistBuddy -c 'Set :DesktopViewSettings:IconViewSettings:gridSpacing 57' ~/Library/Preferences/com.apple.finder.plist && \
         /usr/libexec/PlistBuddy -c 'Set :StandardViewSettings:IconViewSettings:gridSpacing 57' ~/Library/Preferences/com.apple.finder.plist && \
         /usr/libexec/PlistBuddy -c 'Set :FK_StandardViewSettings:IconViewSettings:gridSpacing 57' ~/Library/Preferences/com.apple.finder.plist" \
    "Set icon grid spacing size"

execute "/usr/libexec/PlistBuddy -c 'Set :DesktopViewSettings:IconViewSettings:textSize 12' ~/Library/Preferences/com.apple.finder.plist && \
         /usr/libexec/PlistBuddy -c 'Set :StandardViewSettings:IconViewSettings:textSize 12' ~/Library/Preferences/com.apple.finder.plist" \
    "Set icon label text size"

execute "/usr/libexec/PlistBuddy -c 'Set :DesktopViewSettings:IconViewSettings:labelOnBottom false' ~/Library/Preferences/com.apple.finder.plist && \
         /usr/libexec/PlistBuddy -c 'Set :StandardViewSettings:IconViewSettings:labelOnBottom false' ~/Library/Preferences/com.apple.finder.plist" \
    "Set icon label position"

execute "/usr/libexec/PlistBuddy -c 'Set :DesktopViewSettings:IconViewSettings:showItemInfo true' ~/Library/Preferences/com.apple.finder.plist && \
         /usr/libexec/PlistBuddy -c 'Set :StandardViewSettings:IconViewSettings:showItemInfo true' ~/Library/Preferences/com.apple.finder.plist && \
         /usr/libexec/PlistBuddy -c 'Set :FK_StandardViewSettings:IconViewSettings:showItemInfo true' ~/Library/Preferences/com.apple.finder.plist" \
    "Show item info"

execute "/usr/libexec/PlistBuddy -c 'Set :DesktopViewSettings:IconViewSettings:arrangeBy grid' ~/Library/Preferences/com.apple.finder.plist && \
         /usr/libexec/PlistBuddy -c 'Set :StandardViewSettings:IconViewSettings:arrangeBy grid' ~/Library/Preferences/com.apple.finder.plist && \
         /usr/libexec/PlistBuddy -c 'Set :FK_StandardViewSettings:IconViewSettings:arrangeBy grid' ~/Library/Preferences/com.apple.finder.plist" \
    "Set sort method"

execute "defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false" \
    "Save to disk (not to iCloud) by default"

execute "/System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister -kill -r -domain local -domain system -domain user" \
    "Remove duplicates in the 'Open With' menu"

execute "defaults write com.apple.finder AppleShowAllFiles -bool true" \
    "Show hidden files by default"

execute "defaults write com.apple.finder ShowStatusBar -bool true" \
    "Show status bar"

execute "defaults write com.apple.finder ShowPathbar -bool true" \
    "Show path bar"

execute "defaults write com.apple.finder _FXSortFoldersFirst -bool true" \
    "Keep folders on top when sorting by name"

execute "defaults write NSGlobalDomain com.apple.springing.enabled -bool true" \
    "Enable spring loading for directories"

execute "defaults write NSGlobalDomain com.apple.springing.delay -float 0" \
    "Remove the spring loading delay for directories"

killall "Finder" &> /dev/null

killall "cfprefsd" &> /dev/null


# ---------------------------


print_in_purple "\n   Firefox\n\n"

execute "defaults write org.mozilla.firefox AppleEnableSwipeNavigateWithScrolls -bool false" \
    "Disable backswipe"

killall "firefox" &> /dev/null


# ---------------------------


print_in_purple "\n   Keyboard\n\n"

execute "defaults write -g AppleKeyboardUIMode -int 3" \
    "Enable full keyboard access for all controls"

# execute "defaults write -g ApplePressAndHoldEnabled -bool false" \
#     "Disable press-and-hold in favor of key repeat"

# execute "defaults write -g 'InitialKeyRepeat_Level_Saved' -int 10" \
#     "Set delay until repeat"

# execute "defaults write -g KeyRepeat -int 1" \
#     "Set the key repeat rate to fast"

execute "defaults write -g NSAutomaticCapitalizationEnabled -bool false" \
    "Disable auto-capitalisation of words"

execute "defaults write -g NSAutomaticDashSubstitutionEnabled -bool false" \
    "Disable smart dashes"

execute "defaults write -g NSAutomaticPeriodSubstitutionEnabled -bool false" \
    "Disable double period to full stop substituton"

execute "defaults write -g NSAutomaticQuoteSubstitutionEnabled -bool false" \
    "Disable smart quotes"

execute "defaults write com.apple.universalaccess closeViewScrollWheelToggle -bool true && \
         defaults write com.apple.universalaccess HIDScrollZoomModifierMask -int 262144" \
    "Use scroll gesture with the Ctrl (^) modifier key to zoom"

execute "defaults write com.apple.universalaccess closeViewZoomFollowsFocus -bool true" \
    "Follow the keyboard focus while zoomed in"

execute "defaults write ~/Library/Preferences/com.apple.controlstrip MiniCustomized '(com.apple.system.brightness, com.apple.system.media-play-pause, com.apple.system.volume, com.apple.system.screen-lock )'" \
    "Set default icons in the touch bar (Control Strip)"


# ---------------------------


print_in_purple "\n   Language & Region\n\n"

execute "defaults write -g AppleLanguages -array 'en-AU'" \
    "Set language"

execute "defaults write -g AppleLocale -string 'en_AU@currency=AUD'" \
    "Set locale and currency"

execute "defaults write -g AppleMeasurementUnits -string 'Centimeters'" \
    "Set measurement units"

execute "defaults write NSGlobalDomain AppleMetricUnits -bool true" \
    "Set units to metric"

# execute "defaults write -g NSAutomaticSpellingCorrectionEnabled -bool false" \
#     "Disable auto-correct"

execute "sudo systemsetup -settimezone 'Australia/Sydney' > /dev/null" \
    "Set Timezone" # see `sudo systemsetup -listtimezones` for other values


# ---------------------------


print_in_purple "\n   Photos\n\n"

execute "defaults -currentHost write com.apple.ImageCapture disableHotPlug -bool true" \
    "Prevent Photos from opening automatically when devices are plugged in"

killall "Photos" &> /dev/null


# ---------------------------


print_in_purple "\n   Safari\n\n"

execute "defaults write com.apple.Safari AutoOpenSafeDownloads -bool false" \
    "Disable opening 'safe' files automatically"

execute "defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2BackspaceKeyNavigationEnabled -bool true" \
    "Set backspace key to go to the previous page in history"

execute "defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2DeveloperExtrasEnabled -bool true && \
         defaults write com.apple.Safari IncludeDevelopMenu -bool true && \
         defaults write com.apple.Safari WebKitDeveloperExtrasEnabledPreferenceKey -bool true" \
    "Enable the 'Develop' menu and the 'Web Inspector'"

execute "defaults write com.apple.Safari FindOnPageMatchesWordStartsOnly -bool false" \
    "Set search type to 'Contains' instead of 'Starts With'"

execute "defaults write com.apple.Safari HomePage -string 'about:blank'" \
    "Set home page to 'about:blank'"

execute "defaults write com.apple.Safari IncludeInternalDebugMenu -bool true" \
    "Enable 'Debug' menu"

execute "defaults write com.apple.Safari ShowFavoritesBar -bool false" \
    "Hide bookmarks bar by default"

execute "defaults write com.apple.Safari ShowFullURLInSmartSearchField -bool true" \
    "Show the full URL in the address bar"

execute "defaults write com.apple.Safari SuppressSearchSuggestions -bool true && \
         defaults write com.apple.Safari UniversalSearchEnabled -bool false" \
    "Don't send search queries to Apple"

execute "defaults write -g WebKitDeveloperExtras -bool true" \
    "Add a context menu item for showing the 'Web Inspector' in web views"

execute "defaults write com.apple.Safari WebKitTabToLinksPreferenceKey -bool true && \
         defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2TabsToLinks -bool true" \
    "Press Tab to highlight each item on a web page"

execute "defaults write com.apple.Safari ShowSidebarInTopSites -bool false" \
    "Hide Safari's sidebar in Top Sites"

execute "defaults write com.apple.Safari WebContinuousSpellCheckingEnabled -bool true" \
    "Enable continuous spellchecking"

execute "defaults write com.apple.Safari WebAutomaticSpellingCorrectionEnabled -bool false" \
    "Disable auto-correct"

execute "defaults write com.apple.Safari WarnAboutFraudulentWebsites -bool true" \
    "Warn about fraudulent websites"

execute "defaults write com.apple.Safari SendDoNotTrackHTTPHeader -bool true" \
    "Enable Do-Not-Track"

killall "Safari" &> /dev/null


# ---------------------------


print_in_purple "\n   Spotlight\n\n"

# execute "/usr/libexec/PlistBuddy -c 'Set :AppleSymbolicHotKeys:64:enabled bool false' ~/Library/Preferences/com.apple.symbolichotkeys.plist" \
#     "Disable default Spotlight keyboard shortcut"

# Hide Spotlight tray-icon (and subsequent helper)
#sudo chmod 600 /System/Library/CoreServices/Search.bundle/Contents/MacOS/Search
# Disable Spotlight indexing for any volume that gets mounted and has not yet
# been indexed before.
# Use `sudo mdutil -i off "/Volumes/foo"` to stop indexing any volume.
execute "sudo defaults write /.Spotlight-V100/VolumeConfiguration Exclusions -array '/Volumes'" \
    "Disable Spotlight indexing for any new volume that gets mounted"
# Change indexing order and disable some search results
# Yosemite-specific search results (remove them if you are using macOS 10.9 or older):
#   MENU_DEFINITION
#   MENU_CONVERSION
#   MENU_EXPRESSION
#   MENU_SPOTLIGHT_SUGGESTIONS (send search queries to Apple)
#   MENU_WEBSEARCH             (send search queries to Apple)
#   MENU_OTHER
defaults write com.apple.spotlight orderedItems -array \
    '{"enabled" = 1;"name" = "APPLICATIONS";}' \
    '{"enabled" = 1;"name" = "SYSTEM_PREFS";}' \
    '{"enabled" = 1;"name" = "DIRECTORIES";}' \
    '{"enabled" = 1;"name" = "PDF";}' \
    '{"enabled" = 1;"name" = "FONTS";}' \
    '{"enabled" = 0;"name" = "DOCUMENTS";}' \
    '{"enabled" = 0;"name" = "MESSAGES";}' \
    '{"enabled" = 0;"name" = "CONTACT";}' \
    '{"enabled" = 0;"name" = "EVENT_TODO";}' \
    '{"enabled" = 0;"name" = "IMAGES";}' \
    '{"enabled" = 0;"name" = "BOOKMARKS";}' \
    '{"enabled" = 0;"name" = "MUSIC";}' \
    '{"enabled" = 0;"name" = "MOVIES";}' \
    '{"enabled" = 0;"name" = "PRESENTATIONS";}' \
    '{"enabled" = 0;"name" = "SPREADSHEETS";}' \
    '{"enabled" = 0;"name" = "SOURCE";}' \
    '{"enabled" = 1;"name" = "MENU_DEFINITION";}' \
    '{"enabled" = 0;"name" = "MENU_OTHER";}' \
    '{"enabled" = 1;"name" = "MENU_CONVERSION";}' \
    '{"enabled" = 1;"name" = "MENU_EXPRESSION";}' \
    '{"enabled" = 0;"name" = "MENU_WEBSEARCH";}' \
    '{"enabled" = 0;"name" = "MENU_SPOTLIGHT_SUGGESTIONS";}'

execute "killall mds > /dev/null 2>&1" \
    "Load new settings before rebuilding the index"

execute "sudo mdutil -i on / > /dev/null" \
    "Make sure indexing is enabled for the main volume"

execute "sudo mdutil -E / > /dev/null" \
    "Rebuild the index from scratch"


# ---------------------------


print_in_purple "\n   Terminal\n\n"

# Hover over a window and start typing in it without clicking first
# Terminal and all X11 apps
execute "defaults write com.apple.terminal FocusFollowsMouse -string true && \
         defaults write org.x.X11 wm_ffm -bool true" \
    "Make the focus automatically follow the mouse (Terminal "

execute "defaults write com.apple.terminal SecureKeyboardEntry -bool true" \
    "Enable 'Secure Keyboard Entry'" # https://security.stackexchange.com/a/47786/8918

# execute "defaults write com.apple.Terminal ShowLineMarks -int 0" \
#     "Hide line marks"

execute "defaults write com.apple.terminal StringEncodings -array 4" \
    "Only use UTF-8"

execute "defaults write com.apple.terminal 'Default Window Settings' -string 'Pro' && \
         defaults write com.apple.terminal 'Startup Window Settings' -string 'Pro'" \
    "Set Pro as the default theme"


# ---------------------------


print_in_purple "\n   TextEdit\n\n"

execute "defaults write com.apple.TextEdit PlainTextEncoding -int 4 && \
         defaults write com.apple.TextEdit PlainTextEncodingForWrite -int 4" \
    "Open and save files as UTF-8 encoded"

execute "defaults write com.apple.TextEdit RichText -int 0" \
    "Use plain text mode for new documents"

killall "TextEdit" &> /dev/null


# ---------------------------


print_in_purple "\n   Time Machine\n\n"

execute "defaults write com.apple.TimeMachine DoNotOfferNewDisksForBackup -bool true" \
    "Prevent Time Machine from prompting to use new hard drives as backup volume"

# execute "hash tmutil &> /dev/null && sudo tmutil disablelocal" \
#     "Disable local Time Machine backups"


# ---------------------------


print_in_purple "\n   Trackpad\n\n"

execute "defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true && \
         defaults write com.apple.AppleMultitouchTrackpad Clicking -int 1 && \
         defaults write -g com.apple.mouse.tapBehavior -int 1 && \
         defaults -currentHost write -g com.apple.mouse.tapBehavior -int 1" \
    "Enable 'Tap to click'"

execute "defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadRightClick -bool true && \
         defaults write com.apple.AppleMultitouchTrackpad TrackpadRightClick -int 1 && \
         defaults -currentHost write -g com.apple.trackpad.enableSecondaryClick -bool true && \
         defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadCornerSecondaryClick -int 0 && \
         defaults write com.apple.AppleMultitouchTrackpad TrackpadCornerSecondaryClick -int 0 && \
         defaults -currentHost write -g com.apple.trackpad.trackpadCornerClickBehavior -int 0" \
    "Map 'click or tap with two fingers' to the secondary click"

execute "defaults write -g com.apple.trackpad.scaling 1" \
    "Change the trackpad speed"


# ---------------------------


print_in_purple "\n   UI & UX\n\n"

execute "defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true && \
         defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true" \
   "Avoid creating '.DS_Store' files on network or USB volumes"

execute "defaults write com.apple.menuextra.clock DateFormat -string 'EEE d MMM  HH:mm'" \
    "Setting the clock to 24-hour format in the menu bar"

# execute "defaults write com.apple.menuextra.battery ShowPercent -string 'NO'" \
#     "Hide battery percentage from the menu bar"

# execute "defaults write com.apple.CrashReporter UseUNC 1" \
#     "Make crash reports appear as notifications"

# execute "defaults write com.apple.LaunchServices LSQuarantine -bool false" \
#     "Disable 'Are you sure you want to open this application?' dialog"

execute "defaults write com.apple.print.PrintingPrefs 'Quit When Finished' -bool true" \
    "Automatically quit the printer app once the print jobs are completed"

# execute "defaults write com.apple.screencapture disable-shadow -bool true" \
#     "Disable shadow in screenshots"

mkd "$HOME/Desktop/Screenshots" # Create the Screenshots folder
execute "defaults write com.apple.screencapture location -string '$HOME/Desktop/Screenshots'" \
    "Save screenshots to the Desktop Screenshots folder"

execute "defaults write com.apple.screencapture type -string 'png'" \
    "Save screenshots as PNGs"

execute "defaults write com.apple.screencapture show-thumbnail -bool false" \
    "Do not show screenshot thumbnail"

execute "defaults write com.apple.screensaver askForPassword -int 1 && \
         defaults write com.apple.screensaver askForPasswordDelay -int 60" \
    "Require password a minute after sleep or screen saver mode"

execute "defaults -currentHost write com.apple.screensaver idleTime 300" \
    "Set screen saver idle time to 5 minutes"

execute "defaults -currentHost write com.apple.screensaver showClock -bool true" \
    "Show clock on the screen saver"

execute "defaults write com.apple.spaces spans-displays -bool false" \
    "Enable displays have separate Spaces - switch between Spaces on different monitors"

execute "defaults write -g AppleFontSmoothing -int 2" \
    "Enable subpixel font rendering on non-Apple LCDs"

# execute "defaults write -g AppleShowScrollBars -string 'Always'" \
#     "Always show scrollbars" # Possible values: `WhenScrolling`, `Automatic` and `Always`

# execute "defaults write -g NSDisableAutomaticTermination -bool true" \
#     "Disable automatic termination of inactive apps"

execute "defaults write -g NSNavPanelExpandedStateForSaveMode -bool true && \
         defaults write -g NSNavPanelExpandedStateForSaveMode2 -bool true" \
    "Expand save panel by default"

execute "defaults write -g NSTableViewDefaultSizeMode -int 2" \
    "Set sidebar icon size to medium"

execute "defaults write -g NSUseAnimatedFocusRing -bool false" \
    "Disable the over-the-top focus ring animation"

execute "defaults write com.apple.systempreferences NSQuitAlwaysKeepsWindows -bool false" \
    "Disable resume system-wide"

execute "defaults write -g PMPrintingExpandedStateForPrint -bool true && \
         defaults write -g PMPrintingExpandedStateForPrint2 -bool true" \
    "Expand print panel by default"

execute "sudo systemsetup -setrestartfreeze on" \
    "Restart automatically if the computer freezes"

# execute "sudo defaults write /Library/Preferences/com.apple.Bluetooth.plist ControllerPowerState 0 && \
#          sudo launchctl unload /System/Library/LaunchDaemons/com.apple.blued.plist && \
#          sudo launchctl load /System/Library/LaunchDaemons/com.apple.blued.plist" \
#     "Turn Bluetooth off"

execute "defaults write com.apple.BluetoothAudioAgent 'Apple Bitpool Min (editable)' -int 40" \
    "Increase sound quality for Bluetooth headphones/headsets"

execute "for domain in ~/Library/Preferences/ByHost/com.apple.systemuiserver.*; do
            sudo defaults write \"\${domain}\" dontAutoLoad -array \
                '/System/Library/CoreServices/Menu Extras/Volume.menu' \
                '/System/Library/CoreServices/Menu Extras/User.menu'
         done \
            && sudo defaults write com.apple.systemuiserver menuExtras -array \
                '/System/Library/CoreServices/Menu Extras/Bluetooth.menu' \
                '/System/Library/CoreServices/Menu Extras/AirPort.menu' \
                '/System/Library/CoreServices/Menu Extras/Battery.menu' \
                '/System/Library/CoreServices/Menu Extras/Clock.menu'
        " \
    "Hide Volume icon from the menu bar"

# execute "defaults write com.apple.universalaccess reduceTransparency -bool true" \
#     "Disable transparency in the menu bar and elsewhere"

execute "sudo defaults write /Library/Preferences/.GlobalPreferences AppleInterfaceTheme -string 'Dark' &&
         defaults write NSGlobalDomain AppleInterfaceStyle -string 'Dark'" \
    "Enable the Dark theme for the menu bar"

execute "defaults write NSGlobalDomain AppleReduceDesktopTinting -int 1" \
    "Disable wallpaper tinting in windows"

execute "/usr/libexec/PlistBuddy -c 'Set :AppleSymbolicHotKeys:79:enabled bool false' ~/Library/Preferences/com.apple.symbolichotkeys.plist" \
    "Disable default Mission Control keyboard Move left a space shortcut"

execute "/usr/libexec/PlistBuddy -c 'Set :AppleSymbolicHotKeys:81:enabled bool false' ~/Library/Preferences/com.apple.symbolichotkeys.plist" \
    "Disable default Mission Control keyboard Move right a space shortcut"

# execute "launchctl unload -w /System/Library/LaunchAgents/com.apple.notificationcenterui.plist 2> /dev/null" \
#     "Disable Notification Center and remove the menu bar icon"

execute "sudo defaults write /Library/Preferences/com.apple.windowserver DisplayResolutionEnabled -bool true" \
    "Enable HiDPI display modes (requires restart)"

execute "defaults write com.apple.QuickTimePlayerX MGPlayMovieOnOpen -bool true" \
    "Auto-play videos when opened with QuickTime Player"



# ---------------------------


print_in_purple "\n   Users and Security\n\n"

execute "sudo defaults write /Library/Preferences/.GlobalPreferences MultipleSessionEnabled -bool false" \
    "Disable fast user switching"

execute "sudo defaults write /Library/Preferences/com.apple.loginwindow GuestEnabled -bool false" \
    "Disable the Guest user"

execute "sudo defaults write /Library/Preferences/com.apple.loginwindow SHOWFULLNAME -bool true" \
    "Login window - show username and password fields rather than list of users"
    # May not work if FileVault is enabled

execute "sudo defaults write /Library/Preferences/com.apple.loginwindow AdminHostInfo HostName" \
    "Login window - show IP address, hostname, OS version, etc when clicking the clock"


killall "SystemUIServer" &> /dev/null


# ---------------------------


print_in_purple "\n   SSD\n\n"

execute "sudo pmset -a sms 0" \
    "Disable the sudden motion sensor as it's not useful for SSDs"


# ---------------------------

print_info "Done. Might be a good idea to reboot the system to make sure all the settings are applied"
