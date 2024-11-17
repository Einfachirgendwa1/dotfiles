return function(settings)
  vim.o.scrolloff = 999999
  vim.g.python3_host_prog = "$HOME/venv/bin/python"

  vim.o.mouse = ""
  vim.o.clipboard = "unnamed"

  vim.o.tabstop = settings.tabstop -- A TAB character looks like 4 spaces
  vim.o.expandtab = settings.expandtab -- Pressing the TAB key will insert spaces instead of a TAB character
  vim.o.softtabstop = settings.softtabstop -- Number of spaces inserted instead of a TAB character
  vim.o.shiftwidth = settings.shiftwidth -- Number of spaces inserted when indenting
end
