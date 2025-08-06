# -----------------------------------------------------------------------------
# ZINIT - PLUGIN MANAGER
# -----------------------------------------------------------------------------

# Set the directory for zinit and its plugins
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# Download Zinit if it's not already installed
if [ ! -d "$ZINIT_HOME" ]; then
   mkdir -p "$(dirname $ZINIT_HOME)"
   git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

# Source zinit
source "${ZINIT_HOME}/zinit.zsh"

# -----------------------------------------------------------------------------
# PLUGINS
# -----------------------------------------------------------------------------

# Powerlevel10k Theme
zinit ice depth=1; zinit light romkatv/powerlevel10k

# Syntax Highlighting, Autosuggestions, and FZF
zinit ice lucid wait'0'; zinit light zsh-users/zsh-syntax-highlighting
zinit ice lucid wait'0'; zinit light zsh-users/zsh-autosuggestions
zinit ice lucid wait'0'; zinit light Aloxaf/fzf-tab
zinit ice lucid wait'0'; zinit light junegunn/fzf

# Completions
zinit ice wait'1' atinit'zicompinit'; zinit light zsh-users/zsh-completions

# Snippets
zinit ice lucid wait'0'; zinit snippet OMZL::git.zsh
zinit ice lucid wait'0'; zinit snippet OMZP::*

# -----------------------------------------------------------------------------
# POWERLEVEL10K
# -----------------------------------------------------------------------------

# Enable Powerlevel10k instant prompt
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Source the p10k configuration file
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# -----------------------------------------------------------------------------
# SHELL OPTIONS & HISTORY
# -----------------------------------------------------------------------------

# Keybindings
bindkey -e
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward
bindkey '^[w' kill-region

# History settings
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
setopt appendhistory sharehistory
setopt hist_ignore_space hist_ignore_all_dups hist_save_no_dups

# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'

# -----------------------------------------------------------------------------
# ALIASES & FUNCTIONS
# -----------------------------------------------------------------------------

alias ls="eza --icons=always"
alias vim='nvim'
alias c='clear'
alias lg='lazygit'

# Yazi file manager integration
function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}

# -----------------------------------------------------------------------------
# EXPORTS & ENVIRONMENT
# -----------------------------------------------------------------------------

# Homebrew (for macOS)
if [[ -f "/opt/homebrew/bin/brew" ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# Set default editor
export EDITOR="nvim"

# Zoxide (smarter cd)
eval "$(zoxide init zsh)"

# Tmuxifier
export PATH="$HOME/.tmuxifier/bin:$PATH"
eval "$(tmuxifier init -)"

# Bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
[ -s "$BUN_INSTALL/_bun" ] && source "$BUN_INSTALL/_bun"

# Java
export JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64
export PATH=$JAVA_HOME/bin:$PATH

# Local bin directory
export PATH="$HOME/.local/bin:$PATH"

# pnpm
export PNPM_HOME="/home/anurag-xo/.local/share/pnpm"
export PATH="$PNPM_HOME:$PATH"

# SDKMAN
export SDKMAN_DIR="$HOME/.sdkman"
[ -s "$SDKMAN_DIR/bin/sdkman-init.sh" ] && source "$SDKMAN_DIR/bin/sdkman-init.sh"

