#!/bin/bash

set -e

source "$(dirname "$0")/lib.sh"

TOTAL=7
CURRENT=0

step() {
  CURRENT=$((CURRENT + 1))
  printf "\n${BOLD}[${CURRENT}/${TOTAL}]${RESET} ${CYAN}$1${RESET}\n"
}

# ──────────────────────────────────────────────
# Homebrew
# ──────────────────────────────────────────────
step "Homebrew"

if [[ -f "/opt/homebrew/bin/brew" ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
elif [[ -f "/usr/local/bin/brew" ]]; then
  eval "$(/usr/local/bin/brew shellenv)"
fi

if command -v brew &>/dev/null; then
  brew update --quiet &>/dev/null
  ok "Already installed — updated"
else
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" &>/dev/null
  if [[ -f "/opt/homebrew/bin/brew" ]]; then
    echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> "$HOME/.zprofile"
    eval "$(/opt/homebrew/bin/brew shellenv)"
  elif [[ -f "/usr/local/bin/brew" ]]; then
    eval "$(/usr/local/bin/brew shellenv)"
  fi
  ok "Installed"
fi

# ──────────────────────────────────────────────
# Oh My Zsh
# ──────────────────────────────────────────────
step "Oh My Zsh"

if [[ -d "$HOME/.oh-my-zsh" ]]; then
  skip "Already installed"
else
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended &>/dev/null
  ok "Installed"
fi

ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"

install_zsh_plugin() {
  local repo=$1
  local name=$(basename "$repo")
  local dest="$ZSH_CUSTOM/plugins/$name"

  if [[ -d "$dest" ]]; then
    skip "$name"
  else
    git clone -q "https://github.com/$repo" "$dest" &>/dev/null
    ok "$name"
  fi
}

install_zsh_plugin "zdharma-continuum/fast-syntax-highlighting"
install_zsh_plugin "zsh-users/zsh-autosuggestions"
install_zsh_plugin "zsh-users/zsh-completions"

if ! grep -q "fast-syntax-highlighting" "$HOME/.zshrc" 2>/dev/null; then
  sed -i '' 's/^plugins=(\(.*\))/plugins=(\1 fast-syntax-highlighting zsh-autosuggestions zsh-completions)/' "$HOME/.zshrc"
  ok "Plugins added to .zshrc"
else
  skip "Plugins already in .zshrc"
fi

# ──────────────────────────────────────────────
# Apps
# ──────────────────────────────────────────────
step "Apps"

install_cask() {
  local cask=$1
  local name=$2
  local app_path=$3

  if [[ -n "$app_path" && -d "$app_path" ]] || brew list --cask "$cask" &>/dev/null; then
    skip "$name"
  else
    info "Installing $name..."
    brew install --cask "$cask" --quiet &>/dev/null
    ok "$name"
  fi
}

casks=(
  "google-chrome|Google Chrome|/Applications/Google Chrome.app"
  "1password|1Password|/Applications/1Password.app"
  "visual-studio-code|VS Code|/Applications/Visual Studio Code.app"
  "google-drive|Google Drive|/Applications/Google Drive.app"
  "whatsapp|WhatsApp|/Applications/WhatsApp.app"
  "raycast|Raycast|/Applications/Raycast.app"
  "spotify|Spotify|/Applications/Spotify.app"
  "slack|Slack|/Applications/Slack.app"
  "claude|Claude|/Applications/Claude.app"
  "todoist|Todoist|/Applications/Todoist.app"
  "obsidian|Obsidian|/Applications/Obsidian.app"
  "the-unarchiver|The Unarchiver|/Applications/The Unarchiver.app"
  "iterm2|iTerm2|/Applications/iTerm.app"
  "languagetool-desktop|LanguageTool for Desktop|/Applications/LanguageTool for Desktop.app"
  "cleanshot|CleanShot X|/Applications/CleanShot X.app"
)

for entry in "${casks[@]}"; do
  IFS="|" read -r cask name app_path <<< "$entry"
  install_cask "$cask" "$name" "$app_path"
done

if ! command -v dockutil &>/dev/null; then
  info "Installing dockutil..."
  brew install dockutil --quiet &>/dev/null
  ok "dockutil"
else
  skip "dockutil"
fi

# ──────────────────────────────────────────────
# Dock
# ──────────────────────────────────────────────
step "Dock"

dock_apps=(
  "/Applications/Google Chrome.app"
  "/Applications/Claude.app"
  "/Applications/Slack.app"
  "/Applications/WhatsApp.app"
  "/Applications/Todoist.app"
  "/Applications/Obsidian.app"
  "/Applications/Spotify.app"
  "/Applications/Visual Studio Code.app"
)

dockutil --remove all --no-restart &>/dev/null

for app in "${dock_apps[@]}"; do
  dockutil --add "$app" --no-restart &>/dev/null
done

dockutil --add "$HOME/Downloads" --view fan --display folder --sort dateadded --no-restart &>/dev/null

defaults write com.apple.dock tilesize       -int 256
defaults write com.apple.dock show-recents   -bool false
defaults write com.apple.dock autohide       -bool true
defaults write com.apple.dock autohide-delay -float 0

killall Dock
ok "Configured"

# ──────────────────────────────────────────────
# Finder
# ──────────────────────────────────────────────
step "Finder"

defaults write com.apple.finder ShowHardDrivesOnDesktop              -bool false
defaults write com.apple.finder ShowExternalHardDrivesOnDesktop      -bool true
defaults write com.apple.finder ShowRemovableMediaOnDesktop          -bool true
defaults write com.apple.finder ShowMountedServersOnDesktop          -bool false
defaults write com.apple.finder ShowItemInfo                         -bool true
defaults write com.apple.finder FinderSpawnTab                       -bool true
defaults write NSGlobalDomain   AppleShowAllExtensions               -bool true
defaults write com.apple.finder FXEnableExtensionChangeWarning       -bool false
defaults write com.apple.finder FXEnableRemoveFromICloudDriveWarning -bool true
defaults write com.apple.finder WarnOnEmptyTrash                     -bool false
defaults write com.apple.finder FXRemoveOldTrashItems                -bool false
defaults write com.apple.finder _FXSortFoldersFirst                  -bool true
defaults write com.apple.finder _FXSortFoldersFirstOnDesktop         -bool true
defaults write com.apple.finder FXDefaultSearchScope                 -string "SCcf"

killall Finder
ok "Configured"

# ──────────────────────────────────────────────
# Raycast
# ──────────────────────────────────────────────
step "Raycast"

defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 64 "
  <dict>
    <key>enabled</key><false/>
    <key>value</key>
    <dict>
      <key>parameters</key>
      <array>
        <integer>65535</integer>
        <integer>49</integer>
        <integer>1048576</integer>
      </array>
      <key>type</key>
      <string>standard</string>
    </dict>
  </dict>
"

defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 65 "
  <dict>
    <key>enabled</key><false/>
    <key>value</key>
    <dict>
      <key>parameters</key>
      <array>
        <integer>65535</integer>
        <integer>49</integer>
        <integer>1572864</integer>
      </array>
      <key>type</key>
      <string>standard</string>
    </dict>
  </dict>
"

/System/Library/PrivateFrameworks/SystemAdministration.framework/Resources/activateSettings -u
ok "Spotlight shortcut disabled"

# ──────────────────────────────────────────────
# Wallpaper
# ──────────────────────────────────────────────
step "Wallpaper"

WALLPAPER_URL="https://misc-assets.raycast.com/wallpapers/mono_dark_distortion_2.heic"
WALLPAPER_PATH="$HOME/Pictures/wallpaper.heic"

curl -fsSL "$WALLPAPER_URL" -o "$WALLPAPER_PATH" &>/dev/null
osascript -e "tell application \"System Events\" to tell every desktop to set picture to \"$WALLPAPER_PATH\"" &>/dev/null

ok "Applied"

# ──────────────────────────────────────────────
# Done
# ──────────────────────────────────────────────
printf "\n${GREEN}${BOLD}Done!${RESET}\n"
printf "\n${YELLOW}${BOLD}Manual steps remaining:${RESET}\n"
printf "${DIM}"
printf "  Trackpad\n"
printf "    · Enable tap to click\n"
printf "    · Disable natural scrolling\n"
printf "  Sign in and configure\n"
printf "    · 1Password\n"
printf "    · Google Drive\n"
printf "    · Raycast\n"
printf "    · CleanShot X\n"
printf "    · LanguageTool\n"
printf "  App Store — download and configure\n"
printf "    · Amphetamine\n"
printf "    · Magnet\n"
printf "${RESET}\n"
