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
git clone https://github.com/anoninus/arch-nvim ~/.config/nvim

# Launch Neovim — lazy.nvim bootstraps automatically
nvim
```

> [IMPORTANT!]
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

### Navigation & Buffers
| Key | Action |
|---|---|
| `<Tab>` | Next buffer |
| `<S-Tab>` | Previous buffer |
| `<A-,>` | Swap buffer left |
| `<A-.>` | Swap buffer right |
| `-` | Open Oil (parent directory) |
| `m` / `M` | Leap forward / backward |
| `gm` | Leap from window |
| `<Up>` / `<Down>` | Visual-line aware movement |

### Find Files (`<leader>f`)
| Key | Action |
|---|---|
| `<leader>fz` | Open FzfLua picker |
| `<leader>fd` | Find files in CWD |
| `<leader>fo` | Recent files |
| `<leader>fc` | Find in Neovim config |
| `<leader>fs` | Find in stages dir |
| `<leader>fih` | Find files in HOME |
| `<leader>fir` | Find files in ROOT |

### Flexible FZF (`<leader>e`)
| Key | Action |
|---|---|
| `<leader>ef` | FZF files in typed directory |
| `<leader>eg` | FZF grep in typed directory |

### Grep (`<leader>g`)
| Key | Action |
|---|---|
| `<leader>gd` | Live grep CWD |
| `<leader>gc` | Grep Neovim config |
| `<leader>gs` | Grep stages directory |
| `<leader>gih` | Grep in HOME |
| `<leader>gir` | Grep in ROOT |

### Git (`<leader>G`)
| Key | Action |
|---|---|
| `<leader>Gc` | Git commits (fzf) |
| `<leader>Gs` | Git status (fzf) |
| `<leader>lg` / `<leader>Gl` | Open LazyGit |

### Yazi (`<leader>o`)
| Key | Action |
|---|---|
| `<leader>od` | Yazi in CWD |
| `<leader>oc` | Yazi in Neovim config |
| `<leader>ou` | Yazi in `lua/user/` |
| `<leader>oj` | Yazi in typed directory |

### LSP
| Key | Action |
|---|---|
| `K` | Hover documentation |
| `<C-h>` (insert) | Signature help |
| `H` | Toggle diagnostic float |
| `<leader>ui` | Toggle inlay hints |
| `<leader>dw` | Workspace diagnostics (fzf) |
| `<leader>dt` | Trouble diagnostics panel |

### LSP Server (`<leader>ls`)
| Key | Action |
|---|---|
| `<leader>lsi` | LspInfo |
| `<leader>lsl` | LspLog |
| `<leader>lsr` | LspRestart |

### Rust / Cargo (`<leader>c`)
| Key | Action |
|---|---|
| `<leader>cc` | Cargo check |
| `<leader>cC` | Cargo clean |
| `<leader>cz` | Cargo run |
| `<leader>cb` | Cargo build |
| `<leader>cu` | Cargo update |
| `<leader>cr` | CargoReload |

### Code Runner (`<leader>z`)
| Key | Action |
|---|---|
| `<leader>zz` | Run current file |
| `<leader>zx` | Toggle runner buffer |

Supports: Rust, Go, Python, Lua, JS, TS, Ruby, PHP, Bash, Zig, C, C++, Java

### Terminal (`<leader>t`)
| Key | Action |
|---|---|
| `<leader>tt` | Toggle terminal buffer |
| `<S-Tab>` (terminal) | Exit terminal mode |
| `<M-q>` (terminal) | Close terminal |
| `<C-h/j/k/l>` (terminal) | Navigate splits |

### Sessions (`<leader>s`)
| Key | Action |
|---|---|
| `<leader>sc` | Create session |
| `<leader>ss` | Save current session |
| `<leader>sf` | Load session (fzf) |
| `<leader>sd` | Delete session (fzf) |
| `<leader>si` | Session info |

### Formatting & Autosave
| Key | Action |
|---|---|
| `Fu` / `<C-x>f` | Format file (Conform) |
| `<leader>uf` | Toggle Conform formatter |
| `<leader>ffp` (visual) | Format selection |
| `U` | Toggle autosave |

### Yank & Clipboard (`<leader>y`)
| Key | Action |
|---|---|
| `<leader>ya` | Yank entire buffer |
| `<leader>yp` | Yank file path |
| `<leader>yf` | Yank file name |
| `<leader>ym` | Copy motion to system clipboard (OSC52) |
| `<leader>yt` (visual) | Copy selection to system clipboard |
| `<leader>yc` | Push yank register to system clipboard |
| `<leader>pc` | Paste from Termux clipboard |

### Buffers (`<leader>b`)
| Key | Action |
|---|---|
| `<leader>bs` | Save buffer |
| `<leader>bc` | Clear buffer content |
| `<leader>bd` | Close buffer |

### Toggles (`<leader>u`)
| Key | Action |
|---|---|
| `<leader>un` | Toggle line numbers |
| `<leader>ur` | Toggle relative numbers |
| `<leader>uw` | Toggle word wrap |
| `<leader>uc` | Toggle cursor line |
| `<leader>uh` | Toggle search highlight |
| `<leader>up` | Toggle autopairs |
| `<leader>uP` | Debug autopairs rules |

### Save & Quit (`<leader>w` / `<leader>q`)
| Key | Action |
|---|---|
| `<leader>ws` | Save all |
| `<leader>wq` | Save & quit |
| `<leader>wfs` | Force save |
| `<leader>wfS` | Force save all |
| `<leader>wfa` | Force save & quit all |
| `<leader>qq` | Quit |
| `<leader>qfq` | Force quit |
| `<leader>qfa` | Quit all |
| `<leader>qfw` | Force quit all |

### Lazy / Plugin Load (`<leader>l`)
| Key | Action |
|---|---|
| `<leader>llp` | Lazy profile |
| `<leader>llu` | Lazy update |
| `<leader>lls` | Lazy sync |
| `<leader>lob` | Lazy load blink.cmp |
| `<leader>lod` | Lazy load dressing.nvim |
| `<leader>loi` | Lazy load indent-blankline |
| `<leader>loa` | Lazy load all three |
| `<leader>lot` | Lazy load nvim-treesitter |

### Misc
| Key | Action |
|---|---|
| `<leader>T` | Activate Treesitter on current buffer |
| `<leader>ut` | Toggle Undotree |
| `<leader>hn` | Notification history |
| `<C-k>` (insert) | Snippet expand / jump forward |
| `<C-j>` (insert) | Snippet jump backward |
| `gcc` / `gbc` | Toggle line / block comment |
| `ys` / `ds` / `cs` | Surround add / delete / change |
| `<C-n>` | Multi-cursor |

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
