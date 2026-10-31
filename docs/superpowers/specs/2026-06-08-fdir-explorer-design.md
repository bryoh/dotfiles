# Design: `fdir` - Fuzzy Directory Explorer

A fuzzy directory explorer for Zsh that uses `eza` for listing and `fzf` for interactive navigation. It features live reloading to filter directories dynamically and provides a rich tree-view preview of directory contents.

## Goals
- Provide a fast way to find and navigate to directories.
- Support an optional starting path as a parameter.
- Use `eza` (or `exa`) for high-performance, colored directory listing.
- Interactive live filtering using `fzf`'s `reload` capability.

## Architecture

### 1. Data Source
The command will use `eza` with the following flags:
- `--only-dirs`: Filter to directories only.
- `--all`: Include hidden directories.
- `--color=always`: Maintain color output for `fzf`.

### 2. Interaction Model (`fzf`)
- **Initial Query:** Accepts a path as the first argument (defaults to `.`).
- **Reloading:** As the user types, `fzf` reloads the list using `eza` filtered by the query.
- **Preview:** A side pane showing the contents of the highlighted directory using `eza --tree`.

### 3. Logic Flow
1. Check if `eza` or `exa` is installed.
2. Define the `fdir` function.
3. Capture the starting directory from `$1`.
4. Execute `fzf` with a `reload` bind that calls `eza`.
5. On selection (Enter), the command will print the path (or `cd` into it, depending on final user preference).

## Proposed Implementation

```zsh
fdir() {
  local start_dir="${1:-.}"
  local cmd
  if command -v eza >/dev/null 2>&1; then
    cmd="eza"
  else
    cmd="exa"
  fi

  # --disabled: fzf won't filter the list itself, we rely on the reload command
  # --bind "change:reload...": re-runs the search as you type
  # {q} is the current query string in fzf
  $cmd --only-dirs --all --color=always "$start_dir" | \
    fzf --ansi --disabled --query "" \
      --prompt "Dir> " \
      --header "TAB to select | Enter to print path" \
      --bind "change:reload:$cmd --only-dirs --all --color=always $start_dir | grep -i {q} || true" \
      --preview "$cmd --tree --level=2 --color=always $start_dir/{}" \
      --preview-window="right:50%:border-left"
}
```

## Alternatives Considered
- **Standard fzf filtering:** Faster for small trees, but lacks the "live" feel for very large structures.
- **Recursive search by default:** Can be slow in home directories or root; the "Live Explorer" approach is more targeted.

## Verification Plan
1. Source the function in a test shell.
2. Run `fdir` without arguments (starts in `.`).
3. Run `fdir ~/dotfiles` (starts in specific path).
4. Verify that typing filters the list.
5. Verify that the preview pane shows the directory tree.
