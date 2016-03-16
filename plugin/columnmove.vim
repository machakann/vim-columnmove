" Vim global plugin for moving cursor in vertical direction
" Last Change: 16-Mar-2016.
" Maintainer : Masaaki Nakamura <mckn@outlook.jp>

" License    : NYSL
"              Japanese <http://www.kmonos.net/nysl/>
"              English (Unofficial) <http://www.kmonos.net/nysl/index.en.html>

if exists("g:loaded_columnmove")
  finish
endif
let g:loaded_columnmove = 1

let s:cpoptions = &cpoptions
if stridx(&cpoptions, '<') != -1
  set cpoptions-=<
endif



""" highlight group
function! s:default_highlight() abort
  highlight default link ColumnmoveCandidates IncSearch
endfunction
call s:default_highlight()

augroup columnmove-highlight
  autocmd!
  autocmd ColorScheme * call s:default_highlight()
augroup END



""" keymappings
" vertical f
inoremap <silent><expr>      <Plug>(columnmove-f) columnmove#f('i', '')
nnoremap <silent><expr>      <Plug>(columnmove-f) columnmove#f('n', '')
xnoremap <silent><expr>      <Plug>(columnmove-f) columnmove#f('x', '')
onoremap <silent><expr>      <Plug>(columnmove-f) columnmove#f('o', 'V')
onoremap <silent><expr>     v<Plug>(columnmove-f) columnmove#f('o', '')
onoremap <silent><expr>     V<Plug>(columnmove-f) columnmove#f('o', 'V')
onoremap <silent><expr> <C-v><Plug>(columnmove-f) columnmove#f('o', "<Bslash><lt>C-v>")

" vertical t
inoremap <silent><expr>      <Plug>(columnmove-t) columnmove#t('i', '')
nnoremap <silent><expr>      <Plug>(columnmove-t) columnmove#t('n', '')
xnoremap <silent><expr>      <Plug>(columnmove-t) columnmove#t('x', '')
onoremap <silent><expr>      <Plug>(columnmove-t) columnmove#t('o', 'V')
onoremap <silent><expr>     v<Plug>(columnmove-t) columnmove#t('o', '')
onoremap <silent><expr>     V<Plug>(columnmove-t) columnmove#t('o', 'V')
onoremap <silent><expr> <C-v><Plug>(columnmove-t) columnmove#t('o', "<Bslash><lt>C-v>")

" vertical F
inoremap <silent><expr>      <Plug>(columnmove-F) columnmove#F('i', '')
nnoremap <silent><expr>      <Plug>(columnmove-F) columnmove#F('n', '')
xnoremap <silent><expr>      <Plug>(columnmove-F) columnmove#F('x', '')
onoremap <silent><expr>      <Plug>(columnmove-F) columnmove#F('o', 'V')
onoremap <silent><expr>     v<Plug>(columnmove-F) columnmove#F('o', '')
onoremap <silent><expr>     V<Plug>(columnmove-F) columnmove#F('o', 'V')
onoremap <silent><expr> <C-v><Plug>(columnmove-F) columnmove#F('o', "<Bslash><lt>C-v>")

" vertical T
inoremap <silent><expr>      <Plug>(columnmove-T) columnmove#T('i', '')
nnoremap <silent><expr>      <Plug>(columnmove-T) columnmove#T('n', '')
xnoremap <silent><expr>      <Plug>(columnmove-T) columnmove#T('x', '')
onoremap <silent><expr>      <Plug>(columnmove-T) columnmove#T('o', 'V')
onoremap <silent><expr>     v<Plug>(columnmove-T) columnmove#T('o', '')
onoremap <silent><expr>     V<Plug>(columnmove-T) columnmove#T('o', 'V')
onoremap <silent><expr> <C-v><Plug>(columnmove-T) columnmove#T('o', "<Bslash><lt>C-v>")

" vertical semicolon
inoremap <silent><expr>      <Plug>(columnmove-;) columnmove#semicolon('i', '')
nnoremap <silent><expr>      <Plug>(columnmove-;) columnmove#semicolon('n', '')
xnoremap <silent><expr>      <Plug>(columnmove-;) columnmove#semicolon('x', '')
onoremap <silent><expr>      <Plug>(columnmove-;) columnmove#semicolon('o', 'V')
onoremap <silent><expr>     v<Plug>(columnmove-;) columnmove#semicolon('o', '')
onoremap <silent><expr>     V<Plug>(columnmove-;) columnmove#semicolon('o', 'V')
onoremap <silent><expr> <C-v><Plug>(columnmove-;) columnmove#semicolon('o', "<Bslash><lt>C-v>")

