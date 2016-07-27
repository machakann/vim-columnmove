" NOTE: Since auto-commands are not ignited inside test functions, use
"       g:columnmove#interrupt() to reset explicitly.

let s:suite_b = themis#suite('columnmove-b:')
function! s:suite_b.before_each() abort  "{{{
  mapclear
  mapclear!
  call columnmove#utility#map('nxo', 'b', '\b')
  set tabstop&
  set ambiwidth&
  set commentstring&
  set foldmethod&
  set softtabstop&
  set shiftwidth&
  set expandtab&
  unlet! g:columnmove_fold_open
  unlet! g:columnmove_expand_range
  unlet! g:columnmove_fold_treatment
  unlet! g:columnmove_strict_wbege
  unlet! g:columnmove_stop_on_space
  call columnmove#interrupt()
  %delete
endfunction
"}}}
function! s:suite_b.after() abort  "{{{
  call s:suite_b.before_each()
  mapclear
  mapclear!
endfunction
"}}}

function! s:suite_b.strict() abort  "{{{
  let g:columnmove_strict_wbege = 1

  " #1
  call append(0, ['a', 'b', ';', 'c', 'd'])
  normal 1G0\b
  call g:assert.equals(line('.'), 1, 'failed at #1')
  call columnmove#interrupt()
  %delete

  " #2
  call append(0, ['a', 'b', ';', 'c', 'd'])
  normal 2G0\b
  call g:assert.equals(line('.'), 1, 'failed at #2')
  call columnmove#interrupt()
  %delete

  " #3
  call append(0, ['a', 'b', ';', 'c', 'd'])
  normal 3G0\b
  call g:assert.equals(line('.'), 1, 'failed at #3')
  call columnmove#interrupt()
  %delete

  " #4
  call append(0, ['a', 'b', ';', 'c', 'd'])
  normal 4G0\b
  call g:assert.equals(line('.'), 3, 'failed at #4')
  call columnmove#interrupt()
  %delete

  " #5
  call append(0, ['a', 'b', ';', 'c', 'd'])
  normal 5G0\b
  call g:assert.equals(line('.'), 4, 'failed at #5')
  call columnmove#interrupt()
  %delete

  " #6
  call append(0, ['a', 'b', ' ', 'c', 'd'])
  normal 1G0\b
  call g:assert.equals(line('.'), 1, 'failed at #6')
  call columnmove#interrupt()
  %delete

  " #7
  call append(0, ['a', 'b', ' ', 'c', 'd'])
  normal 2G0\b
  call g:assert.equals(line('.'), 1, 'failed at #7')
  call columnmove#interrupt()
  %delete

  " #8
  call append(0, ['a', 'b', ' ', 'c', 'd'])
  normal 3G0\b
  call g:assert.equals(line('.'), 1, 'failed at #8')
  call columnmove#interrupt()
  %delete

  " #9
  call append(0, ['a', 'b', ' ', 'c', 'd'])
  normal 4G0\b
  call g:assert.equals(line('.'), 1, 'failed at #9')
  call columnmove#interrupt()
  %delete

  " #10
  call append(0, ['a', 'b', ' ', 'c', 'd'])
  normal 5G0\b
  call g:assert.equals(line('.'), 4, 'failed at #10')
  call columnmove#interrupt()
  %delete

  " #11
  call append(0, ['a', 'b', '', 'c', 'd'])
  normal 1G0\b
  call g:assert.equals(line('.'), 1, 'failed at #11')
  call columnmove#interrupt()
  %delete

  " #12
  call append(0, ['a', 'b', '', 'c', 'd'])
  normal 2G0\b
  call g:assert.equals(line('.'), 1, 'failed at #12')
  call columnmove#interrupt()
  %delete

  " #13
  call append(0, ['a', 'b', '', 'c', 'd'])
  normal 3G0\b
  call g:assert.equals(line('.'), 1, 'failed at #13')
  call columnmove#interrupt()
  %delete

  " #14
  call append(0, ['a', 'b', '', 'c', 'd'])
  normal 4G0\b
  call g:assert.equals(line('.'), 1, 'failed at #14')
  call columnmove#interrupt()
  %delete

  " #15
  call append(0, ['a', 'b', '', 'c', 'd'])
  normal 5G0\b
  call g:assert.equals(line('.'), 4, 'failed at #15')
  call columnmove#interrupt()
  %delete

  " #16
  call append(0, [';', ':', 'a', ',', '.'])
  normal 1G0\b
  call g:assert.equals(line('.'), 1, 'failed at #16')
  call columnmove#interrupt()
  %delete

  " #17
  call append(0, [';', ':', 'a', ',', '.'])
  normal 2G0\b
  call g:assert.equals(line('.'), 1, 'failed at #17')
  call columnmove#interrupt()
  %delete

  " #18
  call append(0, [';', ':', 'a', ',', '.'])
  normal 3G0\b
  call g:assert.equals(line('.'), 1, 'failed at #18')
  call columnmove#interrupt()
  %delete

  " #19
  call append(0, [';', ':', 'a', ',', '.'])
  normal 4G0\b
  call g:assert.equals(line('.'), 3, 'failed at #19')
  call columnmove#interrupt()
  %delete

  " #20
  call append(0, [';', ':', 'a', ',', '.'])
  normal 5G0\b
  call g:assert.equals(line('.'), 4, 'failed at #20')
  call columnmove#interrupt()
  %delete

  " #21
  call append(0, [';', ':', ' ', ',', '.'])
  normal 1G0\b
  call g:assert.equals(line('.'), 1, 'failed at #21')
  call columnmove#interrupt()
  %delete

  " #22
  call append(0, [';', ':', ' ', ',', '.'])
  normal 2G0\b
  call g:assert.equals(line('.'), 1, 'failed at #22')
  call columnmove#interrupt()
  %delete

  " #23
  call append(0, [';', ':', ' ', ',', '.'])
  normal 3G0\b
  call g:assert.equals(line('.'), 1, 'failed at #23')
  call columnmove#interrupt()
  %delete

  " #24
  call append(0, [';', ':', ' ', ',', '.'])
  normal 4G0\b
  call g:assert.equals(line('.'), 1, 'failed at #24')
  call columnmove#interrupt()
  %delete

  " #25
  call append(0, [';', ':', ' ', ',', '.'])
  normal 5G0\b
  call g:assert.equals(line('.'), 4, 'failed at #25')
  call columnmove#interrupt()
  %delete

  " #26
  call append(0, [';', ':', '', ',', '.'])
  normal 1G0\b
  call g:assert.equals(line('.'), 1, 'failed at #26')
  call columnmove#interrupt()
  %delete

  " #27
  call append(0, [';', ':', '', ',', '.'])
  normal 2G0\b
  call g:assert.equals(line('.'), 1, 'failed at #27')
  call columnmove#interrupt()
  %delete

  " #28
  call append(0, [';', ':', '', ',', '.'])
  normal 3G0\b
  call g:assert.equals(line('.'), 1, 'failed at #28')
  call columnmove#interrupt()
  %delete

  " #29
  call append(0, [';', ':', '', ',', '.'])
  normal 4G0\b
  call g:assert.equals(line('.'), 1, 'failed at #29')
  call columnmove#interrupt()
  %delete

  " #30
  call append(0, [';', ':', '', ',', '.'])
  normal 5G0\b
  call g:assert.equals(line('.'), 4, 'failed at #30')
  call columnmove#interrupt()
  %delete

  " #31
  call append(0, [' ', ' ', 'a', ' ', ' '])
  normal 1G0\b
  call g:assert.equals(line('.'), 1, 'failed at #31')
  call columnmove#interrupt()
  %delete

  " #32
  call append(0, [' ', ' ', 'a', ' ', ' '])
  normal 2G0\b
  call g:assert.equals(line('.'), 2, 'failed at #32')
  call columnmove#interrupt()
  %delete

  " #33
  call append(0, [' ', ' ', 'a', ' ', ' '])
  normal 3G0\b
  call g:assert.equals(line('.'), 3, 'failed at #33')
  call columnmove#interrupt()
  %delete

  " #34
  call append(0, [' ', ' ', 'a', ' ', ' '])
  normal 4G0\b
  call g:assert.equals(line('.'), 3, 'failed at #34')
  call columnmove#interrupt()
  %delete

  " #35
  call append(0, [' ', ' ', 'a', ' ', ' '])
  normal 5G0\b
  call g:assert.equals(line('.'), 3, 'failed at #35')
  call columnmove#interrupt()
  %delete

  " #36
  call append(0, [' ', ' ', ';', ' ', ' '])
  normal 1G0\b
  call g:assert.equals(line('.'), 1, 'failed at #36')
  call columnmove#interrupt()
  %delete

  " #37
  call append(0, [' ', ' ', ';', ' ', ' '])
  normal 2G0\b
  call g:assert.equals(line('.'), 2, 'failed at #37')
  call columnmove#interrupt()
  %delete

  " #38
  call append(0, [' ', ' ', ';', ' ', ' '])
  normal 3G0\b
  call g:assert.equals(line('.'), 3, 'failed at #38')
  call columnmove#interrupt()
  %delete

  " #39
  call append(0, [' ', ' ', ';', ' ', ' '])
  normal 4G0\b
  call g:assert.equals(line('.'), 3, 'failed at #39')
  call columnmove#interrupt()
  %delete

  " #40
  call append(0, [' ', ' ', ';', ' ', ' '])
  normal 5G0\b
  call g:assert.equals(line('.'), 3, 'failed at #40')
  call columnmove#interrupt()
  %delete

  " #41
  call append(0, [' ', ' ', '', ' ', ' '])
  normal 1G0\b
  call g:assert.equals(line('.'), 1, 'failed at #41')
  call columnmove#interrupt()
  %delete

  " #42
  call append(0, [' ', ' ', '', ' ', ' '])
  normal 2G0\b
  call g:assert.equals(line('.'), 2, 'failed at #42')
  call columnmove#interrupt()
  %delete

  " #43
  call append(0, [' ', ' ', '', ' ', ' '])
  normal 3G0\b
  call g:assert.equals(line('.'), 3, 'failed at #43')
  call columnmove#interrupt()
  %delete

  " #44
  call append(0, [' ', ' ', '', ' ', ' '])
  normal 4G0\b
  call g:assert.equals(line('.'), 4, 'failed at #44')
  call columnmove#interrupt()
  %delete

  " #45
  call append(0, [' ', ' ', '', ' ', ' '])
  normal 5G0\b
  call g:assert.equals(line('.'), 5, 'failed at #45')
  call columnmove#interrupt()
  %delete

  " #46
  call append(0, ['', '', 'a', '', ''])
  normal 1G0\b
  call g:assert.equals(line('.'), 1, 'failed at #46')
  call columnmove#interrupt()
  %delete

  " #47
  call append(0, ['', '', 'a', '', ''])
  normal 2G0\b
  call g:assert.equals(line('.'), 2, 'failed at #47')
  call columnmove#interrupt()
  %delete

  " #48
  call append(0, ['', '', 'a', '', ''])
  normal 3G0\b
  call g:assert.equals(line('.'), 3, 'failed at #48')
  call columnmove#interrupt()
  %delete

  " #49
  call append(0, ['', '', 'a', '', ''])
  normal 4G0\b
  call g:assert.equals(line('.'), 3, 'failed at #49')
  call columnmove#interrupt()
  %delete

  " #50
  call append(0, ['', '', 'a', '', ''])
  normal 5G0\b
  call g:assert.equals(line('.'), 3, 'failed at #50')
  call columnmove#interrupt()
  %delete

  " #51
  call append(0, ['', '', ';', '', ''])
  normal 1G0\b
  call g:assert.equals(line('.'), 1, 'failed at #51')
  call columnmove#interrupt()
  %delete

  " #52
  call append(0, ['', '', ';', '', ''])
  normal 2G0\b
  call g:assert.equals(line('.'), 2, 'failed at #52')
  call columnmove#interrupt()
  %delete

  " #53
  call append(0, ['', '', ';', '', ''])
  normal 3G0\b
  call g:assert.equals(line('.'), 3, 'failed at #53')
  call columnmove#interrupt()
  %delete

  " #54
  call append(0, ['', '', ';', '', ''])
  normal 4G0\b
  call g:assert.equals(line('.'), 3, 'failed at #54')
  call columnmove#interrupt()
  %delete

  " #55
  call append(0, ['', '', ';', '', ''])
  normal 5G0\b
  call g:assert.equals(line('.'), 3, 'failed at #55')
  call columnmove#interrupt()
  %delete

  " #56
  call append(0, ['', '', ' ', '', ''])
  normal 1G0\b
  call g:assert.equals(line('.'), 1, 'failed at #56')
  call columnmove#interrupt()
  %delete

  " #57
  call append(0, ['', '', ' ', '', ''])
  normal 2G0\b
  call g:assert.equals(line('.'), 2, 'failed at #57')
  call columnmove#interrupt()
  %delete

  " #58
  call append(0, ['', '', ' ', '', ''])
  normal 3G0\b
  call g:assert.equals(line('.'), 3, 'failed at #58')
  call columnmove#interrupt()
  %delete

  " #59
  call append(0, ['', '', ' ', '', ''])
  normal 4G0\b
  call g:assert.equals(line('.'), 4, 'failed at #59')
  call columnmove#interrupt()
  %delete

  " #60
  call append(0, ['', '', ' ', '', ''])
  normal 5G0\b
  call g:assert.equals(line('.'), 5, 'failed at #60')
  call columnmove#interrupt()
  %delete

  " #61
  call append(0, ['a', 'b', '', 'c', 'd', '', 'e'])
  normal 7G0\b
  call g:assert.equals(line('.'), 4, 'failed at #61')
  normal \b
  call g:assert.equals(line('.'), 1, 'failed at #61')
  call columnmove#interrupt()
  %delete
