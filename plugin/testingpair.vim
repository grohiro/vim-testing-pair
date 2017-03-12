" vim-testing-pair
"
" The plugin to open testin-pair quickly.
" Toggle the buffers of production code and testing code.
" https://github.com/grohiro/vim-testing-pair

if exists("g:loaded_testing_pair")
    finish
endif
let g:loaded_testing_pair = 1

let s:save_cpo = &cpo
set cpo&vim

if !exists("g:testing_pair_debug")
  let g:testing_pair_debug = 0
endif

command! -nargs=0 OpenTestingPair call testingpair#OpenTestingPair()
command! -nargs=0 ToggleTestingPair call testingpair#ToggleTestingPair()

let &cpo = s:save_cpo
unlet s:save_cpo
