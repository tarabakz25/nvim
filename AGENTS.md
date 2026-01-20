# Repository Guidelines

## Project Structure
- `init.lua`: entrypoint; sets leader key and bootstraps plugin loading via `lazy.nvim`.
- `lua/options/`: editor behavior and UX (`basic.lua`, `ui.lua`, `keymap.lua`, `devserver.lua`).
- `lua/plugins/`: one file per feature/plugin; aggregated automatically by `lua/plugins/init.lua`.
- `luasnippets/`: local LuaSnip snippets loaded at startup.
- Docs: `architecture.md`, `keymap.md`, `plugins.md` describe design, mappings, and plugin inventory.
- Lockfile: `lazy-lock.json` pins plugin versions.

## Build, Test, and Development Commands
This repo is a Neovim configuration (no standalone build).
- Run locally: `nvim` (from this config directory) and watch for startup errors.
- Plugin management (inside Neovim): `:Lazy`, `:Lazy sync`, `:Lazy update`, `:Lazy clean`.
- Health checks: `:checkhealth` (verify external dependencies and providers).
- Tooling:
  - Format: `<leader>f` (via `conform.nvim`), inspect with `:ConformInfo`.
  - Lint: `<leader>li` (via `nvim-lint`).
  - Treesitter: `:TSUpdate`.
  - LSP installers: `:Mason` / `:MasonUpdate`.

## Coding Style & Naming Conventions
- Indentation: 2 spaces, `expandtab` (match `lua/options/basic.lua`).
- Keep settings in `lua/options/*` and plugin specs in `lua/plugins/*`.
- New plugin modules must `return` a lazy.nvim spec table (or list). Files are auto-discovered; no central registry edit needed.
- Prefer descriptive filenames like `web_dev.lua` or `live-server.lua` and keep plugin-specific keymaps close to the plugin module.

## Testing Guidelines
No automated test suite. Validate changes with a quick smoke test:
1. Start Neovim, run `:Lazy sync`, then restart.
2. Run `:checkhealth` and ensure no new errors.
3. Exercise the changed area (keymaps, LSP attach, formatting on save, etc.).

## Commit & Pull Request Guidelines
- Commit subjects in history commonly use prefixes like `fix:` and `refactor:`; follow that style (Japanese subjects are acceptable).
- PRs should include: a short rationale, any new/changed keymaps, and updates to `architecture.md` / `keymap.md` / `plugins.md` when behavior changes.
- Include screenshots or a short clip for UI/UX changes (statusline, dashboard, file explorer).

## Security & Local State
- Don’t commit machine-generated state like `.cache/`, `.state/`, `.data/`, or local logs (e.g. `.nvimlog`).
- Keep tokens/credentials out of the repo; prefer env vars or OS keychain-backed tooling.