endfunction
"}}}
function! s:suite_b.strict_count() abort "{{{
  let g:columnmove_strict_wbege = 1

  " #1
  call append(0, ['a', 'b', ' ', 'c', 'd', ':', 'e'])
  normal 7G0\b
  call g:assert.equals(line('.'), 6, 'failed at #1')
  call columnmove#interrupt()
  %delete

  " #2
  call append(0, ['a', 'b', ' ', 'c', 'd', ':', 'e'])
  normal 7G02\b
  call g:assert.equals(line('.'), 4, 'failed at #2')
  call columnmove#interrupt()
  %delete

  " #3
  call append(0, ['a', 'b', ' ', 'c', 'd', ':', 'e'])
  normal 7G03\b
  call g:assert.equals(line('.'), 1, 'failed at #3')
  call columnmove#interrupt()
  %delete

  " #3
  call append(0, ['a', 'b', ' ', 'c', 'd', ':', 'e'])
  normal 7G04\b
  call g:assert.equals(line('.'), 7, 'failed at #3')
  call columnmove#interrupt()
  %delete
endfunction
"}}}
function! s:suite_b.strict_fold() abort  "{{{
  let g:columnmove_strict_wbege = 1

  " #1
  call append(0, ['a', 'b', '', 'c', 'd', 'e', 'f'])
  1,2fold
  normal 7G0\b
  call g:assert.equals(line('.'), 4, 'failed at #1')
  call columnmove#interrupt()
  %delete

  " #2
  call append(0, ['a', 'b', '', 'c', 'd', 'e', 'f'])
  2,3fold
  normal 7G0\b
  call g:assert.equals(line('.'), 1, 'failed at #2')
  call columnmove#interrupt()
  %delete

  " #3
  call append(0, ['a', 'b', '', 'c', 'd', 'e', 'f'])
  3,4fold
  normal 7G0\b
  call g:assert.equals(line('.'), 1, 'failed at #3')
  call columnmove#interrupt()
  %delete

  " #4
  call append(0, ['a', 'b', '', 'c', 'd', 'e', 'f'])
  4,5fold
  normal 7G0\b
  call g:assert.equals(line('.'), 6, 'failed at #4')
  call columnmove#interrupt()
  %delete

  " #5
  call append(0, ['a', 'b', '', 'c', 'd', 'e', 'f'])
  5,6fold
  normal 7G0\b
  call g:assert.equals(line('.'), 4, 'failed at #5')
  call columnmove#interrupt()
  %delete

  " #6
  call append(0, ['a', 'b', '', 'c', 'd', 'e', 'f'])
  6,7fold
  normal 7G0\b
  call g:assert.equals(line('.'), 4, 'failed at #6')
  call columnmove#interrupt()
  %delete

  " #7
  call append(0, ['a', 'b', '', 'c', 'd', 'e', 'f', 'g'])
  5,6fold
  normal 8G0\b
  call g:assert.equals(line('.'), 4, 'failed at #7')
  call columnmove#interrupt()
  %delete
endfunction
"}}}
function! s:suite_b.strict_option_fold_treatment() abort  "{{{
  let g:columnmove_strict_wbege = 1
  let g:columnmove_fold_treatment = 1

  " #1
  call append(0, ['a', 'b', '', 'c', 'd', 'e', 'f'])
  1,2fold
  normal 7G0\b
  call g:assert.equals(line('.'), 4, 'failed at #1')
  call columnmove#interrupt()
  %delete

  " #2
  call append(0, ['a', 'b', '', 'c', 'd', 'e', 'f'])
  2,3fold
  normal 7G0\b
  call g:assert.equals(line('.'), 4, 'failed at #2')
  call columnmove#interrupt()
  %delete

  " #3
  call append(0, ['a', 'b', '', 'c', 'd', 'e', 'f'])
  3,4fold
  normal 7G0\b
  call g:assert.equals(line('.'), 5, 'failed at #3')
  call columnmove#interrupt()
  %delete

  " #4
  call append(0, ['a', 'b', '', 'c', 'd', 'e', 'f'])
  4,5fold
  normal 7G0\b
  call g:assert.equals(line('.'), 6, 'failed at #4')
  call columnmove#interrupt()
  %delete

  " #5
  call append(0, ['a', 'b', '', 'c', 'd', 'e', 'f'])
  5,6fold
  normal 7G0\b
  call g:assert.equals(line('.'), 4, 'failed at #5')
  call columnmove#interrupt()
  %delete

  " #6
  call append(0, ['a', 'b', '', 'c', 'd', 'e', 'f'])
  6,7fold
  normal 7G0\b
  call g:assert.equals(line('.'), 4, 'failed at #6')
  call columnmove#interrupt()
  %delete

  " #7
  call append(0, ['a', 'b', '', 'c', 'd', 'e', 'f', 'g'])
  5,6fold
  normal 8G0\b
  call g:assert.equals(line('.'), 7, 'failed at #7')
  call columnmove#interrupt()
  %delete
endfunction
"}}}
function! s:suite_b.strict_option_fold_open() abort  "{{{
  let g:columnmove_strict_wbege = 1
  let g:columnmove_fold_open = 1

  " #1
  call append(0, ['a', 'b', ':', 'c', 'd'])
  2,4fold
  normal 5G\b
  call g:assert.equals(line('.'), 4, 'failed at #1')
  call g:assert.equals(foldclosed(2),    -1, 'failed at #1')
  call g:assert.equals(foldclosedend(2), -1, 'failed at #1')
  call columnmove#interrupt()
  %delete

  " #2
  call append(0, ['a', 'b', ' ', 'c', 'd'])
  2,4fold
  normal 5G\b
  call g:assert.equals(line('.'), 4, 'failed at #2')
  call g:assert.equals(foldclosed(2),    -1, 'failed at #2')
  call g:assert.equals(foldclosedend(2), -1, 'failed at #2')
  call columnmove#interrupt()
  %delete

  " #3
  call append(0, ['a', 'b', '', 'c', 'd'])
  2,4fold
  normal 5G\b
  call g:assert.equals(line('.'), 4, 'failed at #3')
  call g:assert.equals(foldclosed(2),    -1, 'failed at #3')
  call g:assert.equals(foldclosedend(2), -1, 'failed at #3')
  call columnmove#interrupt()
  %delete

  " #4
  call append(0, ['a', 'b', 'c', 'd', ':'])
  2,4fold
  normal 5G\b
  call g:assert.equals(line('.'), 1, 'failed at #4')
  call g:assert.equals(foldclosed(2),    2, 'failed at #4')
  call g:assert.equals(foldclosedend(2), 4, 'failed at #4')
  call columnmove#interrupt()
  %delete

  " #5
  call append(0, ['a', 'b', 'c', ' ', 'd'])
  2,4fold
  normal 5G\b
  call g:assert.equals(line('.'), 1, 'failed at #5')
  call g:assert.equals(foldclosed(2),    2, 'failed at #5')
  call g:assert.equals(foldclosedend(2), 4, 'failed at #5')
  call columnmove#interrupt()
  %delete

  " #6
  call append(0, ['a', 'b', 'c', '', 'd'])
  2,4fold
  normal 5G\b
  call g:assert.equals(line('.'), 1, 'failed at #6')
  call g:assert.equals(foldclosed(2),    2, 'failed at #6')
  call g:assert.equals(foldclosedend(2), 4, 'failed at #6')
  call columnmove#interrupt()
  %delete
endfunction
"}}}
function! s:suite_b.strict_option_combinations() abort "{{{
  let g:columnmove_strict_wbege = 1
  let g:columnmove_fold_treatment = 1
  let g:columnmove_fold_open = 1

  " #1
  call append(0, ['a', 'b', ':', 'c', 'd', 'e'])
  2,4fold
  normal 6G\b
  call g:assert.equals(line('.'), 4, 'failed at #1')
  call columnmove#interrupt()
  %delete
endfunction
"}}}
function! s:suite_b.strict_option_stop_on_space() dict abort  "{{{
  let g:columnmove_stop_on_space = 1

  " #1
  call append(0, ['', 'aa', '  ', '', 'bb'])
  normal 5G0\b
  call g:assert.equals(line('.'), 2, 'failed at #1')
  call columnmove#interrupt()
  %delete

  " #2
  call append(0, ['', 'aa', '  ', '', 'bb'])
  normal 5G0l\b
  call g:assert.equals(line('.'), 2, 'failed at #2')
  call columnmove#interrupt()
  %delete

  " #3
  call append(0, ['', 'a ', '  ', '', 'bb'])
  normal 5G0\b
  call g:assert.equals(line('.'), 2, 'failed at #3')
  call columnmove#interrupt()
  %delete

  " #4
  call append(0, ['', 'a ', '  ', '', 'bb'])
  normal 5G0l\b
  call g:assert.equals(line('.'), 2, 'failed at #4')
  call columnmove#interrupt()
  %delete

  let g:columnmove_stop_on_space = 0

  " #5
  call append(0, ['', 'aa', '  ', '', 'bb'])
  normal 5G0\b
  call g:assert.equals(line('.'), 2, 'failed at #5')
  call columnmove#interrupt()
  %delete

  " #6
  call append(0, ['', 'aa', '  ', '', 'bb'])
  normal 5G0l\b
  call g:assert.equals(line('.'), 2, 'failed at #6')
  call columnmove#interrupt()
  %delete

  " #7
  call append(0, ['', 'a ', '  ', '', 'bb'])
  normal 5G0\b
  call g:assert.equals(line('.'), 2, 'failed at #7')
  call columnmove#interrupt()
  %delete

  " #8
  call append(0, ['', 'a ', '  ', '', 'bb'])
  normal 5G0l\b
  call g:assert.equals(line('.'), 5, 'failed at #8')
  call columnmove#interrupt()
  %delete
endfunction
"}}}
function! s:suite_b.strict_curswant() abort "{{{
  let g:columnmove_strict_wbege = 1

  " #1
  call append(0, ['abcde', '', 'fgh', 'ijklm'])
  normal 4G$k\b
  call g:assert.equals(getpos('.')[1:2], [1, 3], 'failed at #1')
  call columnmove#interrupt()
  %delete
endfunction
"}}}
function! s:suite_b.strict_tabchar() abort "{{{
  let g:columnmove_strict_wbege = 1

  " #1
  set tabstop=4
  call append(0, ['	abc', 'defghij', '', 'klmnopq'])
  normal 4G4l\b
  call g:assert.equals(getpos('.')[1:2], [1, 2], 'failed at #1')
  call columnmove#interrupt()
  %delete

  " #2
  set tabstop=4
  call append(0, ['abcdefg', 'hijklmn', '', '	opqr'])
  normal 4G\b
  call g:assert.equals(getpos('.')[1:2], [1, 5], 'failed at #2')
  call columnmove#interrupt()
  %delete
