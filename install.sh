#!/usr/bin/env bash
set -euo pipefail

# Dotfiles installer: backs up existing files and deploys repo configs.
# Usage:
#   ./install.sh              # deploy for current user ($HOME)
#   DRY_RUN=1 ./install.sh    # show actions only
#
# Optional flags (env):
#   BACKUP_SUFFIX=<suffix>    # custom backup suffix (default: timestamp)
#
ts() { date +%Y%m%d-%H%M%S; }

log() { printf "%s\n" "$*"; }
do_cp() {
  local src="$1" dst="$2"
  if [ "${DRY_RUN:-}" = 1 ]; then
    log "DRY: cp -f '$src' '$dst'"; return 0
  fi
  install -D -m 0644 "$src" "$dst"
}

do_sync_dir() {
  local src_dir="$1" dst_dir="$2"
  if [ "${DRY_RUN:-}" = 1 ]; then
    log "DRY: rsync -a '$src_dir/' '$dst_dir/'"; return 0
  fi
  mkdir -p "$dst_dir"
  cp -a "$src_dir/." "$dst_dir/"
}

backup_file() {
  local f="$1" suf="${BACKUP_SUFFIX:-$(ts)}"
  if [ -e "$f" ]; then
    local b="$f.bak.$suf"
    if [ "${DRY_RUN:-}" = 1 ]; then
      log "DRY: mv '$f' '$b'"
    else
      mv "$f" "$b"
    fi
    log "Backed up: $f -> $b"
  fi
}

main() {
  local repo_root
  repo_root="$(cd "$(dirname "$0")" && pwd)"
  local home_dir="$HOME"
  log "Deploying dotfiles from $repo_root to $home_dir"

  # Alacritty
  if [ -f "$repo_root/alacritty/alacritty.toml" ] || [ -f "$repo_root/alacritty/alacritty.yml" ]; then
    mkdir -p "$home_dir/.config/alacritty"
    if [ -f "$repo_root/alacritty/alacritty.toml" ]; then
      backup_file "$home_dir/.config/alacritty/alacritty.toml"
      do_cp "$repo_root/alacritty/alacritty.toml" "$home_dir/.config/alacritty/alacritty.toml"
      log "Installed: ~/.config/alacritty/alacritty.toml"
    fi
    if [ -f "$repo_root/alacritty/alacritty.yml" ]; then
      backup_file "$home_dir/.config/alacritty/alacritty.yml"
      do_cp "$repo_root/alacritty/alacritty.yml" "$home_dir/.config/alacritty/alacritty.yml"
      log "Installed: ~/.config/alacritty/alacritty.yml"
    fi
  fi

  # Zsh + Powerlevel10k configs
  if [ -f "$repo_root/zshrc" ]; then
    backup_file "$home_dir/.zshrc"
    do_cp "$repo_root/zshrc" "$home_dir/.zshrc"
    log "Installed: ~/.zshrc"
  fi
  if [ -f "$repo_root/p10k.zsh" ]; then
    backup_file "$home_dir/.p10k.zsh"
    do_cp "$repo_root/p10k.zsh" "$home_dir/.p10k.zsh"
    log "Installed: ~/.p10k.zsh"
  fi

  # Tmux
  if [ -f "$repo_root/tmux.conf" ]; then
    backup_file "$home_dir/.tmux.conf"
    do_cp "$repo_root/tmux.conf" "$home_dir/.tmux.conf"
    log "Installed: ~/.tmux.conf"
  fi

  # Neovim
  if [ -d "$repo_root/nvim" ]; then
    mkdir -p "$home_dir/.config"
    backup_file "$home_dir/.config/nvim"
    if [ "${DRY_RUN:-}" = 1 ]; then
      log "DRY: copy nvim -> ~/.config/nvim"
    else
      rm -rf "$home_dir/.config/nvim"
      do_sync_dir "$repo_root/nvim" "$home_dir/.config/nvim"
    fi
    log "Installed: ~/.config/nvim"
  fi

  log "Done. You can start a new terminal session to see changes."
}

main "$@"

