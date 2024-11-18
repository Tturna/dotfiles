# My dotfiles and related files

Various configs and setup things using GNU Stow.

---
# Setup

GNU Stow will populate the parent directory with symlinks to all files in the working directory.
To apply the files in this repo to a system as they are/were on my system, do the following.

1. Install stow with your package manager (e.g. `pacman -S stow`)
2. Clone or download this repository to your home directory (as a directory called `dotfiles` to keep it simple).
3. Run `stow .` inside the (`dotfiles`) directory or run `stow --adopt .` instead to automatically move existing files into the `dotfiles` directory (replacing the files).

The directory structure should look like this before running `stow`:
```
/home/user/ (~)
- .config/ (if you have existing configs)
- dotfiles (or whatever you named your directory)
  - <files in this repo>
```

Running `stow .` will create symlinks inside your home directory to all files in the `dotfiles` directory.

*NOTE: running `stow .` with a file structure like above will error because `.config/` already exists. `stow --adopt .` will automatically move `.config/` into `dotfiles/` and replace whatever was in this repo.*

To replace any existing configs and files:
1. Make sure your dotfiles directory is a git repository
2. `stow --adopt .` to move existing files to the repo (and overwrite) and create the symlinks
3. `git restore .` to restore the overwrites back to what they were

[Video tutorial](https://www.youtube.com/watch?v=y6XCebnB9gs)


