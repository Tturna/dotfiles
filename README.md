# My dotfiles and related files

Various configs and setup things using GNU Stow.

---
# Setup

To apply these files to a system as they are/were on my system, do the following.

1. Install stow with your package manager (e.g. `pacman -S stow`)
2. Clone or download this repository to your home directory (often as a directory called `dotfiles`).
3. Run `stow .` inside the (`dotfiles`) directory or run `stow --adopt .` instead to automatically move existing files into the `dotfiles` directory (replacing files in `dotfiles`).

The directory structure should look like this before running `stow`:
```
/home/user/ (~)
- .config/ (if you have existing configs)
- dotfiles (or whatever you named your directory)
  - <files in this repo>
```

Running `stow .` will create symlinks inside your home directory to all files in the `dotfiles` directory.

*NOTE: running `stow .` with a file structure like above will error because `.config/` already exists. `stow --adopt .` will automatically move `.config/` into `dotfiles/` and replace whatever was in this repo.*

[Video tutorial](https://www.youtube.com/watch?v=y6XCebnB9gs)


