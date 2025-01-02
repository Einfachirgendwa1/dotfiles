return {
  "hrsh7th/nvim-cmp",
  opts = function(_, opts)
    local cmp = require "cmp"
    opts.mapping["<C-y>"] = cmp.mapping.select_next_item()
  end,
}
