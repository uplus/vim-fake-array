# vim-fakearray
[![Build Status](https://travis-ci.org/uplus/vim-fakearray.svg?branch=master)](https://travis-ci.org/uplus/vim-fakearray)  
Vim plugin to easy input fake array.  


## Requirements
* [vim-fake](https://github.com/tkhren/vim-fake)  

## Usage

```vim
imap <F3> <Plug>(fakearray)

" My mapping is <c-/>a.
" If you want to use <c-/>, type <c-v><c-/>
imap <1f>a <Plug>(fakearray)
```

[![asciicast](https://asciinema.org/a/02c6zs3bpzr4o4lvzfwv7u24m.png)](https://asciinema.org/a/02c6zs3bpzr4o4lvzfwv7u24m)  


## Configure

```vim
let g:fakearray#prompt_first= 0
let g:fakearray#prompt_second= 100
let g:fakearray#prompt_message = '> '
let g:fakearray#separator = ', '
let g:fakearray_no_default_key_mappings = 1
```