endfunction
"}}}
function! s:suite_b.strict_multibyte_char() abort "{{{
  let g:columnmove_strict_wbege = 1

  " #1
  set ambiwidth=single
  call append(0, ['αbc', 'defg', '', 'hijk'])
  normal 4G\b
  call g:assert.equals(getpos('.')[1:2], [1, 1], 'failed at #1')
  call columnmove#interrupt()
  %delete

  " #2
  set ambiwidth=single
  call append(0, ['αbc', 'defg', '', 'hijk'])
  normal 4Gl\b
  call g:assert.equals(getpos('.')[1:2], [1, strlen('α')+1], 'failed at #2')
  call columnmove#interrupt()
  %delete

  " #3
  set ambiwidth=single
  call append(0, ['αbc', 'defg', '', 'hijk'])
  normal 4G2l\b
  call g:assert.equals(getpos('.')[1:2], [1, strlen('α')+2], 'failed at #3')
  call columnmove#interrupt()
  %delete

  " #4
  set ambiwidth=single
  call append(0, ['abc', 'δefg', '', 'hijk'])
  normal 4G\b
  call g:assert.equals(getpos('.')[1:2], [1, 1], 'failed at #4')
  call columnmove#interrupt()
  %delete

  " #5
  set ambiwidth=single
  call append(0, ['abc', 'δefg', '', 'hijk'])
  normal 4Gl\b
  call g:assert.equals(getpos('.')[1:2], [1, 2], 'failed at #5')
  call columnmove#interrupt()
  %delete

  " #6
  set ambiwidth=single
  call append(0, ['abc', 'δefg', '', 'hijk'])
  normal 4G2l\b
  call g:assert.equals(getpos('.')[1:2], [1, 3], 'failed at #6')
  call columnmove#interrupt()
  %delete

  " #7
  set ambiwidth=single
  call append(0, ['abc', 'defg', '', 'ηijk'])
  normal 4G\b
  call g:assert.equals(getpos('.')[1:2], [1, 1], 'failed at #7')
  call columnmove#interrupt()
  %delete

  " #8
  set ambiwidth=single
  call append(0, ['abc', 'defg', '', 'ηijk'])
  normal 4Gl\b
  call g:assert.equals(getpos('.')[1:2], [1, 2], 'failed at #8')
  let @@ = ''
  normal! yl
  call g:assert.equals(@@, 'b', 'failed at #8')
  call columnmove#interrupt()
  %delete

  " #9
  set ambiwidth=single
  call append(0, ['abc', 'defg', '', 'ηijk'])
  normal 4G2l\b
  call g:assert.equals(getpos('.')[1:2], [1, 3], 'failed at #9')
  let @@ = ''
  normal! yl
  call g:assert.equals(@@, 'c', 'failed at #9')
  call columnmove#interrupt()
  %delete

  " #10
  set ambiwidth=double
  call append(0, ['αbc', 'defg', '', 'hijk'])
  normal 4G\b
  call g:assert.equals(getpos('.')[1:2], [1, 1], 'failed at #10')
  call columnmove#interrupt()
  %delete

  " #11
  set ambiwidth=double
  call append(0, ['αbc', 'defg', '', 'hijk'])
  normal 4Gl\b
  call g:assert.equals(getpos('.')[1:2], [1, 1], 'failed at #11')
  call columnmove#interrupt()
  %delete

  " #12
  set ambiwidth=double
  call append(0, ['αbc', 'defg', '', 'hijk'])
  normal 4G2l\b
  call g:assert.equals(getpos('.')[1:2], [1, strlen('α')+1], 'failed at #12')
  call columnmove#interrupt()
  %delete

  " #13
  set ambiwidth=double
  call append(0, ['abc', 'δefg', '', 'hijk'])
  normal 4G\b
  call g:assert.equals(getpos('.')[1:2], [1, 1], 'failed at #13')
  call columnmove#interrupt()
  %delete

  " #14
  set ambiwidth=double
  call append(0, ['abc', 'δefg', '', 'hijk'])
  normal 4Gl\b
  call g:assert.equals(getpos('.')[1:2], [1, 2], 'failed at #14')
  call columnmove#interrupt()
  %delete

  " #15
  set ambiwidth=double
  call append(0, ['abc', 'δefg', '', 'hijk'])
  normal 4G2l\b
  call g:assert.equals(getpos('.')[1:2], [1, 3], 'failed at #15')
  call columnmove#interrupt()
  %delete

  " #16
  set ambiwidth=double
  call append(0, ['abc', 'defg', '', 'ηijk'])
  normal 4G\b
  call g:assert.equals(getpos('.')[1:2], [1, 1], 'failed at #16')
  call columnmove#interrupt()
  %delete

  " #17
  set ambiwidth=double
  call append(0, ['abc', 'defg', '', 'ηijk'])
  normal 4Gl\b
  call g:assert.equals(getpos('.')[1:2], [1, 3], 'failed at #17')
  let @@ = ''
  normal! yl
  call g:assert.equals(@@, 'c', 'failed at #17')
  call columnmove#interrupt()
  %delete

  " #18
  set ambiwidth=double
  call append(0, ['abc', 'defg', '', 'ηijk'])
  normal 4G2l\b
  call g:assert.equals(getpos('.')[1:2], [2, 4], 'failed at #18')
  let @@ = ''
  normal! yl
  call g:assert.equals(@@, 'g', 'failed at #18')
  call columnmove#interrupt()
  %delete

  " #19
  set ambiwidth=double
  call append(0, ['abc', '', 'δefg', '', 'hijk'])
  normal 5G0l\b
  call g:assert.equals(getpos('.')[1:2], [3, 1], 'failed at #19')
  normal \b
  call g:assert.equals(getpos('.')[1:2], [1, 2], 'failed at #19')
  call columnmove#interrupt()
  %delete

  " #20
  set ambiwidth=double
  call append(0, ['abc', '', 'δefg', '', 'hijk'])
  normal 5G0l\b
  call g:assert.equals(getpos('.')[1:2], [3, 1], 'failed at #20')
  call columnmove#interrupt()
  normal \b
  call g:assert.equals(getpos('.')[1:2], [1, 1], 'failed at #20')
  call columnmove#interrupt()
  %delete
endfunction
"}}}
function! s:suite_b.strict_visual_mode() abort  "{{{
  let g:columnmove_strict_wbege = 1

  " #1
  call append(0, ['a', 'b', ';', 'c', 'd'])
  call setpos("'<", [0, 0, 0, 0])
  call setpos("'>", [0, 0, 0, 0])
  normal 5G0v\b
  execute "normal! \<Esc>"
  call g:assert.equals(getpos("'<"), [0, 4, 1, 0], 'failed at #1')
  call g:assert.equals(getpos("'>"), [0, 5, 1, 0], 'failed at #1')
  call g:assert.equals(visualmode(), 'v', 'failed at #1')
  call columnmove#interrupt()
  %delete

  " #2
  call append(0, ['a', 'b', ';', 'c', 'd'])
  call setpos("'<", [0, 0, 0, 0])
  call setpos("'>", [0, 0, 0, 0])
  normal 5G0V\b
  execute "normal! \<Esc>"
  call g:assert.equals(getpos("'<"), [0, 4, 1, 0], 'failed at #2')
  call g:assert.equals(getpos("'>"), [0, 5, g:intmax, 0], 'failed at #2')
  call g:assert.equals(visualmode(), 'V', 'failed at #2')
  call columnmove#interrupt()
  %delete

  " #3
  call append(0, ['a', 'b', ';', 'c', 'd'])
  call setpos("'<", [0, 0, 0, 0])
  call setpos("'>", [0, 0, 0, 0])
  execute "normal 5G0\<C-v>\\b\<Esc>"
  call g:assert.equals(getpos("'<"), [0, 4, 1, 0], 'failed at #3')
  call g:assert.equals(getpos("'>"), [0, 5, 1, 0], 'failed at #3')
  call g:assert.equals(visualmode(), "\<C-v>", 'failed at #3')
  call columnmove#interrupt()
  %delete

  " #4
  call append(0, ['a', 'b', '', 'c', 'd', '', 'e'])
  call setpos("'<", [0, 0, 0, 0])
  call setpos("'>", [0, 0, 0, 0])
  normal 7G0v\b\b
  execute "normal! \<Esc>"
  call g:assert.equals(getpos("'<"), [0, 1, 1, 0], 'failed at #4')
  call g:assert.equals(getpos("'>"), [0, 7, 1, 0], 'failed at #4')
  call g:assert.equals(visualmode(), 'v', 'failed at #4')
  call columnmove#interrupt()
  %delete

  " #5
  call append(0, ['', '', ''])
  normal 3G0v\b
  call g:assert.equals(mode(), 'v', 'failed at #5')
  execute "normal! \<Esc>"
  call columnmove#interrupt()
  %delete
endfunction
"}}}
function! s:suite_b.strict_operator_pending_mode() abort  "{{{
  let g:columnmove_strict_wbege = 1

  " #1
  " default: linewise
  call append(0, ['abc', 'def', ':::'])
  let @@ = ''
  normal 3G0l""d\b
  call g:assert.equals(getreg('"'), "abc\ndef\n:::\n", 'failed at #1')
  call g:assert.equals(getregtype('"'), 'V', 'failed at #1')
  call columnmove#interrupt()
  %delete

  " #2
  " exclusive character-wise with o_v
  call append(0, ['abc', 'def', ':::'])
  let @@ = ''
  normal 3G0l""dv\b
  call g:assert.equals(getreg('"'), "bc\ndef\n:", 'failed at #2')
  call g:assert.equals(getregtype('"'), 'v', 'failed at #2')
  call columnmove#interrupt()
  %delete

  " #3
  " line-wise with o_V
  call append(0, ['abc', 'def', ':::'])
  let @@ = ''
  normal 3G0l""dV\b
  call g:assert.equals(getreg('"'), "abc\ndef\n:::\n", 'failed at #3')
  call g:assert.equals(getregtype('"'), 'V', 'failed at #3')
  call columnmove#interrupt()
  %delete

  " #4
  " block-wise with o_CTRL-V
  call append(0, ['abc', 'def', ':::'])
  let @@ = ''
  execute "normal 3G0l\"\"d\<C-v>\\b"
  call g:assert.equals(getreg('"'), "b\ne\n:", 'failed at #4')
  call g:assert.equals(getregtype('"'), "\<C-v>1", 'failed at #4')
  call columnmove#interrupt()
  %delete
