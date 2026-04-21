# dotfiles

Personal Mac setup by [@vcamaral](https://github.com/vcamaral).

## Structure

```
dotfiles/
├── install.sh          # sets up symlinks and runs setup_mac.sh
├── setup_mac.sh        # installs apps and configures macOS
├── aliases.sh          # shell aliases (symlinked to ~/.aliases)
├── .gitconfig          # git configuration (symlinked to ~/.gitconfig)
└── .gitignore_global   # global gitignore (symlinked to ~/.gitignore_global)
```

## What it does

### install.sh
- Clones or updates the dotfiles repo
- Creates symlinks for aliases, gitconfig and gitignore_global
- Adds `source ~/.aliases` to `.zshrc`
- Runs `setup_mac.sh`

### setup_mac.sh
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
- Configures the **Dock** (layout, size, auto-hide, no recents)
- Configures **Finder** (extensions, sorting, search scope)
- Disables **Spotlight** shortcut in favor of Raycast
- Sets **wallpaper**

### aliases.sh
- Navigation shortcuts (`..`, `...`, `dl`, `dt`)
- Listing (`ls`, `ll`)
- Git shortcuts (`gs`, `ga`, `gc`, `gp`, `gl`, `gco`)
- System (`reload`, `hosts`, `flushdns`, `pubkey`)
- Utilities (`c`, `h`, `grep`, `port`, `myip`)
- Clipboard (`copy`, `paste`)
- Network (`localip`, `externalip`)

## Install

On a fresh Mac, run:

```bash
curl -fsSL https://raw.githubusercontent.com/vcamaral/dotfiles/main/install.sh | bash && source ~/.zshrc
```

Or clone and run manually:

```bash
git clone git@github.com:vcamaral/dotfiles.git ~/dotfiles
bash ~/dotfiles/install.sh && source ~/.zshrc
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