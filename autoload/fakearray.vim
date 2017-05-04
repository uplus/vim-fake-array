let s:save_cpo = &cpo
set cpo&vim

let g:fakearray#prompt_start = get(g:, 'fakearray#prompt_start', 0)
let g:fakearray#prompt_last = get(g:, 'fakearray#prompt_last', 100)
let g:fakearray#prompt_message = get(g:, 'fakearray#prompt_message', 'Fake Array> ')

let s:type_int = type(0)
let s:type_float = type(0.0)
let s:type_char = type('')

function! fakearray#val(first, second) abort "{{{
  if type(a:first) == s:type_float || type(a:second) == s:type_float
    return fake#float(a:first, a:second)
  elseif type(a:second) == s:type_char && type(a:first) == s:type_int
    return "'" . fake#chars(fake#int(1, a:first), a:second) . "'"
  else
    return fake#int(a:first, a:second)
  endif
endfunction "}}}

function! fakearray#gen(first, second, num) abort "{{{
  return join(map(range(a:num), 'fakearray#val(a:first, a:second)'), ', ')
endfunction "}}}

function! fakearray#prompt() abort "{{{
  let args = map(split(input(g:fakearray#prompt_message)), 'eval(v:val)')
  let len = len(args)
  if len == 1
    return fakearray#gen(g:fakearray#prompt_start, g:fakearray#prompt_last, args[0])
  elseif len == 3
    return fakearray#gen(args[0], args[1], args[2])
  endif
endfunction "}}}

let &cpo = s:save_cpo
unlet s:save_cpo

" vim: et ts=2 sts=2 sw=2 tw=0 ff=unix fdm=marker:
