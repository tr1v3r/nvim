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

## TypeScript and JavaScript

Install with `npm install -g typescript@6 typescript-language-server`. The executable must be on Neovim's `PATH`. The server prefers the project's TypeScript installation and uses the global TypeScript as a fallback. TypeScript 7's native package does not include `tsserver.js`; the current Homebrew formula therefore cannot serve standalone files without an additional compatible TypeScript installation.

The native `ts_ls` configuration enables LSP support for TS, TSX, JS, and JSX, including definitions, references, hover, completion, rename, and code actions. It uses the semantic server directly so initial cross-file queries do not return syntax-only import locations. Project roots are detected from `tsconfig.json`, `jsconfig.json`, `package.json`, or `.git`; standalone files also work. Formatting remains delegated to the existing formatter configuration.

After the server attaches, use `ge` to jump to a definition, `gd` to preview it, `gr` for references, `gt` for a type definition, `H` for hover, and `<leader>cw` to rename. Check attached clients with `:lua print(vim.inspect(vim.lsp.get_clients({ bufnr = 0 })))`.

## Maintenance and Validation

```sh
stylua --check --config-path .stylua.toml .
luacheck . --std luajit --globals vim Snacks _command_panel _flash_esc_or_noh --max-line-length 150 --no-config
nvim --headless +qa
nvim --headless tests/fixtures/treesitter.md "+luafile ${PWD}/tests/smoke.lua" +qa
```

With `typescript-language-server` installed, run `nvim --headless -i NONE "+luafile tests/lsp-typescript.lua" +qa` to verify TS/TSX/JS/JSX service attachment, definitions, references, hover, rename, and the `ge`/`gd` keymaps, plus standalone TS navigation.

Use `:Lazy sync` after changing plugin specifications, `:TSUpdate` after Treesitter updates, and `:checkhealth` when diagnosing providers or external tools. Plugin revisions are committed in `lazy-lock.json`.
