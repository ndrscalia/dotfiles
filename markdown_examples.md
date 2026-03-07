---
title: "An Example Markdown Doc"
author: "Andrea Scalia"
abstract: "This is an abstract."

bibliography: /Users/andreascalia/code/zot_md_test/library_zot.bib
csl: /Users/andreascalia/code/zot_md_test/mhra-notes.csl
suppress-bibliography: true
notes-after-punctuation: true

toc: true
toc-depth: 3
toc-title: "Contents"

highlight-style: breezedark
lang: en-GB

crossref:
  fig-prefix: "Figure"
  tbl-prefix: "Table"
  eq-prefix: "Equation"
  sec-prefix: "Section"

tags:
    - workflow
    - pandoc
    - nvim
    - markdown
---

# Nvim (Nvchad) -> Pandoc/Quarto -> MS Word Workflow

To have a sense on the markup used here and the configuration frontmatter, open this document in your editor (nvim, if you are using the dotfiles available in this repo). GitHub is rendering it.

This is a markdown [File]{.smallcaps} with a footnote [Namely, a footnote with text and reference: @baranowski_companion_2018].

While this is another footnote [^1] which has other text. The really interesting thing is that, with the cursor on the footnote, I can use the go to definition binding (`gd`) to quickly jump to the right location to the bottom of the text. Since nvim has a jump history, `ctrl+o` will simply bring me back.
To insert the reference, either write `:Telescope bibtex` or use the keybinding `<leader>fc` (this is a custom mapping, "find citation").
This is the line of code to run to correctly render this document to docx using `pandoc`:

```bash
pandoc my_doc.md --citeproc -o my_doc.docx
```

