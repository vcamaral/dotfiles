#!/bin/bash

set -e

BOLD="\033[1m"
GREEN="\033[32m"
CYAN="\033[36m"
DIM="\033[2m"
RESET="\033[0m"

DOTFILES_DIR="$HOME/dotfiles"
REPO="git@github.com:vcamaral/dotfiles.git"

ok()   { printf "  ${GREEN}✓${RESET} ${DIM}$1${RESET}\n"; }
info() { printf "  ${DIM}$1${RESET}\n"; }

printf "\n${BOLD}${CYAN}dotfiles — install${RESET}\n\n"

# ──────────────────────────────────────────────
# Clone
# ──────────────────────────────────────────────
if [[ -d "$DOTFILES_DIR" ]]; then
  info "Updating dotfiles repo..."
  git -C "$DOTFILES_DIR" pull --quiet
  ok "Updated"
else
  info "Cloning dotfiles repo..."
  git clone --quiet "$REPO" "$DOTFILES_DIR"
  ok "Cloned"
fi

# ──────────────────────────────────────────────
# Aliases
# ──────────────────────────────────────────────
printf "\n${BOLD}${CYAN}Setting up aliases...${RESET}\n"

ln -sf "$DOTFILES_DIR/aliases.sh" "$HOME/.aliases"
ok "Symlink created (~/.aliases)"

if ! grep -q "source ~/.aliases" "$HOME/.zshrc" 2>/dev/null; then
  echo $'\nsource ~/.aliases' >> "$HOME/.zshrc"
  ok "Added source to .zshrc"
else
  info "Already sourced in .zshrc — skipping"
fi

# ──────────────────────────────────────────────
# Git
# ──────────────────────────────────────────────
printf "\n${BOLD}${CYAN}Setting up git...${RESET}\n"

ln -sf "$DOTFILES_DIR/.gitconfig" "$HOME/.gitconfig"
ok "Symlink created (~/.gitconfig)"

ln -sf "$DOTFILES_DIR/.gitignore_global" "$HOME/.gitignore_global"
ok "Symlink created (~/.gitignore_global)"

# ──────────────────────────────────────────────
# Run setup
# ──────────────────────────────────────────────
printf "\n${BOLD}${CYAN}Running setup...${RESET}\n"
bash "$DOTFILES_DIR/setup_mac.sh"

exec zsh