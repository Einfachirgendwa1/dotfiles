return function(settings)
  if not settings.spelling then return end

  vim.opt.spell = true

  vim.cmd [[
augroup spellcheck_strings
  autocmd!
  autocmd FileType * syntax match SpellText /\v".{-}"/ contains=@Spell
augroup END
]]
end
