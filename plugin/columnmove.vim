" Vim global plugin for moving cursor in vertical direction
" Last Change: 22-Jul-2014.
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
inoremap <silent>      <Plug>(columnmove-f)            <C-r>=columnmove#f('i')<CR>
nnoremap <silent>      <Plug>(columnmove-f)       :<C-u>call columnmove#f('n')<CR>
xnoremap <silent>      <Plug>(columnmove-f)       :<C-u>call columnmove#f('x')<CR>
onoremap <silent>      <Plug>(columnmove-f)      V:<C-u>call columnmove#f('o')<CR>
onoremap <silent>     v<Plug>(columnmove-f)       :<C-u>call columnmove#f('o')<CR>
onoremap <silent>     V<Plug>(columnmove-f)      V:<C-u>call columnmove#f('o')<CR>
onoremap <silent> <C-v><Plug>(columnmove-f)  <C-v>:<C-u>call columnmove#f('o')<CR>

" vertical t
inoremap <silent>      <Plug>(columnmove-t)            <C-r>=columnmove#t('i')<CR>
nnoremap <silent>      <Plug>(columnmove-t)       :<C-u>call columnmove#t('n')<CR>
xnoremap <silent>      <Plug>(columnmove-t)       :<C-u>call columnmove#t('x')<CR>
onoremap <silent>      <Plug>(columnmove-t)      V:<C-u>call columnmove#t('o')<CR>
onoremap <silent>     v<Plug>(columnmove-t)       :<C-u>call columnmove#t('o')<CR>
onoremap <silent>     V<Plug>(columnmove-t)      V:<C-u>call columnmove#t('o')<CR>
onoremap <silent> <C-v><Plug>(columnmove-t)  <C-v>:<C-u>call columnmove#t('o')<CR>

" vertical F
inoremap <silent>      <Plug>(columnmove-F)            <C-r>=columnmove#F('i')<CR>
nnoremap <silent>      <Plug>(columnmove-F)       :<C-u>call columnmove#F('n')<CR>
xnoremap <silent>      <Plug>(columnmove-F)       :<C-u>call columnmove#F('x')<CR>
onoremap <silent>      <Plug>(columnmove-F)      V:<C-u>call columnmove#F('o')<CR>
onoremap <silent>     v<Plug>(columnmove-F)       :<C-u>call columnmove#F('o')<CR>
onoremap <silent>     V<Plug>(columnmove-F)      V:<C-u>call columnmove#F('o')<CR>
onoremap <silent> <C-v><Plug>(columnmove-F)  <C-v>:<C-u>call columnmove#F('o')<CR>

" vertical T
inoremap <silent>      <Plug>(columnmove-T)            <C-r>=columnmove#T('i')<CR>
nnoremap <silent>      <Plug>(columnmove-T)       :<C-u>call columnmove#T('n')<CR>
xnoremap <silent>      <Plug>(columnmove-T)       :<C-u>call columnmove#T('x')<CR>
onoremap <silent>      <Plug>(columnmove-T)      V:<C-u>call columnmove#T('o')<CR>
onoremap <silent>     v<Plug>(columnmove-T)       :<C-u>call columnmove#T('o')<CR>
onoremap <silent>     V<Plug>(columnmove-T)      V:<C-u>call columnmove#T('o')<CR>
onoremap <silent> <C-v><Plug>(columnmove-T)  <C-v>:<C-u>call columnmove#T('o')<CR>

" vertical semicolon
inoremap <silent>      <Plug>(columnmove-;)            <C-r>=columnmove#semicolon('i')<CR>
nnoremap <silent>      <Plug>(columnmove-;)       :<C-u>call columnmove#semicolon('n')<CR>
xnoremap <silent>      <Plug>(columnmove-;)       :<C-u>call columnmove#semicolon('x')<CR>
onoremap <silent>      <Plug>(columnmove-;)      V:<C-u>call columnmove#semicolon('o')<CR>
onoremap <silent>     v<Plug>(columnmove-;)       :<C-u>call columnmove#semicolon('o')<CR>
onoremap <silent>     V<Plug>(columnmove-;)      V:<C-u>call columnmove#semicolon('o')<CR>
onoremap <silent> <C-v><Plug>(columnmove-;)  <C-v>:<C-u>call columnmove#semicolon('o')<CR>

