" NOTE: Since auto-commands are not ignited inside test functions, use
"       g:columnmove#interrupt() to reset explicitly.

let s:suite_ge = themis#suite('columnmove-ge:')
function! s:suite_ge.before_each() abort  "{{{
  mapclear
  mapclear!
  call columnmove#utility#map('nxo', 'ge', '\ge')
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
function! s:suite_ge.after() abort  "{{{
  call s:suite_ge.before_each()
  mapclear
  mapclear!
endfunction
"}}}

function! s:suite_ge.strict() abort  "{{{
  let g:columnmove_strict_wbege = 1

  " #1
  call append(0, ['a', 'b', ';', 'c', 'd'])
  normal 1G0\ge
  call g:assert.equals(line('.'), 1, 'failed at #1')
  call columnmove#interrupt()
  %delete

  " #2
  call append(0, ['a', 'b', ';', 'c', 'd'])
  normal 2G0\ge
  call g:assert.equals(line('.'), 2, 'failed at #2')
  call columnmove#interrupt()
  %delete

  " #3
  call append(0, ['a', 'b', ';', 'c', 'd'])
  normal 3G0\ge
  call g:assert.equals(line('.'), 2, 'failed at #3')
  call columnmove#interrupt()
  %delete

  " #4
  call append(0, ['a', 'b', ';', 'c', 'd'])
  normal 4G0\ge
  call g:assert.equals(line('.'), 3, 'failed at #4')
  call columnmove#interrupt()
  %delete

  " #5
  call append(0, ['a', 'b', ';', 'c', 'd'])
  normal 5G0\ge
  call g:assert.equals(line('.'), 3, 'failed at #5')
  call columnmove#interrupt()
  %delete

  " #6
  call append(0, ['a', 'b', ' ', 'c', 'd'])
  normal 1G0\ge
  call g:assert.equals(line('.'), 1, 'failed at #6')
  call columnmove#interrupt()
  %delete

  " #7
  call append(0, ['a', 'b', ' ', 'c', 'd'])
  normal 2G0\ge
  call g:assert.equals(line('.'), 2, 'failed at #7')
  call columnmove#interrupt()
  %delete

  " #8
  call append(0, ['a', 'b', ' ', 'c', 'd'])
  normal 3G0\ge
  call g:assert.equals(line('.'), 2, 'failed at #8')
  call columnmove#interrupt()
  %delete

  " #9
  call append(0, ['a', 'b', ' ', 'c', 'd'])
  normal 4G0\ge
  call g:assert.equals(line('.'), 2, 'failed at #9')
  call columnmove#interrupt()
  %delete

  " #10
  call append(0, ['a', 'b', ' ', 'c', 'd'])
  normal 5G0\ge
  call g:assert.equals(line('.'), 2, 'failed at #10')
  call columnmove#interrupt()
  %delete

  " #11
  call append(0, ['a', 'b', '', 'c', 'd'])
  normal 1G0\ge
  call g:assert.equals(line('.'), 1, 'failed at #11')
  call columnmove#interrupt()
  %delete

  " #12
  call append(0, ['a', 'b', '', 'c', 'd'])
  normal 2G0\ge
  call g:assert.equals(line('.'), 2, 'failed at #12')
  call columnmove#interrupt()
  %delete

  " #13
  call append(0, ['a', 'b', '', 'c', 'd'])
  normal 3G0\ge
  call g:assert.equals(line('.'), 2, 'failed at #13')
  call columnmove#interrupt()
  %delete

  " #14
  call append(0, ['a', 'b', '', 'c', 'd'])
  normal 4G0\ge
  call g:assert.equals(line('.'), 2, 'failed at #14')
  call columnmove#interrupt()
  %delete

  " #15
  call append(0, ['a', 'b', '', 'c', 'd'])
  normal 5G0\ge
  call g:assert.equals(line('.'), 2, 'failed at #15')
  call columnmove#interrupt()
  %delete

  " #16
  call append(0, [';', ':', 'a', ',', '.'])
  normal 1G0\ge
  call g:assert.equals(line('.'), 1, 'failed at #16')
  call columnmove#interrupt()
  %delete

  " #17
  call append(0, [';', ':', 'a', ',', '.'])
  normal 2G0\ge
  call g:assert.equals(line('.'), 2, 'failed at #17')
  call columnmove#interrupt()
  %delete

  " #18
  call append(0, [';', ':', 'a', ',', '.'])
  normal 3G0\ge
  call g:assert.equals(line('.'), 2, 'failed at #18')
  call columnmove#interrupt()
  %delete

  " #19
  call append(0, [';', ':', 'a', ',', '.'])
  normal 4G0\ge
  call g:assert.equals(line('.'), 3, 'failed at #19')
  call columnmove#interrupt()
  %delete

  " #20
  call append(0, [';', ':', 'a', ',', '.'])
  normal 5G0\ge
  call g:assert.equals(line('.'), 3, 'failed at #20')
  call columnmove#interrupt()
  %delete

  " #21
  call append(0, [';', ':', ' ', ',', '.'])
  normal 1G0\ge
  call g:assert.equals(line('.'), 1, 'failed at #21')
  call columnmove#interrupt()
  %delete

  " #22
  call append(0, [';', ':', ' ', ',', '.'])
  normal 2G0\ge
  call g:assert.equals(line('.'), 2, 'failed at #22')
  call columnmove#interrupt()
  %delete

  " #23
  call append(0, [';', ':', ' ', ',', '.'])
  normal 3G0\ge
  call g:assert.equals(line('.'), 2, 'failed at #23')
  call columnmove#interrupt()
  %delete

  " #24
  call append(0, [';', ':', ' ', ',', '.'])
  normal 4G0\ge
  call g:assert.equals(line('.'), 2, 'failed at #24')
  call columnmove#interrupt()
  %delete

  " #25
  call append(0, [';', ':', ' ', ',', '.'])
  normal 5G0\ge
  call g:assert.equals(line('.'), 2, 'failed at #25')
  call columnmove#interrupt()
  %delete

  " #26
  call append(0, [';', ':', '', ',', '.'])
  normal 1G0\ge
  call g:assert.equals(line('.'), 1, 'failed at #26')
  call columnmove#interrupt()
  %delete

  " #27
  call append(0, [';', ':', '', ',', '.'])
  normal 2G0\ge
  call g:assert.equals(line('.'), 2, 'failed at #27')
  call columnmove#interrupt()
  %delete

  " #28
  call append(0, [';', ':', '', ',', '.'])
  normal 3G0\ge
  call g:assert.equals(line('.'), 2, 'failed at #28')
  call columnmove#interrupt()
  %delete

  " #29
  call append(0, [';', ':', '', ',', '.'])
  normal 4G0\ge
  call g:assert.equals(line('.'), 2, 'failed at #29')
  call columnmove#interrupt()
  %delete

  " #30
  call append(0, [';', ':', '', ',', '.'])
  normal 5G0\ge
  call g:assert.equals(line('.'), 2, 'failed at #30')
  call columnmove#interrupt()
  %delete

  " #31
  call append(0, [' ', ' ', 'a', ' ', ' '])
  normal 1G0\ge
  call g:assert.equals(line('.'), 1, 'failed at #31')
  call columnmove#interrupt()
  %delete

  " #32
  call append(0, [' ', ' ', 'a', ' ', ' '])
  normal 2G0\ge
  call g:assert.equals(line('.'), 2, 'failed at #32')
  call columnmove#interrupt()
  %delete

  " #33
  call append(0, [' ', ' ', 'a', ' ', ' '])
  normal 3G0\ge
  call g:assert.equals(line('.'), 3, 'failed at #33')
  call columnmove#interrupt()
  %delete

  " #34
  call append(0, [' ', ' ', 'a', ' ', ' '])
  normal 4G0\ge
  call g:assert.equals(line('.'), 3, 'failed at #34')
  call columnmove#interrupt()
  %delete

  " #35
  call append(0, [' ', ' ', 'a', ' ', ' '])
  normal 5G0\ge
  call g:assert.equals(line('.'), 3, 'failed at #35')
  call columnmove#interrupt()
  %delete

  " #36
  call append(0, [' ', ' ', ';', ' ', ' '])
  normal 1G0\ge
  call g:assert.equals(line('.'), 1, 'failed at #36')
  call columnmove#interrupt()
  %delete

  " #37
  call append(0, [' ', ' ', ';', ' ', ' '])
  normal 2G0\ge
  call g:assert.equals(line('.'), 2, 'failed at #37')
  call columnmove#interrupt()
  %delete

  " #38
  call append(0, [' ', ' ', ';', ' ', ' '])
  normal 3G0\ge
  call g:assert.equals(line('.'), 3, 'failed at #38')
  call columnmove#interrupt()
  %delete

  " #39
  call append(0, [' ', ' ', ';', ' ', ' '])
  normal 4G0\ge
  call g:assert.equals(line('.'), 3, 'failed at #39')
  call columnmove#interrupt()
  %delete

  " #40
  call append(0, [' ', ' ', ';', ' ', ' '])
  normal 5G0\ge
  call g:assert.equals(line('.'), 3, 'failed at #40')
  call columnmove#interrupt()
  %delete

  " #41
  call append(0, [' ', ' ', '', ' ', ' '])
  normal 1G0\ge
  call g:assert.equals(line('.'), 1, 'failed at #41')
  call columnmove#interrupt()
  %delete

  " #42
  call append(0, [' ', ' ', '', ' ', ' '])
  normal 2G0\ge
  call g:assert.equals(line('.'), 2, 'failed at #42')
  call columnmove#interrupt()
  %delete

  " #43
  call append(0, [' ', ' ', '', ' ', ' '])
  normal 3G0\ge
  call g:assert.equals(line('.'), 3, 'failed at #43')
  call columnmove#interrupt()
  %delete

  " #44
  call append(0, [' ', ' ', '', ' ', ' '])
  normal 4G0\ge
  call g:assert.equals(line('.'), 4, 'failed at #44')
  call columnmove#interrupt()
  %delete

  " #45
  call append(0, [' ', ' ', '', ' ', ' '])
  normal 5G0\ge
  call g:assert.equals(line('.'), 5, 'failed at #45')
  call columnmove#interrupt()
  %delete

  " #46
  call append(0, ['', '', 'a', '', ''])
  normal 1G0\ge
  call g:assert.equals(line('.'), 1, 'failed at #46')
  call columnmove#interrupt()
  %delete

  " #47
  call append(0, ['', '', 'a', '', ''])
  normal 2G0\ge
  call g:assert.equals(line('.'), 2, 'failed at #47')
  call columnmove#interrupt()
  %delete

  " #48
  call append(0, ['', '', 'a', '', ''])
  normal 3G0\ge
  call g:assert.equals(line('.'), 3, 'failed at #48')
  call columnmove#interrupt()
  %delete

  " #49
  call append(0, ['', '', 'a', '', ''])
  normal 4G0\ge
  call g:assert.equals(line('.'), 3, 'failed at #49')
  call columnmove#interrupt()
  %delete

  " #50
  call append(0, ['', '', 'a', '', ''])
  normal 5G0\ge
  call g:assert.equals(line('.'), 3, 'failed at #50')
  call columnmove#interrupt()
  %delete

  " #51
  call append(0, ['', '', ';', '', ''])
  normal 1G0\ge
  call g:assert.equals(line('.'), 1, 'failed at #51')
  call columnmove#interrupt()
  %delete

  " #52
  call append(0, ['', '', ';', '', ''])
  normal 2G0\ge
  call g:assert.equals(line('.'), 2, 'failed at #52')
  call columnmove#interrupt()
  %delete

  " #53
  call append(0, ['', '', ';', '', ''])
  normal 3G0\ge
  call g:assert.equals(line('.'), 3, 'failed at #53')
  call columnmove#interrupt()
  %delete

  " #54
  call append(0, ['', '', ';', '', ''])
  normal 4G0\ge
  call g:assert.equals(line('.'), 3, 'failed at #54')
  call columnmove#interrupt()
  %delete

  " #55
  call append(0, ['', '', ';', '', ''])
  normal 5G0\ge
  call g:assert.equals(line('.'), 3, 'failed at #55')
  call columnmove#interrupt()
  %delete

  " #56
  call append(0, ['', '', ' ', '', ''])
  normal 1G0\ge
  call g:assert.equals(line('.'), 1, 'failed at #56')
  call columnmove#interrupt()
  %delete

  " #57
  call append(0, ['', '', ' ', '', ''])
  normal 2G0\ge
  call g:assert.equals(line('.'), 2, 'failed at #57')
  call columnmove#interrupt()
  %delete

  " #58
  call append(0, ['', '', ' ', '', ''])
  normal 3G0\ge
  call g:assert.equals(line('.'), 3, 'failed at #58')
  call columnmove#interrupt()
  %delete

  " #59
  call append(0, ['', '', ' ', '', ''])
  normal 4G0\ge
  call g:assert.equals(line('.'), 4, 'failed at #59')
  call columnmove#interrupt()
  %delete

  " #60
  call append(0, ['', '', ' ', '', ''])
  normal 5G0\ge
  call g:assert.equals(line('.'), 5, 'failed at #60')
  call columnmove#interrupt()
  %delete

  " #61
  call append(0, ['a', 'b', '', 'c', 'd', '', 'e'])
  normal 7G0\ge
  call g:assert.equals(line('.'), 5, 'failed at #61')
  normal \ge
  call g:assert.equals(line('.'), 2, 'failed at #61')
  call columnmove#interrupt()
  %delete
