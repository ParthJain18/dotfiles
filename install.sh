#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

echo "🚀 Starting dotfiles installation..."

# 1. Update and install system packages
echo "📦 Installing system packages via apt..."
sudo apt update
sudo apt install -y zsh git stow bat zoxide tree curl wget fd-find sd ripgrep

# Install lsd via snap if not installed
if ! command -v lsd &> /dev/null; then
    echo "📦 Installing lsd via snap..."
    sudo snap install lsd
else
    echo "✅ lsd already installed. Skipping..."
fi

# 2. Fix batcat symlink for Ubuntu/Debian
mkdir -p ~/.local/bin
if [ ! -f ~/.local/bin/bat ]; then
    echo "🔗 Creating symlink for batcat -> bat..."
    ln -s /usr/bin/batcat ~/.local/bin/bat
fi

# 3. Install Binaries (FZF, Tealdeer, Superfile, Ghostty)
if [ ! -d ~/.fzf ]; then
    echo "🔍 Installing fzf..."
    git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
    ~/.fzf/install --all
else
    echo "✅ fzf already installed. Skipping..."
fi

if [ ! -f ~/.local/bin/tldr ]; then
    echo "📚 Installing tealdeer (tldr)..."
    wget https://github.com/dbrgn/tealdeer/releases/latest/download/tealdeer-linux-x86_64-musl -O ~/.local/bin/tldr
    chmod +x ~/.local/bin/tldr
else
    echo "✅ tealdeer already installed. Skipping..."
fi

if ! command -v spf &> /dev/null && ! command -v superfile &> /dev/null; then
    echo "🗂️ Installing superfile..."
    bash -c "$(curl -sLo- https://superfile.dev/install.sh)"
else
    echo "✅ superfile already installed. Skipping..."
fi

if ! command -v ghostty &> /dev/null; then
    echo "👻 Installing Ghostty..."
    # The official Ghostty docs recommend this for Ubuntu/Debian
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/mkasberg/ghostty-ubuntu/HEAD/install.sh)"
else
    echo "✅ ghostty already installed. Skipping..."
fi

# 4. Install Oh My Zsh
if [ ! -d ~/.oh-my-zsh ]; then
    echo "🐚 Installing Oh My Zsh..."
    sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
else
    echo "✅ Oh My Zsh already installed. Skipping..."
fi

# 5. Install Zsh Plugins & Themes
ZSH_CUSTOM=${ZSH_CUSTOM:-~/.oh-my-zsh/custom}

install_plugin() {
    if [ ! -d "$ZSH_CUSTOM/$2/$1" ]; then
        echo "🔌 Installing plugin: $1..."
        git clone "$3" "$ZSH_CUSTOM/$2/$1"
    else
        echo "✅ Plugin $1 already installed. Skipping..."
    fi
}

install_plugin "zsh-autosuggestions" "plugins" "https://github.com/zsh-users/zsh-autosuggestions"
install_plugin "zsh-syntax-highlighting" "plugins" "https://github.com/zsh-users/zsh-syntax-highlighting.git"
install_plugin "zsh-completions" "plugins" "https://github.com/zsh-users/zsh-completions"
install_plugin "fzf-tab" "plugins" "https://github.com/Aloxaf/fzf-tab"

if [ ! -d "$ZSH_CUSTOM/themes/powerlevel10k" ]; then
    echo "🎨 Installing Powerlevel10k..."
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$ZSH_CUSTOM/themes/powerlevel10k"
else
    echo "✅ Powerlevel10k already installed. Skipping..."
fi

# 6. Stow Configurations
echo "🔗 Stowing dotfiles..."
cd ~/dotfiles

# Ensure tealdeer config directory exists in the dotfiles repo
mkdir -p tealdeer/.config/tealdeer
if [ ! -f tealdeer/.config/tealdeer/config.toml ]; then
    echo -e "[updates]\nauto_update = true" > tealdeer/.config/tealdeer/config.toml
fi

# Remove existing tealdeer and ghostty configs in ~ to prevent stow conflicts
rm -rf ~/.config/tealdeer
rm -rf ~/.config/ghostty


if [ -f ~/.bashrc ] && [ ! -L ~/.bashrc ]; then
    echo "📦 Backing up default .bashrc to .bashrc.bak..."
    mv ~/.bashrc ~/.bashrc.bak
fi

# Loop through and stow existing directories
for dir in zsh bash git tmux fzf fastfetch tealdeer superfile ghostty; do
    if [ -d "$dir" ]; then
        stow "$dir"
        echo "✅ Stowed $dir"
    fi
done

# 7. Change default shell
if [ "$SHELL" != "$(which zsh)" ]; then
    echo "🔄 Changing default shell to zsh..."
    chsh -s $(which zsh)
fi

echo "🎉 Installation complete! Please restart your terminal or log out and log back in."
