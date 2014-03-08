" Vim global plugin for moving cursor in vertical direction
" Last Change: 08-Mar-2014.
" Maintainer : Masaaki Nakamura <mckn@outlook.com>

" License    : NYSL
"              Japanese <http://www.kmonos.net/nysl/>
"              English (Unofficial) <http://www.kmonos.net/nysl/index.en.html>

if exists("g:loaded_columnmove")
  finish
endif
let g:loaded_columnmove = 1

""" keymappings
" vertical f
nnoremap <silent> <Plug>(columnmove-f)  :<C-u>call columnmove#f('n')<CR>
xnoremap <silent> <Plug>(columnmove-f)  :<C-u>call columnmove#f('x')<CR>
onoremap <silent> <Plug>(columnmove-f)  :<C-u>call columnmove#f('o')<CR>
inoremap <silent> <Plug>(columnmove-f)  <C-r>=columnmove#f('i')<CR>

" vertical t
nnoremap <silent> <Plug>(columnmove-t)  :<C-u>call columnmove#t('n')<CR>
xnoremap <silent> <Plug>(columnmove-t)  :<C-u>call columnmove#t('x')<CR>
onoremap <silent> <Plug>(columnmove-t)  :<C-u>call columnmove#t('o')<CR>
inoremap <silent> <Plug>(columnmove-t)  <C-r>=columnmove#t('i')<CR>

" vertical F
nnoremap <silent> <Plug>(columnmove-F)  :<C-u>call columnmove#F('n')<CR>
xnoremap <silent> <Plug>(columnmove-F)  :<C-u>call columnmove#F('x')<CR>
onoremap <silent> <Plug>(columnmove-F)  :<C-u>call columnmove#F('o')<CR>
inoremap <silent> <Plug>(columnmove-F)  <C-r>=columnmove#F('i')<CR>

" vertical T
nnoremap <silent> <Plug>(columnmove-T)  :<C-u>call columnmove#T('n')<CR>
xnoremap <silent> <Plug>(columnmove-T)  :<C-u>call columnmove#T('x')<CR>
onoremap <silent> <Plug>(columnmove-T)  :<C-u>call columnmove#T('o')<CR>
inoremap <silent> <Plug>(columnmove-T)  <C-r>=columnmove#T('i')<CR>

" vertical semicolon
nnoremap <silent> <Plug>(columnmove-;)  :<C-u>call columnmove#semicolon('n')<CR>
xnoremap <silent> <Plug>(columnmove-;)  :<C-u>call columnmove#semicolon('x')<CR>
onoremap <silent> <Plug>(columnmove-;)  :<C-u>call columnmove#semicolon('o')<CR>
inoremap <silent> <Plug>(columnmove-;)  <C-r>=columnmove#semicolon('i')<CR>

" vertical comma
nnoremap <silent> <Plug>(columnmove-,)  :<C-u>call columnmove#comma('n')<CR>
xnoremap <silent> <Plug>(columnmove-,)  :<C-u>call columnmove#comma('x')<CR>
onoremap <silent> <Plug>(columnmove-,)  :<C-u>call columnmove#comma('o')<CR>
inoremap <silent> <Plug>(columnmove-,)  <C-r>=columnmove#comma('i')<CR>

" vertical w
nnoremap <silent> <Plug>(columnmove-w)  :<C-u>call columnmove#w('n')<CR>
xnoremap <silent> <Plug>(columnmove-w)  :<C-u>call columnmove#w('x')<CR>
onoremap <silent> <Plug>(columnmove-w)  :<C-u>call columnmove#w('o')<CR>
inoremap <silent> <Plug>(columnmove-w)  <C-r>=columnmove#w('i')<CR>

" vertical b
nnoremap <silent> <Plug>(columnmove-b)  :<C-u>call columnmove#b('n')<CR>
xnoremap <silent> <Plug>(columnmove-b)  :<C-u>call columnmove#b('x')<CR>
onoremap <silent> <Plug>(columnmove-b)  :<C-u>call columnmove#b('o')<CR>
inoremap <silent> <Plug>(columnmove-b)  <C-r>=columnmove#b('i')<CR>

" vertical e
nnoremap <silent> <Plug>(columnmove-e)  :<C-u>call columnmove#e('n')<CR>
xnoremap <silent> <Plug>(columnmove-e)  :<C-u>call columnmove#e('x')<CR>
onoremap <silent> <Plug>(columnmove-e)  :<C-u>call columnmove#e('o')<CR>
inoremap <silent> <Plug>(columnmove-e)  <C-r>=columnmove#e('i')<CR>

" vertical ge
nnoremap <silent> <Plug>(columnmove-ge) :<C-u>call columnmove#ge('n')<CR>
xnoremap <silent> <Plug>(columnmove-ge) :<C-u>call columnmove#ge('x')<CR>
onoremap <silent> <Plug>(columnmove-ge) :<C-u>call columnmove#ge('o')<CR>
inoremap <silent> <Plug>(columnmove-ge) <C-r>=columnmove#ge('i')<CR>

""" default keymappings
" If g:columnmove_no_default_key_mappings has been defined, then quit
" immediately.
if exists('g:columnmove_no_default_key_mappings') | finish | endif