endfunction
"}}}
function! s:suite_ge.strict_count() abort "{{{
  let g:columnmove_strict_wbege = 1

  " #1
  call append(0, ['a', 'b', '', 'c', 'd', '', 'e', 'f', '', 'g'])
  normal 10G0\ge
  call g:assert.equals(line('.'), 8, 'failed at #1')
  call columnmove#interrupt()
  %delete

  " #2
  call append(0, ['a', 'b', '', 'c', 'd', '', 'e', 'f', '', 'g'])
  normal 10G02\ge
  call g:assert.equals(line('.'), 5, 'failed at #2')
  call columnmove#interrupt()
  %delete

  " #3
  call append(0, ['a', 'b', '', 'c', 'd', '', 'e', 'f', '', 'g'])
  normal 10G03\ge
  call g:assert.equals(line('.'), 2, 'failed at #3')
  call columnmove#interrupt()
  %delete

  " #3
  call append(0, ['a', 'b', '', 'c', 'd', '', 'e', 'f', '', 'g'])
  normal 10G04\ge
  call g:assert.equals(line('.'), 10, 'failed at #3')
  call columnmove#interrupt()
  %delete
endfunction
"}}}
function! s:suite_ge.strict_fold() abort  "{{{
  let g:columnmove_strict_wbege = 1

  " #1
  call append(0, ['a', 'b', '', 'c', 'd', 'e', 'f'])
  1,2fold
  normal 7G0\ge
  call g:assert.equals(line('.'), 7, 'failed at #1')
  call columnmove#interrupt()
  %delete

  " #2
  call append(0, ['a', 'b', '', 'c', 'd', 'e', 'f'])
  2,3fold
  normal 7G0\ge
  call g:assert.equals(line('.'), 7, 'failed at #2')
  call columnmove#interrupt()
  %delete

  " #3
  call append(0, ['a', 'b', '', 'c', 'd', 'e', 'f'])
  3,4fold
  normal 7G0\ge
  call g:assert.equals(line('.'), 7, 'failed at #3')
  call columnmove#interrupt()
  %delete

  " #4
  call append(0, ['a', 'b', '', 'c', 'd', 'e', 'f'])
  4,5fold
  normal 7G0\ge
  call g:assert.equals(line('.'), 2, 'failed at #4')
  call columnmove#interrupt()
  %delete

  " #5
  call append(0, ['a', 'b', '', 'c', 'd', 'e', 'f'])
  5,6fold
  normal 7G0\ge
  call g:assert.equals(line('.'), 2, 'failed at #5')
  call columnmove#interrupt()
  %delete

  " #6
  call append(0, ['a', 'b', '', 'c', 'd', 'e', 'f'])
  6,7fold
  normal 7G0\ge
  call g:assert.equals(line('.'), 5, 'failed at #6')
  call columnmove#interrupt()
  %delete

  " #7
  call append(0, ['a', 'b', '', 'c', 'd', 'e', 'f', 'g'])
  6,7fold
  normal 8G0\ge
  call g:assert.equals(line('.'), 2, 'failed at #7')
  call columnmove#interrupt()
  %delete
endfunction
"}}}
function! s:suite_ge.strict_option_fold_treatment() abort  "{{{
  let g:columnmove_strict_wbege = 1
  let g:columnmove_fold_treatment = 1

  " #1
  call append(0, ['a', 'b', '', 'c', 'd', 'e', 'f'])
  1,2fold
  normal 7G0\ge
  call g:assert.equals(line('.'), 7, 'failed at #1')
  call columnmove#interrupt()
  %delete

  " #2
  call append(0, ['a', 'b', '', 'c', 'd', 'e', 'f'])
  2,3fold
  normal 7G0\ge
  call g:assert.equals(line('.'), 1, 'failed at #2')
  call columnmove#interrupt()
  %delete

  " #3
  call append(0, ['a', 'b', '', 'c', 'd', 'e', 'f'])
  3,4fold
  normal 7G0\ge
  call g:assert.equals(line('.'), 2, 'failed at #3')
  call columnmove#interrupt()
  %delete

  " #4
  call append(0, ['a', 'b', '', 'c', 'd', 'e', 'f'])
  4,5fold
  normal 7G0\ge
  call g:assert.equals(line('.'), 2, 'failed at #4')
  call columnmove#interrupt()
  %delete

  " #5
  call append(0, ['a', 'b', '', 'c', 'd', 'e', 'f'])
  5,6fold
  normal 7G0\ge
  call g:assert.equals(line('.'), 4, 'failed at #5')
  call columnmove#interrupt()
  %delete

  " #6
  call append(0, ['a', 'b', '', 'c', 'd', 'e', 'f'])
  6,7fold
  normal 7G0\ge
  call g:assert.equals(line('.'), 5, 'failed at #6')
  call columnmove#interrupt()
  %delete

  " #7
  call append(0, ['a', 'b', '', 'c', 'd', 'e', 'f', 'g'])
  6,7fold
  normal 8G0\ge
  call g:assert.equals(line('.'), 5, 'failed at #7')
  call columnmove#interrupt()
  %delete
endfunction
"}}}
function! s:suite_ge.strict_option_fold_open() abort  "{{{
  let g:columnmove_strict_wbege = 1
  let g:columnmove_fold_open = 1

  " #1
  call append(0, ['a', 'b', ':', 'c', 'd'])
  2,4fold
  normal 5G\ge
  call g:assert.equals(line('.'), 3, 'failed at #1')
  call g:assert.equals(foldclosed(2),    -1, 'failed at #1')
  call g:assert.equals(foldclosedend(2), -1, 'failed at #1')
  call columnmove#interrupt()
  %delete

  " #2
  call append(0, ['a', 'b', ' ', 'c', 'd'])
  2,4fold
  normal 5G\ge
  call g:assert.equals(line('.'), 2, 'failed at #2')
  call g:assert.equals(foldclosed(2),    -1, 'failed at #2')
  call g:assert.equals(foldclosedend(2), -1, 'failed at #2')
  call columnmove#interrupt()
  %delete

  " #3
  call append(0, ['a', 'b', '', 'c', 'd'])
  2,4fold
  normal 5G\ge
  call g:assert.equals(line('.'), 2, 'failed at #3')
  call g:assert.equals(foldclosed(2),    -1, 'failed at #3')
  call g:assert.equals(foldclosedend(2), -1, 'failed at #3')
  call columnmove#interrupt()
  %delete

  " #4
  call append(0, [':', 'a', 'b', 'c', 'd'])
  2,4fold
  normal 5G\ge
  call g:assert.equals(line('.'), 1, 'failed at #4')
  call g:assert.equals(foldclosed(2),    2, 'failed at #4')
  call g:assert.equals(foldclosedend(2), 4, 'failed at #4')
  call columnmove#interrupt()
  %delete

  " #5
  call append(0, ['a', ' ', 'b', 'c', 'd'])
  2,4fold
  normal 5G\ge
  call g:assert.equals(line('.'), 1, 'failed at #5')
  call g:assert.equals(foldclosed(2),    2, 'failed at #5')
  call g:assert.equals(foldclosedend(2), 4, 'failed at #5')
  call columnmove#interrupt()
  %delete

  " #6
  call append(0, ['a', '', 'b', 'c', 'd'])
  2,4fold
  normal 5G\ge
  call g:assert.equals(line('.'), 1, 'failed at #6')
  call g:assert.equals(foldclosed(2),    2, 'failed at #6')
  call g:assert.equals(foldclosedend(2), 4, 'failed at #6')
  call columnmove#interrupt()
  %delete
endfunction
"}}}
function! s:suite_ge.strict_option_combinations() abort "{{{
  let g:columnmove_strict_wbege = 1
  let g:columnmove_fold_treatment = 1
  let g:columnmove_fold_open = 1

  " #1
  call append(0, ['a', 'b', ':', 'c', 'd', 'e'])
  2,4fold
  normal 6G\ge
  call g:assert.equals(line('.'), 3, 'failed at #1')
  call columnmove#interrupt()
  %delete
endfunction
"}}}
function! s:suite_ge.strict_option_stop_on_space() dict abort  "{{{
  let g:columnmove_stop_on_space = 1

  " #1
  call append(0, ['', 'aa', '  ', '', 'bb'])
  normal 5G0\ge
  call g:assert.equals(line('.'), 2, 'failed at #1')
  call columnmove#interrupt()
  %delete

  " #2
  call append(0, ['', 'aa', '  ', '', 'bb'])
  normal 5G0l\ge
  call g:assert.equals(line('.'), 2, 'failed at #2')
  call columnmove#interrupt()
  %delete

  " #3
  call append(0, ['', 'a ', '  ', '', 'bb'])
  normal 5G0\ge
  call g:assert.equals(line('.'), 2, 'failed at #3')
  call columnmove#interrupt()
  %delete

  " #4
  call append(0, ['', 'a ', '  ', '', 'bb'])
  normal 5G0l\ge
  call g:assert.equals(line('.'), 2, 'failed at #4')
  call columnmove#interrupt()
  %delete

  let g:columnmove_stop_on_space = 0

  " #5
  call append(0, ['', 'aa', '  ', '', 'bb'])
  normal 5G0\ge
  call g:assert.equals(line('.'), 2, 'failed at #5')
  call columnmove#interrupt()
  %delete

  " #6
  call append(0, ['', 'aa', '  ', '', 'bb'])
  normal 5G0l\ge
  call g:assert.equals(line('.'), 2, 'failed at #6')
  call columnmove#interrupt()
  %delete

  " #7
  call append(0, ['', 'a ', '  ', '', 'bb'])
  normal 5G0\ge
  call g:assert.equals(line('.'), 2, 'failed at #7')
  call columnmove#interrupt()
  %delete

  " #8
  call append(0, ['', 'a ', '  ', '', 'bb'])
  normal 5G0l\ge
  call g:assert.equals(line('.'), 5, 'failed at #8')
  call columnmove#interrupt()
  %delete
endfunction
"}}}
function! s:suite_ge.strict_curswant() abort "{{{
  let g:columnmove_strict_wbege = 1

  " #1
  call append(0, ['abcde', '', 'fgh', 'ijklm'])
  normal 4G$k\ge
  call g:assert.equals(getpos('.')[1:2], [1, 3], 'failed at #1')
  call columnmove#interrupt()
  %delete
endfunction
"}}}
function! s:suite_ge.strict_tabchar() abort "{{{
  let g:columnmove_strict_wbege = 1

  " #1
  set tabstop=4
  call append(0, ['	abc', '', 'defghij', 'klmnopq'])
  normal 4G4l\ge
  call g:assert.equals(getpos('.')[1:2], [1, 2], 'failed at #1')
  call columnmove#interrupt()
  %delete

  " #2
  set tabstop=4
  call append(0, ['abcdefg', '', 'hijklmn', '	opqr'])
  normal 4G\ge
  call g:assert.equals(getpos('.')[1:2], [1, 5], 'failed at #2')
  call columnmove#interrupt()
  %delete
