# 2NVIM Config

The NeoVim configuration that I created.

Why the name: I have the habit of putting a "2" infront of all the configs and applications I make. It's supposed to mean "towards X"  
eg. "Towards a NVIM config"

**This project is not affiliated or associated with the NeoVim project in any way.**

## Installation

1.

```sh
$ ./install.sh
>
```

This creates an executable in your path called `2nvim` that will open NeoVim with the configuration.

2. I recommend you install the "M+1Code Nerd Font Mono" font

3. If you don't have `xterm`, install it through you package manager

4. _If_ you want to replace nvim with 2nvim, you can add the following to your `.bashrc` or `.zshrc`:

```sh
alias nvim=2nvim
```

## But why make it so complicated

I wanted to make a configuration that used VsCode keybindings, but the best terminal applications (Konsole on Linux, and Window Terminal on Windows) comes with built in keybindings that can't be overwritten. Some of these keybindings clash with the VsCode keybindings.

eg. I want `Ctrl+Tab` to switch between NeoVim tabs, but both Konsole and Windows Terminal uses `Ctrl+Tab` to switch between terminal tabs

By providing a seperate executable, I was able to

- Define the baseline terminal keybindings for all installs
  - Use the "intuitive" keybindings that are overwritten by the terminal in my neovim config
- Define a standard font
- Don't overwrite `nvim` (so I can change between configurations easily and uninstall without any reminant issues)
- xterm is a ligher weight application that saves memory and gives me more granular control over the keybindings
- **You can start it from application launchers**. It's annoting to start NeoVim from application launchers (eg. `Ctrl + D` in i3). Running `$ nvim` does not start neovim. Running `$ 2nvim` does start a neovim window.

## Default keybindings

- `Ctrl + S` Save
- `Ctrl + Q` Close tab (I haven't used `Ctrl + W` because it's used for window operations)
- `Ctrl + Tab` Goes forward a tab
- `Ctrl + Shift + Tab` Goes back a tab
- `Ctrl + \` Opens a new buffer (vertical split)
- `Ctrl + Shift + F` Searches for a string in all files (in the current and sub directories)
- `Ctrl + Shift + P` Opens the command palette
- `Ctrl + P` Find file
- `Ctrl + F` Find in file
- `Ctrl + Shift + E` Opens the file explorer

### Todo
- `Ctrl + /` Comments out a line
