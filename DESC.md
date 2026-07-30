# Dotfiles Configuration

Managed with GNU Stow. All configs live under `~/dotfiles/` and are symlinked into place.

---

## zsh

**File:** `.zshrc`

### PATH

Adds the following to `$PATH` (in order of priority):

- Python 3.14 (`/opt/homebrew/opt/python@3.14/libexec/bin`)[^1]
- `/usr/local/bin`
- `~/.local/bin`
- Cargo (`~/.cargo/bin`)
- Mason LSP binaries (`~/.local/share/nvim/mason/bin`)
- Neovim virtualenv (`~/.virtualenvs/neovim/bin`) # for mason.nvim

### Environment

- Default editor and visual editor set to `nvim`.
- Colorized `ls` output via `CLICOLOR=1`.
- 24-bit truecolor support (`COLORTERM=truecolor`). When outside tmux, `TERM` is set to `xterm-256color` to avoid breaking of the colors.

### Prompt

oh-my-posh with the `amro-enhanced` theme (a custom one). The prompt displays:

- Username
- Full working directory path
- Git branch, status (added/modified/deleted/untracked counts), upstream tracking, and stash count
- Active Python's virtualenv name (when applicable)

### Shell Integrations

- **zoxide:** `cd` replacement with frecency-based directory jumping (`z` command).
- **zsh-autosuggestions:** Fish-like inline suggestions, accepted with `Ctrl+o`.
- **edit-command-line:** Edit the current command line in Neovim with `Ctrl+X Ctrl+E`.

### Custom Functions

- `fzfrg [dir | file]` -- Fuzzy search through file contents using `ripgrep` and `fzf`, with `bat`-highlighted preview. When called without arguments, searches the current directory recursively. When called with an  argument, scopes the search to that directory/file.

- `theme [dark | light]` -- Switch Kitty, Tmux and NvChad's theme from dark (tokyonighit) to light (rosepine-dawn). NvChad updates the theme directly in `chadrc.lua`. Tmux swaps `current-theme.conf` and reloads the config. `tmux.conf` source a theme file instead of inline colors for the status bar. Kitty swaps `current-theme.conf` and live-reloads colors via `kitten @ set-colors` (`allow_remote_control yes` is needed in `kitty.conf` to achieve this). In the command you will see a `nvim --headless` line: that is needed because NvChad compiles themes into a case at `~/.local/share/nvim/base46` and every new instance load from that cache, not from `chadrc.lua` directly. The headless nvim call allows to recompile the cache after updating the theme.

### Aliases

| Alias       | Expands to                                          |
|-------------|-----------------------------------------------------|
| `python313` | `/opt/homebrew/opt/python@3.13/libexec/bin/python3` |
| `grep`      | `grep --color=always`                               |
| `ll`        | `ls -la`                                            |

---

## Tmux

**File:** `.config/tmux/tmux.conf`

### General

- Mouse support enabled.
- Windows and panes are numbered starting from 1 (not zero, as it is by default).
- Windows are automatically renumbered on close.
- New splits open in the current working directory.

### Prefix Key

`Ctrl+Space` (default `Ctrl+b` is unbound since it is a crime against humanity).

### Custom Keybindings

| Key             | Action                                             |
|-----------------|----------------------------------------------------|
| `prefix + "`    | Split pane vertically (in current directory)        |
| `prefix + %`    | Split pane horizontally (in current directory)      |
| `prefix + T`    | Open a popup scratch terminal in the current directory |

All the other major keybindings (navigation through panes, windows etc.) are set to default.

### Terminal and Colors

- `default-terminal` set to `xterm-256color` with RGB terminal features for truecolor.
- Image passthrough enabled (`allow-passthrough on`) for kitty graphics protocol, required by `image.nvim`.

### Status Bar

Tokyo Night color scheme: blue (`#7aa2f7`) background with dark (`#1a1b26`) foreground. Active pane border is blue, inactive border is muted gray.

### Plugins

Managed with TPM (Tmux Plugin Manager):

- **tmux-sensible** -- Reasonable default settings.

---

## Kitty

**File:** `.config/kitty/kitty.conf`

### Settings

- Font size: 18pt (system default font).
- Color theme: Adwaita Darker (`current-theme.conf`), with a Nord palette also available in `colors.conf`.
- All other settings are defaults.

---

## Oh My Posh

**Files:** `.config/ohmyposh/amro-enhanced.omp.json`, `gruvbox-enhanced.omp.json`

Two prompt themes are included: amro-enhanced and gruvbox-enhanced. Both are custom themes based on the oh-my-posh built-in (amro and gruvbox).

---

## ipython
**Files:** `.ipython/profile_default/startup/00-rich-df.py`

As of now, only a small startup script is there that runs automatically every time that ipython is launched. It monkey-patches `pd.DataFrame.__repr__` so that any DataFrame that gets evaluated in the REPL renders as a colored and striped table using `rich` and `tabulate`. These package should be installed in the virtual environment via pip. If any package is missing, the script silently falls back to default behavior.

## Neovim (NvChad v2.5)

**Directory:** `.config/nvim/`

