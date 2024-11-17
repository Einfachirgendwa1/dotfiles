local function arraysEqual(a, b)
  if #a ~= #b then return false end
  for i = 1, #a do
    if a[i] ~= b[i] then return false end
  end
  return true
end

vim.api.nvim_create_autocmd({ "BufWrite" }, {
  pattern = { "*.hs" },
  callback = function(_)
    local content = vim.api.nvim_buf_get_lines(0, 0, -1, false)
    local formatter = vim.system({ "fourmolu", "--quiet", "--stdin-input-file", "." }, { stdin = content })
    local result = formatter:wait()

    if result.code ~= 0 then return end
    local stdout = result.stdout
    if stdout == nil then return end

    local formatted_lines = vim.split(stdout, "\n")
    if arraysEqual(formatted_lines, content) then return end
    vim.api.nvim_buf_set_lines(0, 0, -1, false, formatted_lines)
  end,
})
