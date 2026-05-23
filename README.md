# 🌙 nvim-termux

> The just work distro that works out of the box for Neovim 0.12.1

![Neovim](https://img.shields.io/badge/Neovim-0.10%2B-57A143?style=flat-square&logo=neovim)
![Platform](https://img.shields.io/badge/Platform-Termux-black?style=flat-square)
![Theme](https://img.shields.io/badge/Theme-tokyonight--moon-7aa2f7?style=flat-square)
![Plugin Manager](https://img.shields.io/badge/Plugins-lazy.nvim-ff6b6b?style=flat-square)
![License](https://img.shields.io/badge/License-MIT-green?style=flat-square)

---

## ✨ Features

- **Staged boot system** — 7 numbered stages load in strict dependency order; nothing runs before it's needed
- **Aggressive lazy loading** — LSP defers until `BufReadPre`, autopairs until `InsertEnter`, snippets until `InsertEnter`
- **Custom autosave** — built-in debounced autosave module with Conform/LSP format integration and per-filetype allow/deny lists
- **Inline code runner** — run Rust, Python, Go, C/C++, JS, TS, Lua, Bash and more directly from the buffer
- **Full LSP coverage** — 11 language servers across Game Dev, Systems, Web, Scripting and Utilities
- **FZF-powered everything** — find files, live grep, diagnostics, git, sessions — all routed through fzf-lua
- **Termux-aware** — PATH, clipboard (`termux-clipboard-get`), and home/root paths all auto-detect Termux
- **Built-in profiler** — `require()`-hooking profiler + spec timing logger for startup optimization
- **Custom statusline** — hand-crafted, no plugin dependency, with LSP caching and tokyonight palette
- **Which-key conflict checker** — `:CheckKeymaps` user command detects leader binding collisions

---

## 📋 Requirements

| Requirement | Version |
|---|---|
| Neovim | `0.12+` (uses `vim.lsp.config`, `vim.lsp.enable`) |
| Termux | Any recent version |
| Nerd Font | Required for icons in statusline, cokeline, fzf |
| `git` | For lazy.nvim bootstrap |
| `fzf` | For fzf-lua |
| `fd` | For file finding |
| `ripgrep` | For live grep |

Optional LSP servers (install via `pkg` or `npm`/`cargo`/`pip`):

```
lua-language-server  pyright  clangd  rust-analyzer
bash-language-server  marksman  vscode-json-language-server
vscode-css-language-server  vscode-html-language-server  gopls  typescript-language-server
```

---

## 🚀 Installation

```bash
# Back up existing config
mv ~/.config/nvim ~/.config/nvim.bak

# Clone
git clone  --depth=1 https://github.com/anoninus/arch-nvim ~/.config/nvim

# Launch Neovim — lazy.nvim bootstraps automatically
nvim
```

> [!IMPORTANT]
> Make sure to do `:Lazy restore` + `:Lazy install`
> On first launch, lazy.nvim will not automatically install plugins.
> LSP servers must be installed separately.

---

## 🗂️ Directory Structure

```
~/.config/nvim/
├── init.lua                        # Entry point: options → staged loader → colorscheme
└── lua/user/
    ├── stages/                     # Boot pipeline (loaded in numeric order)
    │   ├── 01_sys.lua              # env, plugin manager, clipboard, notify
    │   ├── 02_uiCore.lua           # cokeline, statusline, indent lines
    │   ├── 03_mini.lua             # mini.icons
    │   ├── 04_server.lua           # LSP servers (deferred to BufReadPre)
    │   ├── 05_tools.lua            # diagnostics, formatter, autopairs
    │   ├── 06_ide.lua              # autosave, runner, which-key, fzf, oil, sessions, terminal
    │   └── 07_other.lua            # reserved
    ├── specs/                      # lazy.nvim plugin declarations
    │   ├── colorschemes.lua
    │   ├── completion.lua
    │   ├── core.lua
    │   ├── editor.lua
    │   ├── explorer.lua
    │   ├── formatting.lua
    │   ├── lsp.lua
    │   ├── mini.lua
    │   ├── session.lua
    │   ├── snippets.lua
    │   ├── treesitter.lua
    │   ├── ui.lua
    │   └── utility.lua
    ├── config/
    │   ├── ide/
    │   │   ├── file/               # fzf.lua, oil.lua
    │   │   └── ide/                # autosave, runner, sessions, terminal, which-key, undotree
    │   ├── server/                 # LSP configs (by category)
    │   │   ├── GameDev/            # gdscript
    │   │   ├── HighLevel/          # lua_ls, pyright
    │   │   ├── LowLevel/           # clangd, rust_analyzer
    │   │   ├── Productive/         # bash_ls, marksman
    │   │   ├── Utilities/          # jsonls
    │   │   └── Web/                # cssls, gopls, html, ts_ls
    │   └── tools/                  # lsp.lua, diagnostic, formatter, autopairs, luasnip, navic
    ├── sys/                        # Core system modules
    │   ├── options.lua             # Leader, vim.o settings
    │   ├── plugins.lua             # lazy.nvim setup
    │   ├── env.lua                 # Termux PATH setup
    │   ├── lazy_map.lua            # Manual lazy-load keymaps
    │   ├── last_pos.lua            # Restore cursor on BufReadPost
    │   ├── paste_from_sys.lua      # Termux clipboard paste
    │   └── profiler.lua            # Startup profiler
    ├── mini/                       # mini.nvim module configs
    │   ├── mini_icons.lua
    │   └── mini_notify.lua
    └── ui/core/                    # UI components
        ├── cokeline.lua            # Buffer tabline
        ├── statusline.lua          # Custom statusline
        └── ibl.lua                 # Indent lines (ibl + mini.indentscope)
```

---

## 🔌 Plugins

### Core & Libraries
| Plugin | Role |
|---|---|
| `nvim-lua/plenary.nvim` | Async utilities |
| `MunifTanjim/nui.nvim` | UI component library |
| `nvim-neotest/nvim-io` | Async I/O |
| `ojroques/nvim-osc52` | System clipboard via OSC52 (Termux-compatible) |

### Completion
| Plugin | Role |
|---|---|
| `saghen/blink.cmp` | Completion engine with Rust fuzzy matcher |
| `rafamadriz/friendly-snippets` | Community snippet collection |

### LSP
| Plugin | Role |
|---|---|
| `onsails/lspkind-nvim` | LSP completion icons |
| `folke/trouble.nvim` | Diagnostics list panel |
| `saecki/crates.nvim` | Cargo.toml crate info |

### Formatting
| Plugin | Role |
|---|---|
| `stevearc/conform.nvim` | Multi-formatter, 4-space indent configured |

### UI
| Plugin | Role |
|---|---|
| `willothy/nvim-cokeline` | Buffer tabline |
| `stevearc/dressing.nvim` | Beautiful `vim.ui.input` / `vim.ui.select` |
| `beauwilliams/focus.nvim` | Smart split resizing |
| `lukas-reineke/indent-blankline.nvim` | Static indent guides |
| `folke/tokyonight.nvim` | Colorscheme (`tokyonight-moon`) |

### Treesitter
| Plugin | Role |
|---|---|
| `nvim-treesitter/nvim-treesitter` | Syntax tree, lazy-loaded on demand |

### Explorer & Navigation
| Plugin | Role |
|---|---|
| `stevearc/oil.nvim` | File manager as a buffer (`-` to open) |
| `ibhagwan/fzf-lua` | Fuzzy finder for files, grep, git, diagnostics |
| `leap.nvim` (codeberg fork) | Fast 2-char motion (`m` / `M`) |
| `mikavilpas/yazi.nvim` | Yazi terminal file manager integration |
| `kdheepak/lazygit.nvim` | LazyGit UI inside Neovim |

### Editor
| Plugin | Role |
|---|---|
| `kylechui/nvim-surround` | Add/change/delete surrounds |
| `windwp/nvim-autopairs` | Auto-close brackets, custom Rust rules |
| `numToStr/Comment.nvim` | `gcc` / `gbc` line & block comments |

### Utility
| Plugin | Role |
|---|---|
| `folke/which-key.nvim` | Keymap popup guide (200ms delay) |
| `mg979/vim-visual-multi` | Multi-cursor (`<C-n>`) |
| `mbbill/undotree` | Visual undo history |

### Mini Suite
| Plugin | Role |
|---|---|
| `mini.notify` | Notification toasts (NE corner) |
| `mini.indentscope` | Animated scope highlight |
| `mini.move` | Move lines/selections with `Alt+Arrow` |
| `mini.icons` | Icon provider |

### Session
| Plugin | Role |
|---|---|
| `stevearc/resession.nvim` | Named session save/load |

---

## 🌍 Language Server Coverage

| Category | Language | Server |
|---|---|---|
| Game Dev | GDScript | `gdscript` |
| High Level | Lua | `lua_ls` |
| High Level | Python | `pyright` |
| Low Level | C / C++ | `clangd` |
| Low Level | Rust | `rust_analyzer` |
| Scripting | Bash / Sh | `bashls` |
| Scripting | Markdown | `marksman` |
| Utilities | JSON | `jsonls` |
| Web | CSS / SCSS | `cssls` |
| Web | Go | `gopls` |
| Web | HTML | `html` |
| Web | TypeScript / JavaScript | `ts_ls` |

All servers load on first `BufReadPre` — zero startup overhead.

---

## ⌨️ Keybindings

**Leader:** `<Space>`  
**Local Leader:** `'`

Read about keymaps at : [Key-bindings](./READ/Keymaps.lua)

---

## ⚙️ Notable Design Decisions

**Staged boot** — `init.lua` auto-discovers and numerically sorts files in `lua/user/stages/`, loading them in order. Adding a new stage is as simple as dropping a file named `08_something.lua`.

**Autosave** — a fully custom module (not a plugin) with debounce, filetype allowlists, Conform/LSP format integration, and a `U` toggle. Format-on-autosave is off by default to avoid diagnostic lag.

**LSP via `vim.lsp.config` / `vim.lsp.enable`** — uses Neovim 0.10's native LSP configuration API instead of lspconfig where possible. `capabilities` are injected once on first `LspAttach` via blink.cmp.

**No Telescope** — replaced entirely by fzf-lua. Dressing uses `fzf_lua` as its select backend.

**Termux clipboard** — `termux-clipboard-get` is called async on `<leader>pc`. OSC52 via `nvim-osc52` handles copy in the other direction.

**Treesitter is optional** — loaded on demand with `<leader>T` or `<leader>lot`. Not auto-attached on `BufRead` to keep startup fast on mobile hardware.

---

## 🛠️ User Commands

| Command | Description |
|---|---|
| `:CheckKeymaps` | Detect leader key binding conflicts |
| `:DiagYankWhole` | Yank all diagnostics for current buffer |
| `:DiagYankWorkspace` | Yank all workspace diagnostics |
| `:SnippetDebug` | Debug snippet loading for current filetype |
| `:SnippetLoad` | Manually load snippets |
| `:AutosaveToggle` | Toggle autosave |
| `:AutosaveToggleFormat` | Toggle format-on-autosave |
| `:AutosaveToggleNotify` | Toggle autosave notifications |
| `:ProfilerReport` | Generate startup profile report |

---

## 🎨 Colorscheme

**tokyonight-moon** with custom overrides:

- `FloatTitle` — solid cyan block (`#7dcfff`) with dark bold text
- `WinSeparator` — bright cyan (`#38bdf8`) for split borders
- No italics anywhere (comments, keywords, functions, variables)
- Statusline uses a hand-tuned tokyonight palette defined inline

---

## 📊 Performance

The config ships with two profiling tools:

**Spec timer** — swap `plugins.lua` for `_time_plugins.lua` in `01_sys.lua` to log per-spec load times to `~/.cache/nvim/spec_times.log`.

**Require profiler** — uncomment `require("user.sys.profiler")` at the top of `init.lua` to get a full report of every `require()` call above 0.5ms, written to `~/.config/nvim/profiler_report.txt` after `UIEnter`.

---

## 📄 License

MIT — see [LICENSE](LICENSE)
