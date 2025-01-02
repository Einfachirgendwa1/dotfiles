return function(_)
  ---@diagnostic disable-next-line: missing-fields
  require("neotest").setup {
    adapters = {
      require "neotest-python",
      require "neotest-rust",
    },
  }
end
