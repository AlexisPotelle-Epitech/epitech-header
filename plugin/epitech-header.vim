nnoremap <F10> :call HeaderF10()<cr>

let s:Epitech       = "EPITECH PROJET, "
let s:Descrip       = "File Description:"

function s:GetComStr()
    let hascom = 1
    if &ft == "c"  || &ft == "css" || &ft == "cpp"
        let s:cs = "/\*"
        let s:cc = "\*\* "
        let s:ce = "\*/"
    elseif &ft == "make" || &ft == "text" || &ft == "vim"
        let s:cs = "##"
        let s:cc = "## "
        let s:cs = "##"
    else
        let hascom = 0
    endif
    return hascom
endfunction

function HeaderCreate(new)
if s:GetComStr()
    setl fo-=o fo-=r fo-=a fo-=c
    setl noautoindent nosmartindent nocindent
    execute "normal! ggO" .
      \ s:cs . "\n".
      \ s:cc . s:Epitech . strftime("%Y") . "\n".
      \ s:cc . expand("%:p:h:t") . "\n".
      \ s:cc . s:Descrip . "\n".
      \ s:cc . expand("%:t") . "\n".
      \ s:ce
    if getline(7) !~ '^\s*$' "pb avec le shebang
      execute "normal! 7"
      execute "normal! o"
    endif
    setl fo+=o fo+=r fo+=a fo+=c
    setl autoindent smartindent cindent
    execute "normal! G"
endif
endfunction

function HeaderF10()
  if s:GetComStr()
    if getline(1) == s:cs && getline(6) == s:ce
      execute "normal! gg6dd"
    endif
    call HeaderCreate(0)
  endif
endfunction
