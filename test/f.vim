let s:suite_f = themis#suite('columnmove-f:')
function! s:suite_f.before_each() abort  "{{{
  mapclear
  mapclear!
  call columnmove#utility#map('nxoi', 'f', '\f')
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
function! s:suite_f.after() abort "{{{
  call s:suite_f.before_each()
  mapclear
  mapclear!
endfunction
"}}}

function! s:suite_f.positioning() abort "{{{
  " #1
  call append(0, ['abc', 'def', 'ghi'])
  normal 1G\fa
  call g:assert.equals(getpos('.')[1:2], [1, 1], 'failed at #1')
  %delete

  " #2
  call append(0, ['abc', 'def', 'ghi'])
  normal 1G\fd
  call g:assert.equals(getpos('.')[1:2], [2, 1], 'failed at #2')
  %delete

  " #3
  call append(0, ['abc', 'def', 'ghi'])
  normal 1G\fg
  call g:assert.equals(getpos('.')[1:2], [3, 1], 'failed at #3')
  %delete

  " #4
  call append(0, ['abc', 'def', 'ghi'])
  normal 1Gl\fb
  call g:assert.equals(getpos('.')[1:2], [1, 2], 'failed at #4')
  %delete

  " #5
  call append(0, ['abc', 'def', 'ghi'])
  normal 1Gl\fe
  call g:assert.equals(getpos('.')[1:2], [2, 2], 'failed at #5')
  %delete

  " #6
  call append(0, ['abc', 'def', 'ghi'])
  normal 1Gl\fh
  call g:assert.equals(getpos('.')[1:2], [3, 2], 'failed at #6')
  %delete

  " #7
  call append(0, ['abc', 'def', 'ghi'])
  normal 1G2l\fc
  call g:assert.equals(getpos('.')[1:2], [1, 3], 'failed at #7')
  %delete

  " #8
  call append(0, ['abc', 'def', 'ghi'])
  normal 1G2l\ff
  call g:assert.equals(getpos('.')[1:2], [2, 3], 'failed at #8')
  %delete

  " #9
  call append(0, ['abc', 'def', 'ghi'])
  normal 1G2l\fi
  call g:assert.equals(getpos('.')[1:2], [3, 3], 'failed at #9')
  %delete

  " #10
  call append(0, ['abc', 'def', 'ghi', 'abc'])
  normal 1G\fa
  call g:assert.equals(getpos('.')[1:2], [4, 1], 'failed at #10')
  %delete

  " #11
  call append(0, ['abc', 'def', 'ghi', 'abc'])
  normal 1Gl\fb
  call g:assert.equals(getpos('.')[1:2], [4, 2], 'failed at #11')
  %delete

  " #12
  call append(0, ['abc', 'def', 'ghi', 'abc'])
  normal 1G2l\fc
  call g:assert.equals(getpos('.')[1:2], [4, 3], 'failed at #12')
  %delete

  " #16
  call append(0, ['abc'])
  normal 1G\fa
  call g:assert.equals(getpos('.')[1:2], [1, 1], 'failed at #16')
  %delete