" vertical comma
inoremap <silent>      <Plug>(columnmove-,)            <C-r>=columnmove#comma('i')<CR>
nnoremap <silent>      <Plug>(columnmove-,)       :<C-u>call columnmove#comma('n')<CR>
xnoremap <silent>      <Plug>(columnmove-,)       :<C-u>call columnmove#comma('x')<CR>
onoremap <silent>      <Plug>(columnmove-,)      V:<C-u>call columnmove#comma('o')<CR>
onoremap <silent>     v<Plug>(columnmove-,)       :<C-u>call columnmove#comma('o')<CR>
onoremap <silent>     V<Plug>(columnmove-,)      V:<C-u>call columnmove#comma('o')<CR>
onoremap <silent> <C-v><Plug>(columnmove-,)  <C-v>:<C-u>call columnmove#comma('o')<CR>

" vertical w
inoremap <silent>      <Plug>(columnmove-w)            <C-r>=columnmove#w('i')<CR>
nnoremap <silent>      <Plug>(columnmove-w)       :<C-u>call columnmove#w('n')<CR>
xnoremap <silent>      <Plug>(columnmove-w)       :<C-u>call columnmove#w('x')<CR>
onoremap <silent>      <Plug>(columnmove-w)      V:<C-u>call columnmove#w('o')<CR>
onoremap <silent>     v<Plug>(columnmove-w)       :<C-u>call columnmove#w('o')<CR>
onoremap <silent>     V<Plug>(columnmove-w)      V:<C-u>call columnmove#w('o')<CR>
onoremap <silent> <C-v><Plug>(columnmove-w)  <C-v>:<C-u>call columnmove#w('o')<CR>

" vertical b
inoremap <silent>      <Plug>(columnmove-b)            <C-r>=columnmove#b('i')<CR>
nnoremap <silent>      <Plug>(columnmove-b)       :<C-u>call columnmove#b('n')<CR>
xnoremap <silent>      <Plug>(columnmove-b)       :<C-u>call columnmove#b('x')<CR>
onoremap <silent>      <Plug>(columnmove-b)      V:<C-u>call columnmove#b('o')<CR>
onoremap <silent>     v<Plug>(columnmove-b)       :<C-u>call columnmove#b('o')<CR>
onoremap <silent>     V<Plug>(columnmove-b)      V:<C-u>call columnmove#b('o')<CR>
onoremap <silent> <C-v><Plug>(columnmove-b)  <C-v>:<C-u>call columnmove#b('o')<CR>

" vertical e
inoremap <silent>      <Plug>(columnmove-e)            <C-r>=columnmove#e('i')<CR>
nnoremap <silent>      <Plug>(columnmove-e)       :<C-u>call columnmove#e('n')<CR>
xnoremap <silent>      <Plug>(columnmove-e)       :<C-u>call columnmove#e('x')<CR>
onoremap <silent>      <Plug>(columnmove-e)      V:<C-u>call columnmove#e('o')<CR>
onoremap <silent>     v<Plug>(columnmove-e)       :<C-u>call columnmove#e('o')<CR>
onoremap <silent>     V<Plug>(columnmove-e)      V:<C-u>call columnmove#e('o')<CR>
onoremap <silent> <C-v><Plug>(columnmove-e)  <C-v>:<C-u>call columnmove#e('o')<CR>

" vertical ge
inoremap <silent>      <Plug>(columnmove-ge)           <C-r>=columnmove#ge('i')<CR>
nnoremap <silent>      <Plug>(columnmove-ge)      :<C-u>call columnmove#ge('n')<CR>
xnoremap <silent>      <Plug>(columnmove-ge)      :<C-u>call columnmove#ge('x')<CR>
onoremap <silent>      <Plug>(columnmove-ge)     V:<C-u>call columnmove#ge('o')<CR>
onoremap <silent>     v<Plug>(columnmove-ge)      :<C-u>call columnmove#ge('o')<CR>
onoremap <silent>     V<Plug>(columnmove-ge)     V:<C-u>call columnmove#ge('o')<CR>
onoremap <silent> <C-v><Plug>(columnmove-ge) <C-v>:<C-u>call columnmove#ge('o')<CR>

