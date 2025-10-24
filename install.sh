#!/bin/bash

echo "Installing APT and Snap packages..."
sudo apt update
sudo apt install -y \
    zsh \
    git \
    stow \
    tmux \
    bat \
    zoxide \
    tree \
    curl \
    python3 \
    python3-pip \
sudo snap install lsd

echo "Installing uv..."
curl -LsSf https://astral.sh/uv/install.sh | sh
uv tool install sassyshell

if [ ! -d "$HOME/.fzf" ]; then
    echo "Cloning fzf..."
    git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
else
    echo "fzf is already cloned."
fi

if [ ! -d "$HOME/.oh-my-zsh" ]; then
    echo "Installing Oh My Zsh..."
    sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
else
    echo "Oh My Zsh is already installed."
fi

ZSH_CUSTOM=${ZSH_CUSTOM:-~/.oh-my-zsh/custom}

if [ ! -d "$ZSH_CUSTOM/plugins/zsh-autosuggestions" ]; then
    echo "Cloning zsh-autosuggestions..."
    git clone https://github.com/zsh-users/zsh-autosuggestions $ZSH_CUSTOM/plugins/zsh-autosuggestions
fi

if [ ! -d "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting" ]; then
    echo "Cloning zsh-syntax-highlighting..."
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting
fi

if [ ! -d "$ZSH_CUSTOM/themes/powerlevel10k" ]; then
    echo "Cloning powerlevel10k..."
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git $ZSH_CUSTOM/themes/powerlevel10k
fi

echo "Cleaning up default configs..."
rm -f $HOME/.zshrc

echo "Stowing dotfiles..."
stow zsh tmux fzf

echo "Running fzf installer..."
~/.fzf/install --all

echo "Changing default shell to Zsh..."
chsh -s $(which zsh)

echo "All done! Close and re-open your terminal."