endfunction
"}}}
function! s:suite_b.spoiled() abort "{{{
  let g:columnmove_strict_wbege = 0

  " #1
  call append(0, ['a', 'b', ';', 'c', 'd'])
  normal 1G0\b
  call g:assert.equals(line('.'), 1, 'failed at #1')
  call columnmove#interrupt()
  %delete

  " #2
  call append(0, ['a', 'b', ';', 'c', 'd'])
  normal 2G0\b
  call g:assert.equals(line('.'), 1, 'failed at #2')
  call columnmove#interrupt()
  %delete

  " #3
  call append(0, ['a', 'b', ';', 'c', 'd'])
  normal 3G0\b
  call g:assert.equals(line('.'), 1, 'failed at #3')
  call columnmove#interrupt()
  %delete

  " #4
  call append(0, ['a', 'b', ';', 'c', 'd'])
  normal 4G0\b
  call g:assert.equals(line('.'), 1, 'failed at #4')
  call columnmove#interrupt()
  %delete

  " #5
  call append(0, ['a', 'b', ';', 'c', 'd'])
  normal 5G0\b
  call g:assert.equals(line('.'), 1, 'failed at #5')
  call columnmove#interrupt()
  %delete

  " #6
  call append(0, ['a', 'b', ' ', 'c', 'd'])
  normal 1G0\b
  call g:assert.equals(line('.'), 1, 'failed at #6')
  call columnmove#interrupt()
  %delete

  " #7
  call append(0, ['a', 'b', ' ', 'c', 'd'])
  normal 2G0\b
  call g:assert.equals(line('.'), 1, 'failed at #7')
  call columnmove#interrupt()
  %delete

  " #8
  call append(0, ['a', 'b', ' ', 'c', 'd'])
  normal 3G0\b
  call g:assert.equals(line('.'), 1, 'failed at #8')
  call columnmove#interrupt()
  %delete

  " #9
  call append(0, ['a', 'b', ' ', 'c', 'd'])
  normal 4G0\b
  call g:assert.equals(line('.'), 1, 'failed at #9')
  call columnmove#interrupt()
  %delete

  " #10
  call append(0, ['a', 'b', ' ', 'c', 'd'])
  normal 5G0\b
  call g:assert.equals(line('.'), 1, 'failed at #10')
  call columnmove#interrupt()
  %delete

  " #11
  call append(0, ['a', 'b', '', 'c', 'd'])
  normal 1G0\b
  call g:assert.equals(line('.'), 1, 'failed at #11')
  call columnmove#interrupt()
  %delete

  " #12
  call append(0, ['a', 'b', '', 'c', 'd'])
  normal 2G0\b
  call g:assert.equals(line('.'), 1, 'failed at #12')
  call columnmove#interrupt()
  %delete

  " #13
  call append(0, ['a', 'b', '', 'c', 'd'])
  normal 3G0\b
  call g:assert.equals(line('.'), 1, 'failed at #13')
  call columnmove#interrupt()
  %delete

  " #14
  call append(0, ['a', 'b', '', 'c', 'd'])
  normal 4G0\b
  call g:assert.equals(line('.'), 1, 'failed at #14')
  call columnmove#interrupt()
  %delete

  " #15
  call append(0, ['a', 'b', '', 'c', 'd'])
  normal 5G0\b
  call g:assert.equals(line('.'), 4, 'failed at #15')
  call columnmove#interrupt()
  %delete

  " #16
  call append(0, [';', ':', 'a', ',', '.'])
  normal 1G0\b
  call g:assert.equals(line('.'), 1, 'failed at #16')
  call columnmove#interrupt()
  %delete

  " #17
  call append(0, [';', ':', 'a', ',', '.'])
  normal 2G0\b
  call g:assert.equals(line('.'), 1, 'failed at #17')
  call columnmove#interrupt()
  %delete

  " #18
  call append(0, [';', ':', 'a', ',', '.'])
  normal 3G0\b
  call g:assert.equals(line('.'), 1, 'failed at #18')
  call columnmove#interrupt()
  %delete

  " #19
  call append(0, [';', ':', 'a', ',', '.'])
  normal 4G0\b
  call g:assert.equals(line('.'), 1, 'failed at #19')
  call columnmove#interrupt()
  %delete

  " #20
  call append(0, [';', ':', 'a', ',', '.'])
  normal 5G0\b
  call g:assert.equals(line('.'), 1, 'failed at #20')
  call columnmove#interrupt()
  %delete

  " #21
  call append(0, [';', ':', ' ', ',', '.'])
  normal 1G0\b
  call g:assert.equals(line('.'), 1, 'failed at #21')
  call columnmove#interrupt()
  %delete

  " #22
  call append(0, [';', ':', ' ', ',', '.'])
  normal 2G0\b
  call g:assert.equals(line('.'), 1, 'failed at #22')
  call columnmove#interrupt()
  %delete

  " #23
  call append(0, [';', ':', ' ', ',', '.'])
  normal 3G0\b
  call g:assert.equals(line('.'), 1, 'failed at #23')
  call columnmove#interrupt()
  %delete

  " #24
  call append(0, [';', ':', ' ', ',', '.'])
  normal 4G0\b
  call g:assert.equals(line('.'), 1, 'failed at #24')
  call columnmove#interrupt()
  %delete

  " #25
  call append(0, [';', ':', ' ', ',', '.'])
  normal 5G0\b
  call g:assert.equals(line('.'), 1, 'failed at #25')
  call columnmove#interrupt()
  %delete

  " #26
  call append(0, [';', ':', '', ',', '.'])
  normal 1G0\b
  call g:assert.equals(line('.'), 1, 'failed at #26')
  call columnmove#interrupt()
  %delete

  " #27
  call append(0, [';', ':', '', ',', '.'])
  normal 2G0\b
  call g:assert.equals(line('.'), 1, 'failed at #27')
  call columnmove#interrupt()
  %delete

  " #28
  call append(0, [';', ':', '', ',', '.'])
  normal 3G0\b
  call g:assert.equals(line('.'), 1, 'failed at #28')
  call columnmove#interrupt()
  %delete

  " #29
  call append(0, [';', ':', '', ',', '.'])
  normal 4G0\b
  call g:assert.equals(line('.'), 1, 'failed at #29')
  call columnmove#interrupt()
  %delete

  " #30
  call append(0, [';', ':', '', ',', '.'])
  normal 5G0\b
  call g:assert.equals(line('.'), 4, 'failed at #30')
  call columnmove#interrupt()
  %delete

  " #31
  call append(0, [' ', ' ', 'a', ' ', ' '])
  normal 1G0\b
  call g:assert.equals(line('.'), 1, 'failed at #31')
  call columnmove#interrupt()
  %delete

  " #32
  call append(0, [' ', ' ', 'a', ' ', ' '])
  normal 2G0\b
  call g:assert.equals(line('.'), 1, 'failed at #32')
  call columnmove#interrupt()
  %delete

  " #33
  call append(0, [' ', ' ', 'a', ' ', ' '])
  normal 3G0\b
  call g:assert.equals(line('.'), 1, 'failed at #33')
  call columnmove#interrupt()
  %delete

  " #34
  call append(0, [' ', ' ', 'a', ' ', ' '])
  normal 4G0\b
  call g:assert.equals(line('.'), 1, 'failed at #34')
  call columnmove#interrupt()
  %delete

  " #35
  call append(0, [' ', ' ', 'a', ' ', ' '])
  normal 5G0\b
  call g:assert.equals(line('.'), 1, 'failed at #35')
  call columnmove#interrupt()
  %delete

  " #36
  call append(0, [' ', ' ', ';', ' ', ' '])
  normal 1G0\b
  call g:assert.equals(line('.'), 1, 'failed at #36')
  call columnmove#interrupt()
  %delete

  " #37
  call append(0, [' ', ' ', ';', ' ', ' '])
  normal 2G0\b
  call g:assert.equals(line('.'), 1, 'failed at #37')
  call columnmove#interrupt()
  %delete

  " #38
  call append(0, [' ', ' ', ';', ' ', ' '])
  normal 3G0\b
  call g:assert.equals(line('.'), 1, 'failed at #38')
  call columnmove#interrupt()
  %delete

  " #39
  call append(0, [' ', ' ', ';', ' ', ' '])
  normal 4G0\b
  call g:assert.equals(line('.'), 1, 'failed at #39')
  call columnmove#interrupt()
  %delete

  " #40
  call append(0, [' ', ' ', ';', ' ', ' '])
  normal 5G0\b
  call g:assert.equals(line('.'), 1, 'failed at #40')
  call columnmove#interrupt()
  %delete

  " #41
  call append(0, [' ', ' ', '', ' ', ' '])
  normal 1G0\b
  call g:assert.equals(line('.'), 1, 'failed at #41')
  call columnmove#interrupt()
  %delete

  " #42
  call append(0, [' ', ' ', '', ' ', ' '])
  normal 2G0\b
  call g:assert.equals(line('.'), 1, 'failed at #42')
  call columnmove#interrupt()
  %delete

  " #43
  call append(0, [' ', ' ', '', ' ', ' '])
  normal 3G0\b
  call g:assert.equals(line('.'), 1, 'failed at #43')
  call columnmove#interrupt()
  %delete

  " #44
  call append(0, [' ', ' ', '', ' ', ' '])
  normal 4G0\b
  call g:assert.equals(line('.'), 1, 'failed at #44')
  call columnmove#interrupt()
  %delete

  " #45
  call append(0, [' ', ' ', '', ' ', ' '])
  normal 5G0\b
  call g:assert.equals(line('.'), 4, 'failed at #45')
  call columnmove#interrupt()
  %delete

  " #46
  call append(0, ['', '', 'a', '', ''])
  normal 1G0\b
  call g:assert.equals(line('.'), 1, 'failed at #46')
  call columnmove#interrupt()
  %delete

  " #47
  call append(0, ['', '', 'a', '', ''])
  normal 2G0\b
  call g:assert.equals(line('.'), 2, 'failed at #47')
  call columnmove#interrupt()
  %delete

  " #48
  call append(0, ['', '', 'a', '', ''])
  normal 3G0\b
  call g:assert.equals(line('.'), 3, 'failed at #48')
  call columnmove#interrupt()
  %delete

  " #49
  call append(0, ['', '', 'a', '', ''])
  normal 4G0\b
  call g:assert.equals(line('.'), 3, 'failed at #49')
  call columnmove#interrupt()
  %delete

  " #50
  call append(0, ['', '', 'a', '', ''])
  normal 5G0\b
  call g:assert.equals(line('.'), 3, 'failed at #50')
  call columnmove#interrupt()
  %delete

  " #51
  call append(0, ['', '', ';', '', ''])
  normal 1G0\b
  call g:assert.equals(line('.'), 1, 'failed at #51')
  call columnmove#interrupt()
  %delete

  " #52
  call append(0, ['', '', ';', '', ''])
  normal 2G0\b
  call g:assert.equals(line('.'), 2, 'failed at #52')
  call columnmove#interrupt()
  %delete

  " #53
  call append(0, ['', '', ';', '', ''])
  normal 3G0\b
  call g:assert.equals(line('.'), 3, 'failed at #53')
  call columnmove#interrupt()
  %delete

  " #54
  call append(0, ['', '', ';', '', ''])
  normal 4G0\b
  call g:assert.equals(line('.'), 3, 'failed at #54')
  call columnmove#interrupt()
  %delete

  " #55
  call append(0, ['', '', ';', '', ''])
  normal 5G0\b
  call g:assert.equals(line('.'), 3, 'failed at #55')
  call columnmove#interrupt()
  %delete

  " #56
  call append(0, ['', '', ' ', '', ''])
  normal 1G0\b
  call g:assert.equals(line('.'), 1, 'failed at #56')
  call columnmove#interrupt()
  %delete

  " #57
  call append(0, ['', '', ' ', '', ''])
  normal 2G0\b
  call g:assert.equals(line('.'), 2, 'failed at #57')
  call columnmove#interrupt()
  %delete

  " #58
  call append(0, ['', '', ' ', '', ''])
  normal 3G0\b
  call g:assert.equals(line('.'), 3, 'failed at #58')
  call columnmove#interrupt()
  %delete

  " #59
  call append(0, ['', '', ' ', '', ''])
  normal 4G0\b
  call g:assert.equals(line('.'), 3, 'failed at #59')
  call columnmove#interrupt()
  %delete

  " #60
  call append(0, ['', '', ' ', '', ''])
  normal 5G0\b
  call g:assert.equals(line('.'), 3, 'failed at #60')
  call columnmove#interrupt()
  %delete

  " #61
  call append(0, ['a', 'b', '', 'c', 'd', '', 'e'])
  normal 7G0\b
  call g:assert.equals(line('.'), 4, 'failed at #61')
  normal \b
  call g:assert.equals(line('.'), 1, 'failed at #61')
  call columnmove#interrupt()
  %delete
endfunction
"}}}
function! s:suite_b.spoiled_count() abort "{{{
  let g:columnmove_strict_wbege = 0

  " #1
  call append(0, ['a', 'b', '', 'c', 'd', '', 'e', 'f', '', 'g'])
  normal 10G0\b
  call g:assert.equals(line('.'), 7, 'failed at #1')
  call columnmove#interrupt()
  %delete

  " #2
  call append(0, ['a', 'b', '', 'c', 'd', '', 'e', 'f', '', 'g'])
  normal 10G02\b
  call g:assert.equals(line('.'), 4, 'failed at #2')
  call columnmove#interrupt()
  %delete

  " #3
  call append(0, ['a', 'b', '', 'c', 'd', '', 'e', 'f', '', 'g'])
  normal 10G03\b
  call g:assert.equals(line('.'), 1, 'failed at #3')
  call columnmove#interrupt()
  %delete

  " #3
  call append(0, ['a', 'b', '', 'c', 'd', '', 'e', 'f', '', 'g'])
  normal 10G04\b
  call g:assert.equals(line('.'), 10, 'failed at #3')
  call columnmove#interrupt()
  %delete
endfunction
"}}}
function! s:suite_b.spoiled_fold() abort  "{{{
  let g:columnmove_strict_wbege = 0

  " #1
  call append(0, ['a', 'b', '', 'c', 'd', 'e', 'f'])
  1,2fold
  normal 7G0\b
  call g:assert.equals(line('.'), 4, 'failed at #1')
  call columnmove#interrupt()
  %delete

  " #2
  call append(0, ['a', 'b', '', 'c', 'd', 'e', 'f'])
  2,3fold
  normal 7G0\b
  call g:assert.equals(line('.'), 1, 'failed at #2')
  call columnmove#interrupt()
  %delete

  " #3
  call append(0, ['a', 'b', '', 'c', 'd', 'e', 'f'])
  3,4fold
  normal 7G0\b
  call g:assert.equals(line('.'), 1, 'failed at #3')
  call columnmove#interrupt()
  %delete

  " #4
  call append(0, ['a', 'b', '', 'c', 'd', 'e', 'f'])
  4,5fold
  normal 7G0\b
  call g:assert.equals(line('.'), 6, 'failed at #4')
  call columnmove#interrupt()
  %delete

  " #5
  call append(0, ['a', 'b', '', 'c', 'd', 'e', 'f'])
  5,6fold
  normal 7G0\b
  call g:assert.equals(line('.'), 4, 'failed at #5')
  call columnmove#interrupt()
  %delete

  " #6
  call append(0, ['a', 'b', '', 'c', 'd', 'e', 'f'])
  6,7fold
  normal 7G0\b
  call g:assert.equals(line('.'), 4, 'failed at #6')
  call columnmove#interrupt()
  %delete

  " #7
  call append(0, ['a', 'b', '', 'c', 'd', 'e', 'f', 'g'])
  5,6fold
  normal 8G0\b
  call g:assert.equals(line('.'), 4, 'failed at #7')
  call columnmove#interrupt()
  %delete
