# Setup fzf
# ---------
if [[ ! "$PATH" == */home/parthlinux/.fzf/bin* ]]; then
  PATH="${PATH:+${PATH}:}/home/parthlinux/.fzf/bin"
fi

source <(fzf --zsh)