endfunction
"}}}
function! s:suite_f.fold() abort  "{{{
  " #1
  " skip fold
  let g:columnmove_fold_open = 0
  call append(0, ['a', 'b', 'c', 'b'])
  2,3fold
  normal 1G\fb
  call g:assert.equals(getpos('.')[1:2], [4, 1], 'failed at #1')
  %delete

  " #2
  " open fold
  let g:columnmove_fold_open = 1
  call append(0, ['a', 'b', 'c', 'b'])
  2,3fold
  normal 1G\fb
  call g:assert.equals(getpos('.')[1:2], [2, 1], 'failed at #2')
  %delete

  " #3
  " open fold (beyond a fold)
  let g:columnmove_fold_open = 1
  call append(0, ['a', 'b', 'c', 'd'])
  2,3fold
  normal 1G\fd
  call g:assert.equals(getpos('.')[1:2], [4, 1], 'failed at #3')
  %delete

  " #4
  " open fold (deep fold)
  let g:columnmove_fold_open = 1
  call append(0, ['a', 'b', 'c', 'd', 'e', 'c'])
  3,4fold
  2,5fold
  normal 1G\fc
  call g:assert.equals(getpos('.')[1:2], [6, 1], 'failed at #4')
  %delete

  " #5
  " open fold (deep fold)
  let g:columnmove_fold_open = 2
  call append(0, ['a', 'b', 'c', 'd', 'e', 'c'])
  3,4fold
  2,5fold
  normal 1G\fc
  call g:assert.equals(getpos('.')[1:2], [3, 1], 'failed at #5')
  %delete

  " #6
  " open fold (relatively)
  let g:columnmove_fold_open = -1
  call append(0, ['a', 'b', 'c', 'd', 'e', 'c'])
  3,4fold
  normal 1G\fc
  call g:assert.equals(getpos('.')[1:2], [3, 1], 'failed at #6')
  %delete

  " #7
  " open fold (relatively)
  let g:columnmove_fold_open = -1
  call append(0, ['a', 'b', 'c', 'd', 'e', 'c'])
  3,4fold
  2,5fold
  normal 1G\fc
  call g:assert.equals(getpos('.')[1:2], [6, 1], 'failed at #7')
  %delete

  " #8
  " open fold (relatively)
  let g:columnmove_fold_open = -2
  call append(0, ['a', 'b', 'c', 'd', 'e', 'c'])
  3,4fold
  2,5fold
  normal 1G\fc
  call g:assert.equals(getpos('.')[1:2], [3, 1], 'failed at #8')
  %delete
endfunction
"}}}
function! s:suite_f.count() abort "{{{
  " #1
  call append(0, ['a', 'b', 'b', 'b'])
  normal 1G\fb
  call g:assert.equals(getpos('.')[1:2], [2, 1], 'failed at #1')
  %delete

  " #2
  call append(0, ['a', 'b', 'b', 'b'])
  normal 1G2\fb
  call g:assert.equals(getpos('.')[1:2], [3, 1], 'failed at #2')
  %delete

  " #3
  call append(0, ['a', 'b', 'b', 'b'])
  normal 1G3\fb
  call g:assert.equals(getpos('.')[1:2], [4, 1], 'failed at #3')
  %delete
endfunction
"}}}
function! s:suite_f.curswant() abort  "{{{
  " #1
  call append(0, ['abc', 'd', '', 'efg'])
  normal 1G$j\fe
  call g:assert.equals(getpos('.')[1:2], [4, 1], 'failed at #1')
  %delete
endfunction
"}}}
function! s:suite_f.tab_char() abort  "{{{
  " #1
  set tabstop=4
  call append(0, ["\ta", 'bcdef', 'ghijk'])
  normal 1G\fk
  call g:assert.equals(getpos('.')[1:2], [3, 5], 'failed at #1')
  %delete

  " #2
  set tabstop=4
  call append(0, ['abcde', 'fghij', "\tk"])
  normal 1G$\fk
  call g:assert.equals(getpos('.')[1:2], [3, 2], 'failed at #2')
  %delete

  " #3
  " set tabstop=4
  " call append(0, ["\ta", 'bcdef', 'ghijk'])
  " normal 1G0\fg
  " call g:assert.equals(getpos('.')[1:2], [3, 1], 'failed at #3')
  " %delete

  " #4
  set tabstop=4
  call append(0, ['abcde', 'fghij', "\tk"])
  execute "normal 1G\\f\t"
  call g:assert.equals(getpos('.')[1:2], [3, 1], 'failed at #4')
  %delete
endfunction
"}}}
function! s:suite_f.multibyte_char() abort  "{{{
  " #1
  set ambiwidth=single
  call append(0, ['αb', 'cd', 'ef'])
  normal 1G$\ff
  call g:assert.equals(getpos('.')[1:2], [3, 2], 'failed at #1')
  %delete

  " #2
  set ambiwidth=single
  call append(0, ['ab', 'cd', 'εf'])
  normal 1G$\ff
  call g:assert.equals(getpos('.')[1:2], [3, strlen('ε')+1], 'failed at #2')
  %delete

  " #3
  set ambiwidth=single
  call append(0, ['αb', 'cd', 'ef'])
  normal 1G\fe
  call g:assert.equals(getpos('.')[1:2], [3, 1], 'failed at #3')
  %delete

  " #4
  set ambiwidth=single
  call append(0, ['ab', 'cd', 'εf'])
  normal 1G\fε
  call g:assert.equals(getpos('.')[1:2], [3, 1], 'failed at #4')
  %delete
