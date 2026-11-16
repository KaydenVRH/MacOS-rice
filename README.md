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
| `herdr/` | `~/.config/herdr/config.toml` |
| `kitty/` | `~/.config/kitty/` |
| `kshell/` | `~/.config/kshell/config.toml` |
| `nvim/` | `~/.config/nvim/` |
| `sketchybar/` | `~/.config/sketchybar/` |
| `tmux/` | `~/.config/tmux/` |

With GNU Stow installed, packages can be linked from this directory with:

```sh
cd ~/dotfiles
stow -t "$HOME" aerospace ghostty herdr kitty kshell nvim sketchybar tmux
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

## tmux

`tmux/.config/tmux/tmux.conf` mirrors the kitty multiplexing bindings in
`kitty/.config/kitty/kitty.conf` — same `Ctrl+B` prefix, same keys for splits,
pane movement, tabs, layouts, zoom, scrollback, reload and the fzf script
picker. Two kitty-specific bindings have the closest tmux equivalent: `w`
(kitty's `launch --location=neighbor`) opens a pane beside this one, and `s`
runs the same script picker inside a tmux popup.

Colours are not stored in `tmux.conf`. `scripts/tmux-theme.sh` writes
`theme.conf` from the active kshell theme's palette and reloads a running
server, and both switchers call it — `kshell theme <name>` from the app and
`scripts/theme-switch.sh <name>` from a shell. `theme.conf` is generated, so it
is gitignored; delete it and tmux falls back to its own colours.

## Preserved items

`misc/lost-and-found/` contains old backups, cache data, a loose image, and
files that were removed from the active layout. They are kept for reference,
not used by the current configuration. The tmux plugin backups remain recorded
as submodules there; initialize them only if you need their archived contents.
