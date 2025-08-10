# First, put the evaluations that might produce output

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

if [[ -f "/opt/homebrew/bin/brew" ]]; then
  # If you're using macOS, you'll want this enabled
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# Set the directory we want to store zinit and plugins
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# Download Zinit, if it's not there yet
if [ ! -d "$ZINIT_HOME" ]; then
   mkdir -p "$(dirname $ZINIT_HOME)"
   git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

# Source/Load zinit
source "${ZINIT_HOME}/zinit.zsh"

# Add in Powerlevel10k
zinit ice depth=1; zinit light romkatv/powerlevel10k

# Add in zsh plugins using Turbo Mode (asynchronous loading)
# The 'ice' modifier configures how the next plugin is loaded.
# 'lucid' loads the plugin after the prompt is displayed, making the shell feel instant.
zinit ice lucid wait'0'; zinit light zsh-users/zsh-syntax-highlighting
zinit ice lucid wait'0'; zinit light zsh-users/zsh-autosuggestions
zinit ice lucid wait'0'; zinit light Aloxaf/fzf-tab
zinit ice lucid wait'0'; zinit light junegunn/fzf # Manages fzf keybindings and completions

# Let zinit handle completions. This loads them after a 1s delay and caches them.
zinit ice wait'1' atinit'zicompinit'; zinit light zsh-users/zsh-completions

# Add in snippets asynchronously
zinit ice lucid wait'0'; zinit snippet OMZL::git.zsh
zinit ice lucid wait'0'; zinit snippet OMZP::git
zinit ice lucid wait'0'; zinit snippet OMZP::sudo
zinit ice lucid wait'0'; zinit snippet OMZP::archlinux
zinit ice lucid wait'0'; zinit snippet OMZP::aws
zinit ice lucid wait'0'; zinit snippet OMZP::kubectl
zinit ice lucid wait'0'; zinit snippet OMZP::kubectx
zinit ice lucid wait'0'; zinit snippet OMZP::command-not-found

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Keybindings
bindkey -e
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward
bindkey '^[w' kill-region

# History
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'

# Aliases
# alias ls='ls --color'
alias ls="eza --icons=always"
alias vim='nvim'
alias c='clear'
alias lg='lazygit'

#--Zoxide (better cd) ---
eval "$(zoxide init zsh)"

#--yazi-setup--
export EDITOR="nvim"

function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}

#--tmuxifier-setup--"
export PATH="$HOME/.tmuxifier/bin:$PATH"

eval "$(tmuxifier init -)"

# bun completions
[ -s "/home/anurag-xo/.bun/_bun" ] && source "/home/anurag-xo/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

#java
export JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64  # Adjust path to your installation
export PATH=$JAVA_HOME/bin:$PATH

export PATH="$HOME/.local/bin:$PATH"

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

# Gemini Plugin

# pnpm
export PNPM_HOME="/home/anurag-xo/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end
