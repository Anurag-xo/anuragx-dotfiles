# <img src="https://neovim.io/logos/neovim-mark-flat.png" width="40" height="40"> Anurag's Ultimate Neovim Config

<p align="center">
  <img src="https://img.shields.io/badge/Neovim-0.9.0+-green?logo=neovim" alt="Neovim Version">
  <img src="https://img.shields.io/badge/Lua-5.1+-blue?logo=lua" alt="Lua Version">
  <img src="https://img.shields.io/badge/License-MIT-yellow" alt="License">
</p>

## ✨ Features

<div align="center">

| Category        | Features                                             | Icons |
| --------------- | ---------------------------------------------------- | ----- |
| **Performance** | Lazy-loaded plugins, Optimized startup time          | ⚡🚀  |
| **UI/UX**       | TokyoNight theme, Custom Lualine, Beautiful icons    | 🎨🖌️  |
| **Editing**     | Autocompletion, LSP, Formatting, Syntax highlighting | ✍️🔍  |
| **Navigation**  | Telescope fuzzy finder, NvimTree file explorer       | 🔎📂  |
| **Git**         | Git signs, LazyGit integration                       | 🔀📊  |

</div>

## 🛠️ Installation

### Prerequisites

<div align="center">

| Requirement   | Recommended        | Logo                                                                                   |
| ------------- | ------------------ | -------------------------------------------------------------------------------------- |
| **Neovim**    | v0.9.0+            | <img src="https://neovim.io/logos/neovim-mark-flat.png" width="20">                    |
| **Git**       | Latest             | <img src="https://git-scm.com/images/logos/downloads/Git-Icon-1788C.png" width="20">   |
| **Nerd Font** | FiraCode Nerd Font | <img src="https://www.nerdfonts.com/assets/img/sankey-glyphs.1ecab02e.png" width="20"> |

</div>

```bash
# Backup existing config (if any)
mv ~/.config/nvim ~/.config/nvim.bak

# Clone this repository
git clone https://github.com/Anurag-xo/Neovim-config.git ~/.config/nvim

# Start Neovim (plugins will auto-install)
nvim
```

## 🏗️ Configuration Structure

```tree
📂 ~/.config/nvim
├── 📄 init.lua
├── 📂 lua
│   └── 📂 anurag
│       ├── 📄 lazy.lua          # Plugin manager
│       ├── 📂 core              # Core settings
│       │   ├── 📄 options.lua   # Editor options
│       │   └── 📄 keymaps.lua   # Key mappings
│       └── 📂 plugins           # All plugin configs
│           ├── 📂 lsp           # LSP configurations
│           └── 📄 *.lua         # Individual plugin configs
└── 📄 README.md
```

## ⌨️ Key Bindings Cheatsheet

### 🖥️ Window Management

| Key Binding  | Description               | Icon |
| ------------ | ------------------------- | ---- |
| `<leader>sv` | Split window vertically   | ⬇️   |
| `<leader>sh` | Split window horizontally | ➡️   |
| `<leader>se` | Equalize window sizes     | ⚖️   |
| `<leader>sm` | Maximize/minimize window  | 🔲   |

### 🔍 Navigation

| Key Binding  | Description                     | Icon |
| ------------ | ------------------------------- | ---- |
| `<leader>ff` | Find files (Telescope)          | 📁   |
| `<leader>fg` | Live grep (Telescope)           | 🔎   |
| `<leader>ee` | Toggle file explorer (NvimTree) | 🌳   |

### 💻 LSP & Coding

| Key Binding  | Description        | Icon |
| ------------ | ------------------ | ---- |
| `gd`         | Go to definition   | 🎯   |
| `K`          | Show documentation | 📖   |
| `<leader>ca` | Code actions       | 🛠️   |

## 🧩 Plugin Ecosystem

<div align="center">

| Category    | Plugins                                          | Logos                                                            |
| ----------- | ------------------------------------------------ | ---------------------------------------------------------------- |
| **Core**    | lazy.nvim, plenary.nvim, which-key.nvim          | <img src="https://lazyvim.github.io/static/logo.png" width="20"> |
| **UI**      | tokyonight.nvim, lualine.nvim, nvim-web-devicons | 🌙📊🎨                                                           |
| **Editing** | nvim-cmp, nvim-autopairs, nvim-treesitter        | ✏️🔤🌲                                                           |
| **LSP**     | mason.nvim, nvim-lspconfig, null-ls              | ⚙️🛠️🔧                                                           |

</div>

## 🌟 Recommended Setup

1. Install language servers:
   ```bash
   :Mason
   ```
2. Install formatters:
   ```bash
   npm install -g prettier eslint
   pip install black pylint
   ```
3. Recommended terminal: [WezTerm](https://wezfurlong.org/wezterm/) or [Kitty](https://sw.kovidgoyal.net/kitty/)

## 🤝 Contributing

<p align="center">
  <img src="https://media.giphy.com/media/du3J3cXyzhj75IOgvA/giphy.gif" width="200">
</p>

Contributions are welcome! Please:

1. Fork the repository
2. Create a feature branch
3. Submit a pull request

## 📜 License

MIT License © 2023 Anurag

<p align="center">
  <img src="https://media.giphy.com/media/jpVnC65DmYeyRL4LHS/giphy.gif" width="100">
</p>
```
