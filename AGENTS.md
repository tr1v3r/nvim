# Repository Guidelines

## Project Structure & Module Organization

This repository is a personal Neovim configuration. `init.lua` is the entry point and loads either the standard setup or the VS Code integration (under `vim.g.vscode`, `lua/r1v3r/pack.lua` loads only plugin specs flagged `vsc = true`). Core behavior lives under `lua/r1v3r/`. Plugin specifications are grouped in `lua/plugins/*.lua`; keep detailed setup functions in the matching `lua/plugins/configs/<group>/` directory. Shared helpers belong in `lua/helper/`, snippets in `snips/`, and startup smoke checks in `tests/`. Plugin revisions are pinned in `lazy-lock.json`.

`CLAUDE.md` is a symlink to this file — edit `AGENTS.md` and keep the symlink intact.

## Build, Test, and Development Commands

There is no build step. Neovim 0.12.4 and tree-sitter CLI 0.26.1+ are required. Use these commands from the repository root:

- `nvim` starts Neovim with the configuration and installs missing plugins through lazy.nvim.
- `nvim --headless "+Lazy! sync" +qa` synchronizes plugins and refreshes the lockfile when specifications change.
- `stylua --config-path .stylua.toml .` formats all Lua files.
- `stylua --check --config-path .stylua.toml .` reproduces the style CI check.
- `luacheck . --std luajit --globals vim Snacks _open_lazygit _command_panel _flash_esc_or_noh _debugging --max-line-length 150 --no-config` reproduces lint CI.
- `nvim --headless +qa` is the minimum startup check; CI's smoke job runs `tests/smoke.lua` against the root `init.lua` and `tests/fixtures/treesitter.md` to assert Treesitter highlighting starts cleanly.

## Coding Style & Naming Conventions

Lua is formatted by StyLua with tabs, a four-column indent, Unix line endings, and a 120-column width. Prefer double quotes and trailing commas in multiline tables. Name modules and configuration files in lowercase, using hyphens only when matching a plugin name. Use descriptive `snake_case` for new local functions and variables, while preserving nearby conventions in older modules. Keep plugin declarations small and move substantial configuration into `lua/plugins/configs/`. There is no `.luacheckrc`; when adding a new `_G.*` helper, extend the `--globals` list in `.github/workflows/lint.yml` or lint CI fails.

## Testing Guidelines

No dedicated test framework is present. Every change should pass formatting, Luacheck, and a headless startup. For Treesitter changes, run `nvim --headless tests/fixtures/treesitter.md "+luafile ${PWD}/tests/smoke.lua" +qa`. For other plugin changes, exercise affected keymaps or commands. Confirm `lazy-lock.json` changes are intentional. `.github/workflows/update_lockfile.yml` auto-commits `chore(deps): auto update lazy-lock.json` daily as github-actions[bot] — pull before editing the lockfile and do not blindly revert bot commits.

## Commit & Pull Request Guidelines

History follows Conventional Commits, for example `feat: add plugin integration`, `fix(treesitter): support Neovim APIs`, and `chore(plugins): update plugins`. Keep each commit focused. Pull requests should explain the behavior change, list validation performed, link relevant issues, and include screenshots only for visible UI changes. Work lands directly on `master` (there is no `dev` branch here, unlike the parent dotfiles repo); CI runs on pushes to `master` and on PRs.

## Local Configuration

Do not commit machine-specific settings, secrets, or paths. Put overrides in the table returned by `_device.lua`; it is intentionally ignored by Git and loaded before plugin setup. Language tooling is selected by the `lsp_deps`, `treesitter_deps`, `null_ls_deps`, and `dap_deps` tables in `lua/r1v3r/settings.lua`; override them per-machine via `_device.lua` (CI's smoke job does the same, keeping only the `lua`/`markdown`/`markdown_inline` parsers). `use_ssh` defaults to `true`, so plugin clones go over SSH — on a machine without GitHub SSH keys, create `_device.lua` with `use_ssh = false` before first startup.
