# Neovim Configuration

Personal Neovim configuration focused on fast navigation, language tooling, debugging, and a lazy.nvim-managed plugin setup.

## Requirements

- Neovim 0.12.4
- `tree-sitter` CLI 0.26.1 or newer (tested with 0.26.11; do not use the npm package)
- Git, curl, tar, and a C compiler
- Optional tools used by plugins: `rg`, `fd`, language servers, formatters, and debug adapters

## Installation

Clone the repository into Neovim's default configuration path:

```sh
git clone git@github.com:tr1v3r/nvim.git ~/.config/nvim
nvim --headless "+Lazy! restore" +qa
nvim
```

The default configuration downloads plugins over SSH. To use HTTPS or disable machine-specific features, create an ignored `_device.lua` before the first startup:

```lua
return {
	use_ssh = false,
	use_copilot = false,
	colorscheme = "monokai-pro-spectrum",
}
```

Values returned from `_device.lua` override the defaults in `lua/r1v3r/settings.lua` before plugins and UI settings are loaded.

## Maintenance and Validation

```sh
stylua --check --config-path .stylua.toml .
luacheck . --std luajit --globals vim _toggle_lazygit _command_panel _flash_esc_or_noh _debugging --max-line-length 150 --no-config
nvim --headless +qa
nvim --headless tests/fixtures/treesitter.md "+luafile ${PWD}/tests/smoke.lua" +qa
```

Use `:Lazy sync` after changing plugin specifications, `:TSUpdate` after Treesitter updates, and `:checkhealth` when diagnosing providers or external tools. Plugin revisions are committed in `lazy-lock.json`.
