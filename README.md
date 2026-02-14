# zhng my Mac

[zhng](https://www.singlish.net/zhng/)

1. Install [brew](https://brew.sh/) from source

2. Install all applications in `Brewfile`

```
brew bundle
```

[Stow](https://man.archlinux.org/man/stow.8) essentials

- `-t` -> set target directory (default is parent of current dir)
- `-n` -> no-op, only show what happens
- `-v` -> control output verbosity

3. Create symlink in `~/target/dir` from current directory for a package

```
stow -t ~/target/dir <package-name>
```

4. Install [LazyVim](https://www.lazyvim.org/installation)
