# gitcheck

A small command-line tool that finds every git repository inside a folder (at any depth) and shows the `git status` of each one. It's handy for spotting uncommitted work or unpushed commits across all your projects at once.

```
$ gitcheck ~/Code
✔ ./chess-engine  main...origin/main
● ./emulator
## main...origin/main [ahead 2]
 M src/cpu.c
?? notes.txt

✔ ./website  main...origin/main
```

- **✔ green**: clean, and in sync with the remote
- **● yellow**: uncommitted changes, untracked files, or ahead of/behind the remote

## Install

One-liner:

```bash
curl -fsSL https://raw.githubusercontent.com/PharellJay/Gitcheck/main/install.sh | bash
```

Or from a clone:

```bash
git clone https://github.com/PharellJay/Gitcheck.git
cd Gitcheck
./install.sh
```

This puts `gitcheck` in `~/.local/bin`. If that folder isn't on your `PATH`, the installer tells you what to add to your shell config.

To install somewhere else, set `INSTALL_DIR`:

```bash
sudo INSTALL_DIR=/usr/local/bin ./install.sh
```

**Requirements:** bash, git, and curl or wget (only for the one-liner). Works on Linux and macOS.

## Usage

```bash
gitcheck              # scan the current folder
gitcheck ~/projects   # scan a specific folder
gitcheck -n ~/projects  # skip fetching (instant, works offline)
gitcheck --help
```

- Repos nested inside other repos are found too.
- `.git` and `node_modules` folders are skipped to keep it fast.
- Every repo is fetched first (in parallel), so ahead/behind is current. Fetching never changes your files or branches. Repos whose fetch fails, for example because they need a password, are flagged in red instead of being silently shown as in sync. Use `-n`/`--no-fetch` to skip this when offline; ahead/behind then reflects your last fetch.
- Files matched by `.gitignore` never appear as untracked. If a file you expect to be ignored still shows up as `??`, the pattern doesn't match it; `git check-ignore -v <file>` shows which rule (if any) applies.

## Uninstall

```bash
./install.sh --uninstall
```

or just `rm ~/.local/bin/gitcheck`.

## License

[MIT](LICENSE)
