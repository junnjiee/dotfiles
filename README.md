# zhng my Mac

[zhng](https://www.singlish.net/zhng/)

Note: Install [brew](https://brew.sh/) from source, then everything else flows from here

1. Install all applications in `Brewfile`

```
brew bundle
```

Stow essentials

- `-t` -> set target directory (default is parent of current dir)
- `-n` -> no-op, only show what happens
- `-v` -> control output verbosity

2. Create symlink in `~/target/dir` from current directory for a package

```
stow -t ~/target/dir <package-name>
```
