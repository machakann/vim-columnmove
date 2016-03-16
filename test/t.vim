let s:suite_t = themis#suite('columnmove-t:')
function! s:suite_t.before_each() abort  "{{{
  mapclear
  mapclear!
  call columnmove#utility#map('nxo', 't', '\t')
  set tabstop&
  set ambiwidth&
  set commentstring&
  set foldmethod&
  set softtabstop&
  set shiftwidth&
  set expandtab&
  unlet! g:columnmove_fold_open
  unlet! g:columnmove_expand_range
  %delete
endfunction
"}}}
function! s:suite_t.after() abort  "{{{
  call s:suite_t.before_each()
  mapclear
  mapclear!
endfunction
"}}}

function! s:suite_t.positioning() abort "{{{
  " #1
  call append(0, ['abc', 'def', 'ghi'])
  normal 1G\ta
  call g:assert.equals(getpos('.')[1:2], [1, 1], 'failed at #1')
  %delete

  " #2
  call append(0, ['abc', 'def', 'ghi'])
  normal 1G\td
  call g:assert.equals(getpos('.')[1:2], [1, 1], 'failed at #2')
  %delete

  " #3
  call append(0, ['abc', 'def', 'ghi'])
  normal 1G\tg
  call g:assert.equals(getpos('.')[1:2], [2, 1], 'failed at #3')
  %delete

  " #4
  call append(0, ['abc', 'def', 'ghi'])
  normal 1Gl\tb
  call g:assert.equals(getpos('.')[1:2], [1, 2], 'failed at #4')
  %delete

  " #5
  call append(0, ['abc', 'def', 'ghi'])
  normal 1Gl\te
  call g:assert.equals(getpos('.')[1:2], [1, 2], 'failed at #5')
  %delete

  " #6
  call append(0, ['abc', 'def', 'ghi'])
  normal 1Gl\th
  call g:assert.equals(getpos('.')[1:2], [2, 2], 'failed at #6')
  %delete

  " #7
  call append(0, ['abc', 'def', 'ghi'])
  normal 1G2l\tc
  call g:assert.equals(getpos('.')[1:2], [1, 3], 'failed at #7')
  %delete

  " #8
  call append(0, ['abc', 'def', 'ghi'])
  normal 1G2l\tf
  call g:assert.equals(getpos('.')[1:2], [1, 3], 'failed at #8')
  %delete

  " #9
  call append(0, ['abc', 'def', 'ghi'])
  normal 1G2l\ti
  call g:assert.equals(getpos('.')[1:2], [2, 3], 'failed at #9')
  %delete

  " #10
  call append(0, ['abc', 'def', 'ghi', 'abc'])
  normal 1G\ta
  call g:assert.equals(getpos('.')[1:2], [3, 1], 'failed at #10')
  %delete

  " #11
  call append(0, ['abc', 'def', 'ghi', 'abc'])
  normal 1Gl\tb
  call g:assert.equals(getpos('.')[1:2], [3, 2], 'failed at #11')
  %delete

  " #12
  call append(0, ['abc', 'def', 'ghi', 'abc'])
  normal 1G2l\tc
  call g:assert.equals(getpos('.')[1:2], [3, 3], 'failed at #12')
  %delete