endfunction
"}}}
function! s:suite_b.spoiled_option_fold_treatment() abort  "{{{
  let g:columnmove_strict_wbege = 0
  let g:columnmove_fold_treatment = 1

  " #1
  call append(0, ['a', 'b', '', 'c', 'd', 'e', 'f'])
  1,2fold
  normal 7G0\b
  call g:assert.equals(line('.'), 4, 'failed at #1')
  call columnmove#interrupt()
  %delete

  " #2
  call append(0, ['a', 'b', '', 'c', 'd', 'e', 'f'])
  2,3fold
  normal 7G0\b
  call g:assert.equals(line('.'), 4, 'failed at #2')
  call columnmove#interrupt()
  %delete

  " #3
  call append(0, ['a', 'b', '', 'c', 'd', 'e', 'f'])
  3,4fold
  normal 7G0\b
  call g:assert.equals(line('.'), 5, 'failed at #3')
  call columnmove#interrupt()
  %delete

  " #4
  call append(0, ['a', 'b', '', 'c', 'd', 'e', 'f'])
  4,5fold
  normal 7G0\b
  call g:assert.equals(line('.'), 6, 'failed at #4')
  call columnmove#interrupt()
  %delete

  " #5
  call append(0, ['a', 'b', '', 'c', 'd', 'e', 'f'])
  5,6fold
  normal 7G0\b
  call g:assert.equals(line('.'), 4, 'failed at #5')
  call columnmove#interrupt()
  %delete

  " #6
  call append(0, ['a', 'b', '', 'c', 'd', 'e', 'f'])
  6,7fold
  normal 7G0\b
  call g:assert.equals(line('.'), 4, 'failed at #6')
  call columnmove#interrupt()
  %delete

  " #7
  call append(0, ['a', 'b', '', 'c', 'd', 'e', 'f', 'g'])
  5,6fold
  normal 8G0\b
  call g:assert.equals(line('.'), 7, 'failed at #7')
  call columnmove#interrupt()
  %delete
endfunction
"}}}
function! s:suite_b.spoiled_option_fold_open() abort  "{{{
  let g:columnmove_strict_wbege = 0
  let g:columnmove_fold_open = 1

  " #1
  call append(0, ['a', 'b', ':', 'c', 'd'])
  2,4fold
  normal 5G\b
  call g:assert.equals(line('.'), 1, 'failed at #1')
  call g:assert.equals(foldclosed(2),    2, 'failed at #1')
  call g:assert.equals(foldclosedend(2), 4, 'failed at #1')
  call columnmove#interrupt()
  %delete

  " #2
  call append(0, ['a', 'b', ' ', 'c', 'd'])
  2,4fold
  normal 5G\b
  call g:assert.equals(line('.'), 1, 'failed at #2')
  call g:assert.equals(foldclosed(2),    2, 'failed at #2')
  call g:assert.equals(foldclosedend(2), 4, 'failed at #2')
  call columnmove#interrupt()
  %delete

  " #3
  call append(0, ['a', 'b', '', 'c', 'd'])
  2,4fold
  normal 5G\b
  call g:assert.equals(line('.'), 4, 'failed at #3')
  call g:assert.equals(foldclosed(2),    -1, 'failed at #3')
  call g:assert.equals(foldclosedend(2), -1, 'failed at #3')
  call columnmove#interrupt()
  %delete

  " #4
  call append(0, ['a', 'b', 'c', 'd', ':'])
  2,4fold
  normal 5G\b
  call g:assert.equals(line('.'), 1, 'failed at #4')
  call g:assert.equals(foldclosed(2),    2, 'failed at #4')
  call g:assert.equals(foldclosedend(2), 4, 'failed at #4')
  call columnmove#interrupt()
  %delete

  " #5
  call append(0, ['a', 'b', 'c', ' ', 'd'])
  2,4fold
  normal 5G\b
  call g:assert.equals(line('.'), 1, 'failed at #5')
  call g:assert.equals(foldclosed(2),    2, 'failed at #5')
  call g:assert.equals(foldclosedend(2), 4, 'failed at #5')
  call columnmove#interrupt()
  %delete

  " #6
  call append(0, ['a', 'b', 'c', '', 'd'])
  2,4fold
  normal 5G\b
  call g:assert.equals(line('.'), 1, 'failed at #6')
  call g:assert.equals(foldclosed(2),    2, 'failed at #6')
  call g:assert.equals(foldclosedend(2), 4, 'failed at #6')
  call columnmove#interrupt()
  %delete
endfunction
"}}}
function! s:suite_b.spoiled_option_combinations() abort "{{{
  let g:columnmove_strict_wbege = 0
  let g:columnmove_fold_treatment = 1
  let g:columnmove_fold_open = 1

  " #1
  call append(0, ['a', 'b', '', 'c', 'd', 'e'])
  2,4fold
  normal 6G\b
  call g:assert.equals(line('.'), 4, 'failed at #1')
  call columnmove#interrupt()
  %delete
endfunction
"}}}
function! s:suite_b.spoiled_option_stop_on_space() dict abort  "{{{
  let g:columnmove_strict_wbege = 0
  let g:columnmove_stop_on_space = 1

  " #1
  call append(0, ['', 'aa', '  ', '', 'bb'])
  normal 5G0\b
  call g:assert.equals(line('.'), 2, 'failed at #1')
  call columnmove#interrupt()
  %delete

  " #2
  call append(0, ['', 'aa', '  ', '', 'bb'])
  normal 5G0l\b
  call g:assert.equals(line('.'), 2, 'failed at #2')
  call columnmove#interrupt()
  %delete

  " #3
  call append(0, ['', 'a ', '  ', '', 'bb'])
  normal 5G0\b
  call g:assert.equals(line('.'), 2, 'failed at #3')
  call columnmove#interrupt()
  %delete

  " #4
  call append(0, ['', 'a ', '  ', '', 'bb'])
  normal 5G0l\b
  call g:assert.equals(line('.'), 2, 'failed at #4')
  call columnmove#interrupt()
  %delete

  let g:columnmove_stop_on_space = 0

  " #5
  call append(0, ['', 'aa', '  ', '', 'bb'])
  normal 5G0\b
  call g:assert.equals(line('.'), 2, 'failed at #5')
  call columnmove#interrupt()
  %delete

  " #6
  call append(0, ['', 'aa', '  ', '', 'bb'])
  normal 5G0l\b
  call g:assert.equals(line('.'), 2, 'failed at #6')
  call columnmove#interrupt()
  %delete

  " #7
  call append(0, ['', 'a ', '  ', '', 'bb'])
  normal 5G0\b
  call g:assert.equals(line('.'), 2, 'failed at #7')
  call columnmove#interrupt()
  %delete

  " #8
  call append(0, ['', 'a ', '  ', '', 'bb'])
  normal 5G0l\b
  call g:assert.equals(line('.'), 2, 'failed at #8')
  call columnmove#interrupt()
  %delete
endfunction
"}}}
function! s:suite_b.spoiled_curswant() abort "{{{
  let g:columnmove_strict_wbege = 0

  " #1
  call append(0, ['abcde', '', 'fgh', 'ijklm'])
  normal 4G$k\b
  call g:assert.equals(getpos('.')[1:2], [1, 3], 'failed at #1')
  call columnmove#interrupt()
  %delete
endfunction
"}}}
function! s:suite_b.spoiled_tabchar() abort "{{{
  let g:columnmove_strict_wbege = 0

  " #1
  set tabstop=4
  call append(0, ['	abc', 'defghij', '', 'klmnopq'])
  normal 4G4l\b
  call g:assert.equals(getpos('.')[1:2], [1, 2], 'failed at #1')
  call columnmove#interrupt()
  %delete

  " #2
  set tabstop=4
  call append(0, ['abcdefg', 'hijklmn', '', '	opqr'])
  normal 4G\b
  call g:assert.equals(getpos('.')[1:2], [1, 5], 'failed at #2')
  call columnmove#interrupt()
  %delete
endfunction
"}}}
function! s:suite_b.spoiled_multibyte_char() abort "{{{
  let g:columnmove_strict_wbege = 0

  " #1
  set ambiwidth=single
  call append(0, ['αbc', 'defg', '', 'hijk'])
  normal 4G\b
  call g:assert.equals(getpos('.')[1:2], [1, 1], 'failed at #1')
  call columnmove#interrupt()
  %delete

  " #2
  set ambiwidth=single
  call append(0, ['αbc', 'defg', '', 'hijk'])
  normal 4Gl\b
  call g:assert.equals(getpos('.')[1:2], [1, strlen('α')+1], 'failed at #2')
  call columnmove#interrupt()
  %delete

  " #3
  set ambiwidth=single
  call append(0, ['αbc', 'defg', '', 'hijk'])
  normal 4G2l\b
  call g:assert.equals(getpos('.')[1:2], [1, strlen('α')+2], 'failed at #3')
  call columnmove#interrupt()
  %delete

  " #4
  set ambiwidth=single
  call append(0, ['abc', 'δefg', '', 'hijk'])
  normal 4G\b
  call g:assert.equals(getpos('.')[1:2], [1, 1], 'failed at #4')
  call columnmove#interrupt()
  %delete

  " #5
  set ambiwidth=single
  call append(0, ['abc', 'δefg', '', 'hijk'])
  normal 4Gl\b
  call g:assert.equals(getpos('.')[1:2], [1, 2], 'failed at #5')
  call columnmove#interrupt()
  %delete

  " #6
  set ambiwidth=single
  call append(0, ['abc', 'δefg', '', 'hijk'])
  normal 4G2l\b
  call g:assert.equals(getpos('.')[1:2], [1, 3], 'failed at #6')
  call columnmove#interrupt()
  %delete

  " #7
  set ambiwidth=single
  call append(0, ['abc', 'defg', '', 'ηijk'])
  normal 4G\b
  call g:assert.equals(getpos('.')[1:2], [1, 1], 'failed at #7')
  call columnmove#interrupt()
  %delete

  " #8
  set ambiwidth=single
  call append(0, ['abc', 'defg', '', 'ηijk'])
  normal 4Gl\b
  call g:assert.equals(getpos('.')[1:2], [1, 2], 'failed at #8')
  let @@ = ''
  normal! yl
  call g:assert.equals(@@, 'b', 'failed at #8')
  call columnmove#interrupt()
  %delete

  " #9
  set ambiwidth=single
  call append(0, ['abc', 'defg', '', 'ηijk'])
  normal 4G2l\b
  call g:assert.equals(getpos('.')[1:2], [1, 3], 'failed at #9')
  let @@ = ''
  normal! yl
  call g:assert.equals(@@, 'c', 'failed at #9')
  call columnmove#interrupt()
  %delete

  " #10
  set ambiwidth=double
  call append(0, ['αbc', 'defg', '', 'hijk'])
  normal 4G\b
  call g:assert.equals(getpos('.')[1:2], [1, 1], 'failed at #10')
  call columnmove#interrupt()
  %delete

  " #11
  set ambiwidth=double
  call append(0, ['αbc', 'defg', '', 'hijk'])
  normal 4Gl\b
  call g:assert.equals(getpos('.')[1:2], [1, 1], 'failed at #11')
  call columnmove#interrupt()
  %delete

  " #12
  set ambiwidth=double
  call append(0, ['αbc', 'defg', '', 'hijk'])
  normal 4G2l\b
  call g:assert.equals(getpos('.')[1:2], [1, strlen('α')+1], 'failed at #12')
  call columnmove#interrupt()
  %delete

  " #13
  set ambiwidth=double
  call append(0, ['abc', 'δefg', '', 'hijk'])
  normal 4G\b
  call g:assert.equals(getpos('.')[1:2], [1, 1], 'failed at #13')
  call columnmove#interrupt()
  %delete

  " #14
  set ambiwidth=double
  call append(0, ['abc', 'δefg', '', 'hijk'])
  normal 4Gl\b
  call g:assert.equals(getpos('.')[1:2], [1, 2], 'failed at #14')
  call columnmove#interrupt()
  %delete

  " #15
  set ambiwidth=double
  call append(0, ['abc', 'δefg', '', 'hijk'])
  normal 4G2l\b
  call g:assert.equals(getpos('.')[1:2], [1, 3], 'failed at #15')
  call columnmove#interrupt()
  %delete

  " #16
  set ambiwidth=double
  call append(0, ['abc', 'defg', '', 'ηijk'])
  normal 4G\b
  call g:assert.equals(getpos('.')[1:2], [1, 1], 'failed at #16')
  call columnmove#interrupt()
  %delete

  " #17
  set ambiwidth=double
  call append(0, ['abc', 'defg', '', 'ηijk'])
  normal 4Gl\b
  call g:assert.equals(getpos('.')[1:2], [1, 3], 'failed at #17')
  let @@ = ''
  normal! yl
  call g:assert.equals(@@, 'c', 'failed at #17')
  call columnmove#interrupt()
  %delete

  " #18
  set ambiwidth=double
  call append(0, ['abc', 'defg', '', 'ηijk'])
  normal 4G2l\b
  call g:assert.equals(getpos('.')[1:2], [2, 4], 'failed at #18')
  let @@ = ''
  normal! yl
  call g:assert.equals(@@, 'g', 'failed at #18')
  call columnmove#interrupt()
  %delete

  " #19
  set ambiwidth=double
  call append(0, ['abc', '', 'δefg', '', 'hijk'])
  normal 5G0l\b
  call g:assert.equals(getpos('.')[1:2], [3, 1], 'failed at #19')
  normal \b
  call g:assert.equals(getpos('.')[1:2], [1, 2], 'failed at #19')
  call columnmove#interrupt()
  %delete

  " #20
  set ambiwidth=double
  call append(0, ['abc', '', 'δefg', '', 'hijk'])
  normal 5G0l\b
  call g:assert.equals(getpos('.')[1:2], [3, 1], 'failed at #20')
  call columnmove#interrupt()
  normal \b
  call g:assert.equals(getpos('.')[1:2], [1, 1], 'failed at #20')
  call columnmove#interrupt()
  %delete
