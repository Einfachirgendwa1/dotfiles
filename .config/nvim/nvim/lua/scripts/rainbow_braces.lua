return function(settings)
  local ft = vim.filetype.match { buf = 0 }
  if ft ~= "javascript" then
    ---@diagnostic disable-next-line: missing-fields
    require("nvim-treesitter.configs").setup {
      rainbow = {
        enable = true,
        extended_mode = true,
        max_file_lines = nil,
        colors = settings.brace_colors,
      },
    }
  end
end
