# ──────────────────────────────────────────────
# Navigation
# ──────────────────────────────────────────────
alias ..="cd .."
alias ...="cd ../.."
alias dl="cd ~/Downloads"
alias dt="cd ~/Desktop"

# ──────────────────────────────────────────────
# Listing
# ──────────────────────────────────────────────
alias ls="ls -lh"
alias la="ls -lha"

# ──────────────────────────────────────────────
# Git
# ──────────────────────────────────────────────
alias gs="git status"
alias ga="git add"
alias gc="git commit -m"
alias gp="git push"
alias gl="git log --oneline --graph"
alias gco="git checkout"

# ──────────────────────────────────────────────
# System
# ──────────────────────────────────────────────
alias reload="source ~/.zshrc"
alias hosts="sudo nano /etc/hosts"
alias flushdns="sudo dscacheutil -flushcache && sudo killall -HUP mDNSResponder"
pubkey() {
  local key
  for key in ~/.ssh/id_ed25519.pub ~/.ssh/id_rsa.pub; do
    if [[ -f "$key" ]]; then
      pbcopy < "$key" && echo "SSH key copied to clipboard ($key)"
      return
    fi
  done
  echo "No SSH public key found in ~/.ssh" >&2
  return 1
}

# ──────────────────────────────────────────────
# Utilities
# ──────────────────────────────────────────────
alias c="clear"
alias h="history"
alias grep="grep --color=auto"
port() { lsof -i ":$1"; }
alias myip="localip && externalip"

# ──────────────────────────────────────────────
# Clipboard
# ──────────────────────────────────────────────
alias copy="pbcopy"
alias paste="pbpaste"

# ──────────────────────────────────────────────
# Network
# ──────────────────────────────────────────────
alias localip="ipconfig getifaddr en0"
alias externalip="curl -s https://ipinfo.io/ip && echo"

# ──────────────────────────────────────────────
# Homebrew
# ──────────────────────────────────────────────
alias brewup="brew update && brew upgrade && brew cleanup"