" vertical f
if !hasmapto('<Plug>(columnmove-f)')
  nmap <unique> <M-f> <Plug>(columnmove-f)
  xmap <unique> <M-f> <Plug>(columnmove-f)
  omap <unique> <M-f> <Plug>(columnmove-f)
  imap <unique> <M-f> <Plug>(columnmove-f)
endif

" vertical t
if !hasmapto('<Plug>(columnmove-t)')
  nmap <unique> <M-t> <Plug>(columnmove-t)
  xmap <unique> <M-t> <Plug>(columnmove-t)
  omap <unique> <M-t> <Plug>(columnmove-t)
  imap <unique> <M-t> <Plug>(columnmove-t)
endif

" vertical F
if !hasmapto('<Plug>(columnmove-F)')
  nmap <unique> <M-F> <Plug>(columnmove-F)
  xmap <unique> <M-F> <Plug>(columnmove-F)
  omap <unique> <M-F> <Plug>(columnmove-F)
  imap <unique> <M-F> <Plug>(columnmove-F)
endif

" vertical T
if !hasmapto('<Plug>(columnmove-T)')
  nmap <unique> <M-T> <Plug>(columnmove-T)
  xmap <unique> <M-T> <Plug>(columnmove-T)
  omap <unique> <M-T> <Plug>(columnmove-T)
  imap <unique> <M-T> <Plug>(columnmove-T)
endif

" vertical semicolon
if !hasmapto('<Plug>(columnmove-;)')
  nmap <unique> <M-;> <Plug>(columnmove-;)
  xmap <unique> <M-;> <Plug>(columnmove-;)
  omap <unique> <M-;> <Plug>(columnmove-;)
  imap <unique> <M-;> <Plug>(columnmove-;)
endif

" vertical comma
if !hasmapto('<Plug>(columnmove-,)')
  nmap <unique> <M-,> <Plug>(columnmove-,)
  xmap <unique> <M-,> <Plug>(columnmove-,)
  omap <unique> <M-,> <Plug>(columnmove-,)
  imap <unique> <M-,> <Plug>(columnmove-,)
endif

" vertical w
if !hasmapto('<Plug>(columnmove-w)')
  nmap <unique> <M-w> <Plug>(columnmove-w)
  xmap <unique> <M-w> <Plug>(columnmove-w)
  omap <unique> <M-w> <Plug>(columnmove-w)
  imap <unique> <M-w> <Plug>(columnmove-w)
endif

" vertical b
if !hasmapto('<Plug>(columnmove-b)')
  nmap <unique> <M-b> <Plug>(columnmove-b)
  xmap <unique> <M-b> <Plug>(columnmove-b)
  omap <unique> <M-b> <Plug>(columnmove-b)
  imap <unique> <M-b> <Plug>(columnmove-b)
endif

" vertical e
if !hasmapto('<Plug>(columnmove-e)')
  nmap <unique> <M-e> <Plug>(columnmove-e)
  xmap <unique> <M-e> <Plug>(columnmove-e)
  omap <unique> <M-e> <Plug>(columnmove-e)
  imap <unique> <M-e> <Plug>(columnmove-e)
endif

" vertical ge
if !hasmapto('<Plug>(columnmove-ge)')
  nmap <unique> <M-g>e <Plug>(columnmove-ge)
  xmap <unique> <M-g>e <Plug>(columnmove-ge)
  omap <unique> <M-g>e <Plug>(columnmove-ge)
  imap <unique> <M-g>e <Plug>(columnmove-ge)
  nmap <unique> <M-g><M-e> <Plug>(columnmove-ge)
  xmap <unique> <M-g><M-e> <Plug>(columnmove-ge)
  omap <unique> <M-g><M-e> <Plug>(columnmove-ge)
  imap <unique> <M-g><M-e> <Plug>(columnmove-ge)
endif
