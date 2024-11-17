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