endfunction
"}}}
function! s:suite_f.visual_mode() abort "{{{
  " #1
  call append(0, ['abc', 'def'])
  normal 1Gv\fdd
  call g:assert.equals(getpos('.')[1:2], [1, 1], 'failed at #1')
  call g:assert.equals(getline('.'), 'ef', 'failed at #1')
  %delete

  " #2
  call append(0, ['abc', 'def'])
  normal 1Gv\fz
  call g:assert.equals(mode(), 'v', 'failed at #2')
  execute "normal! \<Esc>"
  %delete
endfunction
"}}}
function! s:suite_f.operator_pending_mode() abort "{{{
  " #1
  mapclear
  mapclear!
  call columnmove#utility#map('o', 'f', '\f')
  call append(0, ['abc', 'def'])
  normal 1Gd\fd
  call g:assert.equals(getpos('.')[1:2], [1, 1], 'failed at #1')
  call g:assert.equals(getline('.'), '', 'failed at #1')
  %delete

  " #2
  mapclear
  mapclear!
  call columnmove#utility#map('o', 'f', '\f', 'V')
  call append(0, ['abc', 'def'])
  normal 1Gd\fd
  call g:assert.equals(getpos('.')[1:2], [1, 1], 'failed at #2')
  call g:assert.equals(getline('.'), '', 'failed at #2')
  %delete

  " #3
  mapclear
  mapclear!
  call columnmove#utility#map('o', 'f', '\f', 'line')
  call append(0, ['abc', 'def'])
  normal 1Gd\fd
  call g:assert.equals(getpos('.')[1:2], [1, 1], 'failed at #3')
  call g:assert.equals(getline('.'), '', 'failed at #3')
  %delete

  " #4
  mapclear
  mapclear!
  call columnmove#utility#map('o', 'f', '\f', 'char')
  call append(0, ['abc', 'def'])
  normal 1Gd\fd
  call g:assert.equals(getpos('.')[1:2], [1, 1], 'failed at #4')
  call g:assert.equals(getline('.'), 'ef', 'failed at #4')
  %delete

  " #5
  mapclear
  mapclear!
  call columnmove#utility#map('o', 'f', '\f', 'v')
  call append(0, ['abc', 'def'])
  normal 1Gd\fd
  call g:assert.equals(getpos('.')[1:2], [1, 1], 'failed at #5')
  call g:assert.equals(getline('.'), 'ef', 'failed at #5')
  %delete

  " #6
  mapclear
  mapclear!
  call columnmove#utility#map('o', 'f', '\f', '')
  call append(0, ['abc', 'def'])
  normal 1Gd\fd
  call g:assert.equals(getpos('.')[1:2], [1, 1], 'failed at #6')
  call g:assert.equals(getline('.'), 'def', 'failed at #6')
  %delete

  " #7
  mapclear
  mapclear!
  call columnmove#utility#map('o', 'f', '\f', 'block')
  call append(0, ['abc', 'def'])
  normal 1Gd\fd
  call g:assert.equals(getpos('.')[1:2], [1, 1], 'failed at #7')
  call g:assert.equals(getline(1), 'bc', 'failed at #7')
  call g:assert.equals(getline(2), 'ef', 'failed at #7')
  %delete

  " #8
  mapclear
  mapclear!
  call columnmove#utility#map('o', 'f', '\f', "\<C-v>")
  call append(0, ['abc', 'def'])
  normal 1Gd\fd
  call g:assert.equals(getpos('.')[1:2], [1, 1], 'failed at #8')
  call g:assert.equals(getline(1), 'bc', 'failed at #8')
  call g:assert.equals(getline(2), 'ef', 'failed at #8')
  %delete
endfunction
"}}}

