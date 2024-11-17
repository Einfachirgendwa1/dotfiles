require("nvim-dap-projects").search_project_config()

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