" vertical W
inoremap <silent>      <Plug>(columnmove-W)            <C-r>=columnmove#W('i')<CR>
nnoremap <silent>      <Plug>(columnmove-W)       :<C-u>call columnmove#W('n')<CR>
xnoremap <silent>      <Plug>(columnmove-W)       :<C-u>call columnmove#W('x')<CR>
onoremap <silent>      <Plug>(columnmove-W)      V:<C-u>call columnmove#W('o')<CR>
onoremap <silent>     v<Plug>(columnmove-W)       :<C-u>call columnmove#W('o')<CR>
onoremap <silent>     V<Plug>(columnmove-W)      V:<C-u>call columnmove#W('o')<CR>
onoremap <silent> <C-v><Plug>(columnmove-W)  <C-v>:<C-u>call columnmove#W('o')<CR>

" vertical B
inoremap <silent>      <Plug>(columnmove-B)            <C-r>=columnmove#B('i')<CR>
nnoremap <silent>      <Plug>(columnmove-B)       :<C-u>call columnmove#B('n')<CR>
xnoremap <silent>      <Plug>(columnmove-B)       :<C-u>call columnmove#B('x')<CR>
onoremap <silent>      <Plug>(columnmove-B)      V:<C-u>call columnmove#B('o')<CR>
onoremap <silent>     v<Plug>(columnmove-B)       :<C-u>call columnmove#B('o')<CR>
onoremap <silent>     V<Plug>(columnmove-B)      V:<C-u>call columnmove#B('o')<CR>
onoremap <silent> <C-v><Plug>(columnmove-B)  <C-v>:<C-u>call columnmove#B('o')<CR>

" vertical E
inoremap <silent>      <Plug>(columnmove-E)            <C-r>=columnmove#E('i')<CR>
nnoremap <silent>      <Plug>(columnmove-E)       :<C-u>call columnmove#E('n')<CR>
xnoremap <silent>      <Plug>(columnmove-E)       :<C-u>call columnmove#E('x')<CR>
onoremap <silent>      <Plug>(columnmove-E)      V:<C-u>call columnmove#E('o')<CR>
onoremap <silent>     v<Plug>(columnmove-E)       :<C-u>call columnmove#E('o')<CR>
onoremap <silent>     V<Plug>(columnmove-E)      V:<C-u>call columnmove#E('o')<CR>
onoremap <silent> <C-v><Plug>(columnmove-E)  <C-v>:<C-u>call columnmove#E('o')<CR>

" vertical gE
inoremap <silent>      <Plug>(columnmove-gE)           <C-r>=columnmove#gE('i')<CR>
nnoremap <silent>      <Plug>(columnmove-gE)      :<C-u>call columnmove#gE('n')<CR>
xnoremap <silent>      <Plug>(columnmove-gE)      :<C-u>call columnmove#gE('x')<CR>
onoremap <silent>      <Plug>(columnmove-gE)     V:<C-u>call columnmove#gE('o')<CR>
onoremap <silent>     v<Plug>(columnmove-gE)      :<C-u>call columnmove#gE('o')<CR>
onoremap <silent>     V<Plug>(columnmove-gE)     V:<C-u>call columnmove#gE('o')<CR>
onoremap <silent> <C-v><Plug>(columnmove-gE) <C-v>:<C-u>call columnmove#gE('o')<CR>

