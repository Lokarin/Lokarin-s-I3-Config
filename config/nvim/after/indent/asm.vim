" ~/.config/nvim/after/indent/asm.vim

setlocal autoindent
setlocal smartindent
setlocal indentkeys+=:
setlocal indentexpr=AsmIndent()

setlocal shiftwidth=4
setlocal tabstop=4
setlocal expandtab

function! AsmIndent()
  " Pega o número da linha anterior
  let lnum = prevnonblank(v:lnum - 1)
  let line = getline(lnum)

  " Se termina com ':', indentar 1 nível (4 espaços)
  if line =~ ':\s*$'
    return indent(lnum) + &shiftwidth
  endif

  " Caso contrário, manter indentação da linha anterior
  return indent(lnum)
endfunction

