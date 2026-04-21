# ──────────────────────────────────────────────
# Navigation
# ──────────────────────────────────────────────
alias ..="cd .."
alias ...="cd ../.."
alias ~="cd ~"
alias dl="cd ~/Downloads"
alias dt="cd ~/Desktop"

# ──────────────────────────────────────────────
# Listing
# ──────────────────────────────────────────────
alias ls="ls -la"
alias ll="ls -lh"

# ──────────────────────────────────────────────
# Git
# ──────────────────────────────────────────────
alias gs="git status"
alias ga="git add ."
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
alias pubkey="cat ~/.ssh/id_rsa.pub | pbcopy && echo 'SSH key copied to clipboard'"

# ──────────────────────────────────────────────
# Network
# ──────────────────────────────────────────────
alias localip="ipconfig getifaddr en0"
alias externalip="curl -s https://ipinfo.io/ip && echo"