endfunction
"}}}
function! s:suite_ge.strict_multibyte_char() abort "{{{
  let g:columnmove_strict_wbege = 1

  " #1
  set ambiwidth=single
  call append(0, ['αbc', '', 'defg', 'hijk'])
  normal 4G\ge
  call g:assert.equals(getpos('.')[1:2], [1, 1], 'failed at #1')
  call columnmove#interrupt()
  %delete

  " #2
  set ambiwidth=single
  call append(0, ['αbc', '', 'defg', 'hijk'])
  normal 4Gl\ge
  call g:assert.equals(getpos('.')[1:2], [1, strlen('α')+1], 'failed at #2')
  call columnmove#interrupt()
  %delete

  " #3
  set ambiwidth=single
  call append(0, ['αbc', '', 'defg', 'hijk'])
  normal 4G2l\ge
  call g:assert.equals(getpos('.')[1:2], [1, strlen('α')+2], 'failed at #3')
  call columnmove#interrupt()
  %delete

  " #4
  set ambiwidth=single
  call append(0, ['abc', '', 'δefg', 'hijk'])
  normal 4G\ge
  call g:assert.equals(getpos('.')[1:2], [1, 1], 'failed at #4')
  call columnmove#interrupt()
  %delete

  " #5
  set ambiwidth=single
  call append(0, ['abc', '', 'δefg', 'hijk'])
  normal 4Gl\ge
  call g:assert.equals(getpos('.')[1:2], [1, 2], 'failed at #5')
  call columnmove#interrupt()
  %delete

  " #6
  set ambiwidth=single
  call append(0, ['abc', '', 'δefg', 'hijk'])
  normal 4G2l\ge
  call g:assert.equals(getpos('.')[1:2], [1, 3], 'failed at #6')
  call columnmove#interrupt()
  %delete

  " #7
  set ambiwidth=single
  call append(0, ['abc', '', 'defg', 'ηijk'])
  normal 4G\ge
  call g:assert.equals(getpos('.')[1:2], [1, 1], 'failed at #7')
  call columnmove#interrupt()
  %delete

  " #8
  set ambiwidth=single
  call append(0, ['abc', '', 'defg', 'ηijk'])
  normal 4Gl\ge
  call g:assert.equals(getpos('.')[1:2], [1, 2], 'failed at #8')
  let @@ = ''
  normal! yl
  call g:assert.equals(@@, 'b', 'failed at #8')
  call columnmove#interrupt()
  %delete

  " #9
  set ambiwidth=single
  call append(0, ['abc', '', 'defg', 'ηijk'])
  normal 4G2l\ge
  call g:assert.equals(getpos('.')[1:2], [1, 3], 'failed at #9')
  let @@ = ''
  normal! yl
  call g:assert.equals(@@, 'c', 'failed at #9')
  call columnmove#interrupt()
  %delete

  " #10
  set ambiwidth=double
  call append(0, ['αbc', '', 'defg', 'hijk'])
  normal 4G\ge
  call g:assert.equals(getpos('.')[1:2], [1, 1], 'failed at #10')
  call columnmove#interrupt()
  %delete

  " #11
  set ambiwidth=double
  call append(0, ['αbc', '', 'defg', 'hijk'])
  normal 4Gl\ge
  call g:assert.equals(getpos('.')[1:2], [1, 1], 'failed at #11')
  call columnmove#interrupt()
  %delete

  " #12
  set ambiwidth=double
  call append(0, ['αbc', '', 'defg', 'hijk'])
  normal 4G2l\ge
  call g:assert.equals(getpos('.')[1:2], [1, strlen('α')+1], 'failed at #12')
  call columnmove#interrupt()
  %delete

  " #13
  set ambiwidth=double
  call append(0, ['abc', '', 'δefg', 'hijk'])
  normal 4G\ge
  call g:assert.equals(getpos('.')[1:2], [1, 1], 'failed at #13')
  call columnmove#interrupt()
  %delete

  " #14
  set ambiwidth=double
  call append(0, ['abc', '', 'δefg', 'hijk'])
  normal 4Gl\ge
  call g:assert.equals(getpos('.')[1:2], [1, 2], 'failed at #14')
  call columnmove#interrupt()
  %delete

  " #15
  set ambiwidth=double
  call append(0, ['abc', '', 'δefg', 'hijk'])
  normal 4G2l\ge
  call g:assert.equals(getpos('.')[1:2], [1, 3], 'failed at #15')
  call columnmove#interrupt()
  %delete

  " #16
  set ambiwidth=double
  call append(0, ['abc', '', 'defg', 'ηijk'])
  normal 4G\ge
  call g:assert.equals(getpos('.')[1:2], [1, 1], 'failed at #16')
  call columnmove#interrupt()
  %delete

  " #17
  set ambiwidth=double
  call append(0, ['abc', '', 'defg', 'ηijk'])
  normal 4Gl\ge
  call g:assert.equals(getpos('.')[1:2], [1, 3], 'failed at #17')
  let @@ = ''
  normal! yl
  call g:assert.equals(@@, 'c', 'failed at #17')
  call columnmove#interrupt()
  %delete

  " #18
  set ambiwidth=double
  call append(0, ['abc', '', 'defg', 'ηijk'])
  normal 4G2l\ge
  call g:assert.equals(getpos('.')[1:2], [4, strlen('η')+2], 'failed at #18')
  let @@ = ''
  normal! yl
  call g:assert.equals(@@, 'j', 'failed at #18')
  call columnmove#interrupt()
  %delete

  " #19
  set ambiwidth=double
  call append(0, ['abc', '', 'δefg', '', 'hijk'])
  normal 5G0l\ge
  call g:assert.equals(getpos('.')[1:2], [3, 1], 'failed at #19')
  normal \ge
  call g:assert.equals(getpos('.')[1:2], [1, 2], 'failed at #19')
  call columnmove#interrupt()
  %delete

  " #20
  set ambiwidth=double
  call append(0, ['abc', '', 'δefg', '', 'hijk'])
  normal 5G0l\ge
  call g:assert.equals(getpos('.')[1:2], [3, 1], 'failed at #20')
  call columnmove#interrupt()
  normal \ge
  call g:assert.equals(getpos('.')[1:2], [1, 1], 'failed at #20')
  call columnmove#interrupt()
  %delete
endfunction
"}}}
function! s:suite_ge.strict_visual_mode() abort  "{{{
  let g:columnmove_strict_wbege = 1

  " #1
  call append(0, ['a', 'b', '', 'c', 'd'])
  call setpos("'<", [0, 0, 0, 0])
  call setpos("'>", [0, 0, 0, 0])
  normal 5G0v\ge
  execute "normal! \<Esc>"
  call g:assert.equals(getpos("'<"), [0, 2, 1, 0], 'failed at #1')
  call g:assert.equals(getpos("'>"), [0, 5, 1, 0], 'failed at #1')
  call g:assert.equals(visualmode(), 'v', 'failed at #1')
  call columnmove#interrupt()
  %delete

  " #2
  call append(0, ['a', 'b', '', 'c', 'd'])
  call setpos("'<", [0, 0, 0, 0])
  call setpos("'>", [0, 0, 0, 0])
  normal 5G0V\ge
  execute "normal! \<Esc>"
  call g:assert.equals(getpos("'<"), [0, 2, 1, 0], 'failed at #2')
  call g:assert.equals(getpos("'>"), [0, 5, g:intmax, 0], 'failed at #2')
  call g:assert.equals(visualmode(), 'V', 'failed at #2')
  call columnmove#interrupt()
  %delete

  " #3
  call append(0, ['a', 'b', '', 'c', 'd'])
  call setpos("'<", [0, 0, 0, 0])
  call setpos("'>", [0, 0, 0, 0])
  execute "normal 5G0\<C-v>\\ge\<Esc>"
  call g:assert.equals(getpos("'<"), [0, 2, 1, 0], 'failed at #3')
  call g:assert.equals(getpos("'>"), [0, 5, 1, 0], 'failed at #3')
  call g:assert.equals(visualmode(), "\<C-v>", 'failed at #3')
  call columnmove#interrupt()
  %delete

  " #4
  call append(0, ['a', 'b', '', 'c', 'd', '', 'e'])
  call setpos("'<", [0, 0, 0, 0])
  call setpos("'>", [0, 0, 0, 0])
  normal 7G0v\ge\ge
  execute "normal! \<Esc>"
  call g:assert.equals(getpos("'<"), [0, 2, 1, 0], 'failed at #4')
  call g:assert.equals(getpos("'>"), [0, 7, 1, 0], 'failed at #4')
  call g:assert.equals(visualmode(), 'v', 'failed at #4')
  call columnmove#interrupt()
  %delete

  " #5
  call append(0, ['', '', ''])
  normal 3G0v\ge
  call g:assert.equals(mode(), 'v', 'failed at #5')
  execute "normal! \<Esc>"
  call columnmove#interrupt()
  %delete
endfunction
"}}}
function! s:suite_ge.strict_operator_pending_mode() abort  "{{{
  let g:columnmove_strict_wbege = 1

  " #1
  " default: linewise
  call append(0, ['abc', 'def', ':::'])
  let @@ = ''
  normal 3G0l""d\ge
  call g:assert.equals(getreg('"'), "def\n:::\n", 'failed at #1')
  call g:assert.equals(getregtype('"'), 'V', 'failed at #1')
  call columnmove#interrupt()
  %delete

  " #2
  " exclusive character-wise with o_v
  call append(0, ['abc', 'def', ':::'])
  let @@ = ''
  normal 3G0l""dv\ge
  call g:assert.equals(getreg('"'), "ef\n:", 'failed at #2')
  call g:assert.equals(getregtype('"'), 'v', 'failed at #2')
  call columnmove#interrupt()
  %delete

  " #3
  " line-wise with o_V
  call append(0, ['abc', 'def', ':::'])
  let @@ = ''
  normal 3G0l""dV\ge
  call g:assert.equals(getreg('"'), "def\n:::\n", 'failed at #3')
  call g:assert.equals(getregtype('"'), 'V', 'failed at #3')
  call columnmove#interrupt()
  %delete

  " #4
  " block-wise with o_CTRL-V
  call append(0, ['abc', 'def', ':::'])
  let @@ = ''
  execute "normal 3G0l\"\"d\<C-v>\\ge"
  call g:assert.equals(getreg('"'), "e\n:", 'failed at #4')
  call g:assert.equals(getregtype('"'), "\<C-v>1", 'failed at #4')
  call columnmove#interrupt()
  %delete
endfunction
"}}}
function! s:suite_ge.spoiled() abort  "{{{
  let g:columnmove_strict_wbege = 0

  " #1
  call append(0, ['a', 'b', ';', 'c', 'd'])
  normal 1G0\ge
  call g:assert.equals(line('.'), 1, 'failed at #1')
  call columnmove#interrupt()
  %delete

  " #2
  call append(0, ['a', 'b', ';', 'c', 'd'])
  normal 2G0\ge
  call g:assert.equals(line('.'), 2, 'failed at #2')
  call columnmove#interrupt()
  %delete

  " #3
  call append(0, ['a', 'b', ';', 'c', 'd'])
  normal 3G0\ge
  call g:assert.equals(line('.'), 3, 'failed at #3')
  call columnmove#interrupt()
  %delete

  " #4
  call append(0, ['a', 'b', ';', 'c', 'd'])
  normal 4G0\ge
  call g:assert.equals(line('.'), 4, 'failed at #4')
  call columnmove#interrupt()
  %delete

  " #5
  call append(0, ['a', 'b', ';', 'c', 'd'])
  normal 5G0\ge
  call g:assert.equals(line('.'), 5, 'failed at #5')
  call columnmove#interrupt()
  %delete

  " #6
  call append(0, ['a', 'b', ' ', 'c', 'd'])
  normal 1G0\ge
  call g:assert.equals(line('.'), 1, 'failed at #6')
  call columnmove#interrupt()
  %delete

  " #7
  call append(0, ['a', 'b', ' ', 'c', 'd'])
  normal 2G0\ge
  call g:assert.equals(line('.'), 2, 'failed at #7')
  call columnmove#interrupt()
  %delete

  " #8
  call append(0, ['a', 'b', ' ', 'c', 'd'])
  normal 3G0\ge
  call g:assert.equals(line('.'), 3, 'failed at #8')
  call columnmove#interrupt()
  %delete

  " #9
  call append(0, ['a', 'b', ' ', 'c', 'd'])
  normal 4G0\ge
  call g:assert.equals(line('.'), 4, 'failed at #9')
  call columnmove#interrupt()
  %delete

  " #10
  call append(0, ['a', 'b', ' ', 'c', 'd'])
  normal 5G0\ge
  call g:assert.equals(line('.'), 5, 'failed at #10')
  call columnmove#interrupt()
  %delete

  " #11
  call append(0, ['a', 'b', '', 'c', 'd'])
  normal 1G0\ge
  call g:assert.equals(line('.'), 1, 'failed at #11')
  call columnmove#interrupt()
  %delete

  " #12
  call append(0, ['a', 'b', '', 'c', 'd'])
  normal 2G0\ge
  call g:assert.equals(line('.'), 2, 'failed at #12')
  call columnmove#interrupt()
  %delete

  " #13
  call append(0, ['a', 'b', '', 'c', 'd'])
  normal 3G0\ge
  call g:assert.equals(line('.'), 2, 'failed at #13')
  call columnmove#interrupt()
  %delete

  " #14
  call append(0, ['a', 'b', '', 'c', 'd'])
  normal 4G0\ge
  call g:assert.equals(line('.'), 2, 'failed at #14')
  call columnmove#interrupt()
  %delete

  " #15
  call append(0, ['a', 'b', '', 'c', 'd'])
  normal 5G0\ge
  call g:assert.equals(line('.'), 2, 'failed at #15')
  call columnmove#interrupt()
  %delete

  " #16
  call append(0, [';', ':', 'a', ',', '.'])
  normal 1G0\ge
  call g:assert.equals(line('.'), 1, 'failed at #16')
  call columnmove#interrupt()
  %delete

  " #17
  call append(0, [';', ':', 'a', ',', '.'])
  normal 2G0\ge
  call g:assert.equals(line('.'), 2, 'failed at #17')
  call columnmove#interrupt()
  %delete

  " #18
  call append(0, [';', ':', 'a', ',', '.'])
  normal 3G0\ge
  call g:assert.equals(line('.'), 3, 'failed at #18')
  call columnmove#interrupt()
  %delete

  " #19
  call append(0, [';', ':', 'a', ',', '.'])
  normal 4G0\ge
  call g:assert.equals(line('.'), 4, 'failed at #19')
  call columnmove#interrupt()
  %delete

  " #20
  call append(0, [';', ':', 'a', ',', '.'])
  normal 5G0\ge
  call g:assert.equals(line('.'), 5, 'failed at #20')
  call columnmove#interrupt()
  %delete

  " #21
  call append(0, [';', ':', ' ', ',', '.'])
  normal 1G0\ge
  call g:assert.equals(line('.'), 1, 'failed at #21')
  call columnmove#interrupt()
  %delete

  " #22
  call append(0, [';', ':', ' ', ',', '.'])
  normal 2G0\ge
  call g:assert.equals(line('.'), 2, 'failed at #22')
  call columnmove#interrupt()
  %delete

  " #23
  call append(0, [';', ':', ' ', ',', '.'])
  normal 3G0\ge
  call g:assert.equals(line('.'), 3, 'failed at #23')
  call columnmove#interrupt()
  %delete

  " #24
  call append(0, [';', ':', ' ', ',', '.'])
  normal 4G0\ge
  call g:assert.equals(line('.'), 4, 'failed at #24')
  call columnmove#interrupt()
  %delete

  " #25
  call append(0, [';', ':', ' ', ',', '.'])
  normal 5G0\ge
  call g:assert.equals(line('.'), 5, 'failed at #25')
  call columnmove#interrupt()
  %delete

  " #26
  call append(0, [';', ':', '', ',', '.'])
  normal 1G0\ge
  call g:assert.equals(line('.'), 1, 'failed at #26')
  call columnmove#interrupt()
  %delete

  " #27
  call append(0, [';', ':', '', ',', '.'])
  normal 2G0\ge
  call g:assert.equals(line('.'), 2, 'failed at #27')
  call columnmove#interrupt()
  %delete

  " #28
  call append(0, [';', ':', '', ',', '.'])
  normal 3G0\ge
  call g:assert.equals(line('.'), 2, 'failed at #28')
  call columnmove#interrupt()
  %delete

  " #29
  call append(0, [';', ':', '', ',', '.'])
  normal 4G0\ge
  call g:assert.equals(line('.'), 2, 'failed at #29')
  call columnmove#interrupt()
  %delete

  " #30
  call append(0, [';', ':', '', ',', '.'])
  normal 5G0\ge
  call g:assert.equals(line('.'), 2, 'failed at #30')
  call columnmove#interrupt()
  %delete

  " #31
  call append(0, [' ', ' ', 'a', ' ', ' '])
  normal 1G0\ge
  call g:assert.equals(line('.'), 1, 'failed at #31')
  call columnmove#interrupt()
  %delete

  " #32
  call append(0, [' ', ' ', 'a', ' ', ' '])
  normal 2G0\ge
  call g:assert.equals(line('.'), 2, 'failed at #32')
  call columnmove#interrupt()
  %delete

  " #33
  call append(0, [' ', ' ', 'a', ' ', ' '])
  normal 3G0\ge
  call g:assert.equals(line('.'), 3, 'failed at #33')
  call columnmove#interrupt()
  %delete

  " #34
  call append(0, [' ', ' ', 'a', ' ', ' '])
  normal 4G0\ge
  call g:assert.equals(line('.'), 4, 'failed at #34')
  call columnmove#interrupt()
  %delete

  " #35
  call append(0, [' ', ' ', 'a', ' ', ' '])
  normal 5G0\ge
  call g:assert.equals(line('.'), 5, 'failed at #35')
  call columnmove#interrupt()
  %delete

  " #36
  call append(0, [' ', ' ', ';', ' ', ' '])
  normal 1G0\ge
  call g:assert.equals(line('.'), 1, 'failed at #36')
  call columnmove#interrupt()
  %delete

  " #37
  call append(0, [' ', ' ', ';', ' ', ' '])
  normal 2G0\ge
  call g:assert.equals(line('.'), 2, 'failed at #37')
  call columnmove#interrupt()
  %delete

  " #38
  call append(0, [' ', ' ', ';', ' ', ' '])
  normal 3G0\ge
  call g:assert.equals(line('.'), 3, 'failed at #38')
  call columnmove#interrupt()
  %delete

  " #39
  call append(0, [' ', ' ', ';', ' ', ' '])
  normal 4G0\ge
  call g:assert.equals(line('.'), 4, 'failed at #39')
  call columnmove#interrupt()
  %delete

  " #40
  call append(0, [' ', ' ', ';', ' ', ' '])
  normal 5G0\ge
  call g:assert.equals(line('.'), 5, 'failed at #40')
  call columnmove#interrupt()
  %delete

  " #41
  call append(0, [' ', ' ', '', ' ', ' '])
  normal 1G0\ge
  call g:assert.equals(line('.'), 1, 'failed at #41')
  call columnmove#interrupt()
  %delete

  " #42
  call append(0, [' ', ' ', '', ' ', ' '])
  normal 2G0\ge
  call g:assert.equals(line('.'), 2, 'failed at #42')
  call columnmove#interrupt()
  %delete

  " #43
  call append(0, [' ', ' ', '', ' ', ' '])
  normal 3G0\ge
  call g:assert.equals(line('.'), 2, 'failed at #43')
  call columnmove#interrupt()
  %delete

  " #44
  call append(0, [' ', ' ', '', ' ', ' '])
  normal 4G0\ge
  call g:assert.equals(line('.'), 2, 'failed at #44')
  call columnmove#interrupt()
  %delete

  " #45
  call append(0, [' ', ' ', '', ' ', ' '])
  normal 5G0\ge
  call g:assert.equals(line('.'), 2, 'failed at #45')
  call columnmove#interrupt()
  %delete

  " #46
  call append(0, ['', '', 'a', '', ''])
  normal 1G0\ge
  call g:assert.equals(line('.'), 1, 'failed at #46')
  call columnmove#interrupt()
  %delete

  " #47
  call append(0, ['', '', 'a', '', ''])
  normal 2G0\ge
  call g:assert.equals(line('.'), 2, 'failed at #47')
  call columnmove#interrupt()
  %delete

  " #48
  call append(0, ['', '', 'a', '', ''])
  normal 3G0\ge
  call g:assert.equals(line('.'), 3, 'failed at #48')
  call columnmove#interrupt()
  %delete

  " #49
  call append(0, ['', '', 'a', '', ''])
  normal 4G0\ge
  call g:assert.equals(line('.'), 3, 'failed at #49')
  call columnmove#interrupt()
  %delete

  " #50
  call append(0, ['', '', 'a', '', ''])
  normal 5G0\ge
  call g:assert.equals(line('.'), 3, 'failed at #50')
  call columnmove#interrupt()
  %delete

  " #51
  call append(0, ['', '', ';', '', ''])
  normal 1G0\ge
  call g:assert.equals(line('.'), 1, 'failed at #51')
  call columnmove#interrupt()
  %delete

  " #52
  call append(0, ['', '', ';', '', ''])
  normal 2G0\ge
  call g:assert.equals(line('.'), 2, 'failed at #52')
  call columnmove#interrupt()
  %delete

  " #53
  call append(0, ['', '', ';', '', ''])
  normal 3G0\ge
  call g:assert.equals(line('.'), 3, 'failed at #53')
  call columnmove#interrupt()
  %delete

  " #54
  call append(0, ['', '', ';', '', ''])
  normal 4G0\ge
  call g:assert.equals(line('.'), 3, 'failed at #54')
  call columnmove#interrupt()
  %delete

  " #55
  call append(0, ['', '', ';', '', ''])
  normal 5G0\ge
  call g:assert.equals(line('.'), 3, 'failed at #55')
  call columnmove#interrupt()
  %delete

  " #56
  call append(0, ['', '', ' ', '', ''])
  normal 1G0\ge
  call g:assert.equals(line('.'), 1, 'failed at #56')
  call columnmove#interrupt()
  %delete

  " #57
  call append(0, ['', '', ' ', '', ''])
  normal 2G0\ge
  call g:assert.equals(line('.'), 2, 'failed at #57')
  call columnmove#interrupt()
  %delete

  " #58
  call append(0, ['', '', ' ', '', ''])
  normal 3G0\ge
  call g:assert.equals(line('.'), 3, 'failed at #58')
  call columnmove#interrupt()
  %delete

  " #59
  call append(0, ['', '', ' ', '', ''])
  normal 4G0\ge
  call g:assert.equals(line('.'), 3, 'failed at #59')
  call columnmove#interrupt()
  %delete

  " #60
  call append(0, ['', '', ' ', '', ''])
  normal 5G0\ge
  call g:assert.equals(line('.'), 3, 'failed at #60')
  call columnmove#interrupt()
  %delete

  " #61
  call append(0, ['a', 'b', '', 'c', 'd', '', 'e'])
  normal 7G0\ge
  call g:assert.equals(line('.'), 5, 'failed at #61')
  normal \ge
  call g:assert.equals(line('.'), 2, 'failed at #61')
  call columnmove#interrupt()
  %delete
endfunction
"}}}
function! s:suite_ge.spoiled_count() abort "{{{
  let g:columnmove_strict_wbege = 0

  " #1
  call append(0, ['a', 'b', '', 'c', 'd', '', 'e', 'f', '', 'g'])
  normal 10G0\ge
  call g:assert.equals(line('.'), 8, 'failed at #1')
  call columnmove#interrupt()
  %delete

  " #2
  call append(0, ['a', 'b', '', 'c', 'd', '', 'e', 'f', '', 'g'])
  normal 10G02\ge
  call g:assert.equals(line('.'), 5, 'failed at #2')
  call columnmove#interrupt()
  %delete

  " #3
  call append(0, ['a', 'b', '', 'c', 'd', '', 'e', 'f', '', 'g'])
  normal 10G03\ge
  call g:assert.equals(line('.'), 2, 'failed at #3')
  call columnmove#interrupt()
  %delete

  " #3
  call append(0, ['a', 'b', '', 'c', 'd', '', 'e', 'f', '', 'g'])
  normal 10G04\ge
  call g:assert.equals(line('.'), 10, 'failed at #3')
  call columnmove#interrupt()
  %delete
endfunction
"}}}
function! s:suite_ge.spoiled_fold() abort  "{{{
  let g:columnmove_strict_wbege = 0

  " #1
  call append(0, ['a', 'b', '', 'c', 'd', 'e', 'f'])
  1,2fold
  normal 7G0\ge
  call g:assert.equals(line('.'), 7, 'failed at #1')
  call columnmove#interrupt()
  %delete

  " #2
  call append(0, ['a', 'b', '', 'c', 'd', 'e', 'f'])
  2,3fold
  normal 7G0\ge
  call g:assert.equals(line('.'), 7, 'failed at #2')
  call columnmove#interrupt()
  %delete

  " #3
  call append(0, ['a', 'b', '', 'c', 'd', 'e', 'f'])
  3,4fold
  normal 7G0\ge
  call g:assert.equals(line('.'), 7, 'failed at #3')
  call columnmove#interrupt()
  %delete

  " #4
  call append(0, ['a', 'b', '', 'c', 'd', 'e', 'f'])
  4,5fold
  normal 7G0\ge
  call g:assert.equals(line('.'), 2, 'failed at #4')
  call columnmove#interrupt()
  %delete

  " #5
  call append(0, ['a', 'b', '', 'c', 'd', 'e', 'f'])
  5,6fold
  normal 7G0\ge
  call g:assert.equals(line('.'), 2, 'failed at #5')
  call columnmove#interrupt()
  %delete

  " #6
  call append(0, ['a', 'b', '', 'c', 'd', 'e', 'f'])
  6,7fold
  normal 7G0\ge
  call g:assert.equals(line('.'), 5, 'failed at #6')
  call columnmove#interrupt()
  %delete

  " #7
  call append(0, ['a', 'b', '', 'c', 'd', 'e', 'f', 'g'])
  6,7fold
  normal 8G0\ge
  call g:assert.equals(line('.'), 2, 'failed at #7')
  call columnmove#interrupt()
  %delete
