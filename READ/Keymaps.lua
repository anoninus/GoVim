# ⌨️ Neovim Keymap Reference

> Complete keymap reference for my Neovim configuration on Termux.
> Leader key is `<Space>` (assumed). Generated from live config audit.

---

## Table of Contents

- [Buffers](#-buffers)
- [Cargo / Rust](#-cargo--rust)
- [Code Runner](#-code-runner)
- [Diagnostics](#-diagnostics)
- [File Navigation](#-file-navigation)
- [Formatting](#-formatting)
- [Git](#-git)
- [History & Notifications](#-history--notifications)
- [Lazy Plugin Manager](#-lazy-plugin-manager)
- [LSP](#-lsp)
- [Lazy Plugin Loader](#-lazy-plugin-loader)
- [Oil File Manager](#-oil-file-manager)
- [Paste](#-paste)
- [Quit](#-quit)
- [Reload](#-reload)
- [Save](#-save)
- [Sessions](#-sessions)
- [Snippets (LuaSnip)](#-snippets-luasnip)
- [Terminal](#-terminal)
- [Toggles](#-toggles)
- [Undo Tree](#-undo-tree)
- [Yank / Clipboard](#-yank--clipboard)
- [Arrow Keys](#-arrow-keys)
- [Buffer Tabs (Cokeline)](#-buffer-tabs-cokeline)
- [Visual Mode](#-visual-mode)
- [Autosave](#-autosave)
- [⚠️ Duplicates Found](#%EF%B8%8F-duplicates-found)

---

## 󰓩 Buffers

| Mode | Key | Action |
|------|-----|--------|
| `n` | `<leader>bs` | Buffer Save *(for Oil etc. buffers)* |
| `n` | `<leader>bc` | Buffer Remove Data — **⚠️ RISKY** |
| `n` | `<leader>bd` | Buffer Close — safe |

---

## 󱘗 Cargo / Rust

> Defined in `lua/user/config/server/LowLevel/rust_analyzer.lua`

| Mode | Key | Action |
|------|-----|--------|
| `n` | `<leader>cc` | Cargo check |
| `n` | `<leader>cC` | Cargo clean |
| `n` | `<leader>cz` | Cargo run |
| `n` | `<leader>cb` | Cargo build |
| `n` | `<leader>cu` | Cargo update |
| `n` | `<leader>cr` | Cargo reload |

---

## 󱐋 Code Runner

> Defined in `lua/user/config/ide/ide/module_require/run.lua`

| Mode | Key | Action |
|------|-----|--------|
| `n` | `<leader>zz` | Run code |
| `n` | `<leader>zx` | Toggle code runner |

---

## 󰃤 Diagnostics

> Defined in `lua/user/config/tools/diagnostic.lua`

| Mode | Key | Action |
|------|-----|--------|
| `n` | `H` | Show diagnostics (hover) |

---

## 󰍉 File Navigation (FZF)

> Defined in `lua/user/config/ide/file/fzf.lua`

| Mode | Key | Action |
|------|-----|--------|
| `n` | `<leader>ef` | FZF find files in custom dir |
| `n` | `<leader>eg` | FZF grep in custom dir |

---

## 󰉻 Formatting

> Defined in `lua/user/config/tools/formatter.lua`

| Mode | Key | Action |
|------|-----|--------|
| `n` | `<leader>uf` | Toggle conform (auto-format) |
| `n` | `Fu` | Format file |
| `n` | `<C-x>f` | Format file |
| `v` | `<leader>ffp` | Format selection |

---

## 󰊢 Git

| Mode | Key | Action |
|------|-----|--------|
| `n` | `<leader>lg` | Open LazyGit |
| `n` | `<leader>Gl` | Open LazyGit *(alias)* |

---

## 󰋚 History & Notifications

| Mode | Key | Action |
|------|-----|--------|
| `n` | `<leader>hn` | Show notification history |

---

## 󰒲 Lazy Plugin Manager

| Mode | Key | Action |
|------|-----|--------|
| `n` | `<leader>llp` | Lazy profile |
| `n` | `<leader>llu` | Lazy update |
| `n` | `<leader>lls` | Lazy sync |

---

## 󰒍 LSP

> Defined in `lua/user/config/tools/lsp.lua`

| Mode | Key | Action |
|------|-----|--------|
| `n` | `K` | LSP hover |
| `i` | `<C-h>` | LSP signature help |
| `n` | `<leader>ui` | Toggle inlay hints |
| `n` | `<leader>lsi` | LspInfo |
| `n` | `<leader>lsl` | LspLog |
| `n` | `<leader>lsr` | LspRestart |

---

## 󰏗 Lazy Plugin Loader

> Defined in `lua/user/sys/lazy_map.lua`

| Mode | Key | Action |
|------|-----|--------|
| `n` | `<leader>lob` | Lazy load `blink.cmp` |
| `n` | `<leader>lod` | Lazy load `dressing.nvim` |
| `n` | `<leader>loi` | Lazy load `indent-blankline.nvim` |
| `n` | `<leader>loa` | Lazy load all three plugins |
| `n` | `<leader>lot` | Lazy load `nvim-treesitter` |

---

## 󰉖 Oil File Manager

> Defined in `lua/user/config/ide/file/oil.lua`

| Mode | Key | Action |
|------|-----|--------|
| `n` | `-` | Open Oil file manager |

---

## 󰅇 Paste

> Defined in `lua/user/sys/paste_from_sys.lua`

| Mode | Key | Action |
|------|-----|--------|
| `n` | `<leader>pc` | Paste from system clipboard |

---

## 󰗼 Quit

| Mode | Key | Action |
|------|-----|--------|
| `n` | `<leader>qq` | Quit |
| `n` | `<leader>qfq` | Force quit |
| `n` | `<leader>qfa` | Quit all |
| `n` | `<leader>qfw` | Force quit all |

---

## 󰑓 Reload

| Mode | Key | Action |
|------|-----|--------|
| `n` | `<leader>rr` | Restart — save & restore session |
| `n` | `<leader>rs` | Restart safely *(fails if unsaved)* |
| `n` | `<leader>rf` | Restart & discard unsaved changes |

---

## 󰆓 Save

| Mode | Key | Action |
|------|-----|--------|
| `n` | `<leader>ws` | Save all |
| `n` | `<leader>wq` | Save & quit |
| `n` | `<leader>wfs` | Force save |
| `n` | `<leader>wfS` | Force save all |
| `n` | `<leader>wfa` | Force save & quit all |

---

## 󰆓 Sessions

> Defined in `lua/user/config/ide/ide/sessions.lua`

| Mode | Key | Action |
|------|-----|--------|
| `n` | `<leader>sc` | Create session |
| `n` | `<leader>ss` | Save session |
| `n` | `<leader>sf` | Find/load session |
| `n` | `<leader>sd` | Delete session |
| `n` | `<leader>si` | Session info |

---

## 󰌌 Snippets (LuaSnip)

> Defined in `lua/user/config/tools/luasnip.lua` — Insert mode only

| Mode | Key | Action |
|------|-----|--------|
| `i` | `<C-k>` | Expand / jump forward in snippet |
| `i` | `<C-j>` | Jump backward in snippet |

---

## 󰆍 Terminal

> Defined in `lua/user/config/ide/ide/toggleterm.lua`

| Mode | Key | Action |
|------|-----|--------|
| `n` | `<leader>tt` | Toggle terminal |
| `t` | `<S-Tab>` | Exit terminal mode |
| `t` | `<M-q>` | Close terminal window |
| `t` | `<C-h>` | Move to left window |
| `t` | `<C-j>` | Move to bottom window |
| `t` | `<C-k>` | Move to top window |
| `t` | `<C-l>` | Move to right window |

---

## 󰔡 Toggles

| Mode | Key | Action |
|------|-----|--------|
| `n` | `<leader>un` | Toggle line numbers |
| `n` | `<leader>ur` | Toggle relative numbers |
| `n` | `<leader>uw` | Toggle word wrap |
| `n` | `<leader>uc` | Toggle cursor line |
| `n` | `<leader>uh` | Toggle highlight search |
| `n` | `<leader>up` | Toggle autopairs (enable) |
| `n` | `<leader>uP` | Toggle autopairs (disable) |

---

## 󰅌 Undo Tree

> Defined in `lua/user/config/ide/ide/undotree.lua`

| Mode | Key | Action |
|------|-----|--------|
| `n` | `<leader>ut` | Toggle Undotree |

---

## 󰅎 Yank / Clipboard

> OSC52-based yanking via `lua/user/specs/core.lua` and which-key

| Mode | Key | Action |
|------|-----|--------|
| `n` | `<leader>ya` | Yank entire file |
| `n` | `<leader>yp` | Yank file path |
| `n` | `<leader>yf` | Yank file name |
| `n` | `<leader>ym` | OSC52 yank (operator) |
| `n` | `<leader>yc` | OSC52 yank (custom) |
| `v` | `<leader>yt` | OSC52 yank (visual) |

---

## ↕ Arrow Keys

> Defined in `lua/user/sys/options.lua` — wraps over soft-wrapped lines

| Mode | Key | Action |
|------|-----|--------|
| `n` | `<Up>` | Move up by display line (`g<Up>`) |
| `n` | `<Down>` | Move down by display line (`g<Down>`) |

---

## 󰓩 Buffer Tabs (Cokeline)

> Defined in `lua/user/ui/core/cokeline.lua`

| Mode | Key | Action |
|------|-----|--------|
| `n` | `<Tab>` | Focus next buffer |
| `n` | `<S-Tab>` | Focus previous buffer |
| `n` | `<A-,>` | Move buffer left |
| `n` | `<A-.>` | Move buffer right |

---

## 󰆏 Visual Mode

| Mode | Key | Action |
|------|-----|--------|
| `v/x` | `<leader>y` | Yank to system clipboard (`"+y`) |

---

## 󰁯 Autosave

> Defined in `lua/user/config/ide/ide/local_module/autosave_module.lua`

| Mode | Key | Action |
|------|-----|--------|
| `n` | `U` | Toggle autosave |

---

## 󰊢 Neovim init.lua

> Defined in `init.lua`

| Mode | Key | Action |
|------|-----|--------|
| `n` | `<leader>T` | Custom function (see init.lua:65) |

---

## ⚠️ Duplicates Found

These keymaps appear more than once across the configuration and may conflict.

| Key | Mode | Definition 1 | Definition 2 |
|-----|------|-------------|-------------|
| `<S-Tab>` | `n` | `cokeline.lua` → Focus previous buffer | `toggleterm.lua` → Exit terminal mode (`t` mode — **not a real conflict**, different modes) |
| `<leader>lg` | `n` | `which-key.lua` → LazyGit | *(check if also defined elsewhere)* |
| `<leader>Gl` | `n` | `which-key.lua` → LazyGit | *(alias of `<leader>lg` — same action, different key)* |
| `<C-h>` | `i` | `lsp.lua` → Signature help | `toggleterm.lua` → Window move left (`t` mode — **not a real conflict**, different modes) |

> **Note:** `<S-Tab>` and `<C-h>` conflicts are **mode-separated** (`n`/`i` vs `t`) and will not actually clash at runtime.
> The `<leader>lg` / `<leader>Gl` pair are intentional aliases pointing to the same command.
> Run `:CheckKeymaps` inside Neovim to detect any live leader key conflicts.

---

## 󰋖 Tips

- Run `:CheckKeymaps` (custom user command) to scan for live leader key conflicts at runtime.
- Which-key groups are defined in `which-key.lua` and provide the pop-up hint menu with a 200ms delay.
- Terminal-mode mappings (`t`) are only active inside ToggleTerm windows.
- Insert-mode mappings (`i`) are only active while typing.

