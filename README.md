
## Installation

```bash
sudo apt update
sudo apt install -y \
    zsh \
    git \
    stow \
    tmux \
    bat \
    zoxide
sudo snap install lsd

git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install
```

```
# Run the OMZ installer
sh -c "$(curl -fsSL [https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh](https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh))"

git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/themes/powerlevel10k
```

## Stow
```bash
stow zsh git tmux fzf
```

## Change default shell
```bash
chsh -s $(which zsh)
```