endfunction
"}}}
function! s:suite_ge.spoiled_option_fold_treatment() abort  "{{{
  let g:columnmove_strict_wbege = 0
  let g:columnmove_fold_treatment = 1

  " #1
  call append(0, ['a', 'b', '', 'c', 'd', 'e', 'f'])
  1,2fold
  normal 7G0\ge
  call g:assert.equals(line('.'), 7, 'failed at #1')
  call columnmove#interrupt()
  %delete

  " #2
  call append(0, ['a', 'b', '', 'c', 'd', 'e', 'f'])
  2,3fold
  normal 7G0\ge
  call g:assert.equals(line('.'), 1, 'failed at #2')
  call columnmove#interrupt()
  %delete

  " #3
  call append(0, ['a', 'b', '', 'c', 'd', 'e', 'f'])
  3,4fold
  normal 7G0\ge
  call g:assert.equals(line('.'), 2, 'failed at #3')
  call columnmove#interrupt()
  %delete

  " #4
  call append(0, ['a', 'b', '', 'c', 'd', 'e', 'f'])
  4,5fold
  normal 7G0\ge
  call g:assert.equals(line('.'), 2, 'failed at #4')
  call columnmove#interrupt()
  %delete

  " #5
  call append(0, ['a', 'b', '', 'c', 'd', 'e', 'f'])
  5,6fold
  normal 7G0\ge
  call g:assert.equals(line('.'), 4, 'failed at #5')
  call columnmove#interrupt()
  %delete

  " #6
  call append(0, ['a', 'b', '', 'c', 'd', 'e', 'f'])
  6,7fold
  normal 7G0\ge
  call g:assert.equals(line('.'), 5, 'failed at #6')
  call columnmove#interrupt()
  %delete

  " #7
  call append(0, ['a', 'b', '', 'c', 'd', 'e', 'f', 'g'])
  6,7fold
  normal 8G0\ge
  call g:assert.equals(line('.'), 5, 'failed at #7')
  call columnmove#interrupt()
  %delete
endfunction
"}}}
function! s:suite_ge.spoiled_option_fold_open() abort  "{{{
  let g:columnmove_strict_wbege = 0
  let g:columnmove_fold_open = 1

  " #1
  call append(0, ['a', 'b', ':', 'c', 'd'])
  2,4fold
  normal 5G\ge
  call g:assert.equals(line('.'), 5, 'failed at #1')
  call g:assert.equals(foldclosed(2),    2, 'failed at #1')
  call g:assert.equals(foldclosedend(2), 4, 'failed at #1')
  call columnmove#interrupt()
  %delete

  " #2
  call append(0, ['a', 'b', ' ', 'c', 'd'])
  2,4fold
  normal 5G\ge
  call g:assert.equals(line('.'), 5, 'failed at #2')
  call g:assert.equals(foldclosed(2),    2, 'failed at #2')
  call g:assert.equals(foldclosedend(2), 4, 'failed at #2')
  call columnmove#interrupt()
  %delete

  " #3
  call append(0, ['a', 'b', '', 'c', 'd'])
  2,4fold
  normal 5G\ge
  call g:assert.equals(line('.'), 2, 'failed at #3')
  call g:assert.equals(foldclosed(2),    -1, 'failed at #3')
  call g:assert.equals(foldclosedend(2), -1, 'failed at #3')
  call columnmove#interrupt()
  %delete

  " #4
  call append(0, [':', 'a', 'b', 'c', 'd'])
  2,4fold
  normal 5G\ge
  call g:assert.equals(line('.'), 5, 'failed at #4')
  call g:assert.equals(foldclosed(2),    2, 'failed at #4')
  call g:assert.equals(foldclosedend(2), 4, 'failed at #4')
  call columnmove#interrupt()
  %delete

  " #5
  call append(0, ['a', ' ', 'b', 'c', 'd'])
  2,4fold
  normal 5G\ge
  call g:assert.equals(line('.'), 5, 'failed at #5')
  call g:assert.equals(foldclosed(2),    2, 'failed at #5')
  call g:assert.equals(foldclosedend(2), 4, 'failed at #5')
  call columnmove#interrupt()
  %delete

  " #6
  call append(0, ['a', '', 'b', 'c', 'd'])
  2,4fold
  normal 5G\ge
  call g:assert.equals(line('.'), 1, 'failed at #6')
  call g:assert.equals(foldclosed(2),    2, 'failed at #6')
  call g:assert.equals(foldclosedend(2), 4, 'failed at #6')
  call columnmove#interrupt()
  %delete
endfunction
"}}}
function! s:suite_ge.spoiled_option_combinations() abort "{{{
  let g:columnmove_strict_wbege = 0
  let g:columnmove_fold_treatment = 1
  let g:columnmove_fold_open = 1

  " #1
  call append(0, ['a', 'b', '', 'c', 'd', 'e'])
  2,4fold
  normal 6G\ge
  call g:assert.equals(line('.'), 2, 'failed at #1')
  call columnmove#interrupt()
  %delete
endfunction
"}}}
function! s:suite_ge.spoiled_option_stop_on_space() dict abort  "{{{
  let g:columnmove_strict_wbege = 0
  let g:columnmove_stop_on_space = 1

  " #1
  call append(0, ['', 'aa', '  ', '', 'bb'])
  normal 5G0\ge
  call g:assert.equals(line('.'), 3, 'failed at #1')
  call columnmove#interrupt()
  %delete

  " #2
  call append(0, ['', 'aa', '  ', '', 'bb'])
  normal 5G0l\ge
  call g:assert.equals(line('.'), 3, 'failed at #2')
  call columnmove#interrupt()
  %delete

  " #3
  call append(0, ['', 'a ', '  ', '', 'bb'])
  normal 5G0\ge
  call g:assert.equals(line('.'), 3, 'failed at #3')
  call columnmove#interrupt()
  %delete

  " #4
  call append(0, ['', 'a ', '  ', '', 'bb'])
  normal 5G0l\ge
  call g:assert.equals(line('.'), 3, 'failed at #4')
  call columnmove#interrupt()
  %delete

  let g:columnmove_stop_on_space = 0

  " #5
  call append(0, ['', 'aa', '  ', '', 'bb'])
  normal 5G0\ge
  call g:assert.equals(line('.'), 3, 'failed at #5')
  call columnmove#interrupt()
  %delete

  " #6
  call append(0, ['', 'aa', '  ', '', 'bb'])
  normal 5G0l\ge
  call g:assert.equals(line('.'), 3, 'failed at #6')
  call columnmove#interrupt()
  %delete

  " #7
  call append(0, ['', 'a ', '  ', '', 'bb'])
  normal 5G0\ge
  call g:assert.equals(line('.'), 3, 'failed at #7')
  call columnmove#interrupt()
  %delete

  " #8
  call append(0, ['', 'a ', '  ', '', 'bb'])
  normal 5G0l\ge
  call g:assert.equals(line('.'), 3, 'failed at #8')
  call columnmove#interrupt()
  %delete
endfunction
"}}}
function! s:suite_ge.spoiled_curswant() abort "{{{
  let g:columnmove_strict_wbege = 0

  " #1
  call append(0, ['abcde', '', 'fgh', 'ijklm'])
  normal 4G$k\ge
  call g:assert.equals(getpos('.')[1:2], [1, 3], 'failed at #1')
  call columnmove#interrupt()
  %delete
endfunction
"}}}
function! s:suite_ge.spoiled_tabchar() abort "{{{
  let g:columnmove_strict_wbege = 0

  " #1
  set tabstop=4
  call append(0, ['	abc', '', 'defghij', 'klmnopq'])
  normal 4G4l\ge
  call g:assert.equals(getpos('.')[1:2], [1, 2], 'failed at #1')
  call columnmove#interrupt()
  %delete

  " #2
  set tabstop=4
  call append(0, ['abcdefg', '', 'hijklmn', '	opqr'])
  normal 4G\ge
  call g:assert.equals(getpos('.')[1:2], [1, 5], 'failed at #2')
  call columnmove#interrupt()
  %delete
endfunction
"}}}
function! s:suite_ge.spoiled_multibyte_char() abort "{{{
  let g:columnmove_strict_wbege = 0

  " #1
  set ambiwidth=single
  call append(0, ['αbc', '', 'defg', 'hijk'])
  normal 4G\ge
  call g:assert.equals(getpos('.')[1:2], [1, 1], 'failed at #1')
  call columnmove#interrupt()
  %delete

  " #2
  set ambiwidth=single
  call append(0, ['αbc', '', 'defg', 'hijk'])
  normal 4Gl\ge
  call g:assert.equals(getpos('.')[1:2], [1, strlen('α')+1], 'failed at #2')
  call columnmove#interrupt()
  %delete

  " #3
  set ambiwidth=single
  call append(0, ['αbc', '', 'defg', 'hijk'])
  normal 4G2l\ge
  call g:assert.equals(getpos('.')[1:2], [1, strlen('α')+2], 'failed at #3')
  call columnmove#interrupt()
  %delete

  " #4
  set ambiwidth=single
  call append(0, ['abc', '', 'δefg', 'hijk'])
  normal 4G\ge
  call g:assert.equals(getpos('.')[1:2], [1, 1], 'failed at #4')
  call columnmove#interrupt()
  %delete

  " #5
  set ambiwidth=single
  call append(0, ['abc', '', 'δefg', 'hijk'])
  normal 4Gl\ge
  call g:assert.equals(getpos('.')[1:2], [1, 2], 'failed at #5')
  call columnmove#interrupt()
  %delete

  " #6
  set ambiwidth=single
  call append(0, ['abc', '', 'δefg', 'hijk'])
  normal 4G2l\ge
  call g:assert.equals(getpos('.')[1:2], [1, 3], 'failed at #6')
  call columnmove#interrupt()
  %delete

  " #7
  set ambiwidth=single
  call append(0, ['abc', '', 'defg', 'ηijk'])
  normal 4G\ge
  call g:assert.equals(getpos('.')[1:2], [1, 1], 'failed at #7')
  call columnmove#interrupt()
  %delete

  " #8
  set ambiwidth=single
  call append(0, ['abc', '', 'defg', 'ηijk'])
  normal 4Gl\ge
  call g:assert.equals(getpos('.')[1:2], [1, 2], 'failed at #8')
  let @@ = ''
  normal! yl
  call g:assert.equals(@@, 'b', 'failed at #8')
  call columnmove#interrupt()
  %delete

  " #9
  set ambiwidth=single
  call append(0, ['abc', '', 'defg', 'ηijk'])
  normal 4G2l\ge
  call g:assert.equals(getpos('.')[1:2], [1, 3], 'failed at #9')
  let @@ = ''
  normal! yl
  call g:assert.equals(@@, 'c', 'failed at #9')
  call columnmove#interrupt()
  %delete

  " #10
  set ambiwidth=double
  call append(0, ['αbc', '', 'defg', 'hijk'])
  normal 4G\ge
  call g:assert.equals(getpos('.')[1:2], [1, 1], 'failed at #10')
  call columnmove#interrupt()
  %delete

  " #11
  set ambiwidth=double
  call append(0, ['αbc', '', 'defg', 'hijk'])
  normal 4Gl\ge
  call g:assert.equals(getpos('.')[1:2], [1, 1], 'failed at #11')
  call columnmove#interrupt()
  %delete

  " #12
  set ambiwidth=double
  call append(0, ['αbc', '', 'defg', 'hijk'])
  normal 4G2l\ge
  call g:assert.equals(getpos('.')[1:2], [1, strlen('α')+1], 'failed at #12')
  call columnmove#interrupt()
  %delete

  " #13
  set ambiwidth=double
  call append(0, ['abc', '', 'δefg', 'hijk'])
  normal 4G\ge
  call g:assert.equals(getpos('.')[1:2], [1, 1], 'failed at #13')
  call columnmove#interrupt()
  %delete

  " #14
  set ambiwidth=double
  call append(0, ['abc', '', 'δefg', 'hijk'])
  normal 4Gl\ge
  call g:assert.equals(getpos('.')[1:2], [1, 2], 'failed at #14')
  call columnmove#interrupt()
  %delete

  " #15
  set ambiwidth=double
  call append(0, ['abc', '', 'δefg', 'hijk'])
  normal 4G2l\ge
  call g:assert.equals(getpos('.')[1:2], [1, 3], 'failed at #15')
  call columnmove#interrupt()
  %delete

  " #16
  set ambiwidth=double
  call append(0, ['abc', '', 'defg', 'ηijk'])
  normal 4G\ge
  call g:assert.equals(getpos('.')[1:2], [1, 1], 'failed at #16')
  call columnmove#interrupt()
  %delete

  " #17
  set ambiwidth=double
  call append(0, ['abc', '', 'defg', 'ηijk'])
  normal 4Gl\ge
  call g:assert.equals(getpos('.')[1:2], [1, 3], 'failed at #17')
  let @@ = ''
  normal! yl
  call g:assert.equals(@@, 'c', 'failed at #17')
  call columnmove#interrupt()
  %delete

  " #18
  set ambiwidth=double
  call append(0, ['abc', '', 'defg', 'ηijk'])
  normal 4G2l\ge
  call g:assert.equals(getpos('.')[1:2], [4, strlen('η')+2], 'failed at #18')
  let @@ = ''
  normal! yl
  call g:assert.equals(@@, 'j', 'failed at #18')
  call columnmove#interrupt()
  %delete

  " #19
  set ambiwidth=double
  call append(0, ['abc', '', 'δefg', '', 'hijk'])
  normal 5G0l\ge
  call g:assert.equals(getpos('.')[1:2], [3, 1], 'failed at #19')
  normal \ge
  call g:assert.equals(getpos('.')[1:2], [1, 2], 'failed at #19')
  call columnmove#interrupt()
  %delete

  " #20
  set ambiwidth=double
  call append(0, ['abc', '', 'δefg', '', 'hijk'])
  normal 5G0l\ge
  call g:assert.equals(getpos('.')[1:2], [3, 1], 'failed at #20')
  call columnmove#interrupt()
  normal \ge
  call g:assert.equals(getpos('.')[1:2], [1, 1], 'failed at #20')
  call columnmove#interrupt()
  %delete