endfunction
"}}}
function! s:suite_b.spoiled_visual_mode() abort  "{{{
  let g:columnmove_strict_wbege = 0

  " #1
  call append(0, ['a', 'b', '', 'c', 'd'])
  call setpos("'<", [0, 0, 0, 0])
  call setpos("'>", [0, 0, 0, 0])
  normal 5G0v\b
  execute "normal! \<Esc>"
  call g:assert.equals(getpos("'<"), [0, 4, 1, 0], 'failed at #1')
  call g:assert.equals(getpos("'>"), [0, 5, 1, 0], 'failed at #1')
  call g:assert.equals(visualmode(), 'v', 'failed at #1')
  call columnmove#interrupt()
  %delete

  " #2
  call append(0, ['a', 'b', '', 'c', 'd'])
  call setpos("'<", [0, 0, 0, 0])
  call setpos("'>", [0, 0, 0, 0])
  normal 5G0V\b
  execute "normal! \<Esc>"
  call g:assert.equals(getpos("'<"), [0, 4, 1, 0], 'failed at #2')
  call g:assert.equals(getpos("'>"), [0, 5, g:intmax, 0], 'failed at #2')
  call g:assert.equals(visualmode(), 'V', 'failed at #2')
  call columnmove#interrupt()
  %delete

  " #3
  call append(0, ['a', 'b', '', 'c', 'd'])
  call setpos("'<", [0, 0, 0, 0])
  call setpos("'>", [0, 0, 0, 0])
  execute "normal 5G0\<C-v>\\b\<Esc>"
  call g:assert.equals(getpos("'<"), [0, 4, 1, 0], 'failed at #3')
  call g:assert.equals(getpos("'>"), [0, 5, 1, 0], 'failed at #3')
  call g:assert.equals(visualmode(), "\<C-v>", 'failed at #3')
  call columnmove#interrupt()
  %delete

  " #4
  call append(0, ['a', 'b', '', 'c', 'd', '', 'e'])
  call setpos("'<", [0, 0, 0, 0])
  call setpos("'>", [0, 0, 0, 0])
  normal 7G0v\b\b
  execute "normal! \<Esc>"
  call g:assert.equals(getpos("'<"), [0, 1, 1, 0], 'failed at #4')
  call g:assert.equals(getpos("'>"), [0, 7, 1, 0], 'failed at #4')
  call g:assert.equals(visualmode(), 'v', 'failed at #4')
  call columnmove#interrupt()
  %delete

  " #5
  call append(0, ['', '', ''])
  normal 3G0v\b
  call g:assert.equals(mode(), 'v', 'failed at #5')
  execute "normal! \<Esc>"
  call columnmove#interrupt()
  %delete
endfunction
"}}}
function! s:suite_b.spoiled_operator_pending_mode() abort  "{{{
  let g:columnmove_strict_wbege = 0

  " #1
  " default: linewise
  call append(0, ['abc', 'def', ':::'])
  let @@ = ''
  normal 3G0l""d\b
  call g:assert.equals(getreg('"'), "abc\ndef\n:::\n", 'failed at #1')
  call g:assert.equals(getregtype('"'), 'V', 'failed at #1')
  call columnmove#interrupt()
  %delete

  " #2
  " exclusive character-wise with o_v
  call append(0, ['abc', 'def', ':::'])
  let @@ = ''
  normal 3G0l""dv\b
  call g:assert.equals(getreg('"'), "bc\ndef\n:", 'failed at #2')
  call g:assert.equals(getregtype('"'), 'v', 'failed at #2')
  call columnmove#interrupt()
  %delete

  " #3
  " line-wise with o_V
  call append(0, ['abc', 'def', ':::'])
  let @@ = ''
  normal 3G0l""dV\b
  call g:assert.equals(getreg('"'), "abc\ndef\n:::\n", 'failed at #3')
  call g:assert.equals(getregtype('"'), 'V', 'failed at #3')
  call columnmove#interrupt()
  %delete

  " #4
  " block-wise with o_CTRL-V
  call append(0, ['abc', 'def', ':::'])
  let @@ = ''
  execute "normal 3G0l\"\"d\<C-v>\\b"
  call g:assert.equals(getreg('"'), "b\ne\n:", 'failed at #4')
  call g:assert.equals(getregtype('"'), "\<C-v>1", 'failed at #4')
  call columnmove#interrupt()
  %delete
endfunction
"}}}

let s:suite_B = themis#suite('columnmove-B:')
function! s:suite_B.before_each() abort  "{{{
  mapclear
  mapclear!
  call columnmove#utility#map('nxo', 'B', '\B')
  set tabstop&
  set ambiwidth&
  set commentstring&
  set foldmethod&
  set softtabstop&
  set shiftwidth&
  set expandtab&
  unlet! g:columnmove_fold_open
  unlet! g:columnmove_expand_range
  unlet! g:columnmove_fold_treatment
  call columnmove#interrupt()
  %delete
endfunction
"}}}
function! s:suite_B.after() abort  "{{{
  call s:suite_B.before_each()
  mapclear
  mapclear!
endfunction
"}}}

function! s:suite_B.strict() abort  "{{{
  " #1
  call append(0, ['a', 'b', ';', 'c', 'd'])
  normal 1G0\B
  call g:assert.equals(line('.'), 1, 'failed at #1')
  call columnmove#interrupt()
  %delete

  " #2
  call append(0, ['a', 'b', ';', 'c', 'd'])
  normal 2G0\B
  call g:assert.equals(line('.'), 1, 'failed at #2')
  call columnmove#interrupt()
  %delete

  " #3
  call append(0, ['a', 'b', ';', 'c', 'd'])
  normal 3G0\B
  call g:assert.equals(line('.'), 1, 'failed at #3')
  call columnmove#interrupt()
  %delete

  " #4
  call append(0, ['a', 'b', ';', 'c', 'd'])
  normal 4G0\B
  call g:assert.equals(line('.'), 1, 'failed at #4')
  call columnmove#interrupt()
  %delete

  " #5
  call append(0, ['a', 'b', ';', 'c', 'd'])
  normal 5G0\B
  call g:assert.equals(line('.'), 1, 'failed at #5')
  call columnmove#interrupt()
  %delete

  " #6
  call append(0, ['a', 'b', ' ', 'c', 'd'])
  normal 1G0\B
  call g:assert.equals(line('.'), 1, 'failed at #6')
  call columnmove#interrupt()
  %delete

  " #7
  call append(0, ['a', 'b', ' ', 'c', 'd'])
  normal 2G0\B
  call g:assert.equals(line('.'), 1, 'failed at #7')
  call columnmove#interrupt()
  %delete

  " #8
  call append(0, ['a', 'b', ' ', 'c', 'd'])
  normal 3G0\B
  call g:assert.equals(line('.'), 1, 'failed at #8')
  call columnmove#interrupt()
  %delete

  " #9
  call append(0, ['a', 'b', ' ', 'c', 'd'])
  normal 4G0\B
  call g:assert.equals(line('.'), 1, 'failed at #9')
  call columnmove#interrupt()
  %delete

  " #10
  call append(0, ['a', 'b', ' ', 'c', 'd'])
  normal 5G0\B
  call g:assert.equals(line('.'), 4, 'failed at #10')
  call columnmove#interrupt()
  %delete

  " #11
  call append(0, ['a', 'b', '', 'c', 'd'])
  normal 1G0\B
  call g:assert.equals(line('.'), 1, 'failed at #11')
  call columnmove#interrupt()
  %delete

  " #12
  call append(0, ['a', 'b', '', 'c', 'd'])
  normal 2G0\B
  call g:assert.equals(line('.'), 1, 'failed at #12')
  call columnmove#interrupt()
  %delete

  " #13
  call append(0, ['a', 'b', '', 'c', 'd'])
  normal 3G0\B
  call g:assert.equals(line('.'), 1, 'failed at #13')
  call columnmove#interrupt()
  %delete

  " #14
  call append(0, ['a', 'b', '', 'c', 'd'])
  normal 4G0\B
  call g:assert.equals(line('.'), 1, 'failed at #14')
  call columnmove#interrupt()
  %delete

  " #15
  call append(0, ['a', 'b', '', 'c', 'd'])
  normal 5G0\B
  call g:assert.equals(line('.'), 4, 'failed at #15')
  call columnmove#interrupt()
  %delete

  " #16
  call append(0, [';', ':', 'a', ',', '.'])
  normal 1G0\B
  call g:assert.equals(line('.'), 1, 'failed at #16')
  call columnmove#interrupt()
  %delete

  " #17
  call append(0, [';', ':', 'a', ',', '.'])
  normal 2G0\B
  call g:assert.equals(line('.'), 1, 'failed at #17')
  call columnmove#interrupt()
  %delete

  " #18
  call append(0, [';', ':', 'a', ',', '.'])
  normal 3G0\B
  call g:assert.equals(line('.'), 1, 'failed at #18')
  call columnmove#interrupt()
  %delete

  " #19
  call append(0, [';', ':', 'a', ',', '.'])
  normal 4G0\B
  call g:assert.equals(line('.'), 1, 'failed at #19')
  call columnmove#interrupt()
  %delete

  " #20
  call append(0, [';', ':', 'a', ',', '.'])
  normal 5G0\B
  call g:assert.equals(line('.'), 1, 'failed at #20')
  call columnmove#interrupt()
  %delete

  " #21
  call append(0, [';', ':', ' ', ',', '.'])
  normal 1G0\B
  call g:assert.equals(line('.'), 1, 'failed at #21')
  call columnmove#interrupt()
  %delete

  " #22
  call append(0, [';', ':', ' ', ',', '.'])
  normal 2G0\B
  call g:assert.equals(line('.'), 1, 'failed at #22')
  call columnmove#interrupt()
  %delete

  " #23
  call append(0, [';', ':', ' ', ',', '.'])
  normal 3G0\B
  call g:assert.equals(line('.'), 1, 'failed at #23')
  call columnmove#interrupt()
  %delete

  " #24
  call append(0, [';', ':', ' ', ',', '.'])
  normal 4G0\B
  call g:assert.equals(line('.'), 1, 'failed at #24')
  call columnmove#interrupt()
  %delete

  " #25
  call append(0, [';', ':', ' ', ',', '.'])
  normal 5G0\B
  call g:assert.equals(line('.'), 4, 'failed at #25')
  call columnmove#interrupt()
  %delete

  " #26
  call append(0, [';', ':', '', ',', '.'])
  normal 1G0\B
  call g:assert.equals(line('.'), 1, 'failed at #26')
  call columnmove#interrupt()
  %delete

  " #27
  call append(0, [';', ':', '', ',', '.'])
  normal 2G0\B
  call g:assert.equals(line('.'), 1, 'failed at #27')
  call columnmove#interrupt()
  %delete

  " #28
  call append(0, [';', ':', '', ',', '.'])
  normal 3G0\B
  call g:assert.equals(line('.'), 1, 'failed at #28')
  call columnmove#interrupt()
  %delete

  " #29
  call append(0, [';', ':', '', ',', '.'])
  normal 4G0\B
  call g:assert.equals(line('.'), 1, 'failed at #29')
  call columnmove#interrupt()
  %delete

  " #30
  call append(0, [';', ':', '', ',', '.'])
  normal 5G0\B
  call g:assert.equals(line('.'), 4, 'failed at #30')
  call columnmove#interrupt()
  %delete

  " #31
  call append(0, [' ', ' ', 'a', ' ', ' '])
  normal 1G0\B
  call g:assert.equals(line('.'), 1, 'failed at #31')
  call columnmove#interrupt()
  %delete

  " #32
  call append(0, [' ', ' ', 'a', ' ', ' '])
  normal 2G0\B
  call g:assert.equals(line('.'), 2, 'failed at #32')
  call columnmove#interrupt()
  %delete

  " #33
  call append(0, [' ', ' ', 'a', ' ', ' '])
  normal 3G0\B
  call g:assert.equals(line('.'), 3, 'failed at #33')
  call columnmove#interrupt()
  %delete

  " #34
  call append(0, [' ', ' ', 'a', ' ', ' '])
  normal 4G0\B
  call g:assert.equals(line('.'), 3, 'failed at #34')
  call columnmove#interrupt()
  %delete

  " #35
  call append(0, [' ', ' ', 'a', ' ', ' '])
  normal 5G0\B
  call g:assert.equals(line('.'), 3, 'failed at #35')
  call columnmove#interrupt()
  %delete

  " #36
  call append(0, [' ', ' ', ';', ' ', ' '])
  normal 1G0\B
  call g:assert.equals(line('.'), 1, 'failed at #36')
  call columnmove#interrupt()
  %delete

  " #37
  call append(0, [' ', ' ', ';', ' ', ' '])
  normal 2G0\B
  call g:assert.equals(line('.'), 2, 'failed at #37')
  call columnmove#interrupt()
  %delete

  " #38
  call append(0, [' ', ' ', ';', ' ', ' '])
  normal 3G0\B
  call g:assert.equals(line('.'), 3, 'failed at #38')
  call columnmove#interrupt()
  %delete

  " #39
  call append(0, [' ', ' ', ';', ' ', ' '])
  normal 4G0\B
  call g:assert.equals(line('.'), 3, 'failed at #39')
  call columnmove#interrupt()
  %delete

  " #40
  call append(0, [' ', ' ', ';', ' ', ' '])
  normal 5G0\B
  call g:assert.equals(line('.'), 3, 'failed at #40')
  call columnmove#interrupt()
  %delete

  " #41
  call append(0, [' ', ' ', '', ' ', ' '])
  normal 1G0\B
  call g:assert.equals(line('.'), 1, 'failed at #41')
  call columnmove#interrupt()
  %delete

  " #42
  call append(0, [' ', ' ', '', ' ', ' '])
  normal 2G0\B
  call g:assert.equals(line('.'), 2, 'failed at #42')
  call columnmove#interrupt()
  %delete

  " #43
  call append(0, [' ', ' ', '', ' ', ' '])
  normal 3G0\B
  call g:assert.equals(line('.'), 3, 'failed at #43')
  call columnmove#interrupt()
  %delete

  " #44
  call append(0, [' ', ' ', '', ' ', ' '])
  normal 4G0\B
  call g:assert.equals(line('.'), 4, 'failed at #44')
  call columnmove#interrupt()
  %delete

  " #45
  call append(0, [' ', ' ', '', ' ', ' '])
  normal 5G0\B
  call g:assert.equals(line('.'), 5, 'failed at #45')
  call columnmove#interrupt()
  %delete

  " #46
  call append(0, ['', '', 'a', '', ''])
  normal 1G0\B
  call g:assert.equals(line('.'), 1, 'failed at #46')
  call columnmove#interrupt()
  %delete

  " #47
  call append(0, ['', '', 'a', '', ''])
  normal 2G0\B
  call g:assert.equals(line('.'), 2, 'failed at #47')
  call columnmove#interrupt()
  %delete

  " #48
  call append(0, ['', '', 'a', '', ''])
  normal 3G0\B
  call g:assert.equals(line('.'), 3, 'failed at #48')
  call columnmove#interrupt()
  %delete

  " #49
  call append(0, ['', '', 'a', '', ''])
  normal 4G0\B
  call g:assert.equals(line('.'), 3, 'failed at #49')
  call columnmove#interrupt()
  %delete

  " #50
  call append(0, ['', '', 'a', '', ''])
  normal 5G0\B
  call g:assert.equals(line('.'), 3, 'failed at #50')
  call columnmove#interrupt()
  %delete

  " #51
  call append(0, ['', '', ';', '', ''])
  normal 1G0\B
  call g:assert.equals(line('.'), 1, 'failed at #51')
  call columnmove#interrupt()
  %delete

  " #52
  call append(0, ['', '', ';', '', ''])
  normal 2G0\B
  call g:assert.equals(line('.'), 2, 'failed at #52')
  call columnmove#interrupt()
  %delete

  " #53
  call append(0, ['', '', ';', '', ''])
  normal 3G0\B
  call g:assert.equals(line('.'), 3, 'failed at #53')
  call columnmove#interrupt()
  %delete

  " #54
  call append(0, ['', '', ';', '', ''])
  normal 4G0\B
  call g:assert.equals(line('.'), 3, 'failed at #54')
  call columnmove#interrupt()
  %delete

  " #55
  call append(0, ['', '', ';', '', ''])
  normal 5G0\B
  call g:assert.equals(line('.'), 3, 'failed at #55')
  call columnmove#interrupt()
  %delete

  " #56
  call append(0, ['', '', ' ', '', ''])
  normal 1G0\B
  call g:assert.equals(line('.'), 1, 'failed at #56')
  call columnmove#interrupt()
  %delete

  " #57
  call append(0, ['', '', ' ', '', ''])
  normal 2G0\B
  call g:assert.equals(line('.'), 2, 'failed at #57')
  call columnmove#interrupt()
  %delete

  " #58
  call append(0, ['', '', ' ', '', ''])
  normal 3G0\B
  call g:assert.equals(line('.'), 3, 'failed at #58')
  call columnmove#interrupt()
  %delete

  " #59
  call append(0, ['', '', ' ', '', ''])
  normal 4G0\B
  call g:assert.equals(line('.'), 4, 'failed at #59')
  call columnmove#interrupt()
  %delete

  " #60
  call append(0, ['', '', ' ', '', ''])
  normal 5G0\B
  call g:assert.equals(line('.'), 5, 'failed at #60')
  call columnmove#interrupt()
  %delete

  " #61
  call append(0, ['a', 'b', '', 'c', 'd', '', 'e'])
  normal 7G0\B
  call g:assert.equals(line('.'), 4, 'failed at #61')
  normal \B
  call g:assert.equals(line('.'), 1, 'failed at #61')
  call columnmove#interrupt()
  %delete
