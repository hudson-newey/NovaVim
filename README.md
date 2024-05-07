# NovaVim

![image](https://github.com/hudson-newey/NovaVim/assets/33742269/70fe99fd-ed40-4234-b15d-5d7036b8dd48)

## Installation

Installing will create an executable in `~/.local/bin` called `2nvim` that will open NovaVim

1. Install the "M+1Code Nerd Font Mono" font

### Using the Git repository (recommened)

2. Clone the GitHub repository

```sh
$ git clone https://github.com/hudson-newey/NovaVim.git
>
```

3.

```sh
$ ./install.sh
>
```

### Using the automatic installation script

Because you are installing by piping to shell, please check the script at <https://raw.githubusercontent.com/hudson-newey/NovaVim/main/web-install.sh> and <https://raw.githubusercontent.com/hudson-newey/NovaVim/main/install.sh> before running it

```sh
$ curl -sL https://raw.githubusercontent.com/hudson-newey/NovaVim/main/web-install.sh | sh
>
```

## Features

- **LSP** (Language Server Protocol) for autocompletion and linting
- **TreeSitter** for syntax highlighting
- **Telescope** for file picker and fuzzy finder
- **minimap.vim** for a minimap
- **NerdTree** for file explorer

## Default keybindings

- `Ctrl + S` Save
- `Ctrl + Q` Close tab (I haven't used `Ctrl + W` because it's used for window operations)
- `Ctrl + N` Select next occurnace of word (similar to `Ctrl + D` in VsCode) (I have a plan to bind this to `Ctrl + D` in the future)
- `Ctrl + O` Switch workspace
- `Ctrl + J` Opens the terminal
- `Ctrl + Tab` Goes forward a tab
- `Ctrl + Shift + Tab` Goes back a tab
- `Ctrl + \` Opens a new buffer (vertical split)

- `Ctrl + Shift + F` Searches for a string in all files (in the current and sub directories)
- `Ctrl + Shift + P` Opens the command palette
- `Ctrl + P` Find file
- `Ctrl + F` Find in file
- `Ctrl + Shift + E` Opens the file explorer
- `Ctrl + Shift + X` Opens Mason (to install extensions)

- `Ctrl + Shift + C` Copy (not the same as nvim yank)
- `Ctrl + Shift + V` Paste (not the same as nvim paste)