endfunction
"}}}
function! s:suite_ge.spoiled_visual_mode() abort  "{{{
  let g:columnmove_strict_wbege = 0

  " #1
  call append(0, ['a', 'b', '', 'c', 'd'])
  call setpos("'<", [0, 0, 0, 0])
  call setpos("'>", [0, 0, 0, 0])
  normal 5G0v\ge
  execute "normal! \<Esc>"
  call g:assert.equals(getpos("'<"), [0, 2, 1, 0], 'failed at #1')
  call g:assert.equals(getpos("'>"), [0, 5, 1, 0], 'failed at #1')
  call g:assert.equals(visualmode(), 'v', 'failed at #1')
  call columnmove#interrupt()
  %delete

  " #2
  call append(0, ['a', 'b', '', 'c', 'd'])
  call setpos("'<", [0, 0, 0, 0])
  call setpos("'>", [0, 0, 0, 0])
  normal 5G0V\ge
  execute "normal! \<Esc>"
  call g:assert.equals(getpos("'<"), [0, 2, 1, 0], 'failed at #2')
  call g:assert.equals(getpos("'>"), [0, 5, g:intmax, 0], 'failed at #2')
  call g:assert.equals(visualmode(), 'V', 'failed at #2')
  call columnmove#interrupt()
  %delete

  " #3
  call append(0, ['a', 'b', '', 'c', 'd'])
  call setpos("'<", [0, 0, 0, 0])
  call setpos("'>", [0, 0, 0, 0])
  execute "normal 5G0\<C-v>\\ge\<Esc>"
  call g:assert.equals(getpos("'<"), [0, 2, 1, 0], 'failed at #3')
  call g:assert.equals(getpos("'>"), [0, 5, 1, 0], 'failed at #3')
  call g:assert.equals(visualmode(), "\<C-v>", 'failed at #3')
  call columnmove#interrupt()
  %delete

  " #4
  call append(0, ['a', 'b', '', 'c', 'd', '', 'e'])
  call setpos("'<", [0, 0, 0, 0])
  call setpos("'>", [0, 0, 0, 0])
  normal 7G0v\ge\ge
  execute "normal! \<Esc>"
  call g:assert.equals(getpos("'<"), [0, 2, 1, 0], 'failed at #4')
  call g:assert.equals(getpos("'>"), [0, 7, 1, 0], 'failed at #4')
  call g:assert.equals(visualmode(), 'v', 'failed at #4')
  call columnmove#interrupt()
  %delete

  " #5
  call append(0, ['', '', ''])
  normal 3G0v\ge
  call g:assert.equals(mode(), 'v', 'failed at #5')
  execute "normal! \<Esc>"
  call columnmove#interrupt()
  %delete
endfunction
"}}}
function! s:suite_ge.spoiled_operator_pending_mode() abort  "{{{
  let g:columnmove_strict_wbege = 0

  " #1
  " default: linewise
  call append(0, ['abc', '', ':::'])
  let @@ = ''
  normal 3G0l""d\ge
  call g:assert.equals(getreg('"'), "abc\n\n:::\n", 'failed at #1')
  call g:assert.equals(getregtype('"'), 'V', 'failed at #1')
  call columnmove#interrupt()
  %delete

  " #2
  " exclusive character-wise with o_v
  call append(0, ['abc', '', ':::'])
  let @@ = ''
  normal 3G0l""dv\ge
  call g:assert.equals(getreg('"'), "bc\n\n:", 'failed at #2')
  call g:assert.equals(getregtype('"'), 'v', 'failed at #2')
  call columnmove#interrupt()
  %delete

  " #3
  " line-wise with o_V
  call append(0, ['abc', '', ':::'])
  let @@ = ''
  normal 3G0l""dV\ge
  call g:assert.equals(getreg('"'), "abc\n\n:::\n", 'failed at #3')
  call g:assert.equals(getregtype('"'), 'V', 'failed at #3')
  call columnmove#interrupt()
  %delete

  " #4
  " block-wise with o_CTRL-V
  call append(0, ['abc', '', ':::'])
  let @@ = ''
  execute "normal 3G0l\"\"d\<C-v>\\ge"
  call g:assert.equals(getreg('"'), "b\n \n:", 'failed at #4')
  call g:assert.equals(getregtype('"'), "\<C-v>1", 'failed at #4')
  call columnmove#interrupt()
  %delete
endfunction
"}}}

let s:suite_gE = themis#suite('columnmove-gE:')
function! s:suite_gE.before_each() abort  "{{{
  mapclear
  mapclear!
  call columnmove#utility#map('nxo', 'gE', '\gE')
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
function! s:suite_gE.after() abort  "{{{
  call s:suite_gE.before_each()
  mapclear
  mapclear!
endfunction
"}}}

function! s:suite_gE.strict() abort  "{{{
  " #1
  call append(0, ['a', 'b', ';', 'c', 'd'])
  normal 1G0\gE
  call g:assert.equals(line('.'), 1, 'failed at #1')
  call columnmove#interrupt()
  %delete

  " #2
  call append(0, ['a', 'b', ';', 'c', 'd'])
  normal 2G0\gE
  call g:assert.equals(line('.'), 2, 'failed at #2')
  call columnmove#interrupt()
  %delete

  " #3
  call append(0, ['a', 'b', ';', 'c', 'd'])
  normal 3G0\gE
  call g:assert.equals(line('.'), 3, 'failed at #3')
  call columnmove#interrupt()
  %delete

  " #4
  call append(0, ['a', 'b', ';', 'c', 'd'])
  normal 4G0\gE
  call g:assert.equals(line('.'), 4, 'failed at #4')
  call columnmove#interrupt()
  %delete

  " #5
  call append(0, ['a', 'b', ';', 'c', 'd'])
  normal 5G0\gE
  call g:assert.equals(line('.'), 5, 'failed at #5')
  call columnmove#interrupt()
  %delete

  " #6
  call append(0, ['a', 'b', ' ', 'c', 'd'])
  normal 1G0\gE
  call g:assert.equals(line('.'), 1, 'failed at #6')
  call columnmove#interrupt()
  %delete

  " #7
  call append(0, ['a', 'b', ' ', 'c', 'd'])
  normal 2G0\gE
  call g:assert.equals(line('.'), 2, 'failed at #7')
  call columnmove#interrupt()
  %delete

  " #8
  call append(0, ['a', 'b', ' ', 'c', 'd'])
  normal 3G0\gE
  call g:assert.equals(line('.'), 2, 'failed at #8')
  call columnmove#interrupt()
  %delete

  " #9
  call append(0, ['a', 'b', ' ', 'c', 'd'])
  normal 4G0\gE
  call g:assert.equals(line('.'), 2, 'failed at #9')
  call columnmove#interrupt()
  %delete

  " #10
  call append(0, ['a', 'b', ' ', 'c', 'd'])
  normal 5G0\gE
  call g:assert.equals(line('.'), 2, 'failed at #10')
  call columnmove#interrupt()
  %delete

  " #11
  call append(0, ['a', 'b', '', 'c', 'd'])
  normal 1G0\gE
  call g:assert.equals(line('.'), 1, 'failed at #11')
  call columnmove#interrupt()
  %delete

  " #12
  call append(0, ['a', 'b', '', 'c', 'd'])
  normal 2G0\gE
  call g:assert.equals(line('.'), 2, 'failed at #12')
  call columnmove#interrupt()
  %delete

  " #13
  call append(0, ['a', 'b', '', 'c', 'd'])
  normal 3G0\gE
  call g:assert.equals(line('.'), 2, 'failed at #13')
  call columnmove#interrupt()
  %delete

  " #14
  call append(0, ['a', 'b', '', 'c', 'd'])
  normal 4G0\gE
  call g:assert.equals(line('.'), 2, 'failed at #14')
  call columnmove#interrupt()
  %delete

  " #15
  call append(0, ['a', 'b', '', 'c', 'd'])
  normal 5G0\gE
  call g:assert.equals(line('.'), 2, 'failed at #15')
  call columnmove#interrupt()
  %delete

  " #16
  call append(0, [';', ':', 'a', ',', '.'])
  normal 1G0\gE
  call g:assert.equals(line('.'), 1, 'failed at #16')
  call columnmove#interrupt()
  %delete

  " #17
  call append(0, [';', ':', 'a', ',', '.'])
  normal 2G0\gE
  call g:assert.equals(line('.'), 2, 'failed at #17')
  call columnmove#interrupt()
  %delete

  " #18
  call append(0, [';', ':', 'a', ',', '.'])
  normal 3G0\gE
  call g:assert.equals(line('.'), 3, 'failed at #18')
  call columnmove#interrupt()
  %delete

  " #19
  call append(0, [';', ':', 'a', ',', '.'])
  normal 4G0\gE
  call g:assert.equals(line('.'), 4, 'failed at #19')
  call columnmove#interrupt()
  %delete

  " #20
  call append(0, [';', ':', 'a', ',', '.'])
  normal 5G0\gE
  call g:assert.equals(line('.'), 5, 'failed at #20')
  call columnmove#interrupt()
  %delete

  " #21
  call append(0, [';', ':', ' ', ',', '.'])
  normal 1G0\gE
  call g:assert.equals(line('.'), 1, 'failed at #21')
  call columnmove#interrupt()
  %delete

  " #22
  call append(0, [';', ':', ' ', ',', '.'])
  normal 2G0\gE
  call g:assert.equals(line('.'), 2, 'failed at #22')
  call columnmove#interrupt()
  %delete

  " #23
  call append(0, [';', ':', ' ', ',', '.'])
  normal 3G0\gE
  call g:assert.equals(line('.'), 2, 'failed at #23')
  call columnmove#interrupt()
  %delete

  " #24
  call append(0, [';', ':', ' ', ',', '.'])
  normal 4G0\gE
  call g:assert.equals(line('.'), 2, 'failed at #24')
  call columnmove#interrupt()
  %delete

  " #25
  call append(0, [';', ':', ' ', ',', '.'])
  normal 5G0\gE
  call g:assert.equals(line('.'), 2, 'failed at #25')
  call columnmove#interrupt()
  %delete

  " #26
  call append(0, [';', ':', '', ',', '.'])
  normal 1G0\gE
  call g:assert.equals(line('.'), 1, 'failed at #26')
  call columnmove#interrupt()
  %delete

  " #27
  call append(0, [';', ':', '', ',', '.'])
  normal 2G0\gE
  call g:assert.equals(line('.'), 2, 'failed at #27')
  call columnmove#interrupt()
  %delete

  " #28
  call append(0, [';', ':', '', ',', '.'])
  normal 3G0\gE
  call g:assert.equals(line('.'), 2, 'failed at #28')
  call columnmove#interrupt()
  %delete

  " #29
  call append(0, [';', ':', '', ',', '.'])
  normal 4G0\gE
  call g:assert.equals(line('.'), 2, 'failed at #29')
  call columnmove#interrupt()
  %delete

  " #30
  call append(0, [';', ':', '', ',', '.'])
  normal 5G0\gE
  call g:assert.equals(line('.'), 2, 'failed at #30')
  call columnmove#interrupt()
  %delete

  " #31
  call append(0, [' ', ' ', 'a', ' ', ' '])
  normal 1G0\gE
  call g:assert.equals(line('.'), 1, 'failed at #31')
  call columnmove#interrupt()
  %delete

  " #32
  call append(0, [' ', ' ', 'a', ' ', ' '])
  normal 2G0\gE
  call g:assert.equals(line('.'), 2, 'failed at #32')
  call columnmove#interrupt()
  %delete

  " #33
  call append(0, [' ', ' ', 'a', ' ', ' '])
  normal 3G0\gE
  call g:assert.equals(line('.'), 3, 'failed at #33')
  call columnmove#interrupt()
  %delete

  " #34
  call append(0, [' ', ' ', 'a', ' ', ' '])
  normal 4G0\gE
  call g:assert.equals(line('.'), 3, 'failed at #34')
  call columnmove#interrupt()
  %delete

  " #35
  call append(0, [' ', ' ', 'a', ' ', ' '])
  normal 5G0\gE
  call g:assert.equals(line('.'), 3, 'failed at #35')
  call columnmove#interrupt()
  %delete

  " #36
  call append(0, [' ', ' ', ';', ' ', ' '])
  normal 1G0\gE
  call g:assert.equals(line('.'), 1, 'failed at #36')
  call columnmove#interrupt()
  %delete

  " #37
  call append(0, [' ', ' ', ';', ' ', ' '])
  normal 2G0\gE
  call g:assert.equals(line('.'), 2, 'failed at #37')
  call columnmove#interrupt()
  %delete

  " #38
  call append(0, [' ', ' ', ';', ' ', ' '])
  normal 3G0\gE
  call g:assert.equals(line('.'), 3, 'failed at #38')
  call columnmove#interrupt()
  %delete

  " #39
  call append(0, [' ', ' ', ';', ' ', ' '])
  normal 4G0\gE
  call g:assert.equals(line('.'), 3, 'failed at #39')
  call columnmove#interrupt()
  %delete

  " #40
  call append(0, [' ', ' ', ';', ' ', ' '])
  normal 5G0\gE
  call g:assert.equals(line('.'), 3, 'failed at #40')
  call columnmove#interrupt()
  %delete

  " #41
  call append(0, [' ', ' ', '', ' ', ' '])
  normal 1G0\gE
  call g:assert.equals(line('.'), 1, 'failed at #41')
  call columnmove#interrupt()
  %delete

  " #42
  call append(0, [' ', ' ', '', ' ', ' '])
  normal 2G0\gE
  call g:assert.equals(line('.'), 2, 'failed at #42')
  call columnmove#interrupt()
  %delete

  " #43
  call append(0, [' ', ' ', '', ' ', ' '])
  normal 3G0\gE
  call g:assert.equals(line('.'), 3, 'failed at #43')
  call columnmove#interrupt()
  %delete

  " #44
  call append(0, [' ', ' ', '', ' ', ' '])
  normal 4G0\gE
  call g:assert.equals(line('.'), 4, 'failed at #44')
  call columnmove#interrupt()
  %delete

  " #45
  call append(0, [' ', ' ', '', ' ', ' '])
  normal 5G0\gE
  call g:assert.equals(line('.'), 5, 'failed at #45')
  call columnmove#interrupt()
  %delete

  " #46
  call append(0, ['', '', 'a', '', ''])
  normal 1G0\gE
  call g:assert.equals(line('.'), 1, 'failed at #46')
  call columnmove#interrupt()
  %delete

  " #47
  call append(0, ['', '', 'a', '', ''])
  normal 2G0\gE
  call g:assert.equals(line('.'), 2, 'failed at #47')
  call columnmove#interrupt()
  %delete

  " #48
  call append(0, ['', '', 'a', '', ''])
  normal 3G0\gE
  call g:assert.equals(line('.'), 3, 'failed at #48')
  call columnmove#interrupt()
  %delete

  " #49
  call append(0, ['', '', 'a', '', ''])
  normal 4G0\gE
  call g:assert.equals(line('.'), 3, 'failed at #49')
  call columnmove#interrupt()
  %delete

  " #50
  call append(0, ['', '', 'a', '', ''])
  normal 5G0\gE
  call g:assert.equals(line('.'), 3, 'failed at #50')
  call columnmove#interrupt()
  %delete

  " #51
  call append(0, ['', '', ';', '', ''])
  normal 1G0\gE
  call g:assert.equals(line('.'), 1, 'failed at #51')
  call columnmove#interrupt()
  %delete

  " #52
  call append(0, ['', '', ';', '', ''])
  normal 2G0\gE
  call g:assert.equals(line('.'), 2, 'failed at #52')
  call columnmove#interrupt()
  %delete

  " #53
  call append(0, ['', '', ';', '', ''])
  normal 3G0\gE
  call g:assert.equals(line('.'), 3, 'failed at #53')
  call columnmove#interrupt()
  %delete

  " #54
  call append(0, ['', '', ';', '', ''])
  normal 4G0\gE
  call g:assert.equals(line('.'), 3, 'failed at #54')
  call columnmove#interrupt()
  %delete

  " #55
  call append(0, ['', '', ';', '', ''])
  normal 5G0\gE
  call g:assert.equals(line('.'), 3, 'failed at #55')
  call columnmove#interrupt()
  %delete

  " #56
  call append(0, ['', '', ' ', '', ''])
  normal 1G0\gE
  call g:assert.equals(line('.'), 1, 'failed at #56')
  call columnmove#interrupt()
  %delete

  " #57
  call append(0, ['', '', ' ', '', ''])
  normal 2G0\gE
  call g:assert.equals(line('.'), 2, 'failed at #57')
  call columnmove#interrupt()
  %delete

  " #58
  call append(0, ['', '', ' ', '', ''])
  normal 3G0\gE
  call g:assert.equals(line('.'), 3, 'failed at #58')
  call columnmove#interrupt()
  %delete

  " #59
  call append(0, ['', '', ' ', '', ''])
  normal 4G0\gE
  call g:assert.equals(line('.'), 4, 'failed at #59')
  call columnmove#interrupt()
  %delete

  " #60
  call append(0, ['', '', ' ', '', ''])
  normal 5G0\gE
  call g:assert.equals(line('.'), 5, 'failed at #60')
  call columnmove#interrupt()
  %delete

  " #61
  call append(0, ['a', 'b', '', 'c', 'd', '', 'e'])
  normal 7G0\gE
  call g:assert.equals(line('.'), 5, 'failed at #61')
  normal \gE
  call g:assert.equals(line('.'), 2, 'failed at #61')
  call columnmove#interrupt()
  %delete