endfunction
"}}}
function! s:suite_B.strict_count() abort "{{{
  " #1
  call append(0, ['a', 'b', '', 'c', 'd', '', 'e', 'f', '', 'g'])
  normal 10G0\B
  call g:assert.equals(line('.'), 7, 'failed at #1')
  call columnmove#interrupt()
  %delete

  " #2
  call append(0, ['a', 'b', '', 'c', 'd', '', 'e', 'f', '', 'g'])
  normal 10G02\B
  call g:assert.equals(line('.'), 4, 'failed at #2')
  call columnmove#interrupt()
  %delete

  " #3
  call append(0, ['a', 'b', '', 'c', 'd', '', 'e', 'f', '', 'g'])
  normal 10G03\B
  call g:assert.equals(line('.'), 1, 'failed at #3')
  call columnmove#interrupt()
  %delete

  " #3
  call append(0, ['a', 'b', '', 'c', 'd', '', 'e', 'f', '', 'g'])
  normal 10G04\B
  call g:assert.equals(line('.'), 10, 'failed at #3')
  call columnmove#interrupt()
  %delete
endfunction
"}}}
function! s:suite_B.strict_fold() abort  "{{{
  " #1
  call append(0, ['a', 'b', '', 'c', 'd', 'e', 'f'])
  1,2fold
  normal 7G0\B
  call g:assert.equals(line('.'), 4, 'failed at #1')
  call columnmove#interrupt()
  %delete

  " #2
  call append(0, ['a', 'b', '', 'c', 'd', 'e', 'f'])
  2,3fold
  normal 7G0\B
  call g:assert.equals(line('.'), 1, 'failed at #2')
  call columnmove#interrupt()
  %delete

  " #3
  call append(0, ['a', 'b', '', 'c', 'd', 'e', 'f'])
  3,4fold
  normal 7G0\B
  call g:assert.equals(line('.'), 1, 'failed at #3')
  call columnmove#interrupt()
  %delete

  " #4
  call append(0, ['a', 'b', '', 'c', 'd', 'e', 'f'])
  4,5fold
  normal 7G0\B
  call g:assert.equals(line('.'), 6, 'failed at #4')
  call columnmove#interrupt()
  %delete

  " #5
  call append(0, ['a', 'b', '', 'c', 'd', 'e', 'f'])
  5,6fold
  normal 7G0\B
  call g:assert.equals(line('.'), 4, 'failed at #5')
  call columnmove#interrupt()
  %delete

  " #6
  call append(0, ['a', 'b', '', 'c', 'd', 'e', 'f'])
  6,7fold
  normal 7G0\B
  call g:assert.equals(line('.'), 4, 'failed at #6')
  call columnmove#interrupt()
  %delete

  " #7
  call append(0, ['a', 'b', '', 'c', 'd', 'e', 'f', 'g'])
  5,6fold
  normal 8G0\B
  call g:assert.equals(line('.'), 4, 'failed at #7')
  call columnmove#interrupt()
  %delete
endfunction
"}}}
function! s:suite_B.strict_option_fold_treatment() abort  "{{{
  let g:columnmove_fold_treatment = 1

  " #1
  call append(0, ['a', 'b', '', 'c', 'd', 'e', 'f'])
  1,2fold
  normal 7G0\B
  call g:assert.equals(line('.'), 4, 'failed at #1')
  call columnmove#interrupt()
  %delete

  " #2
  call append(0, ['a', 'b', '', 'c', 'd', 'e', 'f'])
  2,3fold
  normal 7G0\B
  call g:assert.equals(line('.'), 4, 'failed at #2')
  call columnmove#interrupt()
  %delete

  " #3
  call append(0, ['a', 'b', '', 'c', 'd', 'e', 'f'])
  3,4fold
  normal 7G0\B
  call g:assert.equals(line('.'), 5, 'failed at #3')
  call columnmove#interrupt()
  %delete

  " #4
  call append(0, ['a', 'b', '', 'c', 'd', 'e', 'f'])
  4,5fold
  normal 7G0\B
  call g:assert.equals(line('.'), 6, 'failed at #4')
  call columnmove#interrupt()
  %delete

  " #5
  call append(0, ['a', 'b', '', 'c', 'd', 'e', 'f'])
  5,6fold
  normal 7G0\B
  call g:assert.equals(line('.'), 4, 'failed at #5')
  call columnmove#interrupt()
  %delete

  " #6
  call append(0, ['a', 'b', '', 'c', 'd', 'e', 'f'])
  6,7fold
  normal 7G0\B
  call g:assert.equals(line('.'), 4, 'failed at #6')
  call columnmove#interrupt()
  %delete

  " #7
  call append(0, ['a', 'b', '', 'c', 'd', 'e', 'f', 'g'])
  5,6fold
  normal 8G0\B
  call g:assert.equals(line('.'), 7, 'failed at #7')
  call columnmove#interrupt()
  %delete
endfunction
"}}}
function! s:suite_B.strict_option_fold_open() abort  "{{{
  let g:columnmove_fold_open = 1

  " #1
  call append(0, ['a', 'b', ':', 'c', 'd'])
  2,4fold
  normal 5G\B
  call g:assert.equals(line('.'), 1, 'failed at #1')
  call g:assert.equals(foldclosed(2),    2, 'failed at #1')
  call g:assert.equals(foldclosedend(2), 4, 'failed at #1')
  call columnmove#interrupt()
  %delete

  " #2
  call append(0, ['a', 'b', ' ', 'c', 'd'])
  2,4fold
  normal 5G\B
  call g:assert.equals(line('.'), 4, 'failed at #2')
  call g:assert.equals(foldclosed(2),    -1, 'failed at #2')
  call g:assert.equals(foldclosedend(2), -1, 'failed at #2')
  call columnmove#interrupt()
  %delete

  " #3
  call append(0, ['a', 'b', '', 'c', 'd'])
  2,4fold
  normal 5G\B
  call g:assert.equals(line('.'), 4, 'failed at #3')
  call g:assert.equals(foldclosed(2),    -1, 'failed at #3')
  call g:assert.equals(foldclosedend(2), -1, 'failed at #3')
  call columnmove#interrupt()
  %delete

  " #4
  call append(0, ['a', 'b', 'c', 'd', ':'])
  2,4fold
  normal 5G\B
  call g:assert.equals(line('.'), 1, 'failed at #4')
  call g:assert.equals(foldclosed(2),    2, 'failed at #4')
  call g:assert.equals(foldclosedend(2), 4, 'failed at #4')
  call columnmove#interrupt()
  %delete

  " #5
  call append(0, ['a', 'b', 'c', ' ', 'd'])
  2,4fold
  normal 5G\B
  call g:assert.equals(line('.'), 1, 'failed at #5')
  call g:assert.equals(foldclosed(2),    2, 'failed at #5')
  call g:assert.equals(foldclosedend(2), 4, 'failed at #5')
  call columnmove#interrupt()
  %delete

  " #6
  call append(0, ['a', 'b', 'c', '', 'd'])
  2,4fold
  normal 5G\B
  call g:assert.equals(line('.'), 1, 'failed at #6')
  call g:assert.equals(foldclosed(2),    2, 'failed at #6')
  call g:assert.equals(foldclosedend(2), 4, 'failed at #6')
  call columnmove#interrupt()
  %delete
endfunction
"}}}
function! s:suite_B.strict_option_combinations() abort "{{{
  let g:columnmove_fold_treatment = 1
  let g:columnmove_fold_open = 1

  " #1
  call append(0, ['a', 'b', '', 'c', 'd'])
  2,4fold
  normal 5G\B
  call g:assert.equals(line('.'), 4, 'failed at #1')
  call columnmove#interrupt()
  %delete
