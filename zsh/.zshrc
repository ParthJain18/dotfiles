# =============================================================================
# 1. PRE-INITIALIZATION
# =============================================================================
# Enable Powerlevel10k instant prompt
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Load custom SSH welcome screen immediately
if [ -f ~/.ssh_welcome.zsh ]; then
   source ~/.ssh_welcome.zsh
fi

# =============================================================================
# 2. ENVIRONMENT VARIABLES
# =============================================================================
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export NVM_DIR="$HOME/.nvm"

# Consolidated PATH
export PATH="$HOME/bin:$HOME/.local/bin:/snap/bin:$PATH"

# =============================================================================
# 3. OH MY ZSH CONFIGURATION
# =============================================================================
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="powerlevel10k/powerlevel10k"

plugins=(
  git
  sudo
  fzf
  zsh-completions
  fzf-tab
  zsh-autosuggestions
  zsh-syntax-highlighting
  npm
  docker
  docker-compose
  extract
  colored-man-pages
)

ZSH_DISABLE_COMPFIX="true"
source $ZSH/oh-my-zsh.sh

# =============================================================================
# 4. ALIASES
# =============================================================================
alias tmux='tmux -u'
alias ls='lsd'
alias cat='batcat'
alias sassysh='sassyshell ask'
alias caffeine='gnome-session-inhibit --inhibit idle sleep infinity'
alias dl-audiobook='yt-dlp -f "bestaudio[ext=m4a]/bestaudio" --cookies-from-browser firefox --embed-thumbnail --embed-metadata --add-metadata --embed-chapters -o "/data/audiobooks/%(title)s.%(ext)s"'
alias fd='fdfind'
alias python='python3'
alias copy='xclip -selection clipboard'

# =============================================================================
# 5. FUNCTIONS & LAZY LOADING
# =============================================================================
fastfetch() {
    local random_cat=$(find -L ~/.config/fastfetch/cats/ -maxdepth 1 -type f | shuf -n 1)
    local cols="$(tput cols)"
    if [[ -n "$cols" ]] && (( cols <= 120 )); then
        command fastfetch --logo-position top --logo-type file --logo "$random_cat" "$@"
    else
        command fastfetch --logo-type file --logo "$random_cat" "$@"
    fi
}

# Lazy-load NVM (Compacted)
nvm()  { unset -f nvm node npm npx; [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" --no-use; nvm "$@"; }
node() { unset -f nvm node npm npx; [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"; node "$@"; }
npm()  { unset -f nvm node npm npx; [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"; npm "$@"; }
npx()  { unset -f nvm node npm npx; [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"; npx "$@"; }

# =============================================================================
# 6. POST-INITIALIZATION
# =============================================================================
eval "$(zoxide init zsh --cmd cd)"

[ -f "$HOME/.local/bin/env" ] && source "$HOME/.local/bin/env"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
