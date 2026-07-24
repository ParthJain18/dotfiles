# Dotfiles

My personal dotfiles managed with GNU Stow.

## Quickstart

To set up a new machine from scratch, clone this repository and run the automated installation script:

```bash
git clone [https://github.com/YOUR_USERNAME/dotfiles.git](https://github.com/YOUR_USERNAME/dotfiles.git) ~/dotfiles
cd ~/dotfiles
chmod +x install.sh
./install.sh

## Manual Installation

1. System Packages

```
sudo apt update
sudo apt install -y zsh git stow tmux bat zoxide tree
sudo snap install lsd
```

2. Binaries (Tealdeer & FZF)

```
# FZF
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install --all

# Tealdeer (tldr)
mkdir -p ~/.local/bin
wget https://github.com/dbrgn/tealdeer/releases/latest/download/tealdeer-linux-x86_64-musl -O ~/.local/bin/tldr
chmod +x ~/.local/bin/tldr

# Superfiles (spf)
bash -c "$(curl -sLo- https://superfile.dev/install.sh)"
```

3. Zsh Framework & Plugins

```
# Oh My Zsh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

# Custom Plugins & Themes
ZSH_CUSTOM=${ZSH_CUSTOM:-~/.oh-my-zsh/custom}
git clone https://github.com/zsh-users/zsh-autosuggestions $ZSH_CUSTOM/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git $ZSH_CUSTOM/themes/powerlevel10k
git clone https://github.com/zsh-users/zsh-completions $ZSH_CUSTOM/plugins/zsh-completions
git clone https://github.com/Aloxaf/fzf-tab $ZSH_CUSTOM/plugins/fzf-tab
```

4. Stow Configurations

```
cd ~/dotfiles
stow zsh tmux fastfetch tealdeer
```

5. Finalize

```
chsh -s $(which zsh)
```

