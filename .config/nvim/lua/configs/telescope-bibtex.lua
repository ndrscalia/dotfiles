require("telescope").setup {
  extensions = {
    bibtex = {
      global_files = { "/Users/andreascalia/Documents/zotero.bib" },
      search_keys = { "author", "year", "title" },
      citation_format = "[@{{key}}]",  -- Pandoc-style citation
    },
  },
}
