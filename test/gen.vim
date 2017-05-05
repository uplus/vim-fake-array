let s:suite = themis#suite('gen')
let s:assert = themis#helper('assert')

function! s:suite.before_each() abort
  %delete
endfunction

" Success
function! s:suite.is_string() abort
  call s:assert.is_string(fakearray#gen(0, 10, 1))
endfunction

function! s:suite.zero() abort
  call s:assert.equal('', fakearray#gen(0, 1, 0))
  call s:assert.equal('', fakearray#gen(0, 1.0, 0))
  call s:assert.equal('', fakearray#gen(1, '\w', 0))
endfunction

function! s:suite.int_one() abort
  call s:assert.match(fakearray#gen(0, 10, 1), '\d\+')
endfunction

function! s:suite.int_two() abort
  call s:assert.match(fakearray#gen(0, 10, 2), '\d\+, \d\+')
endfunction

function! s:suite.float_one() abort
  call s:assert.match(fakearray#gen(0, 1.0, 1), '\d\.\d\+')
endfunction

function! s:suite.float_two() abort
  call s:assert.match(fakearray#gen(0, 1.0, 2), '\d\.\d\+, \d\.\d\+')
endfunction

function! s:suite.str_one() abort
  call s:assert.match(fakearray#gen(10, '\w', 1), "'\\w\\+'")
endfunction

function! s:suite.str_two() abort
  call s:assert.match(fakearray#gen(10, '\w', 2), "'\\w\\+', '\\w\\+'")
endfunction
