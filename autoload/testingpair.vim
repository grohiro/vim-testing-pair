" vim-testing-pair
"
" The plugin to open testin-pair quickly.
" Toggle the buffers of production code and testing code.
" https://github.com/grohiro/vim-testing-pair

let s:save_cpo = &cpo
set cpo&vim

function! testingpair#OpenTestingPair()
  call s:OpenBufferRegexp(s:MakeTestingPairRegex())
endfunction

function! testingpair#ToggleTestingPair()
  let regexp = ''
  if s:IsTestFile(expand('%:t:r'))
    let regexp = s:MakeNormalFileRegex()
    if g:testing_pair_debug == 1
      echom 'Opening normal file: ' . regexp
    endif
  else
    let regexp = s:MakeTestingPairRegex()
    if g:testing_pair_debug == 1
      echom 'Opening test file: ' . regexp
    endif
  endif

  call s:OpenBufferRegexp(regexp)
endfunction

function! s:OpenBufferRegexp(regexp) abort
  let s:regexp = '' . a:regexp
  let curbuf = bufnr('%')
  for bufinfo in getbufinfo()
    if bufinfo.bufnr == curbuf
      :continue
    endif
    let basename = fnamemodify(bufinfo.name, ':t:r')
    if basename =~ s:regexp
      execute 'buf '.bufinfo.bufnr
      return 1
    endif
  endfor
  if g:testing_pair_debug == 1
    echom 'Buffer not found: ' . s:regexp
  endif
  return 0
endfunction

function! s:MakeTestingPairRegex()
  return '\c'.expand('%:t:r').'_\?test$'
endfunction

function! s:MakeNormalFileRegex()
  return '\c'.substitute(expand('%:t:r'), '\c_\?test$', '', 'g')
endfunction

function! s:IsTestFile(fname)
  return a:fname =~ '_\?test$'
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo
