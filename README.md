# Dotfiles

Alacritty • Zsh + Oh My Zsh + Powerlevel10k • Neovim • tmux

## Quick Install

Deploy to the current user (backs up existing files):

```
chmod +x install.sh
./install.sh
```

Preview without writing:

```
DRY_RUN=1 ./install.sh
```

## What Gets Installed

- `alacritty/alacritty.toml` or `alacritty.yml` → `~/.config/alacritty/`
- `zshrc` → `~/.zshrc`
- `p10k.zsh` → `~/.p10k.zsh`
- `tmux.conf` → `~/.tmux.conf`
- `nvim/` → `~/.config/nvim/`

Backups are created alongside originals with `.bak.<timestamp>`.

## Requirements

- Alacritty, Zsh, Oh My Zsh, Powerlevel10k, Neovim, tmux, a Nerd Font
- Make Zsh your login shell: `chsh -s "$(command -v zsh)"`

## Manual Copy (Optional)

```
mkdir -p ~/.config/alacritty ~/.config/nvim
cp -f alacritty/* ~/.config/alacritty/
cp -f zshrc ~/.zshrc
cp -f p10k.zsh ~/.p10k.zsh
cp -f tmux.conf ~/.tmux.conf
cp -a nvim/* ~/.config/nvim/
```

That’s it.