endfunction
"}}}
function! s:suite_gE.strict_count() abort "{{{
  " #1
  call append(0, ['a', 'b', '', 'c', 'd', '', 'e', 'f', '', 'g'])
  normal 10G0\gE
  call g:assert.equals(line('.'), 8, 'failed at #1')
  call columnmove#interrupt()
  %delete

  " #2
  call append(0, ['a', 'b', '', 'c', 'd', '', 'e', 'f', '', 'g'])
  normal 10G02\gE
  call g:assert.equals(line('.'), 5, 'failed at #2')
  call columnmove#interrupt()
  %delete

  " #3
  call append(0, ['a', 'b', '', 'c', 'd', '', 'e', 'f', '', 'g'])
  normal 10G03\gE
  call g:assert.equals(line('.'), 2, 'failed at #3')
  call columnmove#interrupt()
  %delete

  " #3
  call append(0, ['a', 'b', '', 'c', 'd', '', 'e', 'f', '', 'g'])
  normal 10G04\gE
  call g:assert.equals(line('.'), 10, 'failed at #3')
  call columnmove#interrupt()
  %delete
endfunction
"}}}
function! s:suite_gE.strict_fold() abort  "{{{
  " #1
  call append(0, ['a', 'b', '', 'c', 'd', 'e', 'f'])
  1,2fold
  normal 7G0\gE
  call g:assert.equals(line('.'), 7, 'failed at #1')
  call columnmove#interrupt()
  %delete

  " #2
  call append(0, ['a', 'b', '', 'c', 'd', 'e', 'f'])
  2,3fold
  normal 7G0\gE
  call g:assert.equals(line('.'), 7, 'failed at #2')
  call columnmove#interrupt()
  %delete

  " #3
  call append(0, ['a', 'b', '', 'c', 'd', 'e', 'f'])
  3,4fold
  normal 7G0\gE
  call g:assert.equals(line('.'), 7, 'failed at #3')
  call columnmove#interrupt()
  %delete

  " #4
  call append(0, ['a', 'b', '', 'c', 'd', 'e', 'f'])
  4,5fold
  normal 7G0\gE
  call g:assert.equals(line('.'), 2, 'failed at #4')
  call columnmove#interrupt()
  %delete

  " #5
  call append(0, ['a', 'b', '', 'c', 'd', 'e', 'f'])
  5,6fold
  normal 7G0\gE
  call g:assert.equals(line('.'), 2, 'failed at #5')
  call columnmove#interrupt()
  %delete

  " #6
  call append(0, ['a', 'b', '', 'c', 'd', 'e', 'f'])
  6,7fold
  normal 7G0\gE
  call g:assert.equals(line('.'), 5, 'failed at #6')
  call columnmove#interrupt()
  %delete

  " #7
  call append(0, ['a', 'b', '', 'c', 'd', 'e', 'f', 'g'])
  6,7fold
  normal 8G0\gE
  call g:assert.equals(line('.'), 2, 'failed at #7')
  call columnmove#interrupt()
  %delete
endfunction
"}}}
function! s:suite_gE.strict_option_fold_treatment() abort  "{{{
  let g:columnmove_fold_treatment = 1

  " #1
  call append(0, ['a', 'b', '', 'c', 'd', 'e', 'f'])
  1,2fold
  normal 7G0\gE
  call g:assert.equals(line('.'), 7, 'failed at #1')
  call columnmove#interrupt()
  %delete

  " #2
  call append(0, ['a', 'b', '', 'c', 'd', 'e', 'f'])
  2,3fold
  normal 7G0\gE
  call g:assert.equals(line('.'), 1, 'failed at #2')
  call columnmove#interrupt()
  %delete

  " #3
  call append(0, ['a', 'b', '', 'c', 'd', 'e', 'f'])
  3,4fold
  normal 7G0\gE
  call g:assert.equals(line('.'), 2, 'failed at #3')
  call columnmove#interrupt()
  %delete

  " #4
  call append(0, ['a', 'b', '', 'c', 'd', 'e', 'f'])
  4,5fold
  normal 7G0\gE
  call g:assert.equals(line('.'), 2, 'failed at #4')
  call columnmove#interrupt()
  %delete

  " #5
  call append(0, ['a', 'b', '', 'c', 'd', 'e', 'f'])
  5,6fold
  normal 7G0\gE
  call g:assert.equals(line('.'), 4, 'failed at #5')
  call columnmove#interrupt()
  %delete

  " #6
  call append(0, ['a', 'b', '', 'c', 'd', 'e', 'f'])
  6,7fold
  normal 7G0\gE
  call g:assert.equals(line('.'), 5, 'failed at #6')
  call columnmove#interrupt()
  %delete

  " #7
  call append(0, ['a', 'b', '', 'c', 'd', 'e', 'f', 'g'])
  6,7fold
  normal 8G0\gE
  call g:assert.equals(line('.'), 5, 'failed at #7')
  call columnmove#interrupt()
  %delete
endfunction
"}}}
function! s:suite_gE.strict_option_fold_open() abort  "{{{
  let g:columnmove_fold_open = 1

  " #1
  call append(0, ['a', 'b', ':', 'c', 'd'])
  2,4fold
  normal 5G\gE
  call g:assert.equals(line('.'), 5, 'failed at #1')
  call g:assert.equals(foldclosed(2),    2, 'failed at #1')
  call g:assert.equals(foldclosedend(2), 4, 'failed at #1')
  call columnmove#interrupt()
  %delete

  " #2
  call append(0, ['a', 'b', ' ', 'c', 'd'])
  2,4fold
  normal 5G\gE
  call g:assert.equals(line('.'), 2, 'failed at #2')
  call g:assert.equals(foldclosed(2),    -1, 'failed at #2')
  call g:assert.equals(foldclosedend(2), -1, 'failed at #2')
  call columnmove#interrupt()
  %delete

  " #3
  call append(0, ['a', 'b', '', 'c', 'd'])
  2,4fold
  normal 5G\gE
  call g:assert.equals(line('.'), 2, 'failed at #3')
  call g:assert.equals(foldclosed(2),    -1, 'failed at #3')
  call g:assert.equals(foldclosedend(2), -1, 'failed at #3')
  call columnmove#interrupt()
  %delete

  " #4
  call append(0, [':', 'a', 'b', 'c', 'd'])
  2,4fold
  normal 5G\gE
  call g:assert.equals(line('.'), 5, 'failed at #4')
  call g:assert.equals(foldclosed(2),    2, 'failed at #4')
  call g:assert.equals(foldclosedend(2), 4, 'failed at #4')
  call columnmove#interrupt()
  %delete

  " #5
  call append(0, ['a', ' ', 'b', 'c', 'd'])
  2,4fold
  normal 5G\gE
  call g:assert.equals(line('.'), 1, 'failed at #5')
  call g:assert.equals(foldclosed(2),    2, 'failed at #5')
  call g:assert.equals(foldclosedend(2), 4, 'failed at #5')
  call columnmove#interrupt()
  %delete

  " #6
  call append(0, ['a', '', 'b', 'c', 'd'])
  2,4fold
  normal 5G\gE
  call g:assert.equals(line('.'), 1, 'failed at #6')
  call g:assert.equals(foldclosed(2),    2, 'failed at #6')
  call g:assert.equals(foldclosedend(2), 4, 'failed at #6')
  call columnmove#interrupt()
  %delete
endfunction
"}}}
function! s:suite_gE.strict_option_combinations() abort "{{{
  let g:columnmove_fold_treatment = 1
  let g:columnmove_fold_open = 1

  " #1
  call append(0, ['a', 'b', '', 'c', 'd', 'e'])
  2,4fold
  normal 6G\gE
  call g:assert.equals(line('.'), 2, 'failed at #1')
  call columnmove#interrupt()
  %delete
