let s:save_cpo = &cpo
set cpo&vim

let g:fakearray#prompt_start = get(g:, 'fakearray#prompt_start', 0)
let g:fakearray#prompt_last = get(g:, 'fakearray#prompt_last', 100)
let g:fakearray#prompt_message = get(g:, 'fakearray#prompt_message', 'Fake Array> ')
let g:fakearray#separator = get(g:, 'fakearray#separator', ', ')

let s:type_int = type(0)
let s:type_float = type(0.0)
let s:type_string = type('')

function! s:error(msg) abort "{{{
  echohl ErrorMsg
  echomsg '[fakearray] Error:' a:msg
  echohl None
endfunction "}}}

function! s:is_num(type_val) abort "{{{
  return a:type_val == s:type_int || a:type_val == s:type_float
endfunction "}}}

function! fakearray#val(first, second) abort "{{{
  let type_first = type(a:first)
  let type_second = type(a:second)

  if type_first == s:type_int && type_second == s:type_int
    return fake#int(a:first, a:second)
  elseif type_first == s:type_int && type_second == s:type_string
    return "'" . fake#chars(fake#int(1, a:first), a:second) . "'"
  elseif type_first == s:type_string
    return "'" . fake#gen(a:first) . "'"
  elseif s:is_num(type_first) && s:is_num(type_second)
    return fake#float(a:first, a:second)
  endif

  call s:error(printf('fakearray#val: Invalid arguments: %s, %s', string(a:first), string(a:second)))
  throw 'fakearray: Invalid arguments'
endfunction "}}}

function! fakearray#gen(first, second, num) abort "{{{
  try
    return join(map(range(a:num), 'fakearray#val(a:first, a:second)'),
      \ get(b:, 'fakearray_separator', g:fakearray#separator))
  catch /fakearray:/
    return ''
  endtry
endfunction "}}}

function! fakearray#prompt() abort "{{{
  try
    let args = map(split(input(g:fakearray#prompt_message), ' '), 'eval(v:val)')
  catch /E121:/
    call s:error('Invalid input: '. v:exception)
    return ''
  endtry

  let len = len(args)
  if len == 1
    return fakearray#gen(g:fakearray#prompt_start, g:fakearray#prompt_last, args[0])
  elseif len == 2
    call s:error('Enough input: Need 1 or 3')
  elseif len == 3
    return fakearray#gen(args[0], args[1], args[2])
  endif
  return ''
endfunction "}}}

let &cpo = s:save_cpo
unlet s:save_cpo

" vim: et ts=2 sts=2 sw=2 tw=0 ff=unix fdm=marker:
