vim.opt.spell = true

vim.cmd [[
augroup spellcheck_strings
  autocmd!
  autocmd FileType * syntax match SpellText /\v".{-}"/ contains=@Spell
augroup END
]]
