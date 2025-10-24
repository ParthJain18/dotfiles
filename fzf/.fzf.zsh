# Setup fzf
# ---------
if [[ ! "$PATH" == */home/parth/.fzf/bin* ]]; then
  PATH="${PATH:+${PATH}:}/home/parth/.fzf/bin"
fi

source <(fzf --zsh)
