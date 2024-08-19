-- This will run last in the setup process and is a good place to configure
-- things like custom filetypes. This just pure lua so anything that doesn't
-- fit in the normal config locations above can go here

vim.o.scrolloff = 999999
vim.g.python3_host_prog = "$HOME/venv/bin/python"

require("nvim-dap-projects").search_project_config()

---@diagnostic disable-next-line: missing-fields
require("neotest").setup {
  adapters = {
    require "neotest-python",
    require "neotest-rust",
  },
}

-- require("rust_analyzer_fast_display_thing").setup()
require("autosave").setup()

local ft = vim.filetype.match { buf = 0 }
if ft ~= "javascript" then
  ---@diagnostic disable-next-line: missing-fields
  require("nvim-treesitter.configs").setup {
    rainbow = {
      enable = true,
      extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
      max_file_lines = nil, -- Do not enable for files with more than n lines, int
      colors = {
        "#f38ba8",
        "#fab387",
        "#f9e2af",
        "#a6e3a1",
        "#89dceb",
        "#74c7ec",
        "#89b4fa",
        "#b4befe",
      },
    },
  }
end

vim.o.mouse = ""
vim.o.clipboard = "unnamed"

vim.o.tabstop = 4 -- A TAB character looks like 4 spaces
vim.o.expandtab = false -- Pressing the TAB key will insert spaces instead of a TAB character
vim.o.softtabstop = 4 -- Number of spaces inserted instead of a TAB character
vim.o.shiftwidth = 4 -- Number of spaces inserted when indenting

vim.cmd.set "exrc"

require("dap").configurations.rust = {
  {
    name = "Launch",
    type = "codelldb",
    request = "launch",
    program = function() -- Ask the user what executable wants to debug
      local handle =
        io.popen "cargo build --message-format=json | jq -r 'select(.profile.test == false and .executable != null) | .executable' | grep '^/' 2>&1"
      if handle == nil then
        vim.notify "Failed to run cargo"
        return
      end
      local result = handle:read "*l"
      handle:close()
      return result
    end,
    cwd = "${workspaceFolder}",
    stopOnEntry = false,
    args = {},
    initCommands = function() -- add rust types support (optional)
      -- Find out where to look for the pretty printer Python module
      local rustc_sysroot = vim.fn.trim(vim.fn.system "rustc --print sysroot")

      local script_import = 'command script import "' .. rustc_sysroot .. '/lib/rustlib/etc/lldb_lookup.py"'
      local commands_file = rustc_sysroot .. "/lib/rustlib/etc/lldb_commands"

      local commands = {}
      local file = io.open(commands_file, "r")
      if file then
        for line in file:lines() do
          table.insert(commands, line)
        end
        file:close()
      end
      table.insert(commands, 1, script_import)

      return commands
    end,
  },
}

-- vim.opt.spell = true
--
-- vim.cmd [[
-- augroup spellcheck_strings
--   autocmd!
--   autocmd FileType * syntax match SpellText /\v".{-}"/ contains=@Spell
-- augroup END
-- ]]
--
-- require("mason").setup {
--   registries = {
--     "file:~/dev/rust/asm_tools/mason-registry",
--   },
-- }
