ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

[ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
[ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"

source "${ZINIT_HOME}/zinit.zsh"


# adding syntax highlighting.
zinit light zsh-users/zsh-syntax-highlighting
#Adding auto completions settings.
zinit light zsh-users/zsh-completions
#Adding auto suggestion.
zinit light zsh-users/zsh-autosuggestions
#Fzf auto completions
zinit light Aloxaf/fzf-tab


#Add snippets
zinit snippet OMZP::git
zinit snippet OMZP::aws


# === 🛠 Compiler and Rust Config === #

export PATH="/opt/homebrew/opt/llvm/bin:$PATH"
export RUSTFLAGS="-L/opt/homebrew/opt/libpq/lib"


# Zoxide for fast directory jumping
eval "$(zoxide init zsh)"


# For terminal colors in tmux (optional)
export TERM=tmux-256color


#Styling 
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' no menu

#load auto-completions at the start.
autoload -U compinit && compinit

#replays all the cached completions
zinit cdreplay -q

eval "$(starship init zsh)"

bindkey '^p' history-search-backward
bindkey '^n' history-search-forward

#Command history setup.
HISTSIZE=4000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
setopt HIST_IGNORE_DUPS
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups


#alias
alias ls='ls --color'

#fzf integrations.
eval "$(fzf --zsh)"

