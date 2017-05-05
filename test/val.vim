let s:suite = themis#suite('val')
let s:assert = themis#helper('assert')
call themis#helper('command').with(s:)

" Success
function! s:suite.int_int() abort
  call s:assert.is_number(fakearray#val(0, 10))
endfunction

function! s:suite.float_int() abort
  call s:assert.is_float(fakearray#val(0.0, 1))
endfunction

function! s:suite.int_float() abort
  call s:assert.is_float(fakearray#val(0, 1.0))
endfunction

function! s:suite.int_str() abort
  call s:assert.is_string(fakearray#val(0, '\w'))
endfunction

function! s:suite.str_int_fake_gen() abort
  call s:assert.is_string(fakearray#val('job', 0))
endfunction

" Invalid arguments
function! s:suite.__invalid__() abort
  let invalid = themis#suite('invalid')

  function! invalid.float_str() abort
    Throws /fakearray: Invalid arguments/ fakearray#val(0.0, 'abc')
  endfunction
endfunction
