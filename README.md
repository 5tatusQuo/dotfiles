# Dotfiles for Neovim + C++ and tmux Developer Workflow

This repository contains my dotfiles for setting up a modern, efficient developer workflow on Ubuntu using **Neovim** (with C++ plugins), **tmux**, **Alacritty**, and **Zsh** with Oh My Zsh. The setup includes Neovim configured as a lightweight IDE for C++ development with LSP support, autocompletion, and auto-compilation, paired with tmux for terminal session management, Alacritty as a fast terminal emulator, and Zsh for an enhanced shell experience. This README provides installation instructions, configuration details, keybindings, and usage tips.

## Overview

- **Neovim**: A modern Vim fork configured with plugins for C++ development, including LSP (`clangd`), autocompletion (`nvim-cmp`), syntax highlighting (`treesitter`), and auto-compilation (`asyncrun.vim`).
- **tmux**: A terminal multiplexer for managing multiple terminal sessions, with custom keybindings for pane splitting and navigation.
- **Alacritty**: A GPU-accelerated terminal emulator, configured to spawn maximized with a Nerd Font for optimal rendering.
- **Zsh with Oh My Zsh**: An enhanced shell with Powerlevel10k theme, autocompletion, and plugins for Git and C++ development.
- **Target Environment**: Ubuntu 22.04 or later.
- **Goal**: A lightweight, productive setup for C++ development with seamless integration between editing, compilation, and session management.

## Prerequisites

- **Ubuntu 22.04** or later with `apt` package manager.
- Basic familiarity with Vim/tmux keybindings.

## Installation

### Step 1: Install Alacritty
1. Install Alacritty:
   ```bash
   sudo apt update
   sudo apt install -y alacritty
   ```
2. Verify installation:
   ```bash
   alacritty --version
   ```
3. Install a Nerd Font for proper glyph rendering (e.g., for Powerlevel10k):
   ```bash
   sudo apt install -y fonts-firacode
   ```
4. Configure Alacritty:
   Copy the `alacritty/` directory to `~/.config/alacritty`:
   ```bash
   mkdir -p ~/.config/alacritty
   cp -r /path/to/repo/alacritty/* ~/.config/alacritty/
   ```
   Replace `/path/to/repo` with your repository path. This sets Alacritty to spawn maximized, use FiraCode Nerd Font, and run Zsh.

### Step 2: Install Zsh and Oh My Zsh
1. Install Zsh:
   ```bash
   sudo apt install -y zsh
   ```
2. Verify installation:
   ```bash
   zsh --version
   ```
3. Install Oh My Zsh:
   ```bash
   sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
   ```
4. Install Powerlevel10k theme:
   ```bash
   git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
   ```
5. Install Zsh plugins:
   ```bash
   git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
   git clone https://github.com/zsh-users/zsh-syntax-highlighting ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
   ```
6. Configure Zsh:
   Copy `zshrc` and `p10k.zsh` to your home directory:
   ```bash
   cp /path/to/repo/zshrc ~/.zshrc
   cp /path/to/repo/p10k.zsh ~/.p10k.zsh
   ```
   Run `p10k configure` after loading Zsh to customize the prompt if desired.

### Step 3: Install Neovim
1. Install Neovim:
   ```bash
   sudo apt install -y neovim
   ```
2. Verify installation:
   ```bash
   nvim --version
   ```

### Step 4: Install C++ Tools
1. Install `clang`, `clangd`, and C++ standard library headers:
   ```bash
   sudo apt install -y clang clangd libstdc++-12-dev
   ```
   - `libstdc++-12-dev` provides standard library headers (e.g., `<iostream>`).
   - Optionally, install `libc++-dev` for `clang`’s standard library:
     ```bash
     sudo apt install -y libc++-dev libc++abi-dev
     ```
2. Install `g++` (alternative compiler, used by `asyncrun.vim`):
   ```bash
   sudo apt install -y g++
   ```
3. Install `bear` (to generate `compile_commands.json` for `clangd`):
   ```bash
   sudo apt install -y bear
   ```
4. Install `xclip` (for Neovim clipboard support):
   ```bash
   sudo apt install -y xclip
   ```
5. Verify installations:
   ```bash
   clang --version
   clangd --version
   g++ --version
   bear --version
   xclip --version
   ```

