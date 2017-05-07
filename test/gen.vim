let s:suite = themis#suite('gen')
let s:assert = themis#helper('assert')

function! s:suite.before_each() abort
  %delete
endfunction

function! s:suite.is_string() abort
  call s:assert.is_string(fakearray#gen(0, 10, 1))
endfunction

function! s:suite.zero() abort
  call s:assert.equal('', fakearray#gen(0, 0, 1))
  call s:assert.equal('', fakearray#gen(0, 0, 1.0))
  call s:assert.equal('', fakearray#gen(0, '\w', 1))
  call s:assert.equal('', fakearray#gen(0, 'job', ''))
endfunction

function! s:suite.__int__() abort
  let int = themis#suite('int')

  function! int.one() abort
    call s:assert.match(fakearray#gen(1, 0, 10), '^\d\+$')
  endfunction

  function! int.two() abort
    call s:assert.match(fakearray#gen(2, 0, 10), '^\d\+, \d\+$')
  endfunction
endfunction

function! s:suite.__float__() abort
  let float = themis#suite('float')

  function! float.one() abort
    call s:assert.match(fakearray#gen(1, 0, 1.0), '^\d\.\d\+$')
  endfunction

  function! float.two() abort
    call s:assert.match(fakearray#gen(2, 0, 1.0), '^\d\.\d\+, \d\.\d\+$')
  endfunction
endfunction

function! s:suite.__str__() abort
  let str = themis#suite('str')

  function! str.one() abort
    call s:assert.match(fakearray#gen(1, '\w', 10), "^'\\w\\+'$")
  endfunction

  function! str.two() abort
    call s:assert.match(fakearray#gen(2, '\w', 10), "^'\\w\\+', '\\w\\+'$")
  endfunction
endfunction

function! s:suite.__fake_gen__() abort
  let fake_gen = themis#suite('fake_gen')

  function! fake_gen.fake_gen_one() abort
    call s:assert.match(fakearray#gen(1, 'word', ''), "^'\\w\\+'$")
  endfunction

  function! fake_gen.fake_gen_two() abort
    call s:assert.match(fakearray#gen(2, 'word', ''), "^'\\w\\+', '\\w\\+'$")
  endfunction
endfunction
