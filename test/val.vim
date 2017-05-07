let s:suite = themis#suite('val')
let s:assert = themis#helper('assert')
call themis#helper('command').with(s:)

" Success
function! s:suite.__int__() abort
  let int = themis#suite('int')

  function! int.int_int() abort
    call s:assert.is_number(fakearray#val(0, 10))
  endfunction
endfunction

function! s:suite.__float__() abort
  let float = themis#suite('float')

  function! float.float_int() abort
    call s:assert.is_float(fakearray#val(0.0, 1))
  endfunction

  function! float.int_float() abort
    call s:assert.is_float(fakearray#val(0, 1.0))
  endfunction

  function! float.float_float() abort
    call s:assert.is_float(fakearray#val(0.0, 1.0))
  endfunction
endfunction

function! s:suite.__str__() abort
  let str = themis#suite('str')

  function! str.str_int() abort
    call s:assert.is_string(fakearray#val('\w', 1))
    call s:assert.match(fakearray#val('\w', 1), "^'\\w'$")
  endfunction

  function! str.str_str__fake_gen() abort
    call s:assert.is_string(fakearray#val('job', ''))
    call s:assert.match(fakearray#val('job', ''), "^'.\\+'$")
  endfunction
endfunction

" Invalid arguments
function! s:suite.__invalid__() abort
  let invalid = themis#suite('invalid argument')

  function! invalid.str_str__non_empty() abort
    Throws /fakearray#val: Invalid argument/ fakearray#val('job', 'abc')
  endfunction

  function! invalid.int_str() abort
    Throws /fakearray#val: Invalid argument/ fakearray#val(0, 'abc')
  endfunction

  function! invalid.float_str() abort
    Throws /fakearray#val: Invalid argument/ fakearray#val(0.0, 'abc')
  endfunction

  function! invalid.str_float() abort
    Throws /fakearray#val: Invalid argument/ fakearray#val('abc', 0.0)
  endfunction
endfunction
