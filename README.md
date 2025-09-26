# My Ideal Terminal Setup for WSL

This repository contains the configuration files and an automated setup script to provision my ideal terminal environment on a new Debian-based WSL (Windows Subsystem for Linux) instance, such as Ubuntu.

The script installs all necessary packages and plugins, and then copies the configuration files to their correct locations.

## Features

This setup script will install and configure the following:

*   **Shell:** Zsh as the default login shell.
*   **Zsh Framework:** [Oh My Zsh](https://ohmyz.sh/) for managing Zsh configuration.
*   **Prompt/Theme:** [Powerlevel10k](https://github.com/romkatv/powerlevel10k) for a fast, flexible, and informative prompt.
*   **Zsh Plugins:**
    *   [zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions): Fish-like autosuggestions for commands.
    *   [zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting): Command line syntax highlighting.
    *   [history-substring-search](https://github.com/zsh-users/zsh-history-substring-search): Enhanced history search.
*   **Modern CLI Tools:**
    *   [tmux](https://github.com/tmux/tmux/wiki): A terminal multiplexer.
    *   [eza](https://github.com/eza-community/eza): A modern replacement for `ls`.
    *   [bat](https://github.com/sharkdp/bat): A `cat` clone with syntax highlighting and Git integration.
    *   [ripgrep](https://github.com/BurntSushi/ripgrep): A very fast alternative to `grep`.
    *   [fdfind](https://github.com/sharkdp/fd): A simple, fast, and user-friendly alternative to `find`.

## Prerequisites

*   A Debian-based Linux distribution (e.g., Ubuntu) running on WSL.
*   The `git` and `curl` packages (the script installs them if they are missing).
*   `sudo` (administrator) privileges to install packages.

## Installation

1.  **Clone the Repository**

    Clone this repository to a location of your choice on your WSL instance, for example, in your home directory:
    ```bash
    git clone https://github.com/YOUR_USERNAME/YOUR_REPO_NAME.git
    cd YOUR_REPO_NAME
    ```

2.  **Run the Setup Script**

    Execute the setup script from within the repository's root directory:
    ```bash
    ./setup.sh
    ```
    The script will prompt for your password to install packages via `apt`.

## Post-Installation

After the script finishes, you **must close and reopen** your WSL terminal for all changes, especially the new default shell, to take effect.

## Customization

You can easily customize this setup by editing the configuration files in this repository *before* running the `setup.sh` script.

*   **Zsh Settings & Plugins:** Modify the `.zshrc` file to change plugins, aliases, or other Zsh settings.
*   **Prompt Appearance:** The `.p10k.zsh` file controls the Powerlevel10k prompt. You can re-run `p10k configure` in the terminal to generate a new configuration.
*   **Tmux Keybindings:** Edit the `.tmux.conf` file to change tmux settings and keybindings.
