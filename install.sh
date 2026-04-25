#!/bin/bash

set -e

source "$(dirname "$0")/lib.sh"

DOTFILES_DIR="$HOME/dotfiles"
REPO="git@github.com:vcamaral/dotfiles.git"

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