" vertical comma
inoremap <silent><expr>      <Plug>(columnmove-,) columnmove#comma('i', '')
nnoremap <silent><expr>      <Plug>(columnmove-,) columnmove#comma('n', '')
xnoremap <silent><expr>      <Plug>(columnmove-,) columnmove#comma('x', '')
onoremap <silent><expr>      <Plug>(columnmove-,) columnmove#comma('o', 'V')
onoremap <silent><expr>     v<Plug>(columnmove-,) columnmove#comma('o', '')
onoremap <silent><expr>     V<Plug>(columnmove-,) columnmove#comma('o', 'V')
onoremap <silent><expr> <C-v><Plug>(columnmove-,) columnmove#comma('o', "<Bslash><lt>C-v>")

" vertical w
inoremap <silent>      <Plug>(columnmove-w)       <C-r>=columnmove#w('i', '')<CR>
nnoremap <silent>      <Plug>(columnmove-w)  :<C-u>call columnmove#w('n', '')<CR>
xnoremap <silent>      <Plug>(columnmove-w)  :<C-u>call columnmove#w('x', '')<CR>
onoremap <silent>      <Plug>(columnmove-w)  :<C-u>call columnmove#w('o', 'V')<CR>
onoremap <silent>     v<Plug>(columnmove-w)  :<C-u>call columnmove#w('o', '')<CR>
onoremap <silent>     V<Plug>(columnmove-w)  :<C-u>call columnmove#w('o', 'V')<CR>
onoremap <silent> <C-v><Plug>(columnmove-w)  :<C-u>call columnmove#w('o', "<Bslash><lt>C-v>")<CR>

" vertical b
inoremap <silent>      <Plug>(columnmove-b)       <C-r>=columnmove#b('i', '')<CR>
nnoremap <silent>      <Plug>(columnmove-b)  :<C-u>call columnmove#b('n', '')<CR>
xnoremap <silent>      <Plug>(columnmove-b)  :<C-u>call columnmove#b('x', '')<CR>
onoremap <silent>      <Plug>(columnmove-b)  :<C-u>call columnmove#b('o', 'V')<CR>
onoremap <silent>     v<Plug>(columnmove-b)  :<C-u>call columnmove#b('o', '')<CR>
onoremap <silent>     V<Plug>(columnmove-b)  :<C-u>call columnmove#b('o', 'V')<CR>
onoremap <silent> <C-v><Plug>(columnmove-b)  :<C-u>call columnmove#b('o', "<Bslash><lt>C-v>")<CR>

" vertical e
inoremap <silent>      <Plug>(columnmove-e)       <C-r>=columnmove#e('i', '')<CR>
nnoremap <silent>      <Plug>(columnmove-e)  :<C-u>call columnmove#e('n', '')<CR>
xnoremap <silent>      <Plug>(columnmove-e)  :<C-u>call columnmove#e('x', '')<CR>
onoremap <silent>      <Plug>(columnmove-e)  :<C-u>call columnmove#e('o', 'V')<CR>
onoremap <silent>     v<Plug>(columnmove-e)  :<C-u>call columnmove#e('o', '')<CR>
onoremap <silent>     V<Plug>(columnmove-e)  :<C-u>call columnmove#e('o', 'V')<CR>
onoremap <silent> <C-v><Plug>(columnmove-e)  :<C-u>call columnmove#e('o', "<Bslash><lt>C-v>")<CR>

" vertical ge
inoremap <silent>      <Plug>(columnmove-ge)      <C-r>=columnmove#ge('i', '')<CR>
nnoremap <silent>      <Plug>(columnmove-ge) :<C-u>call columnmove#ge('n', '')<CR>
xnoremap <silent>      <Plug>(columnmove-ge) :<C-u>call columnmove#ge('x', '')<CR>
onoremap <silent>      <Plug>(columnmove-ge) :<C-u>call columnmove#ge('o', 'V')<CR>
onoremap <silent>     v<Plug>(columnmove-ge) :<C-u>call columnmove#ge('o', '')<CR>
onoremap <silent>     V<Plug>(columnmove-ge) :<C-u>call columnmove#ge('o', 'V')<CR>
onoremap <silent> <C-v><Plug>(columnmove-ge) :<C-u>call columnmove#ge('o', "<Bslash><lt>C-v>")<CR>

" vertical W
inoremap <silent>      <Plug>(columnmove-W)       <C-r>=columnmove#W('i', '')<CR>
nnoremap <silent>      <Plug>(columnmove-W)  :<C-u>call columnmove#W('n', '')<CR>
xnoremap <silent>      <Plug>(columnmove-W)  :<C-u>call columnmove#W('x', '')<CR>
onoremap <silent>      <Plug>(columnmove-W)  :<C-u>call columnmove#W('o', 'V')<CR>
onoremap <silent>     v<Plug>(columnmove-W)  :<C-u>call columnmove#W('o', '')<CR>
onoremap <silent>     V<Plug>(columnmove-W)  :<C-u>call columnmove#W('o', 'V')<CR>
onoremap <silent> <C-v><Plug>(columnmove-W)  :<C-u>call columnmove#W('o', "<Bslash><lt>C-v>")<CR>

" vertical B
inoremap <silent>      <Plug>(columnmove-B)       <C-r>=columnmove#B('i', '')<CR>
nnoremap <silent>      <Plug>(columnmove-B)  :<C-u>call columnmove#B('n', '')<CR>
xnoremap <silent>      <Plug>(columnmove-B)  :<C-u>call columnmove#B('x', '')<CR>
onoremap <silent>      <Plug>(columnmove-B)  :<C-u>call columnmove#B('o', 'V')<CR>
onoremap <silent>     v<Plug>(columnmove-B)  :<C-u>call columnmove#B('o', '')<CR>
onoremap <silent>     V<Plug>(columnmove-B)  :<C-u>call columnmove#B('o', 'V')<CR>
onoremap <silent> <C-v><Plug>(columnmove-B)  :<C-u>call columnmove#B('o', "<Bslash><lt>C-v>")<CR>

" vertical E
inoremap <silent>      <Plug>(columnmove-E)       <C-r>=columnmove#E('i', '')<CR>
nnoremap <silent>      <Plug>(columnmove-E)  :<C-u>call columnmove#E('n', '')<CR>
xnoremap <silent>      <Plug>(columnmove-E)  :<C-u>call columnmove#E('x', '')<CR>
onoremap <silent>      <Plug>(columnmove-E)  :<C-u>call columnmove#E('o', 'V')<CR>
onoremap <silent>     v<Plug>(columnmove-E)  :<C-u>call columnmove#E('o', '')<CR>
onoremap <silent>     V<Plug>(columnmove-E)  :<C-u>call columnmove#E('o', 'V')<CR>
onoremap <silent> <C-v><Plug>(columnmove-E)  :<C-u>call columnmove#E('o', "<Bslash><lt>C-v>")<CR>

" vertical gE
inoremap <silent>      <Plug>(columnmove-gE)      <C-r>=columnmove#gE('i', '')<CR>
nnoremap <silent>      <Plug>(columnmove-gE) :<C-u>call columnmove#gE('n', '')<CR>
xnoremap <silent>      <Plug>(columnmove-gE) :<C-u>call columnmove#gE('x', '')<CR>
onoremap <silent>      <Plug>(columnmove-gE) :<C-u>call columnmove#gE('o', 'V')<CR>
onoremap <silent>     v<Plug>(columnmove-gE) :<C-u>call columnmove#gE('o', '')<CR>
onoremap <silent>     V<Plug>(columnmove-gE) :<C-u>call columnmove#gE('o', 'V')<CR>
onoremap <silent> <C-v><Plug>(columnmove-gE) :<C-u>call columnmove#gE('o', "<Bslash><lt>C-v>")<CR>

" intrinsic mappings
inoremap <Plug>(columnmove-nop) <Nop>
nnoremap <Plug>(columnmove-nop) <Nop>
xnoremap <Plug>(columnmove-nop) <Nop>

""" default keymappings
" If g:columnmove_no_default_key_mappings has been defined, then quit
" immediately.
if exists('g:columnmove_no_default_key_mappings')
  let &cpoptions = s:cpoptions
  finish
endif

" vertical f
if !hasmapto('<Plug>(columnmove-f)')
  silent! nmap <unique>      <M-f>      <Plug>(columnmove-f)
  silent! xmap <unique>      <M-f>      <Plug>(columnmove-f)
  silent! omap <unique>      <M-f>      <Plug>(columnmove-f)
  silent! omap <unique>     v<M-f>     v<Plug>(columnmove-f)
  silent! omap <unique>     V<M-f>     V<Plug>(columnmove-f)
  silent! omap <unique> <C-v><M-f> <C-v><Plug>(columnmove-f)
endif

" vertical t
if !hasmapto('<Plug>(columnmove-t)')
  silent! nmap <unique>      <M-t>      <Plug>(columnmove-t)
  silent! xmap <unique>      <M-t>      <Plug>(columnmove-t)
  silent! omap <unique>      <M-t>      <Plug>(columnmove-t)
  silent! omap <unique>     v<M-t>     v<Plug>(columnmove-t)
  silent! omap <unique>     V<M-t>     V<Plug>(columnmove-t)
  silent! omap <unique> <C-v><M-t> <C-v><Plug>(columnmove-t)
endif

" vertical F
if !hasmapto('<Plug>(columnmove-F)')
  silent! nmap <unique>      <M-F>      <Plug>(columnmove-F)
  silent! xmap <unique>      <M-F>      <Plug>(columnmove-F)
  silent! omap <unique>      <M-F>      <Plug>(columnmove-F)
  silent! omap <unique>     v<M-F>     v<Plug>(columnmove-F)
  silent! omap <unique>     V<M-F>     V<Plug>(columnmove-F)
  silent! omap <unique> <C-v><M-F> <C-v><Plug>(columnmove-F)
endif

" vertical T
if !hasmapto('<Plug>(columnmove-T)')
  silent! nmap <unique>      <M-T>      <Plug>(columnmove-T)
  silent! xmap <unique>      <M-T>      <Plug>(columnmove-T)
  silent! omap <unique>      <M-T>      <Plug>(columnmove-T)
  silent! omap <unique>     v<M-T>     v<Plug>(columnmove-T)
  silent! omap <unique>     V<M-T>     V<Plug>(columnmove-T)
  silent! omap <unique> <C-v><M-T> <C-v><Plug>(columnmove-T)
endif

" vertical semicolon
if !hasmapto('<Plug>(columnmove-;)')
  silent! nmap <unique>      <M-;>      <Plug>(columnmove-;)
  silent! xmap <unique>      <M-;>      <Plug>(columnmove-;)
  silent! omap <unique>      <M-;>      <Plug>(columnmove-;)
  silent! omap <unique>     v<M-;>     v<Plug>(columnmove-;)
  silent! omap <unique>     V<M-;>     V<Plug>(columnmove-;)
  silent! omap <unique> <C-v><M-;> <C-v><Plug>(columnmove-;)
endif

" vertical comma
if !hasmapto('<Plug>(columnmove-,)')
  silent! nmap <unique>      <M-,>      <Plug>(columnmove-,)
  silent! xmap <unique>      <M-,>      <Plug>(columnmove-,)
  silent! omap <unique>      <M-,>      <Plug>(columnmove-,)
  silent! omap <unique>     v<M-,>     v<Plug>(columnmove-,)
  silent! omap <unique>     V<M-,>     V<Plug>(columnmove-,)
  silent! omap <unique> <C-v><M-,> <C-v><Plug>(columnmove-,)
endif

" vertical w
if !hasmapto('<Plug>(columnmove-w)')
  silent! nmap <unique>      <M-w>      <Plug>(columnmove-w)
  silent! xmap <unique>      <M-w>      <Plug>(columnmove-w)
  silent! omap <unique>      <M-w>      <Plug>(columnmove-w)
  silent! omap <unique>     v<M-w>     v<Plug>(columnmove-w)
  silent! omap <unique>     V<M-w>     V<Plug>(columnmove-w)
  silent! omap <unique> <C-v><M-w> <C-v><Plug>(columnmove-w)
endif

" vertical b
if !hasmapto('<Plug>(columnmove-b)')
  silent! nmap <unique>      <M-b>      <Plug>(columnmove-b)
  silent! xmap <unique>      <M-b>      <Plug>(columnmove-b)
  silent! omap <unique>      <M-b>      <Plug>(columnmove-b)
  silent! omap <unique>     v<M-b>     v<Plug>(columnmove-b)
  silent! omap <unique>     V<M-b>     V<Plug>(columnmove-b)
  silent! omap <unique> <C-v><M-b> <C-v><Plug>(columnmove-b)
endif

" vertical e
if !hasmapto('<Plug>(columnmove-e)')
  silent! nmap <unique>      <M-e>      <Plug>(columnmove-e)
  silent! xmap <unique>      <M-e>      <Plug>(columnmove-e)
  silent! omap <unique>      <M-e>      <Plug>(columnmove-e)
  silent! omap <unique>     v<M-e>     v<Plug>(columnmove-e)
  silent! omap <unique>     V<M-e>     V<Plug>(columnmove-e)
  silent! omap <unique> <C-v><M-e> <C-v><Plug>(columnmove-e)
endif

" vertical ge
if !hasmapto('<Plug>(columnmove-ge)')
  silent! nmap <unique>      g<M-e>      <Plug>(columnmove-ge)
  silent! xmap <unique>      g<M-e>      <Plug>(columnmove-ge)
  silent! omap <unique>      g<M-e>      <Plug>(columnmove-ge)
  silent! omap <unique>     vg<M-e>     v<Plug>(columnmove-ge)
  silent! omap <unique>     Vg<M-e>     V<Plug>(columnmove-ge)
  silent! omap <unique> <C-v>g<M-e> <C-v><Plug>(columnmove-ge)

  silent! nmap <unique>      <M-g><M-e>      <Plug>(columnmove-ge)
  silent! xmap <unique>      <M-g><M-e>      <Plug>(columnmove-ge)
  silent! omap <unique>      <M-g><M-e>      <Plug>(columnmove-ge)
  silent! omap <unique>     v<M-g><M-e>     v<Plug>(columnmove-ge)
  silent! omap <unique>     V<M-g><M-e>     V<Plug>(columnmove-ge)
  silent! omap <unique> <C-v><M-g><M-e> <C-v><Plug>(columnmove-ge)
endif

" vertical W
if !hasmapto('<Plug>(columnmove-W)')
  silent! nmap <unique>      <M-W>      <Plug>(columnmove-W)
  silent! xmap <unique>      <M-W>      <Plug>(columnmove-W)
  silent! omap <unique>      <M-W>      <Plug>(columnmove-W)
  silent! omap <unique>     v<M-W>     v<Plug>(columnmove-W)
  silent! omap <unique>     V<M-W>     V<Plug>(columnmove-W)
  silent! omap <unique> <C-v><M-W> <C-v><Plug>(columnmove-W)
endif

" vertical B
if !hasmapto('<Plug>(columnmove-B)')
  silent! nmap <unique>      <M-B>      <Plug>(columnmove-B)
  silent! xmap <unique>      <M-B>      <Plug>(columnmove-B)
  silent! omap <unique>      <M-B>      <Plug>(columnmove-B)
  silent! omap <unique>     v<M-B>     v<Plug>(columnmove-B)
  silent! omap <unique>     V<M-B>     V<Plug>(columnmove-B)
  silent! omap <unique> <C-v><M-B> <C-v><Plug>(columnmove-B)
endif

" vertical E
if !hasmapto('<Plug>(columnmove-E)')
  silent! nmap <unique>      <M-E>      <Plug>(columnmove-E)
  silent! xmap <unique>      <M-E>      <Plug>(columnmove-E)
  silent! omap <unique>      <M-E>      <Plug>(columnmove-E)
  silent! omap <unique>     v<M-E>     v<Plug>(columnmove-E)
  silent! omap <unique>     V<M-E>     V<Plug>(columnmove-E)
  silent! omap <unique> <C-v><M-E> <C-v><Plug>(columnmove-E)
endif

" vertical gE
if !hasmapto('<Plug>(columnmove-gE)')
  silent! nmap <unique>      g<M-E>      <Plug>(columnmove-gE)
  silent! xmap <unique>      g<M-E>      <Plug>(columnmove-gE)
  silent! omap <unique>      g<M-E>      <Plug>(columnmove-gE)
  silent! omap <unique>     vg<M-E>     v<Plug>(columnmove-gE)
  silent! omap <unique>     Vg<M-E>     V<Plug>(columnmove-gE)
  silent! omap <unique> <C-v>g<M-E> <C-v><Plug>(columnmove-gE)

  silent! nmap <unique>      <M-g><M-E>      <Plug>(columnmove-gE)
  silent! xmap <unique>      <M-g><M-E>      <Plug>(columnmove-gE)
  silent! omap <unique>      <M-g><M-E>      <Plug>(columnmove-gE)
  silent! omap <unique>     v<M-g><M-E>     v<Plug>(columnmove-gE)
  silent! omap <unique>     V<M-g><M-E>     V<Plug>(columnmove-gE)
  silent! omap <unique> <C-v><M-g><M-E> <C-v><Plug>(columnmove-gE)
endif

let &cpoptions = s:cpoptions
unlet s:cpoptions

" vim:set ts=2 sts=2 sw=2 et:
