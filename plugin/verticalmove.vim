" Vim global plugin for moving cursor in vertical direction
" Last Change: 17-Feb-2014.
" Maintainer : Masaaki Nakamura <mckn@outlook.com>

" License    : NYSL
"              Japanese <http://www.kmonos.net/nysl/>
"              English (Unofficial) <http://www.kmonos.net/nysl/index.en.html>

if exists("g:loaded_verticalmove")
  finish
endif
let g:loaded_verticalmove = 1

""" keymappings
" vertical f
nnoremap <silent> <Plug>(verticalmove-f)  :<C-u>call verticalmove#f('n')<CR>
xnoremap <silent> <Plug>(verticalmove-f)  :<C-u>call verticalmove#f('x')<CR>
onoremap <silent> <Plug>(verticalmove-f)  :<C-u>call verticalmove#f('o')<CR>
inoremap <silent> <Plug>(verticalmove-f)  <C-r>=verticalmove#f('i')<CR>

" vertical t
nnoremap <silent> <Plug>(verticalmove-t)  :<C-u>call verticalmove#t('n')<CR>
xnoremap <silent> <Plug>(verticalmove-t)  :<C-u>call verticalmove#t('x')<CR>
onoremap <silent> <Plug>(verticalmove-t)  :<C-u>call verticalmove#t('o')<CR>
inoremap <silent> <Plug>(verticalmove-t)  <C-r>=verticalmove#t('i')<CR>

" vertical F
nnoremap <silent> <Plug>(verticalmove-F)  :<C-u>call verticalmove#F('n')<CR>
xnoremap <silent> <Plug>(verticalmove-F)  :<C-u>call verticalmove#F('x')<CR>
onoremap <silent> <Plug>(verticalmove-F)  :<C-u>call verticalmove#F('o')<CR>
inoremap <silent> <Plug>(verticalmove-F)  <C-r>=verticalmove#F('i')<CR>

" vertical T
nnoremap <silent> <Plug>(verticalmove-T)  :<C-u>call verticalmove#T('n')<CR>
xnoremap <silent> <Plug>(verticalmove-T)  :<C-u>call verticalmove#T('x')<CR>
onoremap <silent> <Plug>(verticalmove-T)  :<C-u>call verticalmove#T('o')<CR>
inoremap <silent> <Plug>(verticalmove-T)  <C-r>=verticalmove#T('i')<CR>

" vertical semicolon
nnoremap <silent> <Plug>(verticalmove-;)  :<C-u>call verticalmove#semicolon('n')<CR>
xnoremap <silent> <Plug>(verticalmove-;)  :<C-u>call verticalmove#semicolon('x')<CR>
onoremap <silent> <Plug>(verticalmove-;)  :<C-u>call verticalmove#semicolon('o')<CR>
inoremap <silent> <Plug>(verticalmove-;)  <C-r>=verticalmove#semicolon('i')<CR>

" vertical comma
nnoremap <silent> <Plug>(verticalmove-,)  :<C-u>call verticalmove#comma('n')<CR>
xnoremap <silent> <Plug>(verticalmove-,)  :<C-u>call verticalmove#comma('x')<CR>
onoremap <silent> <Plug>(verticalmove-,)  :<C-u>call verticalmove#comma('o')<CR>
inoremap <silent> <Plug>(verticalmove-,)  <C-r>=verticalmove#comma('i')<CR>

" vertical w
nnoremap <silent> <Plug>(verticalmove-w)  :<C-u>call verticalmove#w('n')<CR>
xnoremap <silent> <Plug>(verticalmove-w)  :<C-u>call verticalmove#w('x')<CR>
onoremap <silent> <Plug>(verticalmove-w)  :<C-u>call verticalmove#w('o')<CR>
inoremap <silent> <Plug>(verticalmove-w)  <C-r>=verticalmove#w('i')<CR>

" vertical b
nnoremap <silent> <Plug>(verticalmove-b)  :<C-u>call verticalmove#b('n')<CR>
xnoremap <silent> <Plug>(verticalmove-b)  :<C-u>call verticalmove#b('x')<CR>
onoremap <silent> <Plug>(verticalmove-b)  :<C-u>call verticalmove#b('o')<CR>
inoremap <silent> <Plug>(verticalmove-b)  <C-r>=verticalmove#b('i')<CR>

" vertical e
nnoremap <silent> <Plug>(verticalmove-e)  :<C-u>call verticalmove#e('n')<CR>
xnoremap <silent> <Plug>(verticalmove-e)  :<C-u>call verticalmove#e('x')<CR>
onoremap <silent> <Plug>(verticalmove-e)  :<C-u>call verticalmove#e('o')<CR>
inoremap <silent> <Plug>(verticalmove-e)  <C-r>=verticalmove#e('i')<CR>

" vertical ge
nnoremap <silent> <Plug>(verticalmove-ge) :<C-u>call verticalmove#ge('n')<CR>
xnoremap <silent> <Plug>(verticalmove-ge) :<C-u>call verticalmove#ge('x')<CR>
onoremap <silent> <Plug>(verticalmove-ge) :<C-u>call verticalmove#ge('o')<CR>
inoremap <silent> <Plug>(verticalmove-ge) <C-r>=verticalmove#ge('i')<CR>

""" default keymappings
" If g:verticalmove_no_default_key_mappings has been defined, then quit
" immediately.
if exists('g:verticalmove_no_default_key_mappings') | finish | endif