endfunction
"}}}
" function! s:suite_t.fold() abort  "{{{
"   " #1
"   " skip fold
"   let g:columnmove_fold_open = 0
"   call append(0, ['a', 'b', 'c', 'b'])
"   2,3fold
"   normal 1G\tb
"   call g:assert.equals(getpos('.')[1:2], [3, 1], 'failed at #1')
"   %delete

"   " #2
"   " open fold
"   let g:columnmove_fold_open = 1
"   call append(0, ['a', 'b', 'c', 'b'])
"   2,3fold
"   normal 1G\tb
"   call g:assert.equals(getpos('.')[1:2], [1, 1], 'failed at #2')
"   %delete

"   " #3
"   " open fold (beyond a fold)
"   let g:columnmove_fold_open = 1
"   call append(0, ['a', 'b', 'c', 'd'])
"   2,3fold
"   normal 1G\td
"   call g:assert.equals(getpos('.')[1:2], [3, 1], 'failed at #3')
"   %delete

"   " #4
"   " open fold (deep fold)
"   let g:columnmove_fold_open = 1
"   call append(0, ['a', 'b', 'c', 'd', 'e', 'c'])
"   3,4fold
"   2,5fold
"   normal 1G\tc
"   call g:assert.equals(getpos('.')[1:2], [5, 1], 'failed at #4')
"   %delete

"   " #5
"   " open fold (deep fold)
"   let g:columnmove_fold_open = 2
"   call append(0, ['a', 'b', 'c', 'd', 'e', 'c'])
"   3,4fold
"   2,5fold
"   normal 1G\tc
"   call g:assert.equals(getpos('.')[1:2], [2, 1], 'failed at #5')
"   %delete

"   " #6
"   " open fold (relatively)
"   let g:columnmove_fold_open = -1
"   call append(0, ['a', 'b', 'c', 'd', 'e', 'c'])
"   3,4fold
"   normal 1G\tc
"   call g:assert.equals(getpos('.')[1:2], [2, 1], 'failed at #6')
"   %delete

"   " #7
"   " open fold (relatively)
"   let g:columnmove_fold_open = -1
"   call append(0, ['a', 'b', 'c', 'd', 'e', 'c'])
"   3,4fold
"   2,5fold
"   normal 1G\tc
"   call g:assert.equals(getpos('.')[1:2], [5, 1], 'failed at #7')
"   %delete

"   " #8
"   " open fold (relatively)
"   let g:columnmove_fold_open = -2
"   call append(0, ['a', 'b', 'c', 'd', 'e', 'c'])
"   3,4fold
"   2,5fold
"   normal 1G\tc
"   call g:assert.equals(getpos('.')[1:2], [2, 1], 'failed at #8')
"   %delete
" endfunction
" "}}}
" function! s:suite_t.count() abort "{{{
"   " #1
"   call append(0, ['a', 'b', 'b', 'b'])
"   normal 1G\tb
"   call g:assert.equals(getpos('.')[1:2], [1, 1], 'failed at #1')
"   %delete

"   " #2
"   call append(0, ['a', 'b', 'b', 'b'])
"   normal 1G2\tb
"   call g:assert.equals(getpos('.')[1:2], [2, 1], 'failed at #2')
"   %delete

"   " #3
"   call append(0, ['a', 'b', 'b', 'b'])
"   normal 1G3\tb
"   call g:assert.equals(getpos('.')[1:2], [3, 1], 'failed at #3')
"   %delete
" endfunction
" "}}}
function! s:suite_t.curswant() abort  "{{{
  " #1
  call append(0, ['abc', 'd', '', 'efg', 'hij'])
  normal 1G$j\th
  call g:assert.equals(getpos('.')[1:2], [4, 1], 'failed at #1')
  %delete

  " #2
  call append(0, ['abc', 'de', '', 'fgh'])
  normal 1G$j\tgj
  call g:assert.equals(getpos('.')[1:2], [4, 2], 'failed at #2')
  %delete
endfunction
"}}}
function! s:suite_t.tab_char() abort  "{{{
  " #1
  set tabstop=4
  call append(0, ["\ta", 'bcdef', 'ghijk'])
  normal 1G\tk
  call g:assert.equals(getpos('.')[1:2], [2, 5], 'failed at #1')
  %delete

  " #2
  " set tabstop=4
  " call append(0, ['abcde', 'fghij', "\tk"])
  " normal 1G$\tk
  " call g:assert.equals(getpos('.')[1:2], [2, 5], 'failed at #2')
  " %delete

  " #3
  " set tabstop=4
  " call append(0, ["\ta", 'bcdef', 'ghijk'])
  " normal 1G0\tg
  " call g:assert.equals(getpos('.')[1:2], [2, 1], 'failed at #3')
  " %delete

  " #4
  set tabstop=4
  call append(0, ['abcde', 'fghij', "\tk"])
  execute "normal 1G\\t\t"
  call g:assert.equals(getpos('.')[1:2], [2, 1], 'failed at #4')
  %delete
endfunction
"}}}
function! s:suite_t.multibyte_char() abort  "{{{
  " #1
  set ambiwidth=single
  call append(0, ['αb', 'cd', 'ef'])
  normal 1G$\tf
  call g:assert.equals(getpos('.')[1:2], [2, 2], 'failed at #1')
  %delete

  " #2
  set ambiwidth=single
  call append(0, ['ab', 'cd', 'εf'])
  normal 1G$\tf
  call g:assert.equals(getpos('.')[1:2], [2, 2], 'failed at #2')
  %delete

  " #3
  set ambiwidth=single
  call append(0, ['αb', 'cd', 'ef'])
  normal 1G\te
  call g:assert.equals(getpos('.')[1:2], [2, 1], 'failed at #3')
  %delete

  " #4
  set ambiwidth=single
  call append(0, ['ab', 'cd', 'εf'])
  normal 1G\tε
  call g:assert.equals(getpos('.')[1:2], [2, 1], 'failed at #4')
  %delete
