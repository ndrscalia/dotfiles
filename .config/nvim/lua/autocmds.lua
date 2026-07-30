require "nvchad.autocmds"

-- auto-init molten kernel and import outputs when opening notebooks
local function molten_init_and_import(e)
  vim.schedule(function()
    if vim.fn.exists(":MoltenInit") == 0 then
      return
    end
    local kernels = vim.fn.MoltenAvailableKernels()
    local try_kernel_name = function()
      local metadata = vim.json.decode(io.open(e.file, "r"):read("a"))["metadata"]
      return metadata.kernelspec.name
    end
    local ok, kernel_name = pcall(try_kernel_name)
    if not ok or not vim.tbl_contains(kernels, kernel_name) then
      kernel_name = nil
      local venv = os.getenv("VIRTUAL_ENV") or os.getenv("CONDA_PREFIX")
      if venv ~= nil then
        kernel_name = string.match(venv, "/.+/(.+)")
      end
    end
    if kernel_name ~= nil and vim.tbl_contains(kernels, kernel_name) then
      vim.cmd(("MoltenInit %s"):format(kernel_name))
    end
    vim.cmd("MoltenImportOutput")
  end)
end

vim.api.nvim_create_autocmd("BufAdd", {
  pattern = { "*.ipynb" },
  callback = molten_init_and_import,
})

vim.api.nvim_create_autocmd("BufEnter", {
  pattern = { "*.ipynb" },
  callback = function(e)
    if vim.api.nvim_get_vvar("vim_did_enter") ~= 1 then
      molten_init_and_import(e)
    end
  end,
})

vim.api.nvim_create_autocmd("BufWritePost", {
  pattern = { "*.ipynb" },
  callback = function()
    vim.schedule(function()
      local ok, status = pcall(function() return require("molten.status").initialized() end)
      if ok and status == "Molten" then
        pcall(vim.cmd, "MoltenExportOutput!")
      end
    end)
  end,
})

-- Godot: buffer-local breakpoint commands + keymaps on .gd files
vim.api.nvim_create_autocmd("FileType", {
  pattern = "gdscript",
  callback = function(args)
    vim.api.nvim_buf_create_user_command(args.buf, "GodotBreakpoint", function()
      vim.cmd("normal! obreakpoint")
      vim.cmd("write")
    end, {})
    vim.api.nvim_buf_create_user_command(args.buf, "GodotDeleteBreakpoints", function()
      vim.cmd("g/breakpoint/d")
      vim.cmd("write")
    end, {})
    vim.keymap.set("n", "<leader>gb", "<cmd>GodotBreakpoint<cr>",
      { buffer = args.buf, desc = "Godot: insert breakpoint" })
    vim.keymap.set("n", "<leader>gD", "<cmd>GodotDeleteBreakpoints<cr>",
      { buffer = args.buf, desc = "Godot: clear all breakpoints" })
    vim.keymap.set("n", "<leader>gr", function()
      local root = vim.g.godot_root
      if not root then
        vim.notify("Not in a Godot project", vim.log.levels.WARN)
        return
      end
      local main_scene = nil
      local f = io.open(root .. "project.godot", "r")
      if f then
        for line in f:lines() do
          local scene = line:match('^run/main_scene="(.-)"')
          if scene then
            main_scene = scene
            break
          end
        end
        f:close()
      end
      local cmd = { vim.g.godot_bin or "godot", "--path", root,
                    "--remote-debug", "tcp://127.0.0.1:6007" }
      if main_scene then
        table.insert(cmd, main_scene)
      end
      vim.system(cmd, { detach = true })
      vim.notify("Godot: launched " .. (main_scene or "main scene"))
    end, { buffer = args.buf, desc = "Godot: run main scene" })
  end,
})
