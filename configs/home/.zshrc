# --- KODA OS CONFIG ---
export KODA_DIR="$HOME/.local/share/koda"
# Ajoute tes scripts Koda au PATH pour pouvoir les lancer de n'importe où
export PATH="$KODA_DIR/bin:$PATH"

export PATH="$HOME/.config/emacs/bin:$PATH"

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"
# export XDG_DATA_DIRS="/usr/share:/usr/local/share"

ZSH_THEME="robbyrussell"

# --- history setup ---
HISTFILE=$HOME/.zhistory
SAVEHIST=1000
HISTSIZE=999
setopt share_history 
setopt hist_expire_dups_first
setopt hist_ignore_dups
setopt hist_verify
setopt share_history

# --- completion using arrow keys (based on history) ---
bindkey '^[[A' history-search-backward
bindkey '^[[B' history-search-forward

# ---- FZF -----

# Set up fzf key bindings and fuzzy completion
eval "$(fzf --zsh)"

cf() {
  local dir
  # On utilise eza au lieu de tree car c'est ce que tu as sur ton système
  dir=$(fd --type d . "${1:-.}" | fzf --preview "eza --tree --icons -L 2 {} | head -200") && cd "$dir"
}

fh() {
  print -z $( ([ -n "$ZSH_NAME" ] && fc -ln 1 || history) | fzf +s --tac | sed 's/ *[0-9]* *//')
}

# Sélectionner un processus et le tuer (SIGTERM)
fk() {
  local pid
  pid=$(ps -ef | sed 1d | fzf -m --ansi --preview "echo {}" --preview-window=bottom:3:wrap | awk '{print $2}')
  if [ "x$pid" != "x" ]; then
    echo $pid | xargs kill -9
  fi
}

# --- setup fzf theme ---
# fg="#CBE0F0"
# bg="#011628"
# bg_highlight="#143652"
# purple="#B388FF"
# blue="#06BCE4"
# cyan="#2CF9ED"

# export FZF_DEFAULT_OPTS="--color=fg:${fg},bg:${bg},hl:${purple},fg+:${fg},bg+:${bg_highlight},hl+:${purple},info:${blue},prompt:${cyan},pointer:${cyan},marker:${cyan},spinner:${cyan},header:${cyan}"

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
#
plugins=(
    git
    zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

# You may need to manually set your language environment
export LANG=en_US.UTF-8
export EDITOR='nvim'

# Users are encouraged to define aliases within a top-level file in
# the $ZSH_CUSTOM folder, with .zsh extension. Examples:
# - $ZSH_CUSTOM/aliases.zsh
# - $ZSH_CUSTOM/macos.zsh
# For a full list of active aliases, run `alias`.

# ---- Zoxide (better cd) ----
eval "$(zoxide init zsh)"
alias cd="z"

# --- ALIAS --
alias zreload="source ~/.zshrc"
alias zedit="nvim ~/.zshrc"
alias n="nvim ."
alias ls='eza -lh --icons --group-directories-first'
alias la='eza -laH --icons --group-directories-first'
alias cdiut='cd ~/Desktop/ressources/etudes/'
alias cdiut2='cd ~/Desktop/ressources/etudes/s2/'
alias cdiut1='cd ~/Desktop/ressources/etudes/s1/'
alias python="python3"
alias cdk="cd $KODA_DIR"
alias fv='nvim $(fzf --preview "bat --color=always --style=numbers --line-range=:500 {}")'
alias tree='eza --tree --icons'
alias oc="opencode"

alias kodaconf='nvim ~/.local/share/koda/DONE-BUT-NOT-SAVE'

# Paramètres par défaut (couleurs, bordures, layout)
export FZF_DEFAULT_OPTS="--height 40% --layout=reverse --border --color=header:italic"

# Utiliser 'fd' au lieu de 'find' pour être plus rapide et ignorer le .git
export FZF_DEFAULT_COMMAND='fd --type f --strip-cwd-prefix --hidden --follow --exclude .git'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

# vim mode and reduce ESCAPE key timeout
bindkey -v
export KEYTIMEOUT=1
