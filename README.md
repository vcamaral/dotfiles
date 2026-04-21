# dotfiles

Personal Mac setup by [@vcamaral](https://github.com/vcamaral).

## What it does

- Installs and updates **Homebrew**
- Installs **Oh My Zsh** with plugins:
  - `fast-syntax-highlighting`
  - `zsh-autosuggestions`
  - `zsh-completions`
- Installs apps via Homebrew Cask:
  - Google Chrome, 1Password, VS Code, Google Drive
  - WhatsApp, Raycast, Spotify, Slack, Claude
  - Todoist, Obsidian, The Unarchiver, iTerm2
  - LanguageTool for Desktop, CleanShot X
- Configures the **Dock** (layout, auto-hide, no recents)
- Configures **Finder** (extensions, sorting, search scope)
- Disables **Spotlight** shortcut in favor of Raycast
- Sets **wallpaper**

## Install

On a fresh Mac, run:

```bash
curl -fsSL https://raw.githubusercontent.com/vcamaral/dotfiles/main/install.sh | bash
```

Or clone and run manually:

```bash
git clone https://github.com/vcamaral/dotfiles.git ~/dotfiles
bash ~/dotfiles/install.sh
```

## Manual steps after install

**Trackpad**
- Enable tap to click
- Disable natural scrolling

**Sign in and configure**
- 1Password
- Google Drive
- Raycast — set `Cmd+Space` as shortcut
- CleanShot X
- LanguageTool

**App Store — download and configure**
- Amphetamine
- Magnet