Built on NvChad v2.5 with lazy.nvim as the plugin manager. Leader key is `Space`, local leader is `,` (useful in ipynb files only).

### General Options

- Relative line numbers enabled.
- Python 3 provider enabled (host program: `~/.virtualenvs/neovim/bin/python3`) (again, for mason.nvim).
- StyLua formatter configured with 120-column width, Unix line endings, 2-space indentation.

### Theme

Tokyo Night (via NvChad's base46 theming system).

### LSP Servers

Configured via `nvim-lspconfig` and Mason:

| Server           | Language              |
|------------------|-----------------------|
| `html`           | HTML                  |
| `cssls`          | CSS                   |
| `marksman`       | Markdown              |
| `markdown_oxide` | Markdown (wiki links) |
| `pyright`        | Python                |
| `gdscript`       | GDScript (Godot)      |

### Formatting

Handled by `conform.nvim`:

| Filetype | Formatter |
|----------|-----------|
| Lua      | stylua    |

Format on save is available but disabled by default.

### Plugins

All plugins beyond the NvChad defaults:

| Plugin                    | Purpose                                              | Load condition      |
|---------------------------|------------------------------------------------------|---------------------|
| `conform.nvim`            | Code formatting                                      | Always              |
| `nvim-lspconfig`          | LSP client configuration                             | Always              |
| `vim-slime`               | Send code to other tmux panes                        | Always              |
| `telescope-bibtex.nvim`   | BibTeX citation search via Telescope                 | Markdown, TeX files |
| `vim-table-mode`          | Automatic table formatting and alignment              | Markdown files     |
| `zen-mode.nvim`           | Distraction-free writing (80-column, word wrap)       | On `:ZenMode` cmd  |
| `render-markdown.nvim`    | In-buffer Markdown rendering (disabled by default)   | Markdown files      |
| `image.nvim`              | Inline image display via kitty graphics protocol     | Markdown files      |
| `molten-nvim`             | Jupyter notebook code execution in Neovim            | Always (eager load) |
| `jupytext.nvim`           | Automatic notebook/script conversion via jupytext    | Always (eager load) |
| `luarocks.nvim`           | LuaRocks dependency manager (for image.nvim)         | Always              |
| `aerial.nvim`             | Code outline / document symbol browser               | Markdown files      |
| `nvim-surround`           | Add/change/delete surrounding pairs                  | VeryLazy            |

NvChad also provides by default: nvim-treesitter, nvim-cmp (with buffer, LSP, Lua, snippet, and path sources), LuaSnip, friendly-snippets, gitsigns.nvim, nvim-autopairs, nvim-tree.lua, telescope.nvim, which-key.nvim, indent-blankline.nvim, mason.nvim, and nvim-web-devicons.

For more informations on these package, please refer to the docs.

### molten.nvim Settings

- Image provider: `image.nvim`
- Auto-open output: off (virtual text used instead)
- Output wrapping: on
- Virtual text output: on
- Max output height: 80 lines

Since molten.nvim is a really complex plugin, please have a look at the docs if something is not working. Have a look at the section below about keybindings.

### Autocommands

Two areas have custom autocommands: Jupyter notebooks and Godot projects.

**Jupyter notebooks** (`.ipynb`):

- **BufAdd / BufEnter**: Automatically initializes a Molten kernel (detected from notebook metadata or active virtualenv) and imports existing cell outputs.
- **BufWritePost**: Exports Molten outputs back into the notebook file on save.

**Godot** (`gdscript` filetype):

- **FileType**: Registers buffer-local `GodotBreakpoint` and `GodotDeleteBreakpoints` user commands (with matching `<leader>gb` and `<leader>gD` keymaps) that insert or strip `breakpoint` lines in the current script, plus a `<leader>gr` keymap that launches the project's main scene.

### Filetype Overrides

**Quarto** (`.qmd`): Treated as Markdown (`filetype = markdown`).

**Markdown** (`.md`):
- Spell checking enabled (English).
- Additional buffer-local keybindings (see table below).

### Keybindings

#### General

| Mode | Key            | Action                    |
|------|----------------|---------------------------|
| i    | `jk`           | Exit insert mode          |
| n    | `<leader>fc`   | Telescope BibTeX citation search |
| n    | `<leader>z`    | Toggle Zen Mode           |
| n    | `<leader>ti`   | Toggle image.nvim on/off  |
| n    | `<leader>ss`   | Send paragraph to REPL    |
| x    | `<leader>ss`   | Send selection to REPL    |
| n    | `<leader>sl`   | Send line to REPL         |


#### Molten (Jupyter)

Local leader is `,`.

| Mode | Key              | Action                        |
|------|------------------|-------------------------------|
| n    | `,mi`            | Initialize Molten kernel      |
| n    | `,e`             | Evaluate operator (motion)    |
| n    | `,rc`            | Run current cell (between `# %%` markers) |
| n    | `,rl`            | Evaluate current line         |
| v    | `,r`             | Evaluate visual selection     |
| n    | `,os`            | Open/enter Molten output window |
| n    | `,oh`            | Hide Molten output            |
| n    | `,md`            | Delete Molten cell            |

The `run_cell` function (`<localleader>rc`) finds the nearest `# %%` markers above and below the cursor and evaluates everything between them through Molten.

#### Markdown (buffer-local)

| Mode | Key            | Action                             |
|------|----------------|-------------------------------------|
| n    | `<leader>wc`   | Show word and character count       |
| n    | `<leader>mr`   | Toggle render-markdown.nvim         |
| n    | `<leader>ms`   | Browse document sections via Telescope LSP symbols |

#### Godot (buffer-local)

Active only in `.gd` (gdscript) buffers.

| Mode | Key            | Action                                    |
|------|----------------|-------------------------------------------|
| n    | `<leader>gb`   | Insert `breakpoint` on a new line and save |
| n    | `<leader>gD`   | Remove all `breakpoint` lines and save     |
| n    | `<leader>gr`   | Run the project's main scene via Godot CLI |


### Telescope BibTeX

Configured to search a global bibliography file (`path/to/bibliography.bib`). Citations are inserted in Pandoc format: `[@key]`.

### vim-slime
For the vim-slime keybindings to work properly, the pane to which you want to send the code has to be the last selected one. If you rearrange panes or want to send to a different one, run `:SlimeConfig` inside nvim. It will prompt you for the socket name and target pane (`{last}`, `{right}`, `{left}`). With this command you can also specify a specific pane numbers.

### Godot

Neovim can act as Godot's external script editor and consume GDScript diagnostics, completion, and goto-definition from a running Godot instance.

On startup, `init.lua` walks up one directory to look for a `project.godot` file. If found, it sets `vim.g.is_godot_project = true` and calls `serverstart` on `<project>/server.pipe`, so Godot can push open-file commands to this Neovim instance via `--remote-send`. Because of this, Neovim must be launched from the project root (or a direct subdirectory) for the round-trip to work.

The GDScript LSP is defined in `.config/nvim/lsp/gdscript.lua` and connects to Godot's built-in language server on `127.0.0.1:6005` (override with the `GDScript_Port` environment variable). It only attaches to buffers with `gdscript`, `gd`, or `gdscript3` filetype whose root markers include `project.godot` or `.git`. Treesitter parsers `gdscript`, `godot_resource`, and `gdshader` are added to the `ensure_installed` list for syntax highlighting.

Debugging is done via the `breakpoint` keyword rather than `nvim-dap` (which is unreliable with Godot). The FileType autocommand above provides `<leader>gb` to insert one and `<leader>gD` to strip them all.

Running the project is bound to `<leader>gr`. The mapping reads `run/main_scene` from `project.godot` and spawns `godot --path <root> <main_scene> --remote-debug tcp://127.0.0.1:6007` detached, so the process survives Neovim quitting. The `--remote-debug` flag connects the game back to the editor's debug channel (default port 6007, configurable under Editor Settings / Network / Debug / Remote Port). For the mapping to work, the `godot` binary must be resolvable on `$PATH`, either through a symlink such as `~/.local/bin/godot -> /Applications/Godot.app/Contents/MacOS/Godot`, or by setting `vim.g.godot_bin` to an absolute path in `init.lua`. Known limitation: because the game is launched outside the editor process, Cmd+. in the editor UI will not stop it; close the game window directly instead.

On the Godot side (one-time setup, not part of the dotfiles), open Editor Settings and configure:

- **Text Editor / External**: set `Use External Editor` to on, `Exec Path` to the full path of the `nvim` binary, and `Exec Flags` to `--server {project}/server.pipe --remote-send "<C-\><C-N>:e {file}<CR>:call cursor({line}+1,{col})<CR>"`.
- **Network / Language Server**: enable `Use Thread` to reduce LSP restarts.
- In the Script view (top-bar workspace), enable `Debug with External Editor` so `breakpoint` hits pause the running scene and focus the paused line in Neovim.

Each Godot project should also gitignore `server.pipe`, `*.uid`, and `.godot/`.

If the LSP gets messed up, just run `:LspRestart`.

This config was based on [Simon Dalvai's](https://simondalvai.org/blog/godot-neovim/) setup.

### Disabled Built-in Plugins

For performance, the following Neovim built-in plugins are disabled: 2html, tohtml, getscript, gzip, logipat, netrw, matchit, tar, rrhelper, spellfile, vimball, zip, tutor, syntax menus, optwin, compiler, bugreport, ftplugin. The `rplugin` provider is intentionally kept enabled for molten-nvim.

### Spell Dictionary

Spell dictionaries for English and Italian are present (`spell/en.utf-8.add` and `spell/it.utf-8.spl`).

### Further Info

Have a look at [markdown_examples.md](https://raw.githubusercontent.com/ndrscalia/dotfiles/refs/heads/main/markdown_examples.md?token=GHSAT0AAAAAADPQ5CXXFHLBANMIEOX5BO4S2NMFI4Q) for further informations on keybindings and plugins specifically meant to work with `.md` or `.qmd` file and for scholarly writing in nvim in general.

[^1]: Python 3.13 is in the aliases, to allow for quickly invoking it if downgrading from 3.14 is needed.
