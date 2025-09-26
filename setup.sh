#!/bin/bash

# ==============================================================================
#                 WSL Debian/Ubuntu Terminal Setup Script
# ==============================================================================
#
# This script automates the setup of a personalized terminal environment.
#
# It performs the following steps:
#   1. Updates package lists and installs essential CLI tools and dependencies.
#   2. Installs Oh My Zsh for Zsh configuration management.
#   3. Installs the Powerlevel10k theme and several useful Zsh plugins.
#   4. Copies the local dotfiles (.zshrc, .p10k.zsh, .tmux.conf) to the home directory.
#   5. Sets Zsh as the default shell for the current user.
#
# ==============================================================================

# Exit immediately if a command exits with a non-zero status.
set -e

# --- Step 1: Update package lists and install dependencies ---
echo "INFO: Updating package lists and installing dependencies..."
sudo apt-get update
sudo apt-get install -y zsh git curl tmux ripgrep

# Install bat (modern 'cat')
# On newer Ubuntu/Debian, the package is 'bat'. On older ones, it's 'batcat'.
# This script installs 'bat' and creates a symlink 'bat' -> 'batcat' if needed.
sudo apt-get install -y bat
if ! command -v bat &> /dev/null; then
    if command -v batcat &> /dev/null; then
        echo "INFO: Creating 'bat' symlink to 'batcat'."
        sudo ln -s /usr/bin/batcat /usr/local/bin/bat
    fi
fi


# Install fd (modern 'find')
# The package is 'fd-find', and the binary is 'fdfind'. We create a symlink for 'fd'.
sudo apt-get install -y fd-find
if [ ! -f /usr/local/bin/fd ]; then
    echo "INFO: Creating 'fd' symlink to 'fdfind'."
    sudo ln -s $(which fdfind) /usr/local/bin/fd
fi

# Install eza (modern 'ls')
# Official installation steps from https://github.com/eza-community/eza/blob/main/INSTALL.md
echo "INFO: Installing eza..."
sudo apt-get install -y gpg
sudo mkdir -p /etc/apt/keyrings
wget -qO- https://raw.githubusercontent.com/eza-community/eza/main/deb.asc | sudo gpg --dearmor -o /etc/apt/keyrings/gierens.gpg
echo "deb [signed-by=/etc/apt/keyrings/gierens.gpg] http://deb.gierens.de stable main" | sudo tee /etc/apt/sources.list.d/gierens.list
sudo chmod 644 /etc/apt/keyrings/gierens.gpg /etc/apt/sources.list.d/gierens.list
sudo apt-get update
sudo apt-get install -y eza


# --- Step 2: Install Oh My Zsh ---
# Check if Oh My Zsh is already installed
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    echo "INFO: Installing Oh My Zsh..."
    # The '--unattended' flag prevents the installer from trying to change the default shell. We do that last.
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
else
    echo "INFO: Oh My Zsh is already installed. Skipping."
fi


# --- Step 3: Install Powerlevel10k Theme and Zsh Plugins ---
ZSH_CUSTOM=${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}

# Install Powerlevel10k theme
if [ ! -d "${ZSH_CUSTOM}/themes/powerlevel10k" ]; then
    echo "INFO: Installing Powerlevel10k theme..."
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM}/themes/powerlevel10k
else
    echo "INFO: Powerlevel10k theme is already installed. Skipping."
fi

# Install zsh-autosuggestions plugin
if [ ! -d "${ZSH_CUSTOM}/plugins/zsh-autosuggestions" ]; then
    echo "INFO: Installing zsh-autosuggestions plugin..."
    git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM}/plugins/zsh-autosuggestions
else
    echo "INFO: zsh-autosuggestions plugin is already installed. Skipping."
fi

# Install zsh-syntax-highlighting plugin
if [ ! -d "${ZSH_CUSTOM}/plugins/zsh-syntax-highlighting" ]; then
    echo "INFO: Installing zsh-syntax-highlighting plugin..."
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM}/plugins/zsh-syntax-highlighting
else
    echo "INFO: zsh-syntax-highlighting plugin is already installed. Skipping."
fi

# Install zsh-history-substring-search plugin
if [ ! -d "${ZSH_CUSTOM}/plugins/zsh-history-substring-search" ]; then
    echo "INFO: Installing zsh-history-substring-search plugin..."
    git clone https://github.com/zsh-users/zsh-history-substring-search ${ZSH_CUSTOM}/plugins/zsh-history-substring-search
else
    echo "INFO: zsh-history-substring-search plugin is already installed. Skipping."
fi


# --- Step 4: Copy Configuration Files ---
# This assumes your config files are in the same directory as the script.
echo "INFO: Copying configuration files..."
cp .zshrc $HOME/.zshrc
cp .p10k.zsh $HOME/.p10k.zsh
cp .tmux.conf $HOME/.tmux.conf


# --- Step 5: Set Zsh as the default shell ---
# Check if the current shell is already zsh
if [ "$SHELL" != "$(which zsh)" ]; then
    echo "INFO: Setting Zsh as the default shell..."
    if chsh -s $(which zsh); then
        echo "INFO: Default shell changed to Zsh."
    else
        echo "ERROR: Could not set Zsh as default shell. Please do it manually."
    fi
else
    echo "INFO: Zsh is already the default shell. Skipping."
fi

echo ""
echo "✅ Setup complete!"
echo "Please restart your terminal or log out and log back in for changes to take full effect."