For more advanced use, see [Pandoc's manual](https://pandoc.org/MANUAL.html#citations). Quarto has surely even more advanced options.

I also installed `vim-table-mode` which allows to quickly write down tables with the command `TableModeToggle`.
See the [repo's readme](https://github.com/dhruvasagar/vim-table-mode) for more instructions.

We could demonstrate how the table should be formatted with `vim-table-mode` while also adding a Pandoc's citation syntax quick reference.

| Syntax                          | Result                        |
|---------------------------------|-------------------------------|
| `[@key]`                        | (Author 2020) or footnote     |
| `@key`                          | Author (2020) - author inline |
| `[@key, p. 33]`                 | with page number              |
| `[see @key]`                    | with prefix                   |
| `[@key, p. 33, emphasis added]` | with suffix                   |
| `[@key1; @key2]`                | multiple citations            |
| `[-@key]`                       | suppress author (year only)   |

Be careful not to add separator rows to highlight borders as showcased by the author of `vim-table-mode`: this will ruin Pandoc's formatting when converting to `.docx`.[^2]

# ZenMode

With `:ZenMode` or `<leader>z` you can activate the Zen Mode, which allows the lines to wrap visually - regardless of terminal's size - without adding an actual new line.

I also added custom keymaps that allow `j` and `k` to navigate visually (and not by actual line) while in Zen Mode.

It works like a charm, but `rln` gets a little messed up...

# Text Editor Utilities

I also added a function for word and chars count that can be triggered with `<leader>wc`, as well as a spell checker for English that will spot worgn wrods. (see `.config/nvim/after/ftplugin/markdown.lua`)

You can also add words to the spell list with `zg` or checking for spelling suggestions with `z=`.

If you have `.spl` files for other languages, you can set the spelling language with `:set spelllang=it`. To be sure of what files the spell checker is using, run `:spellinfo`. You can also set multi-language spell check, e.g.: `:set spelllang=en,it`.

To install Italian spelling I followed this procedure:

```bash
cd .config/nvim/spell
curl -O https://ftp.nluug.nl/pub/vim/runtime/spell/it.utf-8.spl
```

If it is not already there, you will have to create the `spell/` directory.

If you are managing your dotfiles with git, you could add `spell/` to `.gitignore`, otherwise it will get in the way of modified files every time you run `zg` to add a word to the dictionary. If you value keeping such data, leave it as is.

# render-markdown.nvim

I also added this popular plugin to partially render `.md` files. It is disabled by default and you can enable it with `:RenderMarkdown toggle` or with `<leader>mr`.

# How to add todos without highlighting options

One could use a custom and easy protocol to find syntax such as:
- %%CHECK: reference%%
- %%FIX: sentence sounds like shit%%
- %%TODO: add this and that%%

Then you could simply type `/%%.*%%`. Moreover, after the search, everything stays highlighted until you close the doc or run `noh`. Moreover, you will be able to navigate through the found occurrences as usual (go fwd with `n`, bwd with `N`) Another approach could be: `Telescope live_grep default_text=%%`, but this does not leave text highlighted as the first one does.

# Linking other .md docs

I can simply add links to other `.md` docs (thanks to markdown-oxide) with double brackets like so: [[another_doc]]. And obviously, while on the link, I can simply navigate to it with `gd`. I could also add links to sections like so: [[another_doc#This is a section]]. After opening a new buffer with `gd`, I can close it with `:w | bd`.

For this to work, the root directory should contain a `.moxide.toml` file or `.git` directory.

[markdown-oxide](https://github.com/Feel-ix-343/markdown-oxide) will make wikilinks work across `.md` files, not `.qmd` files. In `.qmd` double-brackets notation will work for section-referencing only.

# Table of Contents

I can also create a toc specifying everything in the frontmatter and then adding the `--toc` flag before the `-o` flag in the `pandoc` command. I could also build a manual one simply referencing the different headings with the double square brackets notation: [[references_zotero#Create a reference document]] (this will work in `.qmd` files also).

Regardless of the toc, you can quickly navigate through sections using `:Telescope lsp_document_symbols` or `<leader>ms`. Nvim also comes with a built-in keybinding to quickly go to the previous heading (`[[`) and to the next one (`]]`). With [aerial.nvim](https://github.com/stevearc/aerial.nvim) installed, you can also run `:AerialToggle` to let a navigation menu pop up.

# Create a reference document

If you want more customization when converting to `.docx` (e.g. set font and font size for text's body and footnotes), you can create a reference document with the following Pandoc's command:

```bash
pandoc -o custom-reference.docx --print-default-data-file reference.docx
```

Open custom-reference.docx in Word and modify the styles (don't edit the text, just the styles) and then use it with Pandoc:

```bash
pandoc my_doc.md --citeproc --reference-doc=custom-reference.docx -o my_doc.docx
```

Or add to your frontmatter:

```yaml
reference-doc: path/to/custom-reference.docx
```

With Quarto, this is probably even simpler by now, just as it is to make highly customizable presentations.

# Image Rendering (and Extraction from .docx docs)

The `render-markdown.nvim` plugin, with the aid of the `image.nvim` plugin, is able to also render embedded images. By default, you'll always get them rendered, but tweaking the `lua/plugin/init.lua` is surely possible to toggle it on and off as a default. Currently, `<leader>ti` toggles the rendering of the images on and off.

This perfectly integrates with a pandoc conversion from `.docx`. Pandoc does indeed allow you to extract the media embedded in the `.docx` file, creating a folder where the image get stored. They will automatically get referenced with the correct path (as long as the `.md` file and the `media/` folder stay in the same directory). You only have to add a flag:

```bash
# extract `media/` in the current directory
pandoc my_doc.docx --extract-media=. -o my_doc.md

# extract `media/` in a custom directory
pandoc my_doc.docx --extract-media=./images -o my_doc.md
```

You can obviously output the conversion to a `.qmd` file (you are not limited to `.md`) and there's surely a `quarto` command that does the same since the CLI is built on top of `pandoc`.

# Cross-References

With the filter `pandoc-crossref`, you can add cross-references to figures, tables, sections, equations. The following table (@tbl:cross) summarizes how it does work.

| Type     | Label         | Reference   |
|----------|---------------|-------------|
| Figure   | `{#fig:name}` | `@fig:name` |
| Table    | `{#tbl:name}` | `@tbl:name` |
| Section  | `{#sec:name}` | `@sec:name` |
| Equation | `{#eq:name}`  | `@eq:name`  |
: This is a table caption {#tbl:cross}

The relevant metadata in the frontmatter allows further customization. To use the filter add the flag `--filter pandoc-crossref`[^3].

# There's Way More..
## Metadata Variables
There's a lot more that can be put into the metadata, [here's the main manual's entry](https://pandoc.org/MANUAL.html#variables) to have a look at the metadata. Have a look at Quarto's manual also.

## Writer-Specific Flags
[Here](https://pandoc.org/MANUAL.html#options-affecting-specific-writers) there are writer-specific flags to check.

# Alternatives

A good service if you need actual collaborative editing is HedgeDoc (it has vim motions), but I fear it lacks references support, which would make it useless for scientific writing.

For more code-oriented stuff, Quarto (`.qmd`) is obviously there. It would suffice to change the file's extension and then run the `quarto render` command on your doc. Just a couple differences:

- quarto requires `format` in the frontmatter (even multiple formats);
- you could remove the `crossref` block from frontmatter since it is built-in;
- for cross-references you should use hyphen instead of colon;
- there's no need for the `--toc` and `--citeproc` flag.

Everything else would work just fine. Nvim treats `.qmd` files as `.md` ones since I configured `.configs/after/ftplugin/quarto.lua` to inherit from `.configs/after/ftplugin/markdown.lua`.

[^1]:   Other text.
[^2]:   A really cool feature is `notes-after-punctuation`: you do not have to go crazy if the publisher has different style guidelines as you expected. This will simply move the markers always after punctuation. But this will not work with manually created footnote markers, only with inline ones.
[^3]:   This flag should come after `--citeproc`, otherwise Pandoc will try to render cross-references as normal references.
