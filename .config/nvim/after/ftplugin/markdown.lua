-- spell checking (default English)
vim.opt_local.spell = true
vim.opt_local.spelllang = "en"

-- word count
vim.keymap.set("n", "<leader>wc", function()
  local wc = vim.fn.wordcount()
  print("Words: " .. wc.words .. " | Chars: " .. wc.chars)
end, { buffer = true, desc = "Word count" })

-- renderer-markdown quick toggle
vim.keymap.set("n", "<leader>mr", ":RenderMarkdown toggle<CR>", { buffer = true, desc = "Toggle render markdown" })

-- browse md sections quick toggle
vim.keymap.set("n", "<leader>ms", ":Telescope lsp_document_symbols<CR>", { buffer = true, desc = "Markdown sections" })

-- Renumber labelled footnotes 1..N. Definitions are numbered in the order they
-- appear. References to a label with a single definition all resolve to that
-- definition; references to a label that has multiple definitions are paired
-- positionally (Nth ref carrying label L -> Nth def carrying label L).
-- Inline footnotes (^[...]) are left alone.
local function renumber_footnotes()
  local bufnr = 0
  local view = vim.fn.winsaveview()
  local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)

  -- Pass 1: collect definitions in document order.
  local defs = {}                         -- { {label, line_idx, s, e}, ... }
  local defs_by_label = {}                -- label -> ordered list of def indices
  for i, line in ipairs(lines) do
    local s, e, label = line:find("^(%[%^[^%[%] ]+%]):")
    if s then
      local lbl = label:match("^%[%^(.+)%]$")
      local idx = #defs + 1
      defs[idx] = { label = lbl, line_idx = i, s = s, e = e - 1 }  -- e-1: drop ':'
      defs_by_label[lbl] = defs_by_label[lbl] or {}
      table.insert(defs_by_label[lbl], idx)
    end
  end

  if #defs == 0 then
    vim.notify("No footnote definitions found", vim.log.levels.INFO)
    return
  end

  -- Pass 2: collect references in document order (skipping the def prefix).
  local refs = {}                         -- { {label, line_idx, s, e}, ... }
  for i, line in ipairs(lines) do
    local search_start = 1
    local def_s, def_e = line:find("^%[%^[^%[%] ]+%]:")
    if def_s then search_start = def_e + 1 end
    local pos = search_start
    while true do
      local s, e, lbl = line:find("%[%^([^%[%] ]+)%]", pos)
      if not s then break end
      refs[#refs + 1] = { label = lbl, line_idx = i, s = s, e = e }
      pos = e + 1
    end
  end

  -- Pass 3: resolve each reference to a definition index.
  local per_label_counter = {}
  for _, ref in ipairs(refs) do
    local pool = defs_by_label[ref.label]
    if pool then
      if #pool == 1 then
        ref.new = pool[1]
      else
        per_label_counter[ref.label] = (per_label_counter[ref.label] or 0) + 1
        ref.new = pool[per_label_counter[ref.label]]  -- may be nil if too many refs
      end
    end
  end

  -- Pass 4: collect edits per line and apply right-to-left so columns stay valid.
  local edits = {}
  for idx, def in ipairs(defs) do
    edits[def.line_idx] = edits[def.line_idx] or {}
    table.insert(edits[def.line_idx], { s = def.s, e = def.e, text = "[^" .. idx .. "]" })
  end
  for _, ref in ipairs(refs) do
    if ref.new then
      edits[ref.line_idx] = edits[ref.line_idx] or {}
      table.insert(edits[ref.line_idx], { s = ref.s, e = ref.e, text = "[^" .. ref.new .. "]" })
    end
  end
  for line_idx, line_edits in pairs(edits) do
    table.sort(line_edits, function(a, b) return a.s > b.s end)
    local line = lines[line_idx]
    for _, ed in ipairs(line_edits) do
      line = line:sub(1, ed.s - 1) .. ed.text .. line:sub(ed.e + 1)
    end
    lines[line_idx] = line
  end

  vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, lines)
  vim.fn.winrestview(view)
  vim.notify("Renumbered " .. #defs .. " footnote definition(s)")
end

vim.api.nvim_buf_create_user_command(0, "FootnoteRenumber", renumber_footnotes,
  { desc = "Renumber labelled footnotes 1..N in order of appearance" })

vim.keymap.set("n", "<leader>fn", renumber_footnotes,
  { buffer = true, desc = "Renumber footnotes" })