endfunction
"}}}
function! s:suite_t.visual_mode() abort "{{{
  " #1
  call append(0, ['abc', 'def', 'ghi'])
  normal 1Gv\tgd
  call g:assert.equals(getpos('.')[1:2], [1, 1], 'failed at #1')
  call g:assert.equals(getline('.'), 'ef', 'failed at #1')
  %delete

  " #2
  call append(0, ['abc', 'def'])
  normal 1Gv\tz
  call g:assert.equals(mode(), 'v', 'failed at #2')
  execute "normal! \<Esc>"
  %delete
endfunction
"}}}
function! s:suite_t.operator_pending_mode() abort "{{{
  " #1
  mapclear
  mapclear!
  call columnmove#utility#map('o', 't', '\t')
  call append(0, ['abc', 'def', 'ghi'])
  normal 1Gd\tg
  call g:assert.equals(getpos('.')[1:2], [1, 1], 'failed at #1')
  call g:assert.equals(getline('.'), 'ghi', 'failed at #1')
  %delete

  " #2
  mapclear
  mapclear!
  call columnmove#utility#map('o', 't', '\t', 'V')
  call append(0, ['abc', 'def', 'ghi'])
  normal 1Gd\tg
  call g:assert.equals(getpos('.')[1:2], [1, 1], 'failed at #2')
  call g:assert.equals(getline('.'), 'ghi', 'failed at #2')
  %delete

  " #3
  mapclear
  mapclear!
  call columnmove#utility#map('o', 't', '\t', 'line')
  call append(0, ['abc', 'def', 'ghi'])
  normal 1Gd\tg
  call g:assert.equals(getpos('.')[1:2], [1, 1], 'failed at #3')
  call g:assert.equals(getline('.'), 'ghi', 'failed at #3')
  %delete

  " #4
  mapclear
  mapclear!
  call columnmove#utility#map('o', 't', '\t', 'char')
  call append(0, ['abc', 'def', 'ghi'])
  normal 1Gd\tg
  call g:assert.equals(getpos('.')[1:2], [1, 1], 'failed at #4')
  call g:assert.equals(getline('.'), 'ef', 'failed at #4')
  %delete

  " #5
  mapclear
  mapclear!
  call columnmove#utility#map('o', 't', '\t', 'v')
  call append(0, ['abc', 'def', 'ghi'])
  normal 1Gd\tg
  call g:assert.equals(getpos('.')[1:2], [1, 1], 'failed at #5')
  call g:assert.equals(getline('.'), 'ef', 'failed at #5')
  %delete

  " #6
  mapclear
  mapclear!
  call columnmove#utility#map('o', 't', '\t', '')
  call append(0, ['abc', 'def', 'ghi'])
  normal 1Gd\tg
  call g:assert.equals(getpos('.')[1:2], [1, 1], 'failed at #6')
  call g:assert.equals(getline('.'), 'def', 'failed at #6')
  %delete

  " #7
  mapclear
  mapclear!
  call columnmove#utility#map('o', 't', '\t', 'block')
  call append(0, ['abc', 'def', 'ghi'])
  normal 1Gd\tg
  call g:assert.equals(getpos('.')[1:2], [1, 1], 'failed at #7')
  call g:assert.equals(getline(1), 'bc', 'failed at #7')
  call g:assert.equals(getline(2), 'ef', 'failed at #7')
  %delete

  " #8
  mapclear
  mapclear!
  call columnmove#utility#map('o', 't', '\t', "\<C-v>")
  call append(0, ['abc', 'def', 'ghi'])
  normal 1Gd\tg
  call g:assert.equals(getpos('.')[1:2], [1, 1], 'failed at #8')
  call g:assert.equals(getline(1), 'bc', 'failed at #8')
  call g:assert.equals(getline(2), 'ef', 'failed at #8')
  %delete
endfunction
"}}}

let s:suite_T = themis#suite('columnmove-T:')
function! s:suite_T.before_each() abort  "{{{
  mapclear
  mapclear!
  call columnmove#utility#map('nxo', 'T', '\T')
  set tabstop&
  set ambiwidth&
  set commentstring&
  set foldmethod&
  set softtabstop&
  set shiftwidth&
  set expandtab&
  set scrolloff&
  unlet! g:columnmove_fold_open
  unlet! g:columnmove_expand_range
  %delete
