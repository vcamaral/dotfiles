# ──────────────────────────────────────────────
# Navigation
# ──────────────────────────────────────────────
alias ..="cd .."
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
# Utilities
# ──────────────────────────────────────────────
alias c="clear"
alias h="history"
alias grep="grep --color=auto"
alias port="lsof -i"
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
VPS_HOST="vcamaral@2.24.79.105"
alias vps="ssh $VPS_HOST"
vpstunnel() { ssh -L "${1:-8080}:localhost:${1:-8080}" "$VPS_HOST"; }

# ──────────────────────────────────────────────
# Homebrew
# ──────────────────────────────────────────────
alias brewup="brew upgrade \$(brew outdated)"

# ──────────────────────────────────────────────
# mTLS / Certificates
# ──────────────────────────────────────────────
# curlmtls <url> [cert] [key] [cacert]
# Sem cert/key/cacert, procura *.crt/*.key/*.pem no diretório atual.
curlmtls() {
  local url="$1" cert="$2" key="$3" cacert="$4"

  if [[ -z "$url" ]]; then
    echo "Uso: curlmtls <url> [cert] [key] [cacert]"
    return 1
  fi

  [[ -z "$cert" ]] && cert=$(command ls -1 *.crt 2>/dev/null | head -1)
  [[ -z "$key" ]] && key=$(command ls -1 *.key 2>/dev/null | head -1)
  [[ -z "$cacert" ]] && cacert=$(command ls -1 *.pem 2>/dev/null | head -1)

  if [[ -z "$cert" || -z "$key" ]]; then
    echo "Certificado ou chave não encontrados (esperado *.crt e *.key no diretório atual, ou passe os caminhos explicitamente)."
    return 1
  fi

  cert=$(realpath "$cert")
  key=$(realpath "$key")
  [[ -n "$cacert" ]] && cacert=$(realpath "$cacert")

  echo "cert:   $cert"
  echo "key:    $key"
  [[ -n "$cacert" ]] && echo "cacert: $cacert"

  local extra=()
  [[ -n "$cacert" ]] && extra=(--cacert "$cacert")
  curl --cert "$cert" --key "$key" "${extra[@]}" "$url"
}