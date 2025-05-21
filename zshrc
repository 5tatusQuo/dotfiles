   # Enable Powerlevel10k instant prompt. Must be at the very top of ~/.zshrc.
   # Initialization code that may require console input (e.g., read, tty) must go
   # above this block; everything else should go below.
   if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
     source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
   fi

   # Path to Oh My Zsh installation
   export ZSH="$HOME/.oh-my-zsh"

   # Theme (Powerlevel10k for a modern, customizable prompt)
   ZSH_THEME="powerlevel10k/powerlevel10k"

   # Plugins (enhance C++ workflow, tmux, and git)
   plugins=(
     git              # Git commands and aliases
     zsh-autosuggestions  # Suggests commands as you type
     zsh-syntax-highlighting  # Syntax highlighting for commands
     tmux             # Tmux integration
     command-not-found  # Suggests packages for unknown commands
   )

   # Source Oh My Zsh (must be after instant prompt preamble)
   source $ZSH/oh-my-zsh.sh

   # Powerlevel10k prompt customization (run `p10k configure` to tweak)
   [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

   # Aliases for C++ development
   alias cppcompile="clang++ -std=c++17 -Wall"
   alias cpprun="./a.out"
   alias cppbuild="bear -- clang++ -std=c++17 -Wall"

   # Environment variables
   export PATH="$PATH:/usr/lib/llvm-14/bin"  # Ensure clangd is in PATH
   export EDITOR="nvim"  # Set Neovim as default editor

   # Tmux integration
   export ZSH_TMUX_AUTOSTART=false  # Don’t auto-start tmux (use manually)

   export PATH="$PATH:/opt/nvim-linux-x86_64/bin"
export PATH="$HOME/.local/bin:$PATH"
