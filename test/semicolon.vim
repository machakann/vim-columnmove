let s:suite = themis#suite('columnmove-;:')
function! s:suite.before_each() abort  "{{{
  mapclear
  mapclear!
  set tabstop&
  set ambiwidth&
  set commentstring&
  set foldmethod&
  set softtabstop&
  set shiftwidth&
  set expandtab&
  call columnmove#utility#map('nxo', 'f', '\f')
  call columnmove#utility#map('nxo', 't', '\t')
  call columnmove#utility#map('nxo', ';', '\;')
  %delete
endfunction
"}}}
function! s:suite.after() abort  "{{{
  call s:suite.before_each()
  mapclear
  mapclear!
endfunction
"}}}

function! s:suite.positioning() abort "{{{
  " #1
  call append(0, ['abc', 'def', 'ghi'])
  normal 1G\fa1G\;
  call g:assert.equals(getpos('.')[1:2], [1, 1], 'failed at #1')
  %delete

  " #2
  call append(0, ['abc', 'def', 'ghi'])
  normal 1G\fd1G\;
  call g:assert.equals(getpos('.')[1:2], [2, 1], 'failed at #2')
  %delete

  " #3
  call append(0, ['abc', 'def', 'ghi'])
  normal 1G\fg1G\;
  call g:assert.equals(getpos('.')[1:2], [3, 1], 'failed at #3')
  %delete

  " #4
  call append(0, ['abc', 'def', 'ghi'])
  normal 1Gl\fb1Gl\;
  call g:assert.equals(getpos('.')[1:2], [1, 2], 'failed at #4')
  %delete

  " #5
  call append(0, ['abc', 'def', 'ghi'])
  normal 1Gl\fe1Gl\;
  call g:assert.equals(getpos('.')[1:2], [2, 2], 'failed at #5')
  %delete

  " #6
  call append(0, ['abc', 'def', 'ghi'])
  normal 1Gl\fh1Gl\;
  call g:assert.equals(getpos('.')[1:2], [3, 2], 'failed at #6')
  %delete

  " #7
  call append(0, ['abc', 'def', 'ghi'])
  normal 1G2l\fc1G2l\;
  call g:assert.equals(getpos('.')[1:2], [1, 3], 'failed at #7')
  %delete

  " #8
  call append(0, ['abc', 'def', 'ghi'])
  normal 1G2l\ff1G2l\;
  call g:assert.equals(getpos('.')[1:2], [2, 3], 'failed at #8')
  %delete

  " #9
  call append(0, ['abc', 'def', 'ghi'])
  normal 1G2l\fi1G2l\;
  call g:assert.equals(getpos('.')[1:2], [3, 3], 'failed at #9')
  %delete

  " #10
  call append(0, ['abc', 'def', 'ghi', 'abc'])
  normal 1G\fa1G\;
  call g:assert.equals(getpos('.')[1:2], [4, 1], 'failed at #10')
  %delete

  " #11
  call append(0, ['abc', 'def', 'ghi', 'abc'])
  normal 1Gl\fb1Gl\;
  call g:assert.equals(getpos('.')[1:2], [4, 2], 'failed at #11')
  %delete

  " #12
  call append(0, ['abc', 'def', 'ghi', 'abc'])
  normal 1G2l\fc1G2l\;
  call g:assert.equals(getpos('.')[1:2], [4, 3], 'failed at #12')
  %delete
endfunction
"}}}
function! s:suite.count() abort "{{{
  " #1
  call append(0, ['a', 'b', 'b', 'b'])
  normal 1G\fb\;
  call g:assert.equals(getpos('.')[1:2], [3, 1], 'failed at #1')
  %delete

  " #2
  call append(0, ['a', 'b', 'b', 'b'])
  normal 1G2\fb\;
  call g:assert.equals(getpos('.')[1:2], [4, 1], 'failed at #2')
  %delete

  " #3
  call append(0, ['a', 'b', 'b', 'b'])
  normal 1G3\fb\;
  call g:assert.equals(getpos('.')[1:2], [4, 1], 'failed at #3')
  %delete

  " #4
  call append(0, ['a', 'b', 'b', 'b'])
  normal 1G\fb2\;
  call g:assert.equals(getpos('.')[1:2], [4, 1], 'failed at #4')
  %delete

  " #5
  call append(0, ['a', 'b', 'b', 'b'])
  normal 1G\fb3\;
  call g:assert.equals(getpos('.')[1:2], [2, 1], 'failed at #5')
  %delete
endfunction
"}}}


" vim:set foldmethod=marker:
" vim:set commentstring="%s:
" vim:set ts=2 sts=2 sw=2 et:
