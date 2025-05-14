# Dotfiles

This repository contains my personal configuration files (dotfiles) for various tools and environments.

## Table of Contents

- [Overview](#dotfiles)
- [Applications](#applications)
- [Configuration Contents](#configuration-contents)
- [Usage](#usage)
- [License](#license)

## Configuration Contents

- Shell configuration (`.bashrc`, `.zshrc`)
- Editor settings (e.g., VSCode, Vim)
- Git configuration
- Other development tools

## Categories of Applications

### Terminal Emulators
- [Alacritty](https://alacritty.org/): A fast, cross-platform, OpenGL terminal emulator.
- [Kitty](https://sw.kovidgoyal.net/kitty/): A fast, feature-rich, GPU-based terminal emulator.
- [Ghostty](https://github.com/ghostty/ghostty): A terminal emulator that supports true color and has a built-in file manager.

### Shells & Prompts
- [Zsh](https://www.zsh.org/): A shell designed for interactive use, also a powerful scripting language.
- [Fish](https://fishshell.com/): A smart and user-friendly command line shell.
- [Starship](https://starship.rs/): The minimal, blazing-fast, and infinitely customizable prompt for any shell.

### Editors
- [Vim](https://www.vim.org/): A highly configurable text editor.
- [Neovim](https://neovim.io/): A hyperextensible Vim-based text editor.
- [Nano](https://www.nano-editor.org/): A simple and easy-to-use text editor.
- [Emacs](https://www.gnu.org/software/emacs/): The extensible, customizable, self-documenting real-time display editor.
- [Helix](https://helix-editor.com/): A post-modern text editor.
- [Micro](https://micro-editor.github.io/): A terminal-based text editor that is easy to use and has a modern interface.

### File & Directory Tools
- [Midnight Commander](https://midnight-commander.org/): A file manager for Unix-like systems.
- [Zoxide](https://github.com/ajeetdsouza/zoxide): A smart and efficient alternative to `cd`.
- [Ranger](https://ranger.github.io/): A terminal file manager with VI key bindings.
- [Fasd](https://github.com/junegunn/fasd): A command-line fuzzy finder.
- [Fzf](https://github.com/junegunn/fzf): A command-line fuzzy finder.
- [NCDU](https://dev.yorhel.nl/ncdu): A disk usage analyzer with an ncurses interface.
- [Bat](https://github.com/sharkdp/bat): A `cat(1)` clone with wings.

### Window Management & UI
- [Bspwm](https://github.com/bspwm/bspwm): A tiling window manager.
- [Awesome](https://awesomewm.org/): A highly configurable window manager for X11.
- [Polybar](https://github.com/polybar/polybar): A fast and easy-to-use status bar.
- [Picom](https://github.com/yaylitzis/picom): A lightweight compositor for X11.
- [Rofi](https://github.com/davatorium/rofi): A window switcher, application launcher, and dmenu replacement.
- [Dunst](https://github.com/dunst-project/dunst): A lightweight and customizable notification daemon.
- [Zellij](https://zellij.dev/): A terminal workspace and multiplexer.
- [Tmux](https://github.com/tmux/tmux): A terminal multiplexer.

### System Monitoring & Utilities
- [Glances](https://nicolargo.github.io/glances/): A cross-platform system monitoring tool.
- [Bpytop](https://github.com/ArtyomTrityak/bpytop): A terminal-based resource monitor.
- [Mision Center](https://missioncenter.io/): A system monitoring tool.
- [Neofetch](https://github.com/dylanaraps/neofetch): Displays system information.
- [speedtest](https://www.speedtest.net/): Test your internet connection speed.
- [Ripgrep](https://github.com/BurntSushi/ripgrep): A fast search tool.
- [tldr-pages](https://github.com/tldr-pages/tldr): Simplified and community-driven man pages.
- [Nerd Fonts](https://github.com/ryanoasis/nerd-fonts): Iconic fonts for developers.

## Contents

- Shell configuration (`.bashrc`, `.zshrc`)
- Editor settings (e.g., VSCode, Vim)
- Git configuration
- Other development tools

## Usage

Clone the repository and symlink the files to your home directory:

```sh
git clone https://github.com/yourusername/dotfile.git
cd dotfile
# Example for .bashrc
ln -s $(pwd)/.bashrc ~/.bashrc
```

## License

MIT License
