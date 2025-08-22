# 🛠️ Dotfiles

This repository contains my personal **dotfiles** and configuration files for setting up my development environment.

## 📂 Included Configurations
- **Zsh / .zshrc** → shell setup, aliases, and environment variables
- **Starship** → minimal, fast, and customizable shell prompt
- **WezTerm** → GPU-accelerated terminal emulator with Lua config
- **Zellij** → terminal multiplexer for panes, tabs, and plugins
- **Neovim** → modern text editor with Lua-based configuration
- **AeroSpace** → tiling window manager for macOS
- **JankyBorders** → window border styling for macOS tiling WMs

## ⚡ Usage
Clone the repo and symlink the configs to your home directory:

```bash
git clone https://github.com/<your-username>/dotfiles.git ~/dotfiles
cd ~/dotfiles

# Example symlink for zshrc
ln -s ~/dotfiles/.zshrc ~/.zshrc
```
