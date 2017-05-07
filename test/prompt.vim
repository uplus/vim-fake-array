let s:suite = themis#suite('prompt')
let s:assert = themis#helper('assert')
call themis#helper('command').with(s:)

function! Prompt(input) abort
  exec 'normal' "i\<Plug>(fakearray)" . a:input "\<CR>"
endfunction

function! s:suite.before_each() abort
  %delete
endfunction

function! s:suite.__one__() abort
  let one = themis#suite('one')

  function! one.num() abort
    call Prompt('2')
    call s:assert.match(getline(1), '^\d\+, \d\+$')
  endfunction

  function! one.change_variables() abort
    let save_first = g:fakearray#prompt_first
    let save_second = g:fakearray#prompt_second
    let g:fakearray#prompt_first = 'word'
    let g:fakearray#prompt_second = ''

    try
      call Prompt('2')
      call s:assert.match(getline(1), "^'\\w\\+', '\\w\\+'$")
    finally
      let g:fakearray#prompt_first = save_first
      let g:fakearray#prompt_second = save_second
    endtry
  endfunction
endfunction

function! s:suite.__two__() abort
  let two = themis#suite('two')

  function! two.fake_gen_word() abort
    call Prompt("2 'word'")
    call s:assert.match(getline(1), "^'\\w\\+', '\\w\\+'$")
  endfunction
endfunction

function! s:suite.__three__() abort
  let three = themis#suite('three')

  function! three.nums() abort
    call Prompt('2 0 10')
    call s:assert.match(getline(1), '^\d\+, \d\+$')
  endfunction
endfunction

" Invalid input
function! s:suite.__invalid__() abort
  let invalid = themis#suite('invalid argument')

  function! invalid.undefined_variable() abort
    Throws /fakearray#prompt: Invalid input/ Prompt('a b c')
  endfunction
endfunction