let s:suite_F = themis#suite('columnmove-F:')
function! s:suite_F.before_each() abort  "{{{
  mapclear
  mapclear!
  call columnmove#utility#map('nxo', 'F', '\F')
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
function! s:suite_F.after() abort  "{{{
  call s:suite_F.before_each()
endfunction
"}}}

function! s:suite_F.positioning() abort "{{{
  " #1
  call append(0, ['abc', 'def', 'ghi'])
  normal 3G\Fa
  call g:assert.equals(getpos('.')[1:2], [1, 1], 'failed at #1')
  %delete

  " #2
  call append(0, ['abc', 'def', 'ghi'])
  normal 3G\Fd
  call g:assert.equals(getpos('.')[1:2], [2, 1], 'failed at #2')
  %delete

  " #3
  call append(0, ['abc', 'def', 'ghi'])
  normal 3G\Fg
  call g:assert.equals(getpos('.')[1:2], [3, 1], 'failed at #3')
  %delete

  " #4
  call append(0, ['abc', 'def', 'ghi'])
  normal 3Gl\Fb
  call g:assert.equals(getpos('.')[1:2], [1, 2], 'failed at #4')
  %delete

  " #5
  call append(0, ['abc', 'def', 'ghi'])
  normal 3Gl\Fe
  call g:assert.equals(getpos('.')[1:2], [2, 2], 'failed at #5')
  %delete

  " #6
  call append(0, ['abc', 'def', 'ghi'])
  normal 3Gl\Fh
  call g:assert.equals(getpos('.')[1:2], [3, 2], 'failed at #6')
  %delete

  " #7
  call append(0, ['abc', 'def', 'ghi'])
  normal 3G2l\Fc
  call g:assert.equals(getpos('.')[1:2], [1, 3], 'failed at #7')
  %delete

  " #8
  call append(0, ['abc', 'def', 'ghi'])
  normal 3G2l\Ff
  call g:assert.equals(getpos('.')[1:2], [2, 3], 'failed at #8')
  %delete

  " #9
  call append(0, ['abc', 'def', 'ghi'])
  normal 3G2l\Fi
  call g:assert.equals(getpos('.')[1:2], [3, 3], 'failed at #9')
  %delete

  " #10
  call append(0, ['abc', 'def', 'ghi', 'abc'])
  normal 4G\Fa
  call g:assert.equals(getpos('.')[1:2], [1, 1], 'failed at #10')
  %delete

  " #11
  call append(0, ['abc', 'def', 'ghi', 'abc'])
  normal 4Gl\Fb
  call g:assert.equals(getpos('.')[1:2], [1, 2], 'failed at #11')
  %delete

  " #12
  call append(0, ['abc', 'def', 'ghi', 'abc'])
  normal 4G2l\Fc
  call g:assert.equals(getpos('.')[1:2], [1, 3], 'failed at #12')
  %delete

  " #13
  call append(0, ['abc'])
  normal 1G\Fa
  call g:assert.equals(getpos('.')[1:2], [1, 1], 'failed at #13')
  %delete