endfunction
"}}}
function! s:suite_T.after() abort  "{{{
  call s:suite_T.before_each()
  mapclear
  mapclear!
endfunction
"}}}

function! s:suite_T.positioning() abort "{{{
  " #1
  call append(0, ['abc', 'def', 'ghi'])
  normal 3G\Ta
  call g:assert.equals(getpos('.')[1:2], [2, 1], 'failed at #1')
  %delete

  " #2
  call append(0, ['abc', 'def', 'ghi'])
  normal 3G\Td
  call g:assert.equals(getpos('.')[1:2], [3, 1], 'failed at #2')
  %delete

  " #3
  call append(0, ['abc', 'def', 'ghi'])
  normal 3G\Tg
  call g:assert.equals(getpos('.')[1:2], [3, 1], 'failed at #3')
  %delete

  " #4
  call append(0, ['abc', 'def', 'ghi'])
  normal 3Gl\Tb
  call g:assert.equals(getpos('.')[1:2], [2, 2], 'failed at #4')
  %delete

  " #5
  call append(0, ['abc', 'def', 'ghi'])
  normal 3Gl\Te
  call g:assert.equals(getpos('.')[1:2], [3, 2], 'failed at #5')
  %delete

  " #6
  call append(0, ['abc', 'def', 'ghi'])
  normal 3Gl\Th
  call g:assert.equals(getpos('.')[1:2], [3, 2], 'failed at #6')
  %delete

  " #7
  call append(0, ['abc', 'def', 'ghi'])
  normal 3G2l\Tc
  call g:assert.equals(getpos('.')[1:2], [2, 3], 'failed at #7')
  %delete

  " #8
  call append(0, ['abc', 'def', 'ghi'])
  normal 3G2l\Tf
  call g:assert.equals(getpos('.')[1:2], [3, 3], 'failed at #8')
  %delete

  " #9
  call append(0, ['abc', 'def', 'ghi'])
  normal 3G2l\Ti
  call g:assert.equals(getpos('.')[1:2], [3, 3], 'failed at #9')
  %delete

  " #10
  call append(0, ['abc', 'def', 'ghi', 'abc'])
  normal 4G\Ta
  call g:assert.equals(getpos('.')[1:2], [2, 1], 'failed at #10')
  %delete

  " #11
  call append(0, ['abc', 'def', 'ghi', 'abc'])
  normal 4Gl\Tb
  call g:assert.equals(getpos('.')[1:2], [2, 2], 'failed at #11')
  %delete

  " #12
  call append(0, ['abc', 'def', 'ghi', 'abc'])
  normal 4G2l\Tc
  call g:assert.equals(getpos('.')[1:2], [2, 3], 'failed at #12')
  %delete
endfunction
"}}}
function! s:suite_T.fold() abort  "{{{
  " #1
  " skip fold
  let g:columnmove_fold_open = 0
  call append(0, ['a', 'a', 'b', 'c'])
  2,3fold
  normal 4G\Ta
  call g:assert.equals(getpos('.')[1:2], [2, 1], 'failed at #1')
  %delete

  " #2
  " open fold
  let g:columnmove_fold_open = 1
  call append(0, ['a', 'a', 'b', 'c'])
  2,3fold
  normal 4G\Ta
  call g:assert.equals(getpos('.')[1:2], [3, 1], 'failed at #2')
  %delete

  " #3
  " open fold (beyond a fold)
  let g:columnmove_fold_open = 1
  call append(0, ['a', 'b', 'c', 'd'])
  2,3fold
  normal 4G\Ta
  call g:assert.equals(getpos('.')[1:2], [2, 1], 'failed at #3')
  %delete

  " #4
  " open fold (deep fold)
  let g:columnmove_fold_open = 1
  call append(0, ['a', 'b', 'c', 'd', 'e', 'f'])
  3,4fold
  2,5fold
  normal 6G\Tc
  call g:assert.equals(getpos('.')[1:2], [6, 1], 'failed at #4')
  %delete

  " #5
  " open fold (deep fold)
  let g:columnmove_fold_open = 2
  call append(0, ['a', 'b', 'c', 'd', 'e', 'f'])
  3,4fold
  2,5fold
  normal 6G\Tc
  call g:assert.equals(getpos('.')[1:2], [4, 1], 'failed at #5')
  %delete

  " #6
  " open fold (relatively)
  let g:columnmove_fold_open = -1
  call append(0, ['a', 'b', 'c', 'd', 'e', 'f'])
  3,4fold
  normal 6G\Tc
  call g:assert.equals(getpos('.')[1:2], [4, 1], 'failed at #6')
  %delete

  " #7
  " open fold (relatively)
  let g:columnmove_fold_open = -1
  call append(0, ['a', 'b', 'c', 'd', 'e', 'f'])
  3,4fold
  2,5fold
  normal 6G\Tc
  call g:assert.equals(getpos('.')[1:2], [6, 1], 'failed at #7')
  %delete

  " #8
  " open fold (relatively)
  let g:columnmove_fold_open = -2
  call append(0, ['a', 'b', 'c', 'd', 'e', 'f'])
  3,4fold
  2,5fold
  normal 6G\Tc
  call g:assert.equals(getpos('.')[1:2], [4, 1], 'failed at #8')
  %delete
