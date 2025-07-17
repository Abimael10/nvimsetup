# Personal Neovim Configuration Setup

A modern, minimal Neovim configuration built with [lazy.nvim](https://github.com/folke/lazy.nvim) plugin manager, featuring LSP support, advanced completion, fuzzy finding, and syntax highlighting.

## ⚡ Features

- **Plugin Management**: [lazy.nvim](https://github.com/folke/lazy.nvim) for fast, modern plugin management
- **LSP Support**: Language Server Protocol integration with `nvim-lspconfig`
- **Intelligent Completion**: [Blink.cmp](https://github.com/saghen/blink.cmp) for fast, Rust-powered autocompletion
- **Fuzzy Finding**: [Telescope](https://github.com/nvim-telescope/telescope.nvim) for file and content searching
- **Syntax Highlighting**: [Treesitter](https://github.com/nvim-treesitter/nvim-treesitter) for advanced syntax highlighting
- **Status Line**: [Mini.statusline](https://github.com/echasnovski/mini.nvim) for a clean status bar
- **Theme**: [Tokyo Night](https://github.com/folke/tokyonight.nvim) colorscheme

## 📋 Prerequisites

- **Neovim** >= 0.9.0
- **Git** for plugin management
- **Node.js** (for LSP servers)
- **Rust** (for Blink.cmp compilation, optional)
- **ripgrep** (for Telescope live grep)

## 🚀 Installation

1. **Backup existing configuration** (if any):
   ```bash
   mv ~/.config/nvim ~/.config/nvim.backup
   ```

2. **Clone this configuration**:
   ```bash
   git clone <repository-url> ~/.config/nvim
   ```

3. **Launch Neovim**:
   ```bash
   nvim
   ```
   
   Lazy.nvim will automatically install all plugins on first launch.

## 🔧 Configuration Structure

```
nvimsetup/
├── init.lua                    # Main configuration entry point
├── lazy-lock.json             # Plugin version lock file
└── lua/
    └── config/
        ├── lazy.lua           # Lazy.nvim bootstrap and setup
        └── plugins/
            ├── autocomplete.lua  # Blink.cmp completion setup
            ├── lsp.lua          # LSP configuration
            ├── mini.lua         # Mini.nvim statusline
            ├── telescope.lua    # Telescope fuzzy finder
            └── treesitter.lua   # Treesitter syntax highlighting
```

## ⌨️ Key Mappings

### Leader Key
- **Leader**: `<Space>`
- **Local Leader**: `\`

### Core Mappings

| Key Combination | Mode | Action | Description |
|----------------|------|--------|-------------|
| `<Space><Space>x` | Normal | `<cmd>source %<CR>` | Reload current file |
| `<Space>x` | Normal | `:.lua<CR>` | Execute current line as Lua |
| `<Space>x` | Visual | `:lua<CR>` | Execute selected text as Lua |

### Telescope Mappings

| Key Combination | Action | Description |
|----------------|--------|-------------|
| `<Space>fh` | Find Help | Search through Neovim help tags |
| `<Space>fd` | Find Files | Find files in current directory |
| `<Space>en` | Edit Neovim | Browse Neovim config files |

### Completion (Blink.cmp)

| Key Combination | Action | Description |
|----------------|--------|-------------|
| `Ctrl+Space` | Open Menu | Open completion menu or docs |
| `Ctrl+n` / `Ctrl+p` | Navigate | Select next/previous item |
| `Up` / `Down` | Navigate | Select next/previous item |
| `Ctrl+y` | Accept | Accept selected completion |
| `Ctrl+e` | Close | Hide completion menu |
| `Ctrl+k` | Signature | Toggle signature help |

## 🔌 Plugins Overview

### Core Plugins

#### 1. **Lazy.nvim** - Plugin Manager
- Lazy loading for improved startup time
- Automatic plugin installation and updates
- Lock file for reproducible setups

#### 2. **LSP Configuration** (`lsp.lua:3-11`)
- **Plugin**: `neovim/nvim-lspconfig`
- **Supported Languages**: Rust (Rust Analyzer)
- **Features**: Diagnostics, go-to definition, hover documentation
- **Note**: Lua LSP is commented out but available

#### 3. **Blink.cmp** - Completion Engine (`autocomplete.lua:3-54`)
- **Plugin**: `saghen/blink.cmp`
- Rust-powered fuzzy matching for performance
- Sources: LSP, file paths, snippets, buffer text
- Friendly snippets integration

#### 4. **Telescope** - Fuzzy Finder (`telescope.lua:3-21`)
- **Plugin**: `nvim-telescope/telescope.nvim`
- File finding, help search, config browsing
- Plenary.nvim dependency for Lua utilities

#### 5. **Treesitter** - Syntax Highlighting (`treesitter.lua:3-51`)
- **Plugin**: `nvim-treesitter/nvim-treesitter`
- **Parsers**: C, Lua, Vim, Markdown, Vimdoc
- Performance optimized (disables for large files >100KB)

#### 6. **Mini.statusline** - Status Bar (`mini.lua:3-9`)
- **Plugin**: `echasnovski/mini.nvim`
- Clean, minimal status line with icons

#### 7. **Tokyo Night** - Theme (`lazy.lua:26`)
- **Plugin**: `folke/tokyonight.nvim`
- Modern dark theme with good contrast

## ⚙️ Editor Settings

### Core Settings (`init.lua:3-7`)
- **Clipboard**: System clipboard integration (`unnamedplus`)
- **Line Numbers**: Enabled (`number = true`)
- **Indentation**: 4 spaces (`shiftwidth = 4`)

### Visual Features
- **Yank Highlighting**: Visual feedback when copying text (`init.lua:15-21`)
- **Icons**: Nerd Font support in statusline and completion

## 🛠️ Language Support

### Currently Configured
- **Rust**: Full LSP support with Rust Analyzer
- **Lua**: Treesitter highlighting (LSP available but commented)
- **C**: Treesitter highlighting
- **Markdown**: Treesitter highlighting
- **Vim**: Treesitter highlighting

### Adding New Languages

1. **Add LSP server** in `lua/config/plugins/lsp.lua`:
   ```lua
   require("lspconfig").your_language_server.setup {
       capabilities = capabilities
   }
   ```

2. **Add Treesitter parser** in `lua/config/plugins/treesitter.lua`:
   ```lua
   ensure_installed = { "c", "lua", "vim", "your_language" }
   ```

## 🔍 Troubleshooting

### Plugin Issues
- **Reset plugins**: Remove `~/.local/share/nvim` and restart
- **Update plugins**: Run `:Lazy update` in Neovim
- **Check health**: Run `:checkhealth` for diagnostics

### LSP Issues
- **Install language servers**: Ensure your language server is installed
- **Check LSP status**: Run `:LspInfo` to see active servers
- **View logs**: Run `:LspLog` for debugging

### Performance Issues
- Large files (>100KB) automatically disable Treesitter highlighting
- Lazy loading ensures fast startup times
- Use `:Lazy profile` to analyze plugin load times

## 📚 Learning Resources

- [Neovim Documentation](https://neovim.io/doc/)
- [Lazy.nvim Documentation](https://github.com/folke/lazy.nvim)
- [LSP Configuration Guide](https://github.com/neovim/nvim-lspconfig)
- [Telescope Usage](https://github.com/nvim-telescope/telescope.nvim)
- [Treesitter Configuration](https://github.com/nvim-treesitter/nvim-treesitter)

## 🎯 Next Steps

1. **Install language servers** for your preferred languages
2. **Customize key mappings** in respective plugin files
3. **Add more plugins** by creating new files in `lua/config/plugins/`
4. **Configure additional LSP servers** in `lsp.lua`
5. **Explore Telescope extensions** for enhanced functionality

---

*This configuration provides a solid foundation for modern Neovim development with room for customization and expansion.*
