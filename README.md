# .dotfiles

## Installation

Make sure you have [GNU Stow](https://www.gnu.org/software/stow/) installed.

If you're lifting these from me and plan on making edits, it's strongly recommend you fork the repo first.

Clone into your home directory:

```
cd ~
git clone git@github.com:Golf0ned/.dotfiles.git
cd .dotfiles
```

To install any of these dotfiles, run stow on the directory:

```
stow nvim
stow tmux
```

Make sure to read the helpers section as well.

## Helpers

### Symlinking by hand

Can't install stow (looking at you, college servers with limited permissions)? Symlink by hand!

```
ln -s <path-to-target> <path-to-symlink-destination>
```

### Symlink Hell

Don't accidentally allow stow to symlink too aggressively!

```
mkdir -p ~/.local
mkdir -p ~/.local/bin
mkdir -p ~/.config
mkdir -p ~/.config/hypr
```

### WezTerm

If setting up WSL, remember that WezTerm config should live in your windows install.

While you're at it, may as well make a symlink to your windows anyways...

```
ln -s /mnt/c/Users/<windows-username> ~/windows
mkdir -p ~/windows/.config
cp ~/.dotfiles/wezterm/.config/wezterm/ ~/windows/.config/
```

Also, remember to change your WSL distribution if you're not cool like me