endfunction
"}}}
function! s:suite_F.fold() abort  "{{{
  " #1
  " skip fold
  let g:columnmove_fold_open = 0
  call append(0, ['b', 'a', 'b', 'c'])
  2,3fold
  normal 4G\Fb
  call g:assert.equals(getpos('.')[1:2], [1, 1], 'failed at #1')
  %delete

  " #2
  " open fold
  let g:columnmove_fold_open = 1
  call append(0, ['b', 'a', 'b', 'c'])
  2,3fold
  normal 4G\Fb
  call g:assert.equals(getpos('.')[1:2], [3, 1], 'failed at #2')
  %delete

  " #3
  " open fold (beyond a fold)
  let g:columnmove_fold_open = 1
  call append(0, ['a', 'b', 'c', 'd'])
  2,3fold
  normal 4G\Fa
  call g:assert.equals(getpos('.')[1:2], [1, 1], 'failed at #3')
  %delete

  " #4
  " open fold (deep fold)
  let g:columnmove_fold_open = 1
  call append(0, ['c', 'a', 'b', 'c', 'd', 'e'])
  3,4fold
  2,5fold
  normal 6G\Fc
  call g:assert.equals(getpos('.')[1:2], [1, 1], 'failed at #4')
  %delete

  " #5
  " open fold (deep fold)
  let g:columnmove_fold_open = 2
  call append(0, ['c', 'a', 'b', 'c', 'd', 'e'])
  3,4fold
  2,5fold
  normal 6G\Fc
  call g:assert.equals(getpos('.')[1:2], [4, 1], 'failed at #5')
  %delete

  " #6
  " open fold (relatively)
  let g:columnmove_fold_open = -1
  call append(0, ['c', 'a', 'b', 'c', 'd', 'e'])
  3,4fold
  normal 6G\Fc
  call g:assert.equals(getpos('.')[1:2], [4, 1], 'failed at #6')
  %delete

  " #7
  " open fold (relatively)
  let g:columnmove_fold_open = -1
  call append(0, ['c', 'a', 'b', 'c', 'd', 'e'])
  3,4fold
  2,5fold
  normal 6G\Fc
  call g:assert.equals(getpos('.')[1:2], [1, 1], 'failed at #7')
  %delete

  " #8
  " open fold (relatively)
  let g:columnmove_fold_open = -2
  call append(0, ['c', 'a', 'b', 'c', 'd', 'e'])
  3,4fold
  2,5fold
  normal 6G\Fc
  call g:assert.equals(getpos('.')[1:2], [4, 1], 'failed at #8')
  %delete
endfunction
"}}}
function! s:suite_F.count() abort "{{{
  " #1
  call append(0, ['a', 'a', 'a', 'b'])
  normal 4G\Fa
  call g:assert.equals(getpos('.')[1:2], [3, 1], 'failed at #1')
  %delete

  " #2
  call append(0, ['a', 'a', 'a', 'b'])
  normal 4G2\Fa
  call g:assert.equals(getpos('.')[1:2], [2, 1], 'failed at #2')
  %delete

  " #3
  call append(0, ['a', 'a', 'a', 'b'])
  normal 4G3\Fa
  call g:assert.equals(getpos('.')[1:2], [1, 1], 'failed at #3')
  %delete
endfunction
"}}}
function! s:suite_F.curswant() abort  "{{{
  " #1
  call append(0, ['abc', '', 'd', 'efg'])
  normal 4G$k\Fa
  call g:assert.equals(getpos('.')[1:2], [1, 1], 'failed at #1')
  %delete
endfunction
"}}}
function! s:suite_F.tab_char() abort  "{{{
  " #1
  set tabstop=4
  call append(0, ["\ta", 'bcdef', 'ghijk'])
  normal 3G$\Fa
  call g:assert.equals(getpos('.')[1:2], [1, 2], 'failed at #1')
  %delete

  " #2
  set tabstop=4
  call append(0, ['abcde', 'fghij', "\tk"])
  normal 3G$\Fe
  call g:assert.equals(getpos('.')[1:2], [1, 5], 'failed at #2')
  %delete

  " #3
  set tabstop=4
  call append(0, ["\ta", 'bcdef', 'ghijk'])
  execute "normal 3G0\\F\t"
  call g:assert.equals(getpos('.')[1:2], [1, 1], 'failed at #3')
  %delete

  " #4
  " set tabstop=4
  " call append(0, ['abcde', 'fghij', "\tk"])
  " normal 3G0\Fa
  " call g:assert.equals(getpos('.')[1:2], [1, 1], 'failed at #4')
  " %delete
endfunction
"}}}
function! s:suite_F.multibyte_char() abort  "{{{
  " #1
  set ambiwidth=single
  call append(0, ['αb', 'cd', 'ef'])
  normal 3G$\Fb
  call g:assert.equals(getpos('.')[1:2], [1, strlen('α')+1], 'failed at #1')
  %delete

  " #2
  set ambiwidth=single
  call append(0, ['ab', 'cd', 'εf'])
  normal 3G$\Fb
  call g:assert.equals(getpos('.')[1:2], [1, 2], 'failed at #2')
  %delete

  " #3
  set ambiwidth=single
  call append(0, ['αb', 'cd', 'ef'])
  normal 3G0\Fα
  call g:assert.equals(getpos('.')[1:2], [1, 1], 'failed at #3')
  %delete

  " #4
  set ambiwidth=single
  call append(0, ['ab', 'cd', 'εf'])
  normal 3G0\Fa
  call g:assert.equals(getpos('.')[1:2], [1, 1], 'failed at #4')
  %delete
