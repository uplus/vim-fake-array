if exists('g:loaded_fakearray')
  finish
endif
let s:save_cpo = &cpo
set cpo&vim

inoremap <Plug>(fakearray) <C-r>=fakearray#prompt()<CR>

" Default key mappings.
if !get(g:, 'fakearray_no_default_key_mappings', 0) && 
  \ !hasmapto('<Plug>(fakearray)', 'i')
  silent! imap <unique><F3> <Plug>(fakearray)
endif

let g:loaded_fakearray = 1
let &cpo = s:save_cpo
unlet s:save_cpo
" vim: et ts=2 sts=2 sw=2 tw=0 ff=unix fdm=marker:
