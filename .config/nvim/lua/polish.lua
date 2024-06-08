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

vim.o.mouse = nil
vim.o.clipboard = "unnamed"

vim.o.tabstop = 4 -- A TAB character looks like 4 spaces
vim.o.expandtab = false -- Pressing the TAB key will insert spaces instead of a TAB character
vim.o.softtabstop = 4 -- Number of spaces inserted instead of a TAB character
vim.o.shiftwidth = 4 -- Number of spaces inserted when indenting