""" default keymappings
" If g:columnmove_no_default_key_mappings has been defined, then quit
" immediately.
if exists('g:columnmove_no_default_key_mappings') | finish | endif

" vertical f
if !hasmapto('<Plug>(columnmove-f)')
  imap <unique>      <M-f>      <Plug>(columnmove-f)
  nmap <unique>      <M-f>      <Plug>(columnmove-f)
  xmap <unique>      <M-f>      <Plug>(columnmove-f)
  omap <unique>      <M-f>      <Plug>(columnmove-f)
  omap <unique>     v<M-f>     v<Plug>(columnmove-f)
  omap <unique>     V<M-f>     V<Plug>(columnmove-f)
  omap <unique> <C-v><M-f> <C-v><Plug>(columnmove-f)
endif

" vertical t
if !hasmapto('<Plug>(columnmove-t)')
  imap <unique>      <M-t>      <Plug>(columnmove-t)
  nmap <unique>      <M-t>      <Plug>(columnmove-t)
  xmap <unique>      <M-t>      <Plug>(columnmove-t)
  omap <unique>      <M-t>      <Plug>(columnmove-t)
  omap <unique>     v<M-t>     v<Plug>(columnmove-t)
  omap <unique>     V<M-t>     V<Plug>(columnmove-t)
  omap <unique> <C-v><M-t> <C-v><Plug>(columnmove-t)
endif

" vertical F
if !hasmapto('<Plug>(columnmove-F)')
  imap <unique>      <M-F>      <Plug>(columnmove-F)
  nmap <unique>      <M-F>      <Plug>(columnmove-F)
  xmap <unique>      <M-F>      <Plug>(columnmove-F)
  omap <unique>      <M-F>      <Plug>(columnmove-F)
  omap <unique>     v<M-F>     v<Plug>(columnmove-F)
  omap <unique>     V<M-F>     V<Plug>(columnmove-F)
  omap <unique> <C-v><M-F> <C-v><Plug>(columnmove-F)
endif

" vertical T
if !hasmapto('<Plug>(columnmove-T)')
  imap <unique>      <M-T>      <Plug>(columnmove-T)
  nmap <unique>      <M-T>      <Plug>(columnmove-T)
  xmap <unique>      <M-T>      <Plug>(columnmove-T)
  omap <unique>      <M-T>      <Plug>(columnmove-T)
  omap <unique>     v<M-T>     v<Plug>(columnmove-T)
  omap <unique>     V<M-T>     V<Plug>(columnmove-T)
  omap <unique> <C-v><M-T> <C-v><Plug>(columnmove-T)
endif

" vertical semicolon
if !hasmapto('<Plug>(columnmove-;)')
  imap <unique>      <M-;>      <Plug>(columnmove-;)
  nmap <unique>      <M-;>      <Plug>(columnmove-;)
  xmap <unique>      <M-;>      <Plug>(columnmove-;)
  omap <unique>      <M-;>      <Plug>(columnmove-;)
  omap <unique>     v<M-;>     v<Plug>(columnmove-;)
  omap <unique>     V<M-;>     V<Plug>(columnmove-;)
  omap <unique> <C-v><M-;> <C-v><Plug>(columnmove-;)
endif

" vertical comma
if !hasmapto('<Plug>(columnmove-,)')
  imap <unique>      <M-,>      <Plug>(columnmove-,)
  nmap <unique>      <M-,>      <Plug>(columnmove-,)
  xmap <unique>      <M-,>      <Plug>(columnmove-,)
  omap <unique>      <M-,>      <Plug>(columnmove-,)
  omap <unique>     v<M-,>     v<Plug>(columnmove-,)
  omap <unique>     V<M-,>     V<Plug>(columnmove-,)
  omap <unique> <C-v><M-,> <C-v><Plug>(columnmove-,)
endif

" vertical w
if !hasmapto('<Plug>(columnmove-w)')
  imap <unique>      <M-w>      <Plug>(columnmove-w)
  nmap <unique>      <M-w>      <Plug>(columnmove-w)
  xmap <unique>      <M-w>      <Plug>(columnmove-w)
  omap <unique>      <M-w>      <Plug>(columnmove-w)
  omap <unique>     v<M-w>     v<Plug>(columnmove-w)
  omap <unique>     V<M-w>     V<Plug>(columnmove-w)
  omap <unique> <C-v><M-w> <C-v><Plug>(columnmove-w)
endif

" vertical b
if !hasmapto('<Plug>(columnmove-b)')
  imap <unique>      <M-b>      <Plug>(columnmove-b)
  nmap <unique>      <M-b>      <Plug>(columnmove-b)
  xmap <unique>      <M-b>      <Plug>(columnmove-b)
  omap <unique>      <M-b>      <Plug>(columnmove-b)
  omap <unique>     v<M-b>     v<Plug>(columnmove-b)
  omap <unique>     V<M-b>     V<Plug>(columnmove-b)
  omap <unique> <C-v><M-b> <C-v><Plug>(columnmove-b)
endif

" vertical e
if !hasmapto('<Plug>(columnmove-e)')
  imap <unique>      <M-e>      <Plug>(columnmove-e)
  nmap <unique>      <M-e>      <Plug>(columnmove-e)
  xmap <unique>      <M-e>      <Plug>(columnmove-e)
  omap <unique>      <M-e>      <Plug>(columnmove-e)
  omap <unique>     v<M-e>     v<Plug>(columnmove-e)
  omap <unique>     V<M-e>     V<Plug>(columnmove-e)
  omap <unique> <C-v><M-e> <C-v><Plug>(columnmove-e)
endif

" vertical ge
if !hasmapto('<Plug>(columnmove-ge)')
  imap <unique>      <M-g>e      <Plug>(columnmove-ge)
  nmap <unique>      <M-g>e      <Plug>(columnmove-ge)
  xmap <unique>      <M-g>e      <Plug>(columnmove-ge)
  omap <unique>      <M-g>e      <Plug>(columnmove-ge)
  omap <unique>     v<M-g>e     v<Plug>(columnmove-ge)
  omap <unique>     V<M-g>e     V<Plug>(columnmove-ge)
  omap <unique> <C-v><M-g>e <C-v><Plug>(columnmove-ge)

  imap <unique>      <M-g><M-e>      <Plug>(columnmove-ge)
  nmap <unique>      <M-g><M-e>      <Plug>(columnmove-ge)
  xmap <unique>      <M-g><M-e>      <Plug>(columnmove-ge)
  omap <unique>      <M-g><M-e>      <Plug>(columnmove-ge)
  omap <unique>     v<M-g><M-e>     v<Plug>(columnmove-ge)
  omap <unique>     V<M-g><M-e>     V<Plug>(columnmove-ge)
  omap <unique> <C-v><M-g><M-e> <C-v><Plug>(columnmove-ge)
endif

" vertical W
if !hasmapto('<Plug>(columnmove-W)')
  imap <unique>      <M-W>      <Plug>(columnmove-W)
  nmap <unique>      <M-W>      <Plug>(columnmove-W)
  xmap <unique>      <M-W>      <Plug>(columnmove-W)
  omap <unique>      <M-W>      <Plug>(columnmove-W)
  omap <unique>     v<M-W>     v<Plug>(columnmove-W)
  omap <unique>     V<M-W>     V<Plug>(columnmove-W)
  omap <unique> <C-v><M-W> <C-v><Plug>(columnmove-W)
endif

" vertical B
if !hasmapto('<Plug>(columnmove-B)')
  imap <unique>      <M-B>      <Plug>(columnmove-B)
  nmap <unique>      <M-B>      <Plug>(columnmove-B)
  xmap <unique>      <M-B>      <Plug>(columnmove-B)
  omap <unique>      <M-B>      <Plug>(columnmove-B)
  omap <unique>     v<M-B>     v<Plug>(columnmove-B)
  omap <unique>     V<M-B>     V<Plug>(columnmove-B)
  omap <unique> <C-v><M-B> <C-v><Plug>(columnmove-B)
endif

" vertical E
if !hasmapto('<Plug>(columnmove-E)')
  imap <unique>      <M-E>      <Plug>(columnmove-E)
  nmap <unique>      <M-E>      <Plug>(columnmove-E)
  xmap <unique>      <M-E>      <Plug>(columnmove-E)
  omap <unique>      <M-E>      <Plug>(columnmove-E)
  omap <unique>     v<M-E>     v<Plug>(columnmove-E)
  omap <unique>     V<M-E>     V<Plug>(columnmove-E)
  omap <unique> <C-v><M-E> <C-v><Plug>(columnmove-E)
endif

" vertical gE
if !hasmapto('<Plug>(columnmove-gE)')
  imap <unique>      <M-g>E      <Plug>(columnmove-gE)
  nmap <unique>      <M-g>E      <Plug>(columnmove-gE)
  xmap <unique>      <M-g>E      <Plug>(columnmove-gE)
  omap <unique>      <M-g>E      <Plug>(columnmove-gE)
  omap <unique>     v<M-g>E     v<Plug>(columnmove-gE)
  omap <unique>     V<M-g>E     V<Plug>(columnmove-gE)
  omap <unique> <C-v><M-g>E <C-v><Plug>(columnmove-gE)

  imap <unique>      <M-g><M-E>      <Plug>(columnmove-gE)
  nmap <unique>      <M-g><M-E>      <Plug>(columnmove-gE)
  xmap <unique>      <M-g><M-E>      <Plug>(columnmove-gE)
  omap <unique>      <M-g><M-E>      <Plug>(columnmove-gE)
  omap <unique>     v<M-g><M-E>     v<Plug>(columnmove-gE)
  omap <unique>     V<M-g><M-E>     V<Plug>(columnmove-gE)
  omap <unique> <C-v><M-g><M-E> <C-v><Plug>(columnmove-gE)
endif
