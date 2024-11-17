vim.opt.spell = true

vim.cmd [[
augroup spellcheck_strings
  autocmd!
  autocmd FileType * syntax match SpellText /\v".{-}"/ contains=@Spell
augroup END
]]

require("mason").setup {
  registries = {
    "file:~/dev/rust/asm_tools/mason-registry",
  },
}
