return {
  "mei28/instant_rename.nvim",
  event = { "ModeChanged", "CmdlineChanged" }, -- for lazy loading
  config = function() require "instant_rename" end,
}
