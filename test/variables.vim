let s:suite = themis#suite('variables')
let s:assert = themis#helper('assert')

function! s:suite.after_each() abort
endfunction after_each()

function! s:suite.separator() abort
  let save_separator = g:fakearray#separator
  let g:fakearray#separator = '__'
  call s:assert.match(fakearray#gen(0, 10, 2), '\d\+' . g:fakearray#separator .'\d\+')
  let g:fakearray#separator = save_separator
endfunction

function! s:suite.b_separator() abort
  let b:fakearray_separator = '@'
  call s:assert.match(fakearray#gen(0, 10, 2), '\d\+' . b:fakearray_separator .'\d\+')
  unlet b:fakearray_separator
endfunction
