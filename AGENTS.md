# Repository Guidelines

## Project Structure & Module Organization

This repository is a personal Neovim configuration. `init.lua` is the entry point and loads either the standard setup or the VS Code integration. Core behavior lives under `lua/r1v3r/`: options, keymaps, events, platform detection, and lazy.nvim bootstrap logic. Plugin specifications are grouped by purpose in `lua/plugins/*.lua`; keep detailed setup functions in the matching `lua/plugins/configs/<group>/` directory. Shared helpers belong in `lua/helper/`. User snippets are stored in `snips/snippets/`, with LuaSnip-specific definitions in `snips/lua/`. Plugin revisions are pinned in `lazy-lock.json`.

## Build, Test, and Development Commands

There is no build step. Use these commands from the repository root:

- `nvim` starts Neovim with the configuration and installs missing plugins through lazy.nvim.
- `nvim --headless "+Lazy! sync" +qa` synchronizes plugins and refreshes the lockfile when specifications change.
- `stylua --config-path .stylua.toml .` formats all Lua files.
- `stylua --check --config-path .stylua.toml .` reproduces the style CI check.
- `luacheck . --std luajit --globals vim _toggle_lazygit _command_panel _flash_esc_or_noh _debugging --max-line-length 150 --no-config` reproduces lint CI.
- `nvim --headless +qa` is the minimum startup smoke test; use `:checkhealth` interactively for plugin or provider issues.

## Coding Style & Naming Conventions

Lua is formatted by StyLua with tabs, a four-column indent, Unix line endings, and a 120-column width. Prefer double quotes and trailing commas in multiline tables. Name modules and configuration files in lowercase, using hyphens only when matching a plugin name. Use descriptive `snake_case` for new local functions and variables, while preserving nearby conventions in older modules. Keep plugin declarations small and move substantial configuration into `lua/plugins/configs/`.

## Testing Guidelines

No dedicated automated test framework is present. Every change should pass formatting, Luacheck, and a headless startup. For plugin changes, open a representative file type and exercise affected keymaps or commands. Confirm `lazy-lock.json` changes are intentional.

## Commit & Pull Request Guidelines

History follows Conventional Commits, for example `feat: add plugin integration`, `fix(treesitter): support Neovim APIs`, and `chore(plugins): update plugins`. Keep each commit focused. Pull requests should explain the behavior change, list validation performed, link relevant issues, and include screenshots only for visible UI changes.

## Local Configuration

Do not commit machine-specific settings, secrets, or paths. Put local overrides in `_device.lua`; it is intentionally ignored by Git.