endfunction
"}}}
function! s:suite_F.visual_mode() abort "{{{
  " #1
  call append(0, ['abc', 'def'])
  normal 2Gv\Fad
  call g:assert.equals(getpos('.')[1:2], [1, 1], 'failed at #1')
  call g:assert.equals(getline('.'), 'ef', 'failed at #1')
  %delete

  " #2
  call append(0, ['abc', 'def'])
  normal 2Gv\Fzd
  call g:assert.equals(mode(), 'v', 'failed at #2')
  execute "normal! \<Esc>"
  %delete
endfunction
"}}}
function! s:suite_F.operator_pending_mode() abort "{{{
  " #1
  mapclear
  mapclear!
  call columnmove#utility#map('o', 'F', '\F')
  call append(0, ['abc', 'def'])
  normal 2Gd\Fa
  call g:assert.equals(getpos('.')[1:2], [1, 1], 'failed at #1')
  call g:assert.equals(getline('.'), '', 'failed at #1')
  %delete

  " #2
  mapclear
  mapclear!
  call columnmove#utility#map('o', 'F', '\F', 'V')
  call append(0, ['abc', 'def'])
  normal 2Gd\Fa
  call g:assert.equals(getpos('.')[1:2], [1, 1], 'failed at #2')
  call g:assert.equals(getline('.'), '', 'failed at #2')
  %delete

  " #3
  mapclear
  mapclear!
  call columnmove#utility#map('o', 'F', '\F', 'line')
  call append(0, ['abc', 'def'])
  normal 2Gd\Fa
  call g:assert.equals(getpos('.')[1:2], [1, 1], 'failed at #3')
  call g:assert.equals(getline('.'), '', 'failed at #3')
  %delete

  " #4
  mapclear
  mapclear!
  call columnmove#utility#map('o', 'F', '\F', 'char')
  call append(0, ['abc', 'def'])
  normal 2Gd\Fa
  call g:assert.equals(getpos('.')[1:2], [1, 1], 'failed at #4')
  call g:assert.equals(getline('.'), 'ef', 'failed at #4')
  %delete

  " #5
  mapclear
  mapclear!
  call columnmove#utility#map('o', 'F', '\F', 'v')
  call append(0, ['abc', 'def'])
  normal 2Gd\Fa
  call g:assert.equals(getpos('.')[1:2], [1, 1], 'failed at #5')
  call g:assert.equals(getline('.'), 'ef', 'failed at #5')
  %delete

  " #6
  mapclear
  mapclear!
  call columnmove#utility#map('o', 'F', '\F', '')
  call append(0, ['abc', 'def'])
  normal 2Gd\Fa
  call g:assert.equals(getpos('.')[1:2], [1, 1], 'failed at #6')
  call g:assert.equals(getline('.'), 'def', 'failed at #6')
  %delete

  " #7
  mapclear
  mapclear!
  call columnmove#utility#map('o', 'F', '\F', 'block')
  call append(0, ['abc', 'def'])
  normal 2Gd\Fa
  call g:assert.equals(getpos('.')[1:2], [1, 1], 'failed at #7')
  call g:assert.equals(getline(1), 'bc', 'failed at #7')
  call g:assert.equals(getline(2), 'ef', 'failed at #7')
  %delete

  " #8
  mapclear
  mapclear!
  call columnmove#utility#map('o', 'F', '\F', "\<C-v>")
  call append(0, ['abc', 'def'])
  normal 2Gd\Fa
  call g:assert.equals(getpos('.')[1:2], [1, 1], 'failed at #8')
  call g:assert.equals(getline(1), 'bc', 'failed at #8')
  call g:assert.equals(getline(2), 'ef', 'failed at #8')
  %delete
endfunction
"}}}



" vim:set foldmethod=marker:
" vim:set commentstring="%s:
" vim:set ts=2 sts=2 sw=2 et:
