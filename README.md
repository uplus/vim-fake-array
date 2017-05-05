# vim-fakearray
[![Build Status](https://travis-ci.org/uplus/vim-fakearray.svg?branch=master)](https://travis-ci.org/uplus/vim-fakearray)  
Vim plugin to easy input fake array.  


## Requirements
* [vim-fake](https://github.com/tkhren/vim-fake)  

## Usage

```vim
imap <F3> <Plug>(fakearray)
```

[![asciicast](https://asciinema.org/a/119112.png)](https://asciinema.org/a/119112)  


## Configure

```vim
let g:fakearray#prompt_start = 0
let g:fakearray#prompt_last = 9999
let g:fakearray#prompt_message = '> '
let g:fakearray#separator = ', '
let g:fakearray_no_default_key_mappings = 1
```