### Step 5: Set Up Neovim Configuration
1. Install `lazy.nvim` (plugin manager):
   ```bash
   git clone --filter=blob:none https://github.com/folke/lazy.nvim.git \
     ~/.local/share/nvim/lazy/lazy.nvim
   ```
2. Copy Neovim config:
   Clone this repository or copy the `nvim/` directory to `~/.config/nvim`:
   ```bash
   mkdir -p ~/.config/nvim
   cp -r /path/to/repo/nvim/* ~/.config/nvim/
   ```
   The configuration includes:
   - `init.lua`: Main configuration with plugin setup and basic settings.
   - `lua/config/`: Modular configs for LSP, autocompletion, treesitter, lualine, and asyncrun.
3. Install plugins:
   Open Neovim and run:
   ```bash
   nvim
   :Lazy sync
   ```

### Step 6: Set Up tmux Configuration
1. Copy tmux config:
   Copy `tmux.conf` to `~/.tmux.conf`:
   ```bash
   cp /path/to/repo/tmux.conf ~/.tmux.conf
   ```
2. Reload tmux config:
   Start tmux and reload:
   ```bash
   tmux
   Ctrl-a r
   ```

### Step 7: Configure C++ Project
1. Generate `compile_commands.json` (for `clangd` to resolve headers):
   In your project directory (e.g., `~/dev/cpp/test`):
   ```bash
   cd ~/dev/cpp/test
   bear -- clang++ -std=c++17 test.cpp -o test
   ```
   This creates a `compile_commands.json` file, ensuring `clangd` finds standard library headers like `<iostream>`.

## Configuration Details

### Neovim
- **Plugin Manager**: `lazy.nvim` for managing plugins.
- **Plugins**:
  - `nvim-lspconfig`: Configures `clangd` for C++ LSP (autocompletion, diagnostics).
  - `nvim-cmp` + `cmp-nvim-lsp`: Autocompletion with LSP integration.
  - `L3MON4D3/LuaSnip`: Snippet engine for code snippets.
  - `nvim-treesitter`: Syntax highlighting for C++ and other languages.
  - `asyncrun.vim`: Auto-compiles C++ files on save, showing output in quickfix.
  - `lualine.nvim`: Custom statusline.
  - `tokyonight.nvim`: Theme.
  - Others: `clangd_extensions.nvim`, `vim-fugitive`.
- **Key Files**:
  - `~/.config/nvim/init.lua`: Main configuration.
  - `~/.config/nvim/lua/config/lsp.lua`: LSP setup for `clangd`.
  - `~/.config/nvim/lua/config/cmp.lua`: Autocompletion setup.
  - `~/.config/nvim/lua/config/treesitter.lua`: Syntax highlighting.
  - `~/.config/nvim/lua/config/lualine.lua`: Statusline.
  - `~/.config/nvim/lua/config/asyncrun.lua`: Auto-compilation.

### tmux
- **Prefix**: `Ctrl-a` (replaces default `Ctrl-b`).
- **Key File**: `~/.tmux.conf` with custom bindings for pane splitting, navigation, and reloading.
- **Features**:
  - Mouse support enabled.
  - Custom status bar with hostname and time.
  - Easy pane splitting and navigation.

### Alacritty
- **Features**: GPU-accelerated, maximized window, FiraCode Nerd Font, Zsh shell.
- **Key File**: `~/.config/alacritty/alacritty.yml` with font, color, and shell settings.

### Zsh with Oh My Zsh
- **Features**: Powerlevel10k theme, instant prompt, autocompletion, syntax highlighting, Git and tmux plugins, C++ aliases.
- **Key Files**:
  - `~/.zshrc`: Main Zsh configuration with Oh My Zsh and plugins.
  - `~/.p10k.zsh`: Powerlevel10k prompt settings.

## Common Keybindings

### Neovim
- **Leader Key**: `Space` (set via `vim.g.mapleader = " "`).
- **General**:
  - `:w`: Save file (triggers auto-compilation for `.cpp` files).
  - `:q`: Quit.
- **LSP (C++ Specific)**:
  - `gd`: Go to definition.
  - `K`: Show hover documentation.
  - `<leader>ca`: Code actions (e.g., fix errors).
  - `<leader>rn`: Rename symbol.
  - `<C-Space>`: Trigger autocompletion.
