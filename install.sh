#!/usr/bin/env bash
# Install gitcheck to ~/.local/bin (override with INSTALL_DIR=/some/path).
# Uninstall with: ./install.sh --uninstall
set -euo pipefail

REPO_RAW="https://raw.githubusercontent.com/PharellJay/Gitcheck/main"
INSTALL_DIR="${INSTALL_DIR:-$HOME/.local/bin}"
target="$INSTALL_DIR/gitcheck"

if [[ ${1:-} == "--uninstall" ]]; then
  rm -f "$target"
  echo "✔ Removed $target"
  exit 0
fi

mkdir -p "$INSTALL_DIR"

# Use the local copy when run from a clone, otherwise download it.
src="${BASH_SOURCE[0]:-}"
if [[ -n $src && -f $src && -f "$(dirname "$src")/gitcheck" ]]; then
  cp "$(dirname "$src")/gitcheck" "$target"
else
  tmp="$(mktemp)"
  trap 'rm -f "$tmp"' EXIT
  if command -v curl >/dev/null 2>&1; then
    curl -fsSL "$REPO_RAW/gitcheck" -o "$tmp"
  elif command -v wget >/dev/null 2>&1; then
    wget -qO "$tmp" "$REPO_RAW/gitcheck"
  else
    echo "Error: need curl or wget to download gitcheck." >&2
    exit 1
  fi
  mv "$tmp" "$target"
fi

chmod +x "$target"
echo "✔ gitcheck installed to $target"

case ":$PATH:" in
  *":$INSTALL_DIR:"*) ;;
  *)
    echo
    echo "Note: $INSTALL_DIR is not on your PATH. Add this to your ~/.bashrc (or ~/.zshrc):"
    echo "  export PATH=\"$INSTALL_DIR:\$PATH\""
    ;;
esac