" vertical f
if !hasmapto('<Plug>(verticalmove-f)')
  nmap <unique> <M-f> <Plug>(verticalmove-f)
  xmap <unique> <M-f> <Plug>(verticalmove-f)
  omap <unique> <M-f> <Plug>(verticalmove-f)
  imap <unique> <M-f> <Plug>(verticalmove-f)
endif

" vertical t
if !hasmapto('<Plug>(verticalmove-t)')
  nmap <unique> <M-t> <Plug>(verticalmove-t)
  xmap <unique> <M-t> <Plug>(verticalmove-t)
  omap <unique> <M-t> <Plug>(verticalmove-t)
  imap <unique> <M-t> <Plug>(verticalmove-t)
endif

" vertical F
if !hasmapto('<Plug>(verticalmove-F)')
  nmap <unique> <M-F> <Plug>(verticalmove-F)
  xmap <unique> <M-F> <Plug>(verticalmove-F)
  omap <unique> <M-F> <Plug>(verticalmove-F)
  imap <unique> <M-F> <Plug>(verticalmove-F)
endif

" vertical T
if !hasmapto('<Plug>(verticalmove-T)')
  nmap <unique> <M-T> <Plug>(verticalmove-T)
  xmap <unique> <M-T> <Plug>(verticalmove-T)
  omap <unique> <M-T> <Plug>(verticalmove-T)
  imap <unique> <M-T> <Plug>(verticalmove-T)
endif

" vertical semicolon
if !hasmapto('<Plug>(verticalmove-;)')
  nmap <unique> <M-;> <Plug>(verticalmove-;)
  xmap <unique> <M-;> <Plug>(verticalmove-;)
  omap <unique> <M-;> <Plug>(verticalmove-;)
  imap <unique> <M-;> <Plug>(verticalmove-;)
endif

" vertical comma
if !hasmapto('<Plug>(verticalmove-,)')
  nmap <unique> <M-,> <Plug>(verticalmove-,)
  xmap <unique> <M-,> <Plug>(verticalmove-,)
  omap <unique> <M-,> <Plug>(verticalmove-,)
  imap <unique> <M-,> <Plug>(verticalmove-,)
endif

" vertical w
if !hasmapto('<Plug>(verticalmove-w)')
  nmap <unique> <M-w> <Plug>(verticalmove-w)
  xmap <unique> <M-w> <Plug>(verticalmove-w)
  omap <unique> <M-w> <Plug>(verticalmove-w)
  imap <unique> <M-w> <Plug>(verticalmove-w)
endif

" vertical b
if !hasmapto('<Plug>(verticalmove-b)')
  nmap <unique> <M-b> <Plug>(verticalmove-b)
  xmap <unique> <M-b> <Plug>(verticalmove-b)
  omap <unique> <M-b> <Plug>(verticalmove-b)
  imap <unique> <M-b> <Plug>(verticalmove-b)
endif

" vertical e
if !hasmapto('<Plug>(verticalmove-e)')
  nmap <unique> <M-e> <Plug>(verticalmove-e)
  xmap <unique> <M-e> <Plug>(verticalmove-e)
  omap <unique> <M-e> <Plug>(verticalmove-e)
  imap <unique> <M-e> <Plug>(verticalmove-e)
endif

" vertical ge
if !hasmapto('<Plug>(verticalmove-ge)')
  nmap <unique> <M-g>e <Plug>(verticalmove-ge)
  xmap <unique> <M-g>e <Plug>(verticalmove-ge)
  omap <unique> <M-g>e <Plug>(verticalmove-ge)
  imap <unique> <M-g>e <Plug>(verticalmove-ge)
  nmap <unique> <M-g><M-e> <Plug>(verticalmove-ge)
  xmap <unique> <M-g><M-e> <Plug>(verticalmove-ge)
  omap <unique> <M-g><M-e> <Plug>(verticalmove-ge)
  imap <unique> <M-g><M-e> <Plug>(verticalmove-ge)
endif
