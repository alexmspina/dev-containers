export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"
export XDG_CACHE_HOME="$HOME/.cache"

# Set zsh history
HISTFILE=~/.config/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

setopt INC_APPEND_HISTORY
setopt SHARE_HISTORY
setopt HIST_IGNORE_DUPS
setopt HIST_REDUCE_BLANKS
setopt HIST_VERIFY

autoload -Uz compinit && compinit

# Zsh Plugin Management with antidote
source /root/.antidote/antidote.zsh
antidote load

# Shell Configuration
## Prompt Configuration
export STARSHIP_LOG="error"
export STARSHIP_CONFIG=$XDG_CONFIG_HOME/starship/starship.toml
eval "$(starship init zsh)"

## History Search Keyboard Shortcuts
bindkey "^[[A" history-beginning-search-backward
bindkey "^[[B" history-beginning-search-forward

## Completions
export CARAPACE_BRIDGES='zsh,fish,bash,inshellisense'
zstyle ':completion:*' format $'\e[2;37mCompleting %d\e[m'
source <(carapace _carapace)

## Fuzzy Searching
### Files and Directories
export FZF_DEFAULT_COMMAND='fd --type file --hidden --follow --exclude .git'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND='fd --type directory --hidden --follow --exclude .git'
export FZF_DEFAULT_OPTS="--height 40% --layout=reverse --border --preview 'bat --color=always --style=numbers --line-range=:500 {}'"
export FZF_CTRL_R_OPTS="--preview 'echo {}' --preview-window down:3:hidden:wrap --bind '?:toggle-preview'"

### File Contents
search_contents() {
rg --color=always --line-number --no-heading --smart-case "''${*:-}" | 
fzf --ansi --delimiter : \
    --preview 'bat --style=numbers --color=always --highlight-line {2} {1}' \
    --preview-window '+{2}+3/3'
}
alias sc='search_contents'

## Copy and Pasting
alias uuidgen='uuidgen | tr A-F a-f | tr -d "\n" | tee >(pbcopy)'