endfunction
"}}}
function! s:suite_gE.strict_option_stop_on_space() dict abort  "{{{
  let g:columnmove_stop_on_space = 1

  " #1
  call append(0, ['', 'aa', '  ', '', 'bb'])
  normal 5G0\gE
  call g:assert.equals(line('.'), 2, 'failed at #1')
  call columnmove#interrupt()
  %delete

  " #2
  call append(0, ['', 'aa', '  ', '', 'bb'])
  normal 5G0l\gE
  call g:assert.equals(line('.'), 2, 'failed at #2')
  call columnmove#interrupt()
  %delete

  " #3
  call append(0, ['', 'a ', '  ', '', 'bb'])
  normal 5G0\gE
  call g:assert.equals(line('.'), 2, 'failed at #3')
  call columnmove#interrupt()
  %delete

  " #4
  call append(0, ['', 'a ', '  ', '', 'bb'])
  normal 5G0l\gE
  call g:assert.equals(line('.'), 2, 'failed at #4')
  call columnmove#interrupt()
  %delete

  let g:columnmove_stop_on_space = 0

  " #5
  call append(0, ['', 'aa', '  ', '', 'bb'])
  normal 5G0\gE
  call g:assert.equals(line('.'), 2, 'failed at #5')
  call columnmove#interrupt()
  %delete

  " #6
  call append(0, ['', 'aa', '  ', '', 'bb'])
  normal 5G0l\gE
  call g:assert.equals(line('.'), 2, 'failed at #6')
  call columnmove#interrupt()
  %delete

  " #7
  call append(0, ['', 'a ', '  ', '', 'bb'])
  normal 5G0\gE
  call g:assert.equals(line('.'), 2, 'failed at #7')
  call columnmove#interrupt()
  %delete

  " #8
  call append(0, ['', 'a ', '  ', '', 'bb'])
  normal 5G0l\gE
  call g:assert.equals(line('.'), 5, 'failed at #8')
  call columnmove#interrupt()
  %delete
endfunction
"}}}
function! s:suite_gE.strict_curswant() abort "{{{
  " #1
  call append(0, ['abcde', '', 'fgh', 'ijklm'])
  normal 4G$k\gE
  call g:assert.equals(getpos('.')[1:2], [1, 3], 'failed at #1')
  call columnmove#interrupt()
  %delete
endfunction
"}}}
function! s:suite_gE.strict_tabchar() abort "{{{
  " #1
  set tabstop=4
  call append(0, ['	abc', '', 'defghij', 'klmnopq'])
  normal 4G4l\gE
  call g:assert.equals(getpos('.')[1:2], [1, 2], 'failed at #1')
  call columnmove#interrupt()
  %delete

  " #2
  set tabstop=4
  call append(0, ['abcdefg', '', 'hijklmn', '	opqr'])
  normal 4G\gE
  call g:assert.equals(getpos('.')[1:2], [1, 5], 'failed at #2')
  call columnmove#interrupt()
  %delete
endfunction
"}}}
function! s:suite_gE.strict_multibyte_char() abort "{{{
  " #1
  set ambiwidth=single
  call append(0, ['αbc', '', 'defg', 'hijk'])
  normal 4G\gE
  call g:assert.equals(getpos('.')[1:2], [1, 1], 'failed at #1')
  call columnmove#interrupt()
  %delete

  " #2
  set ambiwidth=single
  call append(0, ['αbc', '', 'defg', 'hijk'])
  normal 4Gl\gE
  call g:assert.equals(getpos('.')[1:2], [1, strlen('α')+1], 'failed at #2')
  call columnmove#interrupt()
  %delete

  " #3
  set ambiwidth=single
  call append(0, ['αbc', '', 'defg', 'hijk'])
  normal 4G2l\gE
  call g:assert.equals(getpos('.')[1:2], [1, strlen('α')+2], 'failed at #3')
  call columnmove#interrupt()
  %delete

  " #4
  set ambiwidth=single
  call append(0, ['abc', '', 'δefg', 'hijk'])
  normal 4G\gE
  call g:assert.equals(getpos('.')[1:2], [1, 1], 'failed at #4')
  call columnmove#interrupt()
  %delete

  " #5
  set ambiwidth=single
  call append(0, ['abc', '', 'δefg', 'hijk'])
  normal 4Gl\gE
  call g:assert.equals(getpos('.')[1:2], [1, 2], 'failed at #5')
  call columnmove#interrupt()
  %delete

  " #6
  set ambiwidth=single
  call append(0, ['abc', '', 'δefg', 'hijk'])
  normal 4G2l\gE
  call g:assert.equals(getpos('.')[1:2], [1, 3], 'failed at #6')
  call columnmove#interrupt()
  %delete

  " #7
  set ambiwidth=single
  call append(0, ['abc', '', 'defg', 'ηijk'])
  normal 4G\gE
  call g:assert.equals(getpos('.')[1:2], [1, 1], 'failed at #7')
  call columnmove#interrupt()
  %delete

  " #8
  set ambiwidth=single
  call append(0, ['abc', '', 'defg', 'ηijk'])
  normal 4Gl\gE
  call g:assert.equals(getpos('.')[1:2], [1, 2], 'failed at #8')
  let @@ = ''
  normal! yl
  call g:assert.equals(@@, 'b', 'failed at #8')
  call columnmove#interrupt()
  %delete

  " #9
  set ambiwidth=single
  call append(0, ['abc', '', 'defg', 'ηijk'])
  normal 4G2l\gE
  call g:assert.equals(getpos('.')[1:2], [1, 3], 'failed at #9')
  let @@ = ''
  normal! yl
  call g:assert.equals(@@, 'c', 'failed at #9')
  call columnmove#interrupt()
  %delete

  " #10
  set ambiwidth=double
  call append(0, ['αbc', '', 'defg', 'hijk'])
  normal 4G\gE
  call g:assert.equals(getpos('.')[1:2], [1, 1], 'failed at #10')
  call columnmove#interrupt()
  %delete

  " #11
  set ambiwidth=double
  call append(0, ['αbc', '', 'defg', 'hijk'])
  normal 4Gl\gE
  call g:assert.equals(getpos('.')[1:2], [1, 1], 'failed at #11')
  call columnmove#interrupt()
  %delete

  " #12
  set ambiwidth=double
  call append(0, ['αbc', '', 'defg', 'hijk'])
  normal 4G2l\gE
  call g:assert.equals(getpos('.')[1:2], [1, strlen('α')+1], 'failed at #12')
  call columnmove#interrupt()
  %delete

  " #13
  set ambiwidth=double
  call append(0, ['abc', '', 'δefg', 'hijk'])
  normal 4G\gE
  call g:assert.equals(getpos('.')[1:2], [1, 1], 'failed at #13')
  call columnmove#interrupt()
  %delete

  " #14
  set ambiwidth=double
  call append(0, ['abc', '', 'δefg', 'hijk'])
  normal 4Gl\gE
  call g:assert.equals(getpos('.')[1:2], [1, 2], 'failed at #14')
  call columnmove#interrupt()
  %delete

  " #15
  set ambiwidth=double
  call append(0, ['abc', '', 'δefg', 'hijk'])
  normal 4G2l\gE
  call g:assert.equals(getpos('.')[1:2], [1, 3], 'failed at #15')
  call columnmove#interrupt()
  %delete

  " #16
  set ambiwidth=double
  call append(0, ['abc', '', 'defg', 'ηijk'])
  normal 4G\gE
  call g:assert.equals(getpos('.')[1:2], [1, 1], 'failed at #16')
  call columnmove#interrupt()
  %delete

  " #17
  set ambiwidth=double
  call append(0, ['abc', '', 'defg', 'ηijk'])
  normal 4Gl\gE
  call g:assert.equals(getpos('.')[1:2], [1, 3], 'failed at #17')
  let @@ = ''
  normal! yl
  call g:assert.equals(@@, 'c', 'failed at #17')
  call columnmove#interrupt()
  %delete

  " #18
  set ambiwidth=double
  call append(0, ['abc', '', 'defg', 'ηijk'])
  normal 4G2l\gE
  call g:assert.equals(getpos('.')[1:2], [4, strlen('η')+2], 'failed at #18')
  let @@ = ''
  normal! yl
  call g:assert.equals(@@, 'j', 'failed at #18')
  call columnmove#interrupt()
  %delete

  " #19
  set ambiwidth=double
  call append(0, ['abc', '', 'δefg', '', 'hijk'])
  normal 5G0l\gE
  call g:assert.equals(getpos('.')[1:2], [3, 1], 'failed at #19')
  normal \gE
  call g:assert.equals(getpos('.')[1:2], [1, 2], 'failed at #19')
  call columnmove#interrupt()
  %delete

  " #20
  set ambiwidth=double
  call append(0, ['abc', '', 'δefg', '', 'hijk'])
  normal 5G0l\gE
  call g:assert.equals(getpos('.')[1:2], [3, 1], 'failed at #20')
  call columnmove#interrupt()
  normal \gE
  call g:assert.equals(getpos('.')[1:2], [1, 1], 'failed at #20')
  call columnmove#interrupt()
  %delete
endfunction
"}}}
function! s:suite_gE.strict_visual_mode() abort  "{{{
  " #1
  call append(0, ['a', 'b', '', 'c', 'd'])
  call setpos("'<", [0, 0, 0, 0])
  call setpos("'>", [0, 0, 0, 0])
  normal 5G0v\gE
  execute "normal! \<Esc>"
  call g:assert.equals(getpos("'<"), [0, 2, 1, 0], 'failed at #1')
  call g:assert.equals(getpos("'>"), [0, 5, 1, 0], 'failed at #1')
  call g:assert.equals(visualmode(), 'v', 'failed at #1')
  call columnmove#interrupt()
  %delete

  " #2
  call append(0, ['a', 'b', '', 'c', 'd'])
  call setpos("'<", [0, 0, 0, 0])
  call setpos("'>", [0, 0, 0, 0])
  normal 5G0V\gE
  execute "normal! \<Esc>"
  call g:assert.equals(getpos("'<"), [0, 2, 1, 0], 'failed at #2')
  call g:assert.equals(getpos("'>"), [0, 5, g:intmax, 0], 'failed at #2')
  call g:assert.equals(visualmode(), 'V', 'failed at #2')
  call columnmove#interrupt()
  %delete

  " #3
  call append(0, ['a', 'b', '', 'c', 'd'])
  call setpos("'<", [0, 0, 0, 0])
  call setpos("'>", [0, 0, 0, 0])
  execute "normal 5G0\<C-v>\\gE\<Esc>"
  call g:assert.equals(getpos("'<"), [0, 2, 1, 0], 'failed at #3')
  call g:assert.equals(getpos("'>"), [0, 5, 1, 0], 'failed at #3')
  call g:assert.equals(visualmode(), "\<C-v>", 'failed at #3')
  call columnmove#interrupt()
  %delete

  " #4
  call append(0, ['a', 'b', '', 'c', 'd', '', 'e'])
  call setpos("'<", [0, 0, 0, 0])
  call setpos("'>", [0, 0, 0, 0])
  normal 7G0v\gE\gE
  execute "normal! \<Esc>"
  call g:assert.equals(getpos("'<"), [0, 2, 1, 0], 'failed at #4')
  call g:assert.equals(getpos("'>"), [0, 7, 1, 0], 'failed at #4')
  call g:assert.equals(visualmode(), 'v', 'failed at #4')
  call columnmove#interrupt()
  %delete

  " #5
  call append(0, ['', '', ''])
  normal 3G0v\gE
  call g:assert.equals(mode(), 'v', 'failed at #5')
  execute "normal! \<Esc>"
  call columnmove#interrupt()
  %delete
endfunction
"}}}
function! s:suite_gE.strict_operator_pending_mode() abort  "{{{
  " #1
  " default: linewise
  call append(0, ['abc', '', ':::'])
  let @@ = ''
  normal 3G0l""d\gE
  call g:assert.equals(getreg('"'), "abc\n\n:::\n", 'failed at #1')
  call g:assert.equals(getregtype('"'), 'V', 'failed at #1')
  call columnmove#interrupt()
  %delete

  " #2
  " exclusive character-wise with o_v
  call append(0, ['abc', '', ':::'])
  let @@ = ''
  normal 3G0l""dv\gE
  call g:assert.equals(getreg('"'), "bc\n\n:", 'failed at #2')
  call g:assert.equals(getregtype('"'), 'v', 'failed at #2')
  call columnmove#interrupt()
  %delete

  " #3
  " line-wise with o_V
  call append(0, ['abc', '', ':::'])
  let @@ = ''
  normal 3G0l""dV\gE
  call g:assert.equals(getreg('"'), "abc\n\n:::\n", 'failed at #3')
  call g:assert.equals(getregtype('"'), 'V', 'failed at #3')
  call columnmove#interrupt()
  %delete

  " #4
  " block-wise with o_CTRL-V
  call append(0, ['abc', '', ':::'])
  let @@ = ''
  execute "normal 3G0l\"\"d\<C-v>\\gE"
  call g:assert.equals(getreg('"'), "b\n \n:", 'failed at #4')
  call g:assert.equals(getregtype('"'), "\<C-v>1", 'failed at #4')
  call columnmove#interrupt()
  %delete
endfunction
"}}}

" vim:set foldmethod=marker:
" vim:set commentstring="%s:
" vim:set ts=2 sts=2 sw=2 et:
