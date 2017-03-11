" vim-testing-pair
"
" The plugin to open testin-pair quickly.
" Toggle the buffers of production code and testing code.

command! OpenTestingPair :call OpenTestingPair()
command! ToggleTestingPair :call ToggleTestingPair()

function! OpenTestingPair()
  call s:OpenBufferRegexp(s:MakeTestingPairRegex())
endfunction

function! ToggleTestingPair()
  if s:IsTestFile(expand('%:t:r'))
    let regexp = s:MakeNormalFileRegex()
    call s:OpenBufferRegexp(regexp)
  else
    call OpenTestingPair()
  endif
endfunction

function! s:OpenBufferRegexp(regexp) abort
  let s:regexp = '' . a:regexp
  for bufinfo in getbufinfo()
    let basename = fnamemodify(bufinfo.name, ':t:r')
    if basename =~ s:regexp
      execute 'buf '.bufinfo.bufnr
      return 1
    endif
  endfor
  echo 'buf not found: ' . s:regexp
  return 0
endfunction

function! s:MakeTestingPairRegex()
  return '\c'.expand('%:t:r').'_\?test$'
endfunction

function! s:MakeNormalFileRegex()
  return substitute(expand('%:t:r'), '\c_\?test$', '', 'g')
endfunction

function! s:IsTestFile(fname)
  return a:fname =~ '_\?test$'
endfunction