endfunction
"}}}
" function! s:suite_T.count() abort "{{{
"   " #1
"   call append(0, ['a', 'a', 'a', 'b'])
"   normal 4G\Ta
"   call g:assert.equals(getpos('.')[1:2], [4, 1], 'failed at #1')
"   %delete

"   " #2
"   call append(0, ['a', 'a', 'a', 'b'])
"   normal 4G2\Ta
"   call g:assert.equals(getpos('.')[1:2], [3, 1], 'failed at #2')
"   %delete

"   " #3
"   call append(0, ['a', 'a', 'a', 'b'])
"   normal 4G3\ta
"   call g:assert.equals(getpos('.')[1:2], [2, 1], 'failed at #3')
"   %delete
" endfunction
" "}}}
function! s:suite_T.curswant() abort  "{{{
  " #1
  call append(0, ['abc', 'def', '', 'g', 'hij'])
  normal 5G$k\Ta
  call g:assert.equals(getpos('.')[1:2], [2, 1], 'failed at #1')
  %delete

  " #2
  call append(0, ['abc', '', 'de', 'fgh'])
  normal 4G$k\Tbk
  call g:assert.equals(getpos('.')[1:2], [1, 2], 'failed at #2')
  %delete
endfunction
"}}}
" function! s:suite_T.tab_char() abort  "{{{
"   " #1
"   set tabstop=4
"   call append(0, ["\ta", 'bcdef', 'ghijk'])
"   normal 3G$\Ta
"   call g:assert.equals(getpos('.')[1:2], [2, 5], 'failed at #1')
"   %delete

"   " #2
"   set tabstop=4
"   call append(0, ['abcde', 'fghij', "\tk"])
"   normal 3G$\Te
"   call g:assert.equals(getpos('.')[1:2], [2, 5], 'failed at #2')
"   %delete

"   " #3
"   set tabstop=4
"   call append(0, ["\ta", 'bcdef', 'ghijk'])
"   execute "normal 3G\\t\t"
"   call g:assert.equals(getpos('.')[1:2], [2, 1], 'failed at #3')
"   %delete

"   " #4
"   set tabstop=4
"   call append(0, ["\ta", 'bcdef', 'ghijk'])
"   execute "normal 3Gl\\t\t"
"   call g:assert.equals(getpos('.')[1:2], [2, 2], 'failed at #4')
"   %delete

"   " #5
"   set tabstop=4
"   call append(0, ['abcde', 'fghij', "\tk"])
"   normal 3G0\Ta
"   call g:assert.equals(getpos('.')[1:2], [2, 1], 'failed at #5')
"   %delete
" endfunction
" "}}}
function! s:suite_T.multibyte_char() abort  "{{{
  " #1
  set ambiwidth=single
  call append(0, ['αb', 'cd', 'ef'])
  normal 3G$\Tb
  call g:assert.equals(getpos('.')[1:2], [2, 2], 'failed at #1')
  %delete

  " #2
  set ambiwidth=single
  call append(0, ['ab', 'cd', 'εf'])
  normal 3G$\Tb
  call g:assert.equals(getpos('.')[1:2], [2, 2], 'failed at #2')
  %delete

  " #3
  set ambiwidth=single
  call append(0, ['αb', 'cd', 'ef'])
  normal 3G\Tα
  call g:assert.equals(getpos('.')[1:2], [2, 1], 'failed at #3')
  %delete

  " #4
  set ambiwidth=single
  call append(0, ['ab', 'cd', 'εf'])
  normal 3G\Ta
  call g:assert.equals(getpos('.')[1:2], [2, 1], 'failed at #4')
  %delete