endfunction
"}}}
function! s:suite_B.strict_option_stop_on_space() dict abort  "{{{
  let g:columnmove_stop_on_space = 1

  " #1
  call append(0, ['',  'aa', '  ', '', 'bb'])
  normal 5G0\B
  call g:assert.equals(line('.'), 2, 'failed at #1')
  call columnmove#interrupt()
  %delete

  " #2
  call append(0, ['',  'aa', '  ', '', 'bb'])
  normal 5G0l\B
  call g:assert.equals(line('.'), 2, 'failed at #2')
  call columnmove#interrupt()
  %delete

  " #3
  call append(0, ['',  'a ', '  ', '', 'bb'])
  normal 5G0\B
  call g:assert.equals(line('.'), 2, 'failed at #3')
  call columnmove#interrupt()
  %delete

  " #4
  call append(0, ['',  'a ', '  ', '', 'bb'])
  normal 5G0l\B
  call g:assert.equals(line('.'), 2, 'failed at #4')
  call columnmove#interrupt()
  %delete

  let g:columnmove_stop_on_space = 0

  " #5
  call append(0, ['',  'aa', '  ', '', 'bb'])
  normal 5G0\B
  call g:assert.equals(line('.'), 2, 'failed at #5')
  call columnmove#interrupt()
  %delete

  " #6
  call append(0, ['',  'aa', '  ', '', 'bb'])
  normal 5G0l\B
  call g:assert.equals(line('.'), 2, 'failed at #6')
  call columnmove#interrupt()
  %delete

  " #7
  call append(0, ['',  'a ', '  ', '', 'bb'])
  normal 5G0\B
  call g:assert.equals(line('.'), 2, 'failed at #7')
  call columnmove#interrupt()
  %delete

  " #8
  call append(0, ['',  'a ', '  ', '', 'bb'])
  normal 5G0l\B
  call g:assert.equals(line('.'), 5, 'failed at #8')
  call columnmove#interrupt()
  %delete
endfunction
"}}}
function! s:suite_B.strict_curswant() abort "{{{
  " #1
  call append(0, ['abcde', '', 'fgh', 'ijklm'])
  normal 4G$k\B
  call g:assert.equals(getpos('.')[1:2], [1, 3], 'failed at #1')
  call columnmove#interrupt()
  %delete
endfunction
"}}}
function! s:suite_B.strict_tabchar() abort "{{{
  " #1
  set tabstop=4
  call append(0, ['	abc', 'defghij', '', 'klmnopq'])
  normal 4G4l\B
  call g:assert.equals(getpos('.')[1:2], [1, 2], 'failed at #1')
  call columnmove#interrupt()
  %delete

  " #2
  set tabstop=4
  call append(0, ['abcdefg', 'hijklmn', '', '	opqr'])
  normal 4G\B
  call g:assert.equals(getpos('.')[1:2], [1, 5], 'failed at #2')
  call columnmove#interrupt()
  %delete
endfunction
"}}}
function! s:suite_B.strict_multibyte_char() abort "{{{
  " #1
  set ambiwidth=single
  call append(0, ['αbc', 'defg', '', 'hijk'])
  normal 4G\B
  call g:assert.equals(getpos('.')[1:2], [1, 1], 'failed at #1')
  call columnmove#interrupt()
  %delete

  " #2
  set ambiwidth=single
  call append(0, ['αbc', 'defg', '', 'hijk'])
  normal 4Gl\B
  call g:assert.equals(getpos('.')[1:2], [1, strlen('α')+1], 'failed at #2')
  call columnmove#interrupt()
  %delete

  " #3
  set ambiwidth=single
  call append(0, ['αbc', 'defg', '', 'hijk'])
  normal 4G2l\B
  call g:assert.equals(getpos('.')[1:2], [1, strlen('α')+2], 'failed at #3')
  call columnmove#interrupt()
  %delete

  " #4
  set ambiwidth=single
  call append(0, ['abc', 'δefg', '', 'hijk'])
  normal 4G\B
  call g:assert.equals(getpos('.')[1:2], [1, 1], 'failed at #4')
  call columnmove#interrupt()
  %delete

  " #5
  set ambiwidth=single
  call append(0, ['abc', 'δefg', '', 'hijk'])
  normal 4Gl\B
  call g:assert.equals(getpos('.')[1:2], [1, 2], 'failed at #5')
  call columnmove#interrupt()
  %delete

  " #6
  set ambiwidth=single
  call append(0, ['abc', 'δefg', '', 'hijk'])
  normal 4G2l\B
  call g:assert.equals(getpos('.')[1:2], [1, 3], 'failed at #6')
  call columnmove#interrupt()
  %delete

  " #7
  set ambiwidth=single
  call append(0, ['abc', 'defg', '', 'ηijk'])
  normal 4G\B
  call g:assert.equals(getpos('.')[1:2], [1, 1], 'failed at #7')
  call columnmove#interrupt()
  %delete

  " #8
  set ambiwidth=single
  call append(0, ['abc', 'defg', '', 'ηijk'])
  normal 4Gl\B
  call g:assert.equals(getpos('.')[1:2], [1, 2], 'failed at #8')
  let @@ = ''
  normal! yl
  call g:assert.equals(@@, 'b', 'failed at #8')
  call columnmove#interrupt()
  %delete

  " #9
  set ambiwidth=single
  call append(0, ['abc', 'defg', '', 'ηijk'])
  normal 4G2l\B
  call g:assert.equals(getpos('.')[1:2], [1, 3], 'failed at #9')
  let @@ = ''
  normal! yl
  call g:assert.equals(@@, 'c', 'failed at #9')
  call columnmove#interrupt()
  %delete

  " #10
  set ambiwidth=double
  call append(0, ['αbc', 'defg', '', 'hijk'])
  normal 4G\B
  call g:assert.equals(getpos('.')[1:2], [1, 1], 'failed at #10')
  call columnmove#interrupt()
  %delete

  " #11
  set ambiwidth=double
  call append(0, ['αbc', 'defg', '', 'hijk'])
  normal 4Gl\B
  call g:assert.equals(getpos('.')[1:2], [1, 1], 'failed at #11')
  call columnmove#interrupt()
  %delete

  " #12
  set ambiwidth=double
  call append(0, ['αbc', 'defg', '', 'hijk'])
  normal 4G2l\B
  call g:assert.equals(getpos('.')[1:2], [1, strlen('α')+1], 'failed at #12')
  call columnmove#interrupt()
  %delete

  " #13
  set ambiwidth=double
  call append(0, ['abc', 'δefg', '', 'hijk'])
  normal 4G\B
  call g:assert.equals(getpos('.')[1:2], [1, 1], 'failed at #13')
  call columnmove#interrupt()
  %delete

  " #14
  set ambiwidth=double
  call append(0, ['abc', 'δefg', '', 'hijk'])
  normal 4Gl\B
  call g:assert.equals(getpos('.')[1:2], [1, 2], 'failed at #14')
  call columnmove#interrupt()
  %delete

  " #15
  set ambiwidth=double
  call append(0, ['abc', 'δefg', '', 'hijk'])
  normal 4G2l\B
  call g:assert.equals(getpos('.')[1:2], [1, 3], 'failed at #15')
  call columnmove#interrupt()
  %delete

  " #16
  set ambiwidth=double
  call append(0, ['abc', 'defg', '', 'ηijk'])
  normal 4G\B
  call g:assert.equals(getpos('.')[1:2], [1, 1], 'failed at #16')
  call columnmove#interrupt()
  %delete

  " #17
  set ambiwidth=double
  call append(0, ['abc', 'defg', '', 'ηijk'])
  normal 4Gl\B
  call g:assert.equals(getpos('.')[1:2], [1, 3], 'failed at #17')
  let @@ = ''
  normal! yl
  call g:assert.equals(@@, 'c', 'failed at #17')
  call columnmove#interrupt()
  %delete

  " #18
  set ambiwidth=double
  call append(0, ['abc', 'defg', '', 'ηijk'])
  normal 4G2l\B
  call g:assert.equals(getpos('.')[1:2], [2, 4], 'failed at #18')
  let @@ = ''
  normal! yl
  call g:assert.equals(@@, 'g', 'failed at #18')
  call columnmove#interrupt()
  %delete

  " #19
  set ambiwidth=double
  call append(0, ['abc', '', 'δefg', '', 'hijk'])
  normal 5G0l\B
  call g:assert.equals(getpos('.')[1:2], [3, 1], 'failed at #19')
  normal \B
  call g:assert.equals(getpos('.')[1:2], [1, 2], 'failed at #19')
  call columnmove#interrupt()
  %delete

  " #20
  set ambiwidth=double
  call append(0, ['abc', '', 'δefg', '', 'hijk'])
  normal 5G0l\B
  call g:assert.equals(getpos('.')[1:2], [3, 1], 'failed at #20')
  call columnmove#interrupt()
  normal \B
  call g:assert.equals(getpos('.')[1:2], [1, 1], 'failed at #20')
  call columnmove#interrupt()
  %delete
endfunction
"}}}
function! s:suite_B.strict_visual_mode() abort  "{{{
  " #1
  call append(0, ['a', 'b', '', 'c', 'd'])
  call setpos("'<", [0, 0, 0, 0])
  call setpos("'>", [0, 0, 0, 0])
  normal 5G0v\B
  execute "normal! \<Esc>"
  call g:assert.equals(getpos("'<"), [0, 4, 1, 0], 'failed at #1')
  call g:assert.equals(getpos("'>"), [0, 5, 1, 0], 'failed at #1')
  call g:assert.equals(visualmode(), 'v', 'failed at #1')
  call columnmove#interrupt()
  %delete

  " #2
  call append(0, ['a', 'b', '', 'c', 'd'])
  call setpos("'<", [0, 0, 0, 0])
  call setpos("'>", [0, 0, 0, 0])
  normal 5G0V\B
  execute "normal! \<Esc>"
  call g:assert.equals(getpos("'<"), [0, 4, 1, 0], 'failed at #2')
  call g:assert.equals(getpos("'>"), [0, 5, g:intmax, 0], 'failed at #2')
  call g:assert.equals(visualmode(), 'V', 'failed at #2')
  call columnmove#interrupt()
  %delete

  " #3
  call append(0, ['a', 'b', '', 'c', 'd'])
  call setpos("'<", [0, 0, 0, 0])
  call setpos("'>", [0, 0, 0, 0])
  execute "normal 5G0\<C-v>\\B\<Esc>"
  call g:assert.equals(getpos("'<"), [0, 4, 1, 0], 'failed at #3')
  call g:assert.equals(getpos("'>"), [0, 5, 1, 0], 'failed at #3')
  call g:assert.equals(visualmode(), "\<C-v>", 'failed at #3')
  call columnmove#interrupt()
  %delete

  " #4
  call append(0, ['a', 'b', '', 'c', 'd', '', 'e'])
  call setpos("'<", [0, 0, 0, 0])
  call setpos("'>", [0, 0, 0, 0])
  normal 7G0v\B\B
  execute "normal! \<Esc>"
  call g:assert.equals(getpos("'<"), [0, 1, 1, 0], 'failed at #4')
  call g:assert.equals(getpos("'>"), [0, 7, 1, 0], 'failed at #4')
  call g:assert.equals(visualmode(), 'v', 'failed at #4')
  call columnmove#interrupt()
  %delete

  " #5
  call append(0, ['', '', ''])
  normal 3G0v\B
  call g:assert.equals(mode(), 'v', 'failed at #5')
  execute "normal! \<Esc>"
  call columnmove#interrupt()
  %delete
endfunction
"}}}
function! s:suite_B.strict_operator_pending_mode() abort  "{{{
  " #1
  " default: linewise
  call append(0, ['abc', 'def', ':::'])
  let @@ = ''
  normal 3G0l""d\B
  call g:assert.equals(getreg('"'), "abc\ndef\n:::\n", 'failed at #1')
  call g:assert.equals(getregtype('"'), 'V', 'failed at #1')
  call columnmove#interrupt()
  %delete

  " #2
  " exclusive character-wise with o_v
  call append(0, ['abc', 'def', ':::'])
  let @@ = ''
  normal 3G0l""dv\B
  call g:assert.equals(getreg('"'), "bc\ndef\n:", 'failed at #2')
  call g:assert.equals(getregtype('"'), 'v', 'failed at #2')
  call columnmove#interrupt()
  %delete

  " #3
  " line-wise with o_V
  call append(0, ['abc', 'def', ':::'])
  let @@ = ''
  normal 3G0l""dV\B
  call g:assert.equals(getreg('"'), "abc\ndef\n:::\n", 'failed at #3')
  call g:assert.equals(getregtype('"'), 'V', 'failed at #3')
  call columnmove#interrupt()
  %delete

  " #4
  " block-wise with o_CTRL-V
  call append(0, ['abc', 'def', ':::'])
  let @@ = ''
  execute "normal 3G0l\"\"d\<C-v>\\B"
  call g:assert.equals(getreg('"'), "b\ne\n:", 'failed at #4')
  call g:assert.equals(getregtype('"'), "\<C-v>1", 'failed at #4')
  call columnmove#interrupt()
  %delete
endfunction
"}}}

" vim:set foldmethod=marker:
" vim:set commentstring="%s:
" vim:set ts=2 sts=2 sw=2 et:
