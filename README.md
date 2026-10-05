# macOS dotfiles

Personal macOS configuration, themes, scripts, and wallpaper assets. The app
directories are arranged as GNU Stow packages where practical; the files in
`scripts/`, `wallpapers/`, and `live-wallpapers/` are shared assets referenced
by the configs.

## Packages

| Directory | Managed configuration |
| --- | --- |
| `aerospace/` | `~/.aerospace.toml` |
| `ghostty/` | Ghostty's Application Support config |
| `kitty/` | `~/.config/kitty/` |
| `kshell/` | `~/.config/kshell/config.toml` |
| `nvim/` | `~/.config/nvim/` |
| `sketchybar/` | `~/.config/sketchybar/` |
| `tmux/` | `~/.config/tmux/` |

With GNU Stow installed, packages can be linked from this directory with:

```sh
cd ~/dotfiles
stow -t "$HOME" aerospace ghostty kitty kshell nvim sketchybar tmux
```

This repo assumes shared assets remain at `~/dotfiles`, as referenced by some
theme and launcher configs. Review the package list before stowing on another
machine, since these settings are tailored to this macOS setup.

## kshell

The personal kshell config is versioned at
`kshell/.config/kshell/config.toml` and linked at `~/.config/kshell`. The kshell
application source remains a separate project at
`~/programs/projects/kshell`; this repo only owns its user configuration.
Build/install the app from that project before using the kshell integrations.

## Preserved items

`misc/lost-and-found/` contains old backups, cache data, a loose image, and
files that were removed from the active layout. They are kept for reference,
not used by the current configuration. The tmux plugin backups remain recorded
as submodules there; initialize them only if you need their archived contents.
