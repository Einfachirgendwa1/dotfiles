local settings = {
  spelling = false,
  brace_colors = {
    "#f38ba8",
    "#fab387",
    "#f9e2af",
    "#a6e3a1",
    "#89dceb",
    "#74c7ec",
    "#89b4fa",
    "#b4befe",
  },
  tabstop = 4,
  expandtab = true,
  softtabstop = 4,
  shiftwidth = 4,
}

local module_initializers = {
  require "scripts.settings",
  require "scripts.neotest",
  require "scripts.rainbow_braces",
  require "scripts.dap",
  require "scripts.fourmulo",
  require "scripts.tmux_compile",
  require "scripts.clangd",
  require "scripts.spelling",
}

for _, init in ipairs(module_initializers) do
  init(settings)
end