- **Quickfix (for `asyncrun.vim`)**:
  - `<leader>q`: Open quickfix window (show compilation output/errors).
  - `<leader>Q`: Close quickfix window.
  - `<leader>qn`: Next quickfix item.
  - `<leader>qp`: Previous quickfix item.
  - `<leader>cc`: Manually compile and run C++ file.
- **Note**: `<leader>` means press `Space`, then the next key (e.g., `Space q` for `<leader>q`).

### tmux
- **Prefix**: `Ctrl-a` (press `Ctrl-a`, release, then the next key).
- **Pane Management**:
  - `Ctrl-a |`: Split pane vertically.
  - `Ctrl-a -`: Split pane horizontally.
  - `Alt-Left/Right/Up/Down`: Navigate between panes (no prefix needed).
- **Config Reload**:
  - `Ctrl-a r`: Reload `~/.tmux.conf` (displays "Reloaded!").
- **Session Management**:
  - `Ctrl-a d`: Detach from session.
  - `tmux attach -t <session>`: Reattach to a session.
- **Other**:
  - `Ctrl-a ?`: List all keybindings.

### Zsh
- **Aliases** (defined in `~/.zshrc`):
  - `cppcompile`: `clang++ -std=c++17 -Wall`.
  - `cpprun`: `./a.out`.
  - `cppbuild`: `bear -- clang++ -std=c++17 -Wall` (generates `compile_commands.json`).
  - Git aliases (via `git` plugin): `gst` (`git status`), `ga` (`git add`), etc.
- **Autocompletion**: Press Tab to complete commands (e.g., `clang++ --std=` → `c++17`).

## Usage Workflow

1. **Start Alacritty**:
   ```bash
   alacritty
   ```
   Opens a maximized Zsh session with Powerlevel10k prompt.

2. **Start tmux**:
   ```bash
   tmux
   ```
   Or create a named session:
   ```bash
   tmux new -s cpp_dev
   ```

3. **Split Panes**:
   - `Ctrl-a |`: Vertical split (e.g., Neovim in one pane, terminal in another).
   - `Ctrl-a -`: Horizontal split (e.g., for logs or Git).

4. **Edit C++ Code**:
   - Open Neovim: `nvim test.cpp`.
   - Write code, use LSP features (`gd`, `K`, `<C-Space>`).
   - Save (`:w`) to auto-compile via `asyncrun.vim`.
   - View errors/output: `<leader>q`.
   - Navigate errors: `<leader>qn`/`qp`.

5. **Compile and Run**:
   - Auto-compilation runs `clang++ -std=c++17 file.cpp -o file.out && ./file.out` on save.
   - Manually compile: `<leader>cc` or `cppcompile test.cpp -o test && cpprun`.
   - Generate `compile_commands.json`: `cppbuild test.cpp -o test`.

6. **Version Control**:
   In a tmux pane, use Git:
   ```bash
   gst  # git status
   ga .  # git add .
   git commit -m "Update code"
   ```

7. **Reload Configs**:
   - Neovim: `:source ~/.config/nvim/init.lua`.
   - tmux: `Ctrl-a r`.
   - Zsh: `source ~/.zshrc`.

## Customization

- **Neovim**:
  - Add plugins in `init.lua` under `require("lazy").setup`.
  - Modify `lua/config/` files for LSP, autocompletion, etc.
  - Explore plugins like `telescope.nvim` (fuzzy finder) or `nvim-dap` (debugging).
- **tmux**:
  - Change prefix (e.g., `set -g prefix C-s`) in `~/.tmux.conf`.
  - Add plugins via TPM (tmux Plugin Manager).
- **Alacritty**:
  - Configure in `~/.config/alacritty/alacritty.yml` (e.g., font size, colors).
- **Zsh**:
  - Add plugins to `~/.zshrc` (e.g., `docker`, `kubectl`).
  - Customize Powerlevel10k: `p10k configure`.
- **Backup**:
  - Store `~/.config/nvim`, `~/.tmux.conf`, `~/.config/alacritty`, `~/.zshrc`, and `~/.p10k.zsh` in this repository.
  - Commit changes: `git add . && git commit -m "Update dotfiles"`.

## Contributing

Feel free to fork this repository, submit issues, or suggest improvements. These dotfiles are tailored for my C++ workflow but can be adapted for other languages.

## License

MIT License. Use and modify these dotfiles freely.