# Repository Guidelines

## Project Structure & Module Organization
- `init.lua` bootstraps LazyVim, establishes leader keys, and pulls in everything under `lua/config`.
- `lua/config/options.lua` centralizes core editor options; adjust defaults there instead of scattering `vim.opt` calls.
- `lua/config/lazy.lua` defines plugin imports; keep custom modules under `lua/config/plugins/` so Lazy can auto-discover them.
- Each file in `lua/config/plugins/*.lua` configures a single feature (e.g., `telescope.lua`, `treesitter.lua`); mirror that pattern when adding new tools.
- `lazy-lock.json` pins plugin revisions—re-run `nvim --headless "+Lazy sync" +qa` and commit the lockfile whenever dependencies change.

## Build, Test, and Development Commands
- `nvim --headless "+Lazy sync" +qa` installs or removes plugins per `lua/config/lazy.lua`.
- `nvim --headless "+Lazy check" +qa` validates plugin updates and highlights breaking changes before you push them.
- `nvim --headless "+checkhealth" +qa` runs health checks for core subsystems (LSP, Treesitter, formatters); resolve warnings prior to review.
- `nvim --clean -u init.lua "+Lazy profile"` opens a clean session for profiling load time—use it when investigating startup regressions.

## Coding Style & Naming Conventions
- Lua files use two-space indentation with `expandtab=true` (see `lua/config/options.lua`); helpers and locals should follow `snake_case`.
- Return plugin specs as tables and avoid inline anonymous functions when a local helper keeps the module readable.
- For user commands or keymaps, group related mappings in dedicated tables and annotate non-obvious behavior with concise comments.
- Formatting relies on LazyVim’s Conform + Prettier extras; run `:Format` inside affected buffers before committing.

## Testing Guidelines
- After editing plugins, reload quickly with `:Lazy reload {module}` or `:source %` to catch runtime errors without restarting.
- Use `:checkhealth` after dependency or LSP tweaks, and capture a short summary of notable warnings in the pull request.
- When modifying Treesitter or formatting rules, open representative files (Lua, TypeScript, Markdown) and confirm highlighting, completion, and formatting still apply.

## Commit & Pull Request Guidelines
- Follow a lightweight Conventional Commits style such as `feat(plugins): add markdown preview tweaks` to keep history searchable.
- Limit commits to one concern and include relevant `AGENTS.md` or config updates when behavior changes.
- Pull requests should outline the motivation, list affected plugins or options, mention test commands run, and include screenshots/GIFs for UI-visible changes.

## Agent-Specific Instructions
- Toggle AI assistants in `lua/config/lazy.lua`; only enable one provider per branch to keep `lazy-lock.json` stable.
- Document any agent-specific keymaps or workflows in the relevant plugin module so contributors can understand the active assistant.
- Use `<leader>uc` to open the colorscheme selector and swap between the bundled presets (Tokyo Night, Catppuccin, GitHub Dark, Carbonfox, Gruvbox, OneDark, Kanagawa, Everforest, Rose Pine, Dracula).