endfunction
"}}}
function! s:suite_T.visual_mode() abort "{{{
  " #1
  call append(0, ['abc', 'def', 'ghi'])
  normal 3Gv\Tad
  call g:assert.equals(getpos('.')[1:2], [2, 1], 'failed at #1')
  call g:assert.equals(getline(1), 'abc', 'failed at #1')
  call g:assert.equals(getline(2), 'hi', 'failed at #1')
  %delete

  " #2
  call append(0, ['abc', 'def'])
  normal 2Gv\Tzd
  call g:assert.equals(mode(), 'v', 'failed at #2')
  execute "normal! \<Esc>"
  %delete
endfunction
"}}}
function! s:suite_T.operator_pending_mode() abort "{{{
  " #1
  mapclear
  mapclear!
  call columnmove#utility#map('o', 'T', '\T')
  call append(0, ['abc', 'def', 'ghi'])
  normal 3Gd\Ta
  call g:assert.equals(getpos('.')[1:2], [2, 1], 'failed at #1')
  call g:assert.equals(getline(1), 'abc', 'failed at #1')
  call g:assert.equals(getline(2), '', 'failed at #1')
  %delete

  " #2
  mapclear
  mapclear!
  call columnmove#utility#map('o', 'T', '\T', 'V')
  call append(0, ['abc', 'def', 'ghi'])
  normal 3Gd\Ta
  call g:assert.equals(getpos('.')[1:2], [2, 1], 'failed at #2')
  call g:assert.equals(getline(1), 'abc', 'failed at #2')
  call g:assert.equals(getline(2), '', 'failed at #2')
  %delete

  " #3
  mapclear
  mapclear!
  call columnmove#utility#map('o', 'T', '\T', 'line')
  call append(0, ['abc', 'def', 'ghi'])
  normal 3Gd\Ta
  call g:assert.equals(getpos('.')[1:2], [2, 1], 'failed at #3')
  call g:assert.equals(getline(1), 'abc', 'failed at #3')
  call g:assert.equals(getline(2), '', 'failed at #3')
  %delete

  " #4
  mapclear
  mapclear!
  call columnmove#utility#map('o', 'T', '\T', 'char')
  call append(0, ['abc', 'def', 'ghi'])
  normal 3Gd\Ta
  call g:assert.equals(getpos('.')[1:2], [2, 1], 'failed at #4')
  call g:assert.equals(getline(1), 'abc', 'failed at #4')
  call g:assert.equals(getline(2), 'hi', 'failed at #4')
  %delete

  " #5
  mapclear
  mapclear!
  call columnmove#utility#map('o', 'T', '\T', 'v')
  call append(0, ['abc', 'def', 'ghi'])
  normal 3Gd\Ta
  call g:assert.equals(getpos('.')[1:2], [2, 1], 'failed at #5')
  call g:assert.equals(getline(1), 'abc', 'failed at #5')
  call g:assert.equals(getline(2), 'hi', 'failed at #5')
  %delete

  " #6
  mapclear
  mapclear!
  call columnmove#utility#map('o', 'T', '\T', '')
  call append(0, ['abc', 'def', 'ghi'])
  normal 3Gd\Ta
  call g:assert.equals(getpos('.')[1:2], [2, 1], 'failed at #6')
  call g:assert.equals(getline(1), 'abc', 'failed at #6')
  call g:assert.equals(getline(2), 'ghi', 'failed at #6')
  %delete

  " #7
  mapclear
  mapclear!
  call columnmove#utility#map('o', 'T', '\T', 'block')
  call append(0, ['abc', 'def', 'ghi'])
  normal 3Gd\Ta
  call g:assert.equals(getpos('.')[1:2], [2, 1], 'failed at #7')
  call g:assert.equals(getline(1), 'abc', 'failed at #7')
  call g:assert.equals(getline(2), 'ef', 'failed at #7')
  call g:assert.equals(getline(3), 'hi', 'failed at #7')
  %delete

  " #8
  mapclear
  mapclear!
  call columnmove#utility#map('o', 'T', '\T', "\<C-v>")
  call append(0, ['abc', 'def', 'ghi'])
  normal 3Gd\Ta
  call g:assert.equals(getpos('.')[1:2], [2, 1], 'failed at #8')
  call g:assert.equals(getline(1), 'abc', 'failed at #8')
  call g:assert.equals(getline(2), 'ef', 'failed at #8')
  call g:assert.equals(getline(3), 'hi', 'failed at #8')
  %delete
endfunction
"}}}



" vim:set foldmethod=marker:
" vim:set commentstring="%s:
" vim:set ts=2 sts=2 sw=2 et:
