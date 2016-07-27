let s:suite = themis#suite('columnmove unit test:')
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
  %delete
endfunction
"}}}
function! s:suite.after() abort  "{{{
  call s:suite.before_each()
  mapclear
  mapclear!
endfunction
"}}}

let s:scope = themis#helper('scope')
let s:columnmove = s:scope.funcs('autoload/columnmove.vim')

function! s:suite._pick_up_char_no_multibyte() abort  "{{{
  " #1
  let [c, col] = s:columnmove._pick_up_char_no_multibyte('a', 1)
  call g:assert.equals(c,   'a', 'failed at #1')
  call g:assert.equals(col,  1,  'failed at #1')

  " #2
  let [c, col] = s:columnmove._pick_up_char_no_multibyte('ab', 1)
  call g:assert.equals(c,   'a', 'failed at #2')
  call g:assert.equals(col,  1,  'failed at #2')

  " #3
  let [c, col] = s:columnmove._pick_up_char_no_multibyte('ab', 2)
  call g:assert.equals(c,   'b', 'failed at #3')
  call g:assert.equals(col,  2,  'failed at #3')

  " #4
  let [c, col] = s:columnmove._pick_up_char_no_multibyte('abc', 1)
  call g:assert.equals(c,   'a', 'failed at #4')
  call g:assert.equals(col,  1,  'failed at #4')

  " #5
  let [c, col] = s:columnmove._pick_up_char_no_multibyte('abc', 2)
  call g:assert.equals(c,   'b', 'failed at #5')
  call g:assert.equals(col,  2,  'failed at #5')

  " #6
  let [c, col] = s:columnmove._pick_up_char_no_multibyte('abc', 3)
  call g:assert.equals(c,   'c', 'failed at #6')
  call g:assert.equals(col,  3,  'failed at #6')

  " #7
  let [c, col] = s:columnmove._pick_up_char_no_multibyte('abcd', 1)
  call g:assert.equals(c,   'a', 'failed at #7')
  call g:assert.equals(col,  1,  'failed at #7')

  " #8
  let [c, col] = s:columnmove._pick_up_char_no_multibyte('abcd', 2)
  call g:assert.equals(c,   'b', 'failed at #8')
  call g:assert.equals(col,  2,  'failed at #8')

  " #9
  let [c, col] = s:columnmove._pick_up_char_no_multibyte('abcd', 3)
  call g:assert.equals(c,   'c', 'failed at #9')
  call g:assert.equals(col,  3,  'failed at #9')

  " #10
  let [c, col] = s:columnmove._pick_up_char_no_multibyte('abcd', 4)
  call g:assert.equals(c,   'd', 'failed at #10')
  call g:assert.equals(col,  4,  'failed at #10')

  " #11
  let [c, col] = s:columnmove._pick_up_char_no_multibyte('abcde', 1)
  call g:assert.equals(c,   'a', 'failed at #11')
  call g:assert.equals(col,  1,  'failed at #11')

  " #12
  let [c, col] = s:columnmove._pick_up_char_no_multibyte('abcde', 2)
  call g:assert.equals(c,   'b', 'failed at #12')
  call g:assert.equals(col,  2,  'failed at #12')

  " #13
  let [c, col] = s:columnmove._pick_up_char_no_multibyte('abcde', 3)
  call g:assert.equals(c,   'c', 'failed at #13')
  call g:assert.equals(col,  3,  'failed at #13')

  " #14
  let [c, col] = s:columnmove._pick_up_char_no_multibyte('abcde', 4)
  call g:assert.equals(c,   'd', 'failed at #14')
  call g:assert.equals(col,  4,  'failed at #14')

  " #15
  let [c, col] = s:columnmove._pick_up_char_no_multibyte('abcde', 5)
  call g:assert.equals(c,   'e', 'failed at #15')
  call g:assert.equals(col,  5,  'failed at #15')

  " #16
  let [c, col] = s:columnmove._pick_up_char_no_multibyte('abcdef', 1)
  call g:assert.equals(c,   'a', 'failed at #16')
  call g:assert.equals(col,  1,  'failed at #16')

  " #17
  let [c, col] = s:columnmove._pick_up_char_no_multibyte('abcdef', 2)
  call g:assert.equals(c,   'b', 'failed at #17')
  call g:assert.equals(col,  2,  'failed at #17')

  " #18
  let [c, col] = s:columnmove._pick_up_char_no_multibyte('abcdef', 3)
  call g:assert.equals(c,   'c', 'failed at #18')
  call g:assert.equals(col,  3,  'failed at #18')

  " #19
  let [c, col] = s:columnmove._pick_up_char_no_multibyte('abcdef', 4)
  call g:assert.equals(c,   'd', 'failed at #19')
  call g:assert.equals(col,  4,  'failed at #19')

  " #20
  let [c, col] = s:columnmove._pick_up_char_no_multibyte('abcdef', 5)
  call g:assert.equals(c,   'e', 'failed at #20')
  call g:assert.equals(col,  5,  'failed at #20')

  " #21
  let [c, col] = s:columnmove._pick_up_char_no_multibyte('abcdef', 6)
  call g:assert.equals(c,   'f', 'failed at #21')
  call g:assert.equals(col,  6,  'failed at #21')
endfunction
"}}}
function! s:suite._pick_up_char_sequential() abort  "{{{
  " #1
  let [c, col] = s:columnmove._pick_up_char_sequential('a', 1)
  call g:assert.equals(c,   'a', 'failed at #1')
  call g:assert.equals(col,  1,  'failed at #1')

  " #2
  let [c, col] = s:columnmove._pick_up_char_sequential('ab', 1)
  call g:assert.equals(c,   'a', 'failed at #2')
  call g:assert.equals(col,  1,  'failed at #2')

  " #3
  let [c, col] = s:columnmove._pick_up_char_sequential('ab', 2)
  call g:assert.equals(c,   'b', 'failed at #3')
  call g:assert.equals(col,  2,  'failed at #3')

  " #4
  let [c, col] = s:columnmove._pick_up_char_sequential('abc', 1)
  call g:assert.equals(c,   'a', 'failed at #4')
  call g:assert.equals(col,  1,  'failed at #4')

  " #5
  let [c, col] = s:columnmove._pick_up_char_sequential('abc', 2)
  call g:assert.equals(c,   'b', 'failed at #5')
  call g:assert.equals(col,  2,  'failed at #5')

  " #6
  let [c, col] = s:columnmove._pick_up_char_sequential('abc', 3)
  call g:assert.equals(c,   'c', 'failed at #6')
  call g:assert.equals(col,  3,  'failed at #6')

  " #7
  let [c, col] = s:columnmove._pick_up_char_sequential('abcd', 1)
  call g:assert.equals(c,   'a', 'failed at #7')
  call g:assert.equals(col,  1,  'failed at #7')

  " #8
  let [c, col] = s:columnmove._pick_up_char_sequential('abcd', 2)
  call g:assert.equals(c,   'b', 'failed at #8')
  call g:assert.equals(col,  2,  'failed at #8')

  " #9
  let [c, col] = s:columnmove._pick_up_char_sequential('abcd', 3)
  call g:assert.equals(c,   'c', 'failed at #9')
  call g:assert.equals(col,  3,  'failed at #9')

  " #10
  let [c, col] = s:columnmove._pick_up_char_sequential('abcd', 4)
  call g:assert.equals(c,   'd', 'failed at #10')
  call g:assert.equals(col,  4,  'failed at #10')

  " #11
  let [c, col] = s:columnmove._pick_up_char_sequential('abcde', 1)
  call g:assert.equals(c,   'a', 'failed at #11')
  call g:assert.equals(col,  1,  'failed at #11')

  " #12
  let [c, col] = s:columnmove._pick_up_char_sequential('abcde', 2)
  call g:assert.equals(c,   'b', 'failed at #12')
  call g:assert.equals(col,  2,  'failed at #12')

  " #13
  let [c, col] = s:columnmove._pick_up_char_sequential('abcde', 3)
  call g:assert.equals(c,   'c', 'failed at #13')
  call g:assert.equals(col,  3,  'failed at #13')

  " #14
  let [c, col] = s:columnmove._pick_up_char_sequential('abcde', 4)
  call g:assert.equals(c,   'd', 'failed at #14')
  call g:assert.equals(col,  4,  'failed at #14')

  " #15
  let [c, col] = s:columnmove._pick_up_char_sequential('abcde', 5)
  call g:assert.equals(c,   'e', 'failed at #15')
  call g:assert.equals(col,  5,  'failed at #15')

  " #16
  let [c, col] = s:columnmove._pick_up_char_sequential('abcdef', 1)
  call g:assert.equals(c,   'a', 'failed at #16')
  call g:assert.equals(col,  1,  'failed at #16')

  " #17
  let [c, col] = s:columnmove._pick_up_char_sequential('abcdef', 2)
  call g:assert.equals(c,   'b', 'failed at #17')
  call g:assert.equals(col,  2,  'failed at #17')

  " #18
  let [c, col] = s:columnmove._pick_up_char_sequential('abcdef', 3)
  call g:assert.equals(c,   'c', 'failed at #18')
  call g:assert.equals(col,  3,  'failed at #18')

  " #19
  let [c, col] = s:columnmove._pick_up_char_sequential('abcdef', 4)
  call g:assert.equals(c,   'd', 'failed at #19')
  call g:assert.equals(col,  4,  'failed at #19')

  " #20
  let [c, col] = s:columnmove._pick_up_char_sequential('abcdef', 5)
  call g:assert.equals(c,   'e', 'failed at #20')
  call g:assert.equals(col,  5,  'failed at #20')

  " #21
  let [c, col] = s:columnmove._pick_up_char_sequential('abcdef', 6)
  call g:assert.equals(c,   'f', 'failed at #21')
  call g:assert.equals(col,  6,  'failed at #21')

  " #22
  set tabstop=4
  let [c, col] = s:columnmove._pick_up_char_sequential('		a', 1)
  call g:assert.equals(c,   '	', 'failed at #22')
  call g:assert.equals(col,   1, 'failed at #22')

  " #23
  set tabstop=4
  let [c, col] = s:columnmove._pick_up_char_sequential('		a', 2)
  call g:assert.equals(c,   '	', 'failed at #23')
  call g:assert.equals(col,   1, 'failed at #23')

  " #24
  set tabstop=4
  let [c, col] = s:columnmove._pick_up_char_sequential('		a', 3)
  call g:assert.equals(c,   '	', 'failed at #24')
  call g:assert.equals(col,   1, 'failed at #24')

  " #25
  set tabstop=4
  let [c, col] = s:columnmove._pick_up_char_sequential('		a', 4)
  call g:assert.equals(c,   '	', 'failed at #25')
  call g:assert.equals(col,   1, 'failed at #25')

  " #26
  set tabstop=4
  let [c, col] = s:columnmove._pick_up_char_sequential('		a', 5)
  call g:assert.equals(c,   '	', 'failed at #26')
  call g:assert.equals(col,   2, 'failed at #26')

  " #27
  set tabstop=4
  let [c, col] = s:columnmove._pick_up_char_sequential('		a', 6)
  call g:assert.equals(c,   '	', 'failed at #27')
  call g:assert.equals(col,   2, 'failed at #27')

  " #28
  set tabstop=4
  let [c, col] = s:columnmove._pick_up_char_sequential('		a', 7)
  call g:assert.equals(c,   '	', 'failed at #28')
  call g:assert.equals(col,   2, 'failed at #28')

  " #29
  set tabstop=4
  let [c, col] = s:columnmove._pick_up_char_sequential('		a', 8)
  call g:assert.equals(c,   '	', 'failed at #29')
  call g:assert.equals(col,   2, 'failed at #29')

  " #30
  set tabstop=4
  let [c, col] = s:columnmove._pick_up_char_sequential('		a', 9)
  call g:assert.equals(c,   'a', 'failed at #30')
  call g:assert.equals(col,   3, 'failed at #30')

  " #31
  set tabstop=4
  let [c, col] = s:columnmove._pick_up_char_sequential('	a	', 1)
  call g:assert.equals(c,   '	', 'failed at #31')
  call g:assert.equals(col,   1, 'failed at #31')

  " #32
  set tabstop=4
  let [c, col] = s:columnmove._pick_up_char_sequential('	a	', 2)
  call g:assert.equals(c,   '	', 'failed at #32')
  call g:assert.equals(col,   1, 'failed at #32')

  " #33
  set tabstop=4
  let [c, col] = s:columnmove._pick_up_char_sequential('	a	', 3)
  call g:assert.equals(c,   '	', 'failed at #33')
  call g:assert.equals(col,   1, 'failed at #33')

  " #34
  set tabstop=4
  let [c, col] = s:columnmove._pick_up_char_sequential('	a	', 4)
  call g:assert.equals(c,   '	', 'failed at #34')
  call g:assert.equals(col,   1, 'failed at #34')

  " #35
  set tabstop=4
  let [c, col] = s:columnmove._pick_up_char_sequential('	a	', 5)
  call g:assert.equals(c,   'a', 'failed at #35')
  call g:assert.equals(col,   2, 'failed at #35')

  " #36
  set tabstop=4
  let [c, col] = s:columnmove._pick_up_char_sequential('	a	', 6)
  call g:assert.equals(c,   '	', 'failed at #36')
  call g:assert.equals(col,   3, 'failed at #36')

  " #37
  set tabstop=4
  let [c, col] = s:columnmove._pick_up_char_sequential('	a	', 7)
  call g:assert.equals(c,   '	', 'failed at #37')
  call g:assert.equals(col,   3, 'failed at #37')

  " #38
  set tabstop=4
  let [c, col] = s:columnmove._pick_up_char_sequential('	a	', 8)
  call g:assert.equals(c,   '	', 'failed at #38')
  call g:assert.equals(col,   3, 'failed at #38')

  " #39
  set ambiwidth=single
  let [c, col] = s:columnmove._pick_up_char_sequential('αβγ', 1)
  call g:assert.equals(c,   'α', 'failed at #39')
  call g:assert.equals(col,   1, 'failed at #39')

  " #40
  set ambiwidth=single
  let [c, col] = s:columnmove._pick_up_char_sequential('αβγ', 2)
  call g:assert.equals(c, 'β', 'failed at #40')
  call g:assert.equals(col, strlen('α')+1, 'failed at #40')

  " #41
  set ambiwidth=single
  let [c, col] = s:columnmove._pick_up_char_sequential('αβγ', 3)
  call g:assert.equals(c, 'γ', 'failed at #41')
  call g:assert.equals(col, strlen('αβ')+1, 'failed at #41')

  " #42
  set ambiwidth=double
  let [c, col] = s:columnmove._pick_up_char_sequential('αβγ', 1)
  call g:assert.equals(c,   'α', 'failed at #42')
  call g:assert.equals(col,   1, 'failed at #42')

  " #43
  set ambiwidth=double
  let [c, col] = s:columnmove._pick_up_char_sequential('αβγ', 2)
  call g:assert.equals(c,   'α', 'failed at #43')
  call g:assert.equals(col,   1, 'failed at #43')

  " #44
  set ambiwidth=double
  let [c, col] = s:columnmove._pick_up_char_sequential('αβγ', 3)
  call g:assert.equals(c, 'β', 'failed at #44')
  call g:assert.equals(col, strlen('α')+1, 'failed at #44')

  " #45
  set ambiwidth=double
  let [c, col] = s:columnmove._pick_up_char_sequential('αβγ', 4)
  call g:assert.equals(c, 'β', 'failed at #45')
  call g:assert.equals(col, strlen('α')+1, 'failed at #45')

  " #46
  set ambiwidth=double
  let [c, col] = s:columnmove._pick_up_char_sequential('αβγ', 5)
  call g:assert.equals(c, 'γ', 'failed at #46')
  call g:assert.equals(col, strlen('αβ')+1, 'failed at #46')

  " #47
  set ambiwidth=double
  let [c, col] = s:columnmove._pick_up_char_sequential('αβγ', 6)
  call g:assert.equals(c, 'γ', 'failed at #47')
  call g:assert.equals(col, strlen('αβ')+1, 'failed at #47')
endfunction
"}}}
function! s:suite._pick_up_char_binary() abort  "{{{
  " #1
  let [c, col] = s:columnmove._pick_up_char_binary('a', 1)
  call g:assert.equals(c,   'a', 'failed at #1')
  call g:assert.equals(col,  1,  'failed at #1')

  " #2
  let [c, col] = s:columnmove._pick_up_char_binary('ab', 1)
  call g:assert.equals(c,   'a', 'failed at #2')
  call g:assert.equals(col,  1,  'failed at #2')

  " #3
  let [c, col] = s:columnmove._pick_up_char_binary('ab', 2)
  call g:assert.equals(c,   'b', 'failed at #3')
  call g:assert.equals(col,  2,  'failed at #3')

  " #4
  let [c, col] = s:columnmove._pick_up_char_binary('abc', 1)
  call g:assert.equals(c,   'a', 'failed at #4')
  call g:assert.equals(col,  1,  'failed at #4')

  " #5
  let [c, col] = s:columnmove._pick_up_char_binary('abc', 2)
  call g:assert.equals(c,   'b', 'failed at #5')
  call g:assert.equals(col,  2,  'failed at #5')

  " #6
  let [c, col] = s:columnmove._pick_up_char_binary('abc', 3)
  call g:assert.equals(c,   'c', 'failed at #6')
  call g:assert.equals(col,  3,  'failed at #6')

  " #7
  let [c, col] = s:columnmove._pick_up_char_binary('abcd', 1)
  call g:assert.equals(c,   'a', 'failed at #7')
  call g:assert.equals(col,  1,  'failed at #7')

  " #8
  let [c, col] = s:columnmove._pick_up_char_binary('abcd', 2)
  call g:assert.equals(c,   'b', 'failed at #8')
  call g:assert.equals(col,  2,  'failed at #8')

  " #9
  let [c, col] = s:columnmove._pick_up_char_binary('abcd', 3)
  call g:assert.equals(c,   'c', 'failed at #9')
  call g:assert.equals(col,  3,  'failed at #9')

  " #10
  let [c, col] = s:columnmove._pick_up_char_binary('abcd', 4)
  call g:assert.equals(c,   'd', 'failed at #10')
  call g:assert.equals(col,  4,  'failed at #10')

  " #11
  let [c, col] = s:columnmove._pick_up_char_binary('abcde', 1)
  call g:assert.equals(c,   'a', 'failed at #11')
  call g:assert.equals(col,  1,  'failed at #11')

  " #12
  let [c, col] = s:columnmove._pick_up_char_binary('abcde', 2)
  call g:assert.equals(c,   'b', 'failed at #12')
  call g:assert.equals(col,  2,  'failed at #12')

  " #13
  let [c, col] = s:columnmove._pick_up_char_binary('abcde', 3)
  call g:assert.equals(c,   'c', 'failed at #13')
  call g:assert.equals(col,  3,  'failed at #13')

  " #14
  let [c, col] = s:columnmove._pick_up_char_binary('abcde', 4)
  call g:assert.equals(c,   'd', 'failed at #14')
  call g:assert.equals(col,  4,  'failed at #14')

  " #15
  let [c, col] = s:columnmove._pick_up_char_binary('abcde', 5)
  call g:assert.equals(c,   'e', 'failed at #15')
  call g:assert.equals(col,  5,  'failed at #15')

  " #16
  let [c, col] = s:columnmove._pick_up_char_binary('abcdef', 1)
  call g:assert.equals(c,   'a', 'failed at #16')
  call g:assert.equals(col,  1,  'failed at #16')

  " #17
  let [c, col] = s:columnmove._pick_up_char_binary('abcdef', 2)
  call g:assert.equals(c,   'b', 'failed at #17')
  call g:assert.equals(col,  2,  'failed at #17')

  " #18
  let [c, col] = s:columnmove._pick_up_char_binary('abcdef', 3)
  call g:assert.equals(c,   'c', 'failed at #18')
  call g:assert.equals(col,  3,  'failed at #18')

  " #19
  let [c, col] = s:columnmove._pick_up_char_binary('abcdef', 4)
  call g:assert.equals(c,   'd', 'failed at #19')
  call g:assert.equals(col,  4,  'failed at #19')

  " #20
  let [c, col] = s:columnmove._pick_up_char_binary('abcdef', 5)
  call g:assert.equals(c,   'e', 'failed at #20')
  call g:assert.equals(col,  5,  'failed at #20')

  " #21
  let [c, col] = s:columnmove._pick_up_char_binary('abcdef', 6)
  call g:assert.equals(c,   'f', 'failed at #21')
  call g:assert.equals(col,  6,  'failed at #21')

  " #22
  set tabstop=4
  let [c, col] = s:columnmove._pick_up_char_binary('		a', 1)
  call g:assert.equals(c,   '	', 'failed at #22')
  call g:assert.equals(col,   1, 'failed at #22')

  " #23
  set tabstop=4
  let [c, col] = s:columnmove._pick_up_char_binary('		a', 2)
  call g:assert.equals(c,   '	', 'failed at #23')
  call g:assert.equals(col,   1, 'failed at #23')

  " #24
  set tabstop=4
  let [c, col] = s:columnmove._pick_up_char_binary('		a', 3)
  call g:assert.equals(c,   '	', 'failed at #24')
  call g:assert.equals(col,   1, 'failed at #24')

  " #25
  set tabstop=4
  let [c, col] = s:columnmove._pick_up_char_binary('		a', 4)
  call g:assert.equals(c,   '	', 'failed at #25')
  call g:assert.equals(col,   1, 'failed at #25')

  " #26
  set tabstop=4
  let [c, col] = s:columnmove._pick_up_char_binary('		a', 5)
  call g:assert.equals(c,   '	', 'failed at #26')
  call g:assert.equals(col,   2, 'failed at #26')

  " #27
  set tabstop=4
  let [c, col] = s:columnmove._pick_up_char_binary('		a', 6)
  call g:assert.equals(c,   '	', 'failed at #27')
  call g:assert.equals(col,   2, 'failed at #27')

  " #28
  set tabstop=4
  let [c, col] = s:columnmove._pick_up_char_binary('		a', 7)
  call g:assert.equals(c,   '	', 'failed at #28')
  call g:assert.equals(col,   2, 'failed at #28')

  " #29
  set tabstop=4
  let [c, col] = s:columnmove._pick_up_char_binary('		a', 8)
  call g:assert.equals(c,   '	', 'failed at #29')
  call g:assert.equals(col,   2, 'failed at #29')

  " #30
  set tabstop=4
  let [c, col] = s:columnmove._pick_up_char_binary('		a', 9)
  call g:assert.equals(c,   'a', 'failed at #30')
  call g:assert.equals(col,   3, 'failed at #30')

  " #31
  set tabstop=4
  let [c, col] = s:columnmove._pick_up_char_binary('	a	', 1)
  call g:assert.equals(c,   '	', 'failed at #31')
  call g:assert.equals(col,   1, 'failed at #31')

  " #32
  set tabstop=4
  let [c, col] = s:columnmove._pick_up_char_binary('	a	', 2)
  call g:assert.equals(c,   '	', 'failed at #32')
  call g:assert.equals(col,   1, 'failed at #32')

  " #33
  set tabstop=4
  let [c, col] = s:columnmove._pick_up_char_binary('	a	', 3)
  call g:assert.equals(c,   '	', 'failed at #33')
  call g:assert.equals(col,   1, 'failed at #33')

  " #34
  set tabstop=4
  let [c, col] = s:columnmove._pick_up_char_binary('	a	', 4)
  call g:assert.equals(c,   '	', 'failed at #34')
  call g:assert.equals(col,   1, 'failed at #34')

  " #35
  set tabstop=4
  let [c, col] = s:columnmove._pick_up_char_binary('	a	', 5)
  call g:assert.equals(c,   'a', 'failed at #35')
  call g:assert.equals(col,   2, 'failed at #35')

  " #36
  set tabstop=4
  let [c, col] = s:columnmove._pick_up_char_binary('	a	', 6)
  call g:assert.equals(c,   '	', 'failed at #36')
  call g:assert.equals(col,   3, 'failed at #36')

  " #37
  set tabstop=4
  let [c, col] = s:columnmove._pick_up_char_binary('	a	', 7)
  call g:assert.equals(c,   '	', 'failed at #37')
  call g:assert.equals(col,   3, 'failed at #37')

  " #38
  set tabstop=4
  let [c, col] = s:columnmove._pick_up_char_binary('	a	', 8)
  call g:assert.equals(c,   '	', 'failed at #38')
  call g:assert.equals(col,   3, 'failed at #38')

  " #39
  set ambiwidth=single
  let [c, col] = s:columnmove._pick_up_char_binary('αβγ', 1)
  call g:assert.equals(c,   'α', 'failed at #39')
  call g:assert.equals(col,   1, 'failed at #39')

  " #40
  set ambiwidth=single
  let [c, col] = s:columnmove._pick_up_char_binary('αβγ', 2)
  call g:assert.equals(c, 'β', 'failed at #40')
  call g:assert.equals(col, strlen('α')+1, 'failed at #40')

  " #41
  set ambiwidth=single
  let [c, col] = s:columnmove._pick_up_char_binary('αβγ', 3)
  call g:assert.equals(c, 'γ', 'failed at #41')
  call g:assert.equals(col, strlen('αβ')+1, 'failed at #41')

  " #42
  set ambiwidth=double
  let [c, col] = s:columnmove._pick_up_char_binary('αβγ', 1)
  call g:assert.equals(c,   'α', 'failed at #42')
  call g:assert.equals(col,   1, 'failed at #42')

  " #43
  set ambiwidth=double
  let [c, col] = s:columnmove._pick_up_char_binary('αβγ', 2)
  call g:assert.equals(c,   'α', 'failed at #43')
  call g:assert.equals(col,   1, 'failed at #43')

  " #44
  set ambiwidth=double
  let [c, col] = s:columnmove._pick_up_char_binary('αβγ', 3)
  call g:assert.equals(c, 'β', 'failed at #44')
  call g:assert.equals(col, strlen('α')+1, 'failed at #44')

  " #45
  set ambiwidth=double
  let [c, col] = s:columnmove._pick_up_char_binary('αβγ', 4)
  call g:assert.equals(c, 'β', 'failed at #45')
  call g:assert.equals(col, strlen('α')+1, 'failed at #45')

  " #46
  set ambiwidth=double
  let [c, col] = s:columnmove._pick_up_char_binary('αβγ', 5)
  call g:assert.equals(c, 'γ', 'failed at #46')
  call g:assert.equals(col, strlen('αβ')+1, 'failed at #46')

  " #47
  set ambiwidth=double
  let [c, col] = s:columnmove._pick_up_char_binary('αβγ', 6)
  call g:assert.equals(c, 'γ', 'failed at #47')
  call g:assert.equals(col, strlen('αβ')+1, 'failed at #47')
endfunction
"}}}
function! s:suite.pick_up_char() abort  "{{{
  " #1
  let [c, col] = s:columnmove.pick_up_char('', 0, 0)
  call g:assert.equals(c,   '', 'failed at #1')
  call g:assert.equals(col,  0, 'failed at #1')

  " #2
  let [c, col] = s:columnmove.pick_up_char('', 1, 0)
  call g:assert.equals(c,   '', 'failed at #2')
  call g:assert.equals(col,  0, 'failed at #2')

  " #3
  let [c, col] = s:columnmove.pick_up_char('a', 1, 0)
  call g:assert.equals(c,   'a', 'failed at #3')
  call g:assert.equals(col,  1,  'failed at #3')

  " #4
  let [c, col] = s:columnmove.pick_up_char('a', 2, 0)
  call g:assert.equals(c,   '', 'failed at #4')
  call g:assert.equals(col,  0, 'failed at #4')

  " #5
  let [c, col] = s:columnmove.pick_up_char('ab', 1, 0)
  call g:assert.equals(c,   'a', 'failed at #5')
  call g:assert.equals(col,  1,  'failed at #5')

  " #6
  let [c, col] = s:columnmove.pick_up_char('ab', 2, 0)
  call g:assert.equals(c,   'b', 'failed at #6')
  call g:assert.equals(col,  2,  'failed at #6')

  " #7
  let [c, col] = s:columnmove.pick_up_char('ab', 3, 0)
  call g:assert.equals(c,   '', 'failed at #7')
  call g:assert.equals(col,  0, 'failed at #7')

  " #8
  let [c, col] = s:columnmove.pick_up_char('abc', 1, 0)
  call g:assert.equals(c,   'a', 'failed at #8')
  call g:assert.equals(col,  1,  'failed at #8')

  " #9
  let [c, col] = s:columnmove.pick_up_char('abc', 2, 0)
  call g:assert.equals(c,   'b', 'failed at #9')
  call g:assert.equals(col,  2,  'failed at #9')

  " #10
  let [c, col] = s:columnmove.pick_up_char('abc', 3, 0)
  call g:assert.equals(c,   'c', 'failed at #10')
  call g:assert.equals(col,  3,  'failed at #10')

  " #11
  let [c, col] = s:columnmove.pick_up_char('abc', 4, 0)
  call g:assert.equals(c,   '', 'failed at #11')
  call g:assert.equals(col,  0, 'failed at #11')

  " #12
  let [c, col] = s:columnmove.pick_up_char('abcd', 1, 0)
  call g:assert.equals(c,   'a', 'failed at #12')
  call g:assert.equals(col,  1,  'failed at #12')

  " #13
  let [c, col] = s:columnmove.pick_up_char('abcd', 2, 0)
  call g:assert.equals(c,   'b', 'failed at #13')
  call g:assert.equals(col,  2,  'failed at #13')

  " #14
  let [c, col] = s:columnmove.pick_up_char('abcd', 3, 0)
  call g:assert.equals(c,   'c', 'failed at #14')
  call g:assert.equals(col,  3,  'failed at #14')

  " #15
  let [c, col] = s:columnmove.pick_up_char('abcd', 4, 0)
  call g:assert.equals(c,   'd', 'failed at #15')
  call g:assert.equals(col,  4,  'failed at #15')

  " #16
  let [c, col] = s:columnmove.pick_up_char('abcd', 5, 0)
  call g:assert.equals(c,   '', 'failed at #16')
  call g:assert.equals(col,  0, 'failed at #16')

  " #17
  let [c, col] = s:columnmove.pick_up_char('abcde', 1, 0)
  call g:assert.equals(c,   'a', 'failed at #17')
  call g:assert.equals(col,  1,  'failed at #17')

  " #18
  let [c, col] = s:columnmove.pick_up_char('abcde', 2, 0)
  call g:assert.equals(c,   'b', 'failed at #18')
  call g:assert.equals(col,  2,  'failed at #18')

  " #19
  let [c, col] = s:columnmove.pick_up_char('abcde', 3, 0)
  call g:assert.equals(c,   'c', 'failed at #19')
  call g:assert.equals(col,  3,  'failed at #19')

  " #20
  let [c, col] = s:columnmove.pick_up_char('abcde', 4, 0)
  call g:assert.equals(c,   'd', 'failed at #20')
  call g:assert.equals(col,  4,  'failed at #20')

  " #21
  let [c, col] = s:columnmove.pick_up_char('abcde', 5, 0)
  call g:assert.equals(c,   'e', 'failed at #21')
  call g:assert.equals(col,  5,  'failed at #21')

  " #22
  let [c, col] = s:columnmove.pick_up_char('abcde', 6, 0)
  call g:assert.equals(c,   '', 'failed at #22')
  call g:assert.equals(col,  0, 'failed at #22')

  " #23
  let [c, col] = s:columnmove.pick_up_char('abcdef', 1, 0)
  call g:assert.equals(c,   'a', 'failed at #23')
  call g:assert.equals(col,  1,  'failed at #23')

  " #24
  let [c, col] = s:columnmove.pick_up_char('abcdef', 2, 0)
  call g:assert.equals(c,   'b', 'failed at #24')
  call g:assert.equals(col,  2,  'failed at #24')

  " #25
  let [c, col] = s:columnmove.pick_up_char('abcdef', 3, 0)
  call g:assert.equals(c,   'c', 'failed at #25')
  call g:assert.equals(col,  3,  'failed at #25')

  " #26
  let [c, col] = s:columnmove.pick_up_char('abcdef', 4, 0)
  call g:assert.equals(c,   'd', 'failed at #26')
  call g:assert.equals(col,  4,  'failed at #26')

  " #27
  let [c, col] = s:columnmove.pick_up_char('abcdef', 5, 0)
  call g:assert.equals(c,   'e', 'failed at #27')
  call g:assert.equals(col,  5,  'failed at #27')

  " #28
  let [c, col] = s:columnmove.pick_up_char('abcdef', 6, 0)
  call g:assert.equals(c,   'f', 'failed at #28')
  call g:assert.equals(col,  6,  'failed at #28')

  " #29
  let [c, col] = s:columnmove.pick_up_char('abcdef', 7, 0)
  call g:assert.equals(c,   '', 'failed at #29')
  call g:assert.equals(col,  0, 'failed at #29')

  " #30
  set tabstop=4
  let [c, col] = s:columnmove.pick_up_char('		a', 1, 0)
  call g:assert.equals(c,   '	', 'failed at #30')
  call g:assert.equals(col,   1, 'failed at #30')

  " #31
  set tabstop=4
  let [c, col] = s:columnmove.pick_up_char('		a', 2, 0)
  call g:assert.equals(c,   '	', 'failed at #31')
  call g:assert.equals(col,   1, 'failed at #31')

  " #32
  set tabstop=4
  let [c, col] = s:columnmove.pick_up_char('		a', 3, 0)
  call g:assert.equals(c,   '	', 'failed at #32')
  call g:assert.equals(col,   1, 'failed at #32')

  " #33
  set tabstop=4
  let [c, col] = s:columnmove.pick_up_char('		a', 4, 0)
  call g:assert.equals(c,   '	', 'failed at #33')
  call g:assert.equals(col,   1, 'failed at #33')

  " #34
  set tabstop=4
  let [c, col] = s:columnmove.pick_up_char('		a', 5, 0)
  call g:assert.equals(c,   '	', 'failed at #34')
  call g:assert.equals(col,   2, 'failed at #34')

  " #35
  set tabstop=4
  let [c, col] = s:columnmove.pick_up_char('		a', 6, 0)
  call g:assert.equals(c,   '	', 'failed at #35')
  call g:assert.equals(col,   2, 'failed at #35')

  " #36
  set tabstop=4
  let [c, col] = s:columnmove.pick_up_char('		a', 7, 0)
  call g:assert.equals(c,   '	', 'failed at #36')
  call g:assert.equals(col,   2, 'failed at #36')

  " #37
  set tabstop=4
  let [c, col] = s:columnmove.pick_up_char('		a', 8, 0)
  call g:assert.equals(c,   '	', 'failed at #37')
  call g:assert.equals(col,   2, 'failed at #37')

  " #38
  set tabstop=4
  let [c, col] = s:columnmove.pick_up_char('		a', 9, 0)
  call g:assert.equals(c,   'a', 'failed at #38')
  call g:assert.equals(col,   3, 'failed at #38')

  " #39
  set tabstop=4
  let [c, col] = s:columnmove.pick_up_char('		a', 10, 0)
  call g:assert.equals(c,   '', 'failed at #39')
  call g:assert.equals(col,  0, 'failed at #39')

  " #40
  set tabstop=4
  let [c, col] = s:columnmove.pick_up_char('	a	', 1, 0)
  call g:assert.equals(c,   '	', 'failed at #40')
  call g:assert.equals(col,   1, 'failed at #40')

  " #41
  set tabstop=4
  let [c, col] = s:columnmove.pick_up_char('	a	', 2, 0)
  call g:assert.equals(c,   '	', 'failed at #41')
  call g:assert.equals(col,   1, 'failed at #41')

  " #42
  set tabstop=4
  let [c, col] = s:columnmove.pick_up_char('	a	', 3, 0)
  call g:assert.equals(c,   '	', 'failed at #42')
  call g:assert.equals(col,   1, 'failed at #42')

  " #43
  set tabstop=4
  let [c, col] = s:columnmove.pick_up_char('	a	', 4, 0)
  call g:assert.equals(c,   '	', 'failed at #43')
  call g:assert.equals(col,   1, 'failed at #43')

  " #44
  set tabstop=4
  let [c, col] = s:columnmove.pick_up_char('	a	', 5, 0)
  call g:assert.equals(c,   'a', 'failed at #44')
  call g:assert.equals(col,   2, 'failed at #44')

  " #45
  set tabstop=4
  let [c, col] = s:columnmove.pick_up_char('	a	', 6, 0)
  call g:assert.equals(c,   '	', 'failed at #45')
  call g:assert.equals(col,   3, 'failed at #45')

  " #46
  set tabstop=4
  let [c, col] = s:columnmove.pick_up_char('	a	', 7, 0)
  call g:assert.equals(c,   '	', 'failed at #46')
  call g:assert.equals(col,   3, 'failed at #46')

  " #47
  set tabstop=4
  let [c, col] = s:columnmove.pick_up_char('	a	', 8, 0)
  call g:assert.equals(c,   '	', 'failed at #47')
  call g:assert.equals(col,   3, 'failed at #47')

  " #48
  set tabstop=4
  let [c, col] = s:columnmove.pick_up_char('	a	', 9, 0)
  call g:assert.equals(c,   '', 'failed at #48')
  call g:assert.equals(col,  0, 'failed at #48')

  " #49
  set ambiwidth=single
  let [c, col] = s:columnmove.pick_up_char('αβγ', 1, 0)
  call g:assert.equals(c,   'α', 'failed at #49')
  call g:assert.equals(col,   1, 'failed at #49')

  " #50
  set ambiwidth=single
  let [c, col] = s:columnmove.pick_up_char('αβγ', 2, 0)
  call g:assert.equals(c, 'β', 'failed at #50')
  call g:assert.equals(col, strlen('α')+1, 'failed at #50')

  " #51
  set ambiwidth=single
  let [c, col] = s:columnmove.pick_up_char('αβγ', 3, 0)
  call g:assert.equals(c, 'γ', 'failed at #51')
  call g:assert.equals(col, strlen('αβ')+1, 'failed at #51')

  " #52
  set ambiwidth=single
  let [c, col] = s:columnmove.pick_up_char('αβγ', 4, 0)
  call g:assert.equals(c,  '', 'failed at #52')
  call g:assert.equals(col, 0, 'failed at #52')

  " #53
  set ambiwidth=double
  let [c, col] = s:columnmove.pick_up_char('αβγ', 1, 0)
  call g:assert.equals(c,   'α', 'failed at #53')
  call g:assert.equals(col,   1, 'failed at #53')

  " #54
  set ambiwidth=double
  let [c, col] = s:columnmove.pick_up_char('αβγ', 2, 0)
  call g:assert.equals(c,   'α', 'failed at #54')
  call g:assert.equals(col,   1, 'failed at #54')

  " #55
  set ambiwidth=double
  let [c, col] = s:columnmove.pick_up_char('αβγ', 3, 0)
  call g:assert.equals(c, 'β', 'failed at #55')
  call g:assert.equals(col, strlen('α')+1, 'failed at #55')

  " #56
  set ambiwidth=double
  let [c, col] = s:columnmove.pick_up_char('αβγ', 4, 0)
  call g:assert.equals(c, 'β', 'failed at #56')
  call g:assert.equals(col, strlen('α')+1, 'failed at #56')

  " #57
  set ambiwidth=double
  let [c, col] = s:columnmove.pick_up_char('αβγ', 5, 0)
  call g:assert.equals(c, 'γ', 'failed at #57')
  call g:assert.equals(col, strlen('αβ')+1, 'failed at #57')

  " #58
  set ambiwidth=double
  let [c, col] = s:columnmove.pick_up_char('αβγ', 6, 0)
  call g:assert.equals(c, 'γ', 'failed at #58')
  call g:assert.equals(col, strlen('αβ')+1, 'failed at #58')

  " #59
  set ambiwidth=double
  let [c, col] = s:columnmove.pick_up_char('αβγ', 7, 0)
  call g:assert.equals(c,  '', 'failed at #59')
  call g:assert.equals(col, 0, 'failed at #59')
endfunction
"}}}
function! s:suite.open_fold_forward() abort "{{{
  " #1
  let baseline  = 1
  let startline = 2
  let endline   = 3
  let level     = 0
  call append(0, ['a', 'b', 'c'])
  2,3fold
  let opened_fold = s:columnmove.open_fold_forward(baseline, startline, endline, level)
  call g:assert.equals(opened_fold, [], 'failed at #1')
  call g:assert.equals(foldclosed(1), -1, 'failed at #1')
  call g:assert.equals(foldclosed(2), 2, 'failed at #1')
  call g:assert.equals(foldclosed(3), 2, 'failed at #1')
  %delete

  " #2
  let baseline  = 1
  let startline = 2
  let endline   = 3
  let level     = 1
  call append(0, ['a', 'b', 'c'])
  2,3fold
  let opened_fold = s:columnmove.open_fold_forward(baseline, startline, endline, level)
  call g:assert.equals(opened_fold, [[2, 3]], 'failed at #2')
  call g:assert.equals(foldclosed(1), -1, 'failed at #2')
  call g:assert.equals(foldclosed(2), -1, 'failed at #2')
  call g:assert.equals(foldclosed(3), -1, 'failed at #2')
  %delete

  " #3
  let baseline  = 1
  let startline = 2
  let endline   = 5
  let level     = 1
  call append(0, ['a', 'b', 'c', 'd', 'e'])
  2,3fold
  4,5fold
  let opened_fold = s:columnmove.open_fold_forward(baseline, startline, endline, level)
  call g:assert.equals(opened_fold, [[2, 3], [4, 5]], 'failed at #3')
  call g:assert.equals(foldclosed(1), -1, 'failed at #3')
  call g:assert.equals(foldclosed(2), -1, 'failed at #3')
  call g:assert.equals(foldclosed(3), -1, 'failed at #3')
  call g:assert.equals(foldclosed(4), -1, 'failed at #3')
  call g:assert.equals(foldclosed(5), -1, 'failed at #3')
  %delete

  " #4
  let baseline  = 1
  let startline = 2
  let endline   = 5
  let level     = 1
  call append(0, ['a', 'b', 'c', 'd', 'e'])
  3,4fold
  2,5fold
  let opened_fold = s:columnmove.open_fold_forward(baseline, startline, endline, level)
  call g:assert.equals(opened_fold, [[2, 5]], 'failed at #4')
  call g:assert.equals(foldclosed(1), -1, 'failed at #4')
  call g:assert.equals(foldclosed(2), -1, 'failed at #4')
  call g:assert.equals(foldclosed(3),  3, 'failed at #4')
  call g:assert.equals(foldclosed(4),  3, 'failed at #4')
  call g:assert.equals(foldclosed(5), -1, 'failed at #4')
  %delete

  " #5
  let baseline  = 1
  let startline = 2
  let endline   = 5
  let level     = 2
  call append(0, ['a', 'b', 'c', 'd', 'e'])
  3,4fold
  2,5fold
  let opened_fold = s:columnmove.open_fold_forward(baseline, startline, endline, level)
  call g:assert.equals(opened_fold, [[2, 5], [3, 4]], 'failed at #5')
  call g:assert.equals(foldclosed(1), -1, 'failed at #5')
  call g:assert.equals(foldclosed(2), -1, 'failed at #5')
  call g:assert.equals(foldclosed(3), -1, 'failed at #5')
  call g:assert.equals(foldclosed(4), -1, 'failed at #5')
  call g:assert.equals(foldclosed(5), -1, 'failed at #5')
  %delete

  " #6
  let baseline  = 1
  let startline = 2
  let endline   = 5
  let level     = 1
  call append(0, ['a', 'b', 'c', 'd', 'e'])
  2,5fold
  1,5fold
  1,5foldopen
  let opened_fold = s:columnmove.open_fold_forward(baseline, startline, endline, level)
  call g:assert.equals(opened_fold, [], 'failed at #6')
  call g:assert.equals(foldclosed(1), -1, 'failed at #6')
  call g:assert.equals(foldclosed(2),  2, 'failed at #6')
  call g:assert.equals(foldclosed(3),  2, 'failed at #6')
  call g:assert.equals(foldclosed(4),  2, 'failed at #6')
  call g:assert.equals(foldclosed(5),  2, 'failed at #6')
  %delete

  " #7
  let baseline  = 1
  let startline = 2
  let endline   = 3
  let level     = -1
  call append(0, ['a', 'b', 'c'])
  2,3fold
  let opened_fold = s:columnmove.open_fold_forward(baseline, startline, endline, level)
  call g:assert.equals(opened_fold, [[2, 3]], 'failed at #7')
  call g:assert.equals(foldclosed(1), -1, 'failed at #7')
  call g:assert.equals(foldclosed(2), -1, 'failed at #7')
  call g:assert.equals(foldclosed(3), -1, 'failed at #7')
  %delete

  " #8
  let baseline  = 1
  let startline = 2
  let endline   = 5
  let level     = -1
  call append(0, ['a', 'b', 'c', 'd', 'e'])
  2,3fold
  4,5fold
  let opened_fold = s:columnmove.open_fold_forward(baseline, startline, endline, level)
  call g:assert.equals(opened_fold, [[2, 3], [4, 5]], 'failed at #8')
  call g:assert.equals(foldclosed(1), -1, 'failed at #8')
  call g:assert.equals(foldclosed(2), -1, 'failed at #8')
  call g:assert.equals(foldclosed(3), -1, 'failed at #8')
  call g:assert.equals(foldclosed(4), -1, 'failed at #8')
  call g:assert.equals(foldclosed(5), -1, 'failed at #8')
  %delete

  " #9
  let baseline  = 1
  let startline = 2
  let endline   = 5
  let level     = -1
  call append(0, ['a', 'b', 'c', 'd', 'e'])
  3,4fold
  2,5fold
  let opened_fold = s:columnmove.open_fold_forward(baseline, startline, endline, level)
  call g:assert.equals(opened_fold, [[2, 5]], 'failed at #9')
  call g:assert.equals(foldclosed(1), -1, 'failed at #9')
  call g:assert.equals(foldclosed(2), -1, 'failed at #9')
  call g:assert.equals(foldclosed(3),  3, 'failed at #9')
  call g:assert.equals(foldclosed(4),  3, 'failed at #9')
  call g:assert.equals(foldclosed(5), -1, 'failed at #9')
  %delete

  " #10
  let baseline  = 1
  let startline = 2
  let endline   = 5
  let level     = -2
  call append(0, ['a', 'b', 'c', 'd', 'e'])
  3,4fold
  2,5fold
  let opened_fold = s:columnmove.open_fold_forward(baseline, startline, endline, level)
  call g:assert.equals(opened_fold, [[2, 5], [3, 4]], 'failed at #10')
  call g:assert.equals(foldclosed(1), -1, 'failed at #10')
  call g:assert.equals(foldclosed(2), -1, 'failed at #10')
  call g:assert.equals(foldclosed(3), -1, 'failed at #10')
  call g:assert.equals(foldclosed(4), -1, 'failed at #10')
  call g:assert.equals(foldclosed(5), -1, 'failed at #10')
  %delete

  " #11
  let baseline  = 1
  let startline = 2
  let endline   = 5
  let level     = -1
  call append(0, ['a', 'b', 'c', 'd', 'e'])
  2,5fold
  1,5fold
  1,5foldopen
  let opened_fold = s:columnmove.open_fold_forward(baseline, startline, endline, level)
  call g:assert.equals(opened_fold, [[2, 5]], 'failed at #11')
  call g:assert.equals(foldclosed(1), -1, 'failed at #11')
  call g:assert.equals(foldclosed(2), -1, 'failed at #11')
  call g:assert.equals(foldclosed(3), -1, 'failed at #11')
  call g:assert.equals(foldclosed(4), -1, 'failed at #11')
  call g:assert.equals(foldclosed(5), -1, 'failed at #11')
  %delete
endfunction
"}}}
function! s:suite.open_fold_backward() abort "{{{
  " #1
  let baseline  = 3
  let startline = 2
  let endline   = 1
  let level     = 0
  call append(0, ['a', 'b', 'c'])
  1,2fold
  let opened_fold = s:columnmove.open_fold_backward(baseline, startline, endline, level)
  call g:assert.equals(opened_fold, [], 'failed at #1')
  call g:assert.equals(foldclosed(1),  1, 'failed at #1')
  call g:assert.equals(foldclosed(2),  1, 'failed at #1')
  call g:assert.equals(foldclosed(3), -1, 'failed at #1')
  %delete

  " #2
  let baseline  = 3
  let startline = 2
  let endline   = 1
  let level     = 1
  call append(0, ['a', 'b', 'c'])
  1,2fold
  let opened_fold = s:columnmove.open_fold_backward(baseline, startline, endline, level)
  call g:assert.equals(opened_fold, [[1, 2]], 'failed at #2')
  call g:assert.equals(foldclosed(1), -1, 'failed at #2')
  call g:assert.equals(foldclosed(2), -1, 'failed at #2')
  call g:assert.equals(foldclosed(3), -1, 'failed at #2')
  %delete

  " #3
  let baseline  = 5
  let startline = 4
  let endline   = 1
  let level     = 1
  call append(0, ['a', 'b', 'c', 'd', 'e'])
  1,2fold
  3,4fold
  let opened_fold = s:columnmove.open_fold_backward(baseline, startline, endline, level)
  call g:assert.equals(opened_fold, [[3, 4], [1, 2]], 'failed at #3')
  call g:assert.equals(foldclosed(1), -1, 'failed at #3')
  call g:assert.equals(foldclosed(2), -1, 'failed at #3')
  call g:assert.equals(foldclosed(3), -1, 'failed at #3')
  call g:assert.equals(foldclosed(4), -1, 'failed at #3')
  call g:assert.equals(foldclosed(5), -1, 'failed at #3')
  %delete

  " #4
  let baseline  = 5
  let startline = 4
  let endline   = 1
  let level     = 1
  call append(0, ['a', 'b', 'c', 'd', 'e'])
  2,3fold
  1,4fold
  let opened_fold = s:columnmove.open_fold_backward(baseline, startline, endline, level)
  call g:assert.equals(opened_fold, [[1, 4]], 'failed at #4')
  call g:assert.equals(foldclosed(1), -1, 'failed at #4')
  call g:assert.equals(foldclosed(2),  2, 'failed at #4')
  call g:assert.equals(foldclosed(3),  2, 'failed at #4')
  call g:assert.equals(foldclosed(4), -1, 'failed at #4')
  call g:assert.equals(foldclosed(5), -1, 'failed at #4')
  %delete

  " #5
  let baseline  = 5
  let startline = 4
  let endline   = 1
  let level     = 2
  call append(0, ['a', 'b', 'c', 'd', 'e'])
  2,3fold
  1,4fold
  let opened_fold = s:columnmove.open_fold_backward(baseline, startline, endline, level)
  call g:assert.equals(opened_fold, [[1, 4], [2, 3]], 'failed at #5')
  call g:assert.equals(foldclosed(1), -1, 'failed at #5')
  call g:assert.equals(foldclosed(2), -1, 'failed at #5')
  call g:assert.equals(foldclosed(3), -1, 'failed at #5')
  call g:assert.equals(foldclosed(4), -1, 'failed at #5')
  call g:assert.equals(foldclosed(5), -1, 'failed at #5')
  %delete

  " #6
  let baseline  = 5
  let startline = 4
  let endline   = 1
  let level     = 1
  call append(0, ['a', 'b', 'c', 'd', 'e'])
  1,4fold
  1,5fold
  1,5foldopen
  let opened_fold = s:columnmove.open_fold_backward(baseline, startline, endline, level)
  call g:assert.equals(opened_fold, [], 'failed at #6')
  call g:assert.equals(foldclosed(1),  1, 'failed at #6')
  call g:assert.equals(foldclosed(2),  1, 'failed at #6')
  call g:assert.equals(foldclosed(3),  1, 'failed at #6')
  call g:assert.equals(foldclosed(4),  1, 'failed at #6')
  call g:assert.equals(foldclosed(5), -1, 'failed at #6')
  %delete

  " #7
  let baseline  = 3
  let startline = 2
  let endline   = 1
  let level     = -1
  call append(0, ['a', 'b', 'c'])
  1,2fold
  let opened_fold = s:columnmove.open_fold_backward(baseline, startline, endline, level)
  call g:assert.equals(opened_fold, [[1, 2]], 'failed at #7')
  call g:assert.equals(foldclosed(1), -1, 'failed at #7')
  call g:assert.equals(foldclosed(2), -1, 'failed at #7')
  call g:assert.equals(foldclosed(3), -1, 'failed at #7')
  %delete

  " #8
  let baseline  = 5
  let startline = 4
  let endline   = 1
  let level     = -1
  call append(0, ['a', 'b', 'c', 'd', 'e'])
  1,2fold
  3,4fold
  let opened_fold = s:columnmove.open_fold_backward(baseline, startline, endline, level)
  call g:assert.equals(opened_fold, [[3, 4], [1, 2]], 'failed at #8')
  call g:assert.equals(foldclosed(1), -1, 'failed at #8')
  call g:assert.equals(foldclosed(2), -1, 'failed at #8')
  call g:assert.equals(foldclosed(3), -1, 'failed at #8')
  call g:assert.equals(foldclosed(4), -1, 'failed at #8')
  call g:assert.equals(foldclosed(5), -1, 'failed at #8')
  %delete

  " #9
  let baseline  = 5
  let startline = 4
  let endline   = 1
  let level     = -1
  call append(0, ['a', 'b', 'c', 'd', 'e'])
  2,3fold
  1,4fold
  let opened_fold = s:columnmove.open_fold_backward(baseline, startline, endline, level)
  call g:assert.equals(opened_fold, [[1, 4]], 'failed at #9')
  call g:assert.equals(foldclosed(1), -1, 'failed at #9')
  call g:assert.equals(foldclosed(2),  2, 'failed at #9')
  call g:assert.equals(foldclosed(3),  2, 'failed at #9')
  call g:assert.equals(foldclosed(4), -1, 'failed at #9')
  call g:assert.equals(foldclosed(5), -1, 'failed at #9')
  %delete

  " #10
  let baseline  = 5
  let startline = 4
  let endline   = 1
  let level     = -2
  call append(0, ['a', 'b', 'c', 'd', 'e'])
  2,3fold
  1,4fold
  let opened_fold = s:columnmove.open_fold_backward(baseline, startline, endline, level)
  call g:assert.equals(opened_fold, [[1, 4], [2, 3]], 'failed at #10')
  call g:assert.equals(foldclosed(1), -1, 'failed at #10')
  call g:assert.equals(foldclosed(2), -1, 'failed at #10')
  call g:assert.equals(foldclosed(3), -1, 'failed at #10')
  call g:assert.equals(foldclosed(4), -1, 'failed at #10')
  call g:assert.equals(foldclosed(5), -1, 'failed at #10')
  %delete

  " #11
  let baseline  = 5
  let startline = 4
  let endline   = 1
  let level     = -1
  call append(0, ['a', 'b', 'c', 'd', 'e'])
  1,4fold
  1,5fold
  1,5foldopen
  let opened_fold = s:columnmove.open_fold_backward(baseline, startline, endline, level)
  call g:assert.equals(opened_fold, [[1, 4]], 'failed at #11')
  call g:assert.equals(foldclosed(1), -1, 'failed at #11')
  call g:assert.equals(foldclosed(2), -1, 'failed at #11')
  call g:assert.equals(foldclosed(3), -1, 'failed at #11')
  call g:assert.equals(foldclosed(4), -1, 'failed at #11')
  call g:assert.equals(foldclosed(5), -1, 'failed at #11')
  %delete
endfunction
"}}}
function! s:suite.scan_forward() abort  "{{{
  " #1
  call append(0, ['a'])
  let candidates = []
  let startline  = 1
  let endline    = 1
  let curswant   = 1
  let l:count    = 1
  let ignorecase = 0
  call s:columnmove.scan_forward(candidates, startline, endline, curswant, l:count, ignorecase)
  call g:assert.equals(map(copy(candidates), 'v:val["c"]'),    ['a'], 'failed at #1')
  call g:assert.equals(map(copy(candidates), 'v:val["lnum"]'),   [1], 'failed at #1')
  call g:assert.equals(map(copy(candidates), 'v:val["col"]'),    [1], 'failed at #1')
  %delete

  " #2
  call append(0, ['abc', 'def', 'ghi'])
  let candidates = []
  let startline  = 1
  let endline    = 3
  let curswant   = 1
  let l:count    = 1
  let ignorecase = 0
  call s:columnmove.scan_forward(candidates, startline, endline, curswant, l:count, ignorecase)
  call g:assert.equals(map(copy(candidates), 'v:val.c'),    ['a', 'd', 'g'], 'failed at #2')
  call g:assert.equals(map(copy(candidates), 'v:val.lnum'), [  1,   2,   3], 'failed at #2')
  call g:assert.equals(map(copy(candidates), 'v:val.col'),  [  1,   1,   1], 'failed at #2')
  %delete

  " #3
  call append(0, ['abc', 'def', 'ghi'])
  let candidates = []
  let startline  = 1
  let endline    = 3
  let curswant   = 2
  let l:count    = 1
  let ignorecase = 0
  call s:columnmove.scan_forward(candidates, startline, endline, curswant, l:count, ignorecase)
  call g:assert.equals(map(copy(candidates), 'v:val.c'),    ['b', 'e', 'h'], 'failed at #3')
  call g:assert.equals(map(copy(candidates), 'v:val.lnum'), [  1,   2,   3], 'failed at #3')
  call g:assert.equals(map(copy(candidates), 'v:val.col'),  [  2,   2,   2], 'failed at #3')
  %delete

  " #4
  call append(0, ['abc', 'def', 'ghi'])
  let candidates = []
  let startline  = 1
  let endline    = 3
  let curswant   = 3
  let l:count    = 1
  let ignorecase = 0
  call s:columnmove.scan_forward(candidates, startline, endline, curswant, l:count, ignorecase)
  call g:assert.equals(map(copy(candidates), 'v:val.c'),    ['c', 'f', 'i'], 'failed at #4')
  call g:assert.equals(map(copy(candidates), 'v:val.lnum'), [  1,   2,   3], 'failed at #4')
  call g:assert.equals(map(copy(candidates), 'v:val.col'),  [  3,   3,   3], 'failed at #4')
  %delete

  " #5
  call append(0, ['a', 'a', 'A'])
  let candidates = []
  let startline  = 1
  let endline    = 3
  let curswant   = 1
  let l:count    = 1
  let ignorecase = 0
  call s:columnmove.scan_forward(candidates, startline, endline, curswant, l:count, ignorecase)
  call g:assert.equals(map(copy(candidates), 'v:val.c'),    ['a', 'A'], 'failed at #5')
  call g:assert.equals(map(copy(candidates), 'v:val.lnum'), [  1,   3], 'failed at #5')
  call g:assert.equals(map(copy(candidates), 'v:val.col'),  [  1,   1], 'failed at #5')
  %delete

  " #6
  call append(0, ['a', 'a', 'A'])
  let candidates = []
  let startline  = 1
  let endline    = 3
  let curswant   = 1
  let l:count    = 2
  let ignorecase = 0
  call s:columnmove.scan_forward(candidates, startline, endline, curswant, l:count, ignorecase)
  call g:assert.equals(map(copy(candidates), 'v:val.c'),    ['a'], 'failed at #6')
  call g:assert.equals(map(copy(candidates), 'v:val.lnum'), [  2], 'failed at #6')
  call g:assert.equals(map(copy(candidates), 'v:val.col'),  [  1], 'failed at #6')
  %delete

  " #7
  call append(0, ['a', 'a', 'A'])
  let candidates = []
  let startline  = 1
  let endline    = 3
  let curswant   = 1
  let l:count    = 3
  let ignorecase = 0
  call s:columnmove.scan_forward(candidates, startline, endline, curswant, l:count, ignorecase)
  call g:assert.equals(map(copy(candidates), 'v:val.c'),    [], 'failed at #7')
  call g:assert.equals(map(copy(candidates), 'v:val.lnum'), [], 'failed at #7')
  call g:assert.equals(map(copy(candidates), 'v:val.col'),  [], 'failed at #7')
  %delete

  " #8
  call append(0, ['a', 'a', 'A'])
  let candidates = []
  let startline  = 1
  let endline    = 3
  let curswant   = 1
  let l:count    = 1
  let ignorecase = 1
  call s:columnmove.scan_forward(candidates, startline, endline, curswant, l:count, ignorecase)
  call g:assert.equals(map(copy(candidates), 'v:val.c'),    ['a'], 'failed at #8')
  call g:assert.equals(map(copy(candidates), 'v:val.lnum'), [  1], 'failed at #8')
  call g:assert.equals(map(copy(candidates), 'v:val.col'),  [  1], 'failed at #8')
  %delete

  " #9
  call append(0, ['a', 'a', 'A'])
  let candidates = []
  let startline  = 1
  let endline    = 3
  let curswant   = 1
  let l:count    = 2
  let ignorecase = 1
  call s:columnmove.scan_forward(candidates, startline, endline, curswant, l:count, ignorecase)
  call g:assert.equals(map(copy(candidates), 'v:val.c'),    ['a'], 'failed at #9')
  call g:assert.equals(map(copy(candidates), 'v:val.lnum'), [  2], 'failed at #9')
  call g:assert.equals(map(copy(candidates), 'v:val.col'),  [  1], 'failed at #9')
  %delete

  " #10
  call append(0, ['a', 'a', 'A'])
  let candidates = []
  let startline  = 1
  let endline    = 3
  let curswant   = 1
  let l:count    = 3
  let ignorecase = 1
  call s:columnmove.scan_forward(candidates, startline, endline, curswant, l:count, ignorecase)
  call g:assert.equals(map(copy(candidates), 'v:val.c'),    ['A'], 'failed at #10')
  call g:assert.equals(map(copy(candidates), 'v:val.lnum'), [  3], 'failed at #10')
  call g:assert.equals(map(copy(candidates), 'v:val.col'),  [  1], 'failed at #10')
  %delete
endfunction
"}}}
function! s:suite.scan_backward() abort  "{{{
  " #1
  call append(0, ['a'])
  let candidates = []
  let startline  = 1
  let endline    = 1
  let curswant   = 1
  let l:count    = 1
  let ignorecase = 0
  call s:columnmove.scan_backward(candidates, startline, endline, curswant, l:count, ignorecase)
  call g:assert.equals(map(copy(candidates), 'v:val["c"]'),    ['a'], 'failed at #1')
  call g:assert.equals(map(copy(candidates), 'v:val["lnum"]'),   [1], 'failed at #1')
  call g:assert.equals(map(copy(candidates), 'v:val["col"]'),    [1], 'failed at #1')
  %delete

  " #2
  call append(0, ['abc', 'def', 'ghi'])
  let candidates = []
  let startline  = 3
  let endline    = 1
  let curswant   = 1
  let l:count    = 1
  let ignorecase = 0
  call s:columnmove.scan_backward(candidates, startline, endline, curswant, l:count, ignorecase)
  call g:assert.equals(map(copy(candidates), 'v:val.c'),    ['g', 'd', 'a'], 'failed at #2')
  call g:assert.equals(map(copy(candidates), 'v:val.lnum'), [  3,   2,   1], 'failed at #2')
  call g:assert.equals(map(copy(candidates), 'v:val.col'),  [  1,   1,   1], 'failed at #2')
  %delete

  " #3
  call append(0, ['abc', 'def', 'ghi'])
  let candidates = []
  let startline  = 3
  let endline    = 1
  let curswant   = 2
  let l:count    = 1
  let ignorecase = 0
  call s:columnmove.scan_backward(candidates, startline, endline, curswant, l:count, ignorecase)
  call g:assert.equals(map(copy(candidates), 'v:val.c'),    ['h', 'e', 'b'], 'failed at #3')
  call g:assert.equals(map(copy(candidates), 'v:val.lnum'), [  3,   2,   1], 'failed at #3')
  call g:assert.equals(map(copy(candidates), 'v:val.col'),  [  2,   2,   2], 'failed at #3')
  %delete

  " #4
  call append(0, ['abc', 'def', 'ghi'])
  let candidates = []
  let startline  = 3
  let endline    = 1
  let curswant   = 3
  let l:count    = 1
  let ignorecase = 0
  call s:columnmove.scan_backward(candidates, startline, endline, curswant, l:count, ignorecase)
  call g:assert.equals(map(copy(candidates), 'v:val.c'),    ['i', 'f', 'c'], 'failed at #4')
  call g:assert.equals(map(copy(candidates), 'v:val.lnum'), [  3,   2,   1], 'failed at #4')
  call g:assert.equals(map(copy(candidates), 'v:val.col'),  [  3,   3,   3], 'failed at #4')
  %delete

  " #5
  call append(0, ['a', 'a', 'A'])
  let candidates = []
  let startline  = 3
  let endline    = 1
  let curswant   = 1
  let l:count    = 1
  let ignorecase = 0
  call s:columnmove.scan_backward(candidates, startline, endline, curswant, l:count, ignorecase)
  call g:assert.equals(map(copy(candidates), 'v:val.c'),    ['A', 'a'], 'failed at #5')
  call g:assert.equals(map(copy(candidates), 'v:val.lnum'), [  3,   2], 'failed at #5')
  call g:assert.equals(map(copy(candidates), 'v:val.col'),  [  1,   1], 'failed at #5')
  %delete

  " #6
  call append(0, ['a', 'a', 'A'])
  let candidates = []
  let startline  = 3
  let endline    = 1
  let curswant   = 1
  let l:count    = 2
  let ignorecase = 0
  call s:columnmove.scan_backward(candidates, startline, endline, curswant, l:count, ignorecase)
  call g:assert.equals(map(copy(candidates), 'v:val.c'),    ['a'], 'failed at #6')
  call g:assert.equals(map(copy(candidates), 'v:val.lnum'), [  1], 'failed at #6')
  call g:assert.equals(map(copy(candidates), 'v:val.col'),  [  1], 'failed at #6')
  %delete

  " #7
  call append(0, ['a', 'a', 'A'])
  let candidates = []
  let startline  = 3
  let endline    = 1
  let curswant   = 1
  let l:count    = 3
  let ignorecase = 0
  call s:columnmove.scan_backward(candidates, startline, endline, curswant, l:count, ignorecase)
  call g:assert.equals(map(copy(candidates), 'v:val.c'),    [], 'failed at #7')
  call g:assert.equals(map(copy(candidates), 'v:val.lnum'), [], 'failed at #7')
  call g:assert.equals(map(copy(candidates), 'v:val.col'),  [], 'failed at #7')
  %delete

  " #8
  call append(0, ['a', 'a', 'A'])
  let candidates = []
  let startline  = 3
  let endline    = 1
  let curswant   = 1
  let l:count    = 1
  let ignorecase = 1
  call s:columnmove.scan_backward(candidates, startline, endline, curswant, l:count, ignorecase)
  call g:assert.equals(map(copy(candidates), 'v:val.c'),    ['A'], 'failed at #8')
  call g:assert.equals(map(copy(candidates), 'v:val.lnum'), [  3], 'failed at #8')
  call g:assert.equals(map(copy(candidates), 'v:val.col'),  [  1], 'failed at #8')
  %delete

  " #9
  call append(0, ['a', 'a', 'A'])
  let candidates = []
  let startline  = 3
  let endline    = 1
  let curswant   = 1
  let l:count    = 2
  let ignorecase = 1
  call s:columnmove.scan_backward(candidates, startline, endline, curswant, l:count, ignorecase)
  call g:assert.equals(map(copy(candidates), 'v:val.c'),    ['a'], 'failed at #9')
  call g:assert.equals(map(copy(candidates), 'v:val.lnum'), [  2], 'failed at #9')
  call g:assert.equals(map(copy(candidates), 'v:val.col'),  [  1], 'failed at #9')
  %delete

  " #10
  call append(0, ['a', 'a', 'A'])
  let candidates = []
  let startline  = 3
  let endline    = 1
  let curswant   = 1
  let l:count    = 3
  let ignorecase = 1
  call s:columnmove.scan_backward(candidates, startline, endline, curswant, l:count, ignorecase)
  call g:assert.equals(map(copy(candidates), 'v:val.c'),    ['a'], 'failed at #10')
  call g:assert.equals(map(copy(candidates), 'v:val.lnum'), [  1], 'failed at #10')
  call g:assert.equals(map(copy(candidates), 'v:val.col'),  [  1], 'failed at #10')
  %delete
endfunction
"}}}
function! s:suite.search_char_in_section_forward() abort  "{{{
  " #1
  call append(0, ['a'])
  let char        = 'a'
  let charlist    = []
  let sectionhead = 1
  let sectiontail = line('$')
  let curswant    = 1
  let l:count     = 1
  let ignorecase  = 0
  let [lnum, col] = s:columnmove.search_char_in_section_forward(char, charlist, sectionhead, sectiontail, curswant, l:count, ignorecase)
  call g:assert.equals(lnum, 1, 'failed at #1')
  call g:assert.equals(col,  1, 'failed at #1')
  %delete

  " #2
  call append(0, ['abc', 'def', 'ghi'])
  let char        = 'a'
  let charlist    = []
  let sectionhead = 1
  let sectiontail = 3
  let curswant    = 1
  let l:count     = 1
  let ignorecase  = 0
  let [lnum, col] = s:columnmove.search_char_in_section_forward(char, charlist, sectionhead, sectiontail, curswant, l:count, ignorecase)
  call g:assert.equals(lnum, 1, 'failed at #2')
  call g:assert.equals(col,  1, 'failed at #2')
  %delete

  " #3
  call append(0, ['abc', 'def', 'ghi'])
  let char        = 'd'
  let charlist    = []
  let sectionhead = 1
  let sectiontail = 3
  let curswant    = 1
  let l:count     = 1
  let ignorecase  = 0
  let [lnum, col] = s:columnmove.search_char_in_section_forward(char, charlist, sectionhead, sectiontail, curswant, l:count, ignorecase)
  call g:assert.equals(lnum, 2, 'failed at #3')
  call g:assert.equals(col,  1, 'failed at #3')
  %delete

  " #4
  call append(0, ['abc', 'def', 'ghi'])
  let char        = 'g'
  let charlist    = []
  let sectionhead = 1
  let sectiontail = 3
  let curswant    = 1
  let l:count     = 1
  let ignorecase  = 0
  let [lnum, col] = s:columnmove.search_char_in_section_forward(char, charlist, sectionhead, sectiontail, curswant, l:count, ignorecase)
  call g:assert.equals(lnum, 3, 'failed at #4')
  call g:assert.equals(col,  1, 'failed at #4')
  %delete

  " #5
  call append(0, ['abc', 'def', 'ghi'])
  let char        = 'a'
  let charlist    = []
  let sectionhead = 1
  let sectiontail = 3
  let curswant    = 2
  let l:count     = 1
  let ignorecase  = 0
  let [lnum, col] = s:columnmove.search_char_in_section_forward(char, charlist, sectionhead, sectiontail, curswant, l:count, ignorecase)
  call g:assert.equals(lnum, 4, 'failed at #5')
  call g:assert.equals(col,  0, 'failed at #5')
  %delete

  " #6
  call append(0, ['abc', 'def', 'ghi'])
  let char        = 'b'
  let charlist    = []
  let sectionhead = 1
  let sectiontail = 3
  let curswant    = 2
  let l:count     = 1
  let ignorecase  = 0
  let [lnum, col] = s:columnmove.search_char_in_section_forward(char, charlist, sectionhead, sectiontail, curswant, l:count, ignorecase)
  call g:assert.equals(lnum, 1, 'failed at #6')
  call g:assert.equals(col,  2, 'failed at #6')
  %delete

  " #7
  call append(0, ['abc', 'def', 'ghi'])
  let char        = 'e'
  let charlist    = []
  let sectionhead = 1
  let sectiontail = 3
  let curswant    = 2
  let l:count     = 1
  let ignorecase  = 0
  let [lnum, col] = s:columnmove.search_char_in_section_forward(char, charlist, sectionhead, sectiontail, curswant, l:count, ignorecase)
  call g:assert.equals(lnum, 2, 'failed at #7')
  call g:assert.equals(col,  2, 'failed at #7')
  %delete

  " #8
  call append(0, ['abc', 'def', 'ghi'])
  let char        = 'h'
  let charlist    = []
  let sectionhead = 1
  let sectiontail = 3
  let curswant    = 2
  let l:count     = 1
  let ignorecase  = 0
  let [lnum, col] = s:columnmove.search_char_in_section_forward(char, charlist, sectionhead, sectiontail, curswant, l:count, ignorecase)
  call g:assert.equals(lnum, 3, 'failed at #8')
  call g:assert.equals(col,  2, 'failed at #8')
  %delete

  " #9
  call append(0, ['abc', 'def', 'ghi'])
  let char        = 'g'
  let charlist    = []
  let sectionhead = 1
  let sectiontail = 3
  let curswant    = 2
  let l:count     = 1
  let ignorecase  = 0
  let [lnum, col] = s:columnmove.search_char_in_section_forward(char, charlist, sectionhead, sectiontail, curswant, l:count, ignorecase)
  call g:assert.equals(lnum, 4, 'failed at #9')
  call g:assert.equals(col,  0, 'failed at #9')
  %delete

  " #10
  call append(0, ['abc', 'def', 'ghi'])
  let char        = 'c'
  let charlist    = []
  let sectionhead = 1
  let sectiontail = 3
  let curswant    = 3
  let l:count     = 1
  let ignorecase  = 0
  let [lnum, col] = s:columnmove.search_char_in_section_forward(char, charlist, sectionhead, sectiontail, curswant, l:count, ignorecase)
  call g:assert.equals(lnum, 1, 'failed at #10')
  call g:assert.equals(col,  3, 'failed at #10')
  %delete

  " #11
  call append(0, ['abc', 'def', 'ghi'])
  let char        = 'f'
  let charlist    = []
  let sectionhead = 1
  let sectiontail = 3
  let curswant    = 3
  let l:count     = 1
  let ignorecase  = 0
  let [lnum, col] = s:columnmove.search_char_in_section_forward(char, charlist, sectionhead, sectiontail, curswant, l:count, ignorecase)
  call g:assert.equals(lnum, 2, 'failed at #11')
  call g:assert.equals(col,  3, 'failed at #11')
  %delete

  " #12
  call append(0, ['abc', 'def', 'ghi'])
  let char        = 'i'
  let charlist    = []
  let sectionhead = 1
  let sectiontail = 3
  let curswant    = 3
  let l:count     = 1
  let ignorecase  = 0
  let [lnum, col] = s:columnmove.search_char_in_section_forward(char, charlist, sectionhead, sectiontail, curswant, l:count, ignorecase)
  call g:assert.equals(lnum, 3, 'failed at #12')
  call g:assert.equals(col,  3, 'failed at #12')
  %delete

  " #13
  call append(0, ['abc', 'def', 'ghi'])
  let char        = 'a'
  let charlist    = []
  let sectionhead = 1
  let sectiontail = 3
  let curswant    = 3
  let l:count     = 1
  let ignorecase  = 0
  let [lnum, col] = s:columnmove.search_char_in_section_forward(char, charlist, sectionhead, sectiontail, curswant, l:count, ignorecase)
  call g:assert.equals(lnum, 4, 'failed at #13')
  call g:assert.equals(col,  0, 'failed at #13')
  %delete

  " #14
  call append(0, ['a', 'a', 'A'])
  let char        = 'a'
  let charlist    = []
  let sectionhead = 1
  let sectiontail = 3
  let curswant    = 1
  let l:count     = 2
  let ignorecase  = 0
  let [lnum, col] = s:columnmove.search_char_in_section_forward(char, charlist, sectionhead, sectiontail, curswant, l:count, ignorecase)
  call g:assert.equals(lnum, 2, 'failed at #14')
  call g:assert.equals(col,  1, 'failed at #14')
  %delete

  " #15
  call append(0, ['a', 'a', 'A'])
  let char        = 'a'
  let charlist    = []
  let sectionhead = 1
  let sectiontail = 3
  let curswant    = 1
  let l:count     = 3
  let ignorecase  = 0
  let [lnum, col] = s:columnmove.search_char_in_section_forward(char, charlist, sectionhead, sectiontail, curswant, l:count, ignorecase)
  call g:assert.equals(lnum, 4, 'failed at #15')
  call g:assert.equals(col,  0, 'failed at #15')
  %delete

  " #16
  call append(0, ['a', 'a', 'A'])
  let char        = 'a'
  let charlist    = []
  let sectionhead = 1
  let sectiontail = 3
  let curswant    = 1
  let l:count     = 2
  let ignorecase  = 1
  let [lnum, col] = s:columnmove.search_char_in_section_forward(char, charlist, sectionhead, sectiontail, curswant, l:count, ignorecase)
  call g:assert.equals(lnum, 2, 'failed at #16')
  call g:assert.equals(col,  1, 'failed at #16')
  %delete

  " #17
  call append(0, ['a', 'a', 'A'])
  let char        = 'a'
  let charlist    = []
  let sectionhead = 1
  let sectiontail = 3
  let curswant    = 1
  let l:count     = 3
  let ignorecase  = 1
  let [lnum, col] = s:columnmove.search_char_in_section_forward(char, charlist, sectionhead, sectiontail, curswant, l:count, ignorecase)
  call g:assert.equals(lnum, 3, 'failed at #17')
  call g:assert.equals(col,  1, 'failed at #17')
  %delete
endfunction
"}}}
function! s:suite.search_char_in_section_backward() abort  "{{{
  " #1
  call append(0, ['a'])
  let char        = 'a'
  let charlist    = []
  let sectionhead = 1
  let sectiontail = 1
  let curswant    = 1
  let l:count     = 1
  let ignorecase  = 0
  let [lnum, col] = s:columnmove.search_char_in_section_backward(char, charlist, sectionhead, sectiontail, curswant, l:count, ignorecase)
  call g:assert.equals(lnum, 1, 'failed at #1')
  call g:assert.equals(col,  1, 'failed at #1')
  %delete

  " #2
  call append(0, ['abc', 'def', 'ghi'])
  let char        = 'a'
  let charlist    = []
  let sectionhead = 3
  let sectiontail = 1
  let curswant    = 1
  let l:count     = 1
  let ignorecase  = 0
  let [lnum, col] = s:columnmove.search_char_in_section_backward(char, charlist, sectionhead, sectiontail, curswant, l:count, ignorecase)
  call g:assert.equals(lnum, 1, 'failed at #2')
  call g:assert.equals(col,  1, 'failed at #2')
  %delete

  " #3
  call append(0, ['abc', 'def', 'ghi'])
  let char        = 'd'
  let charlist    = []
  let sectionhead = 3
  let sectiontail = 1
  let curswant    = 1
  let l:count     = 1
  let ignorecase  = 0
  let [lnum, col] = s:columnmove.search_char_in_section_backward(char, charlist, sectionhead, sectiontail, curswant, l:count, ignorecase)
  call g:assert.equals(lnum, 2, 'failed at #3')
  call g:assert.equals(col,  1, 'failed at #3')
  %delete

  " #4
  call append(0, ['abc', 'def', 'ghi'])
  let char        = 'g'
  let charlist    = []
  let sectionhead = 3
  let sectiontail = 1
  let curswant    = 1
  let l:count     = 1
  let ignorecase  = 0
  let [lnum, col] = s:columnmove.search_char_in_section_backward(char, charlist, sectionhead, sectiontail, curswant, l:count, ignorecase)
  call g:assert.equals(lnum, 3, 'failed at #4')
  call g:assert.equals(col,  1, 'failed at #4')
  %delete

  " #5
  call append(0, ['abc', 'def', 'ghi'])
  let char        = 'a'
  let charlist    = []
  let sectionhead = 3
  let sectiontail = 1
  let curswant    = 2
  let l:count     = 1
  let ignorecase  = 0
  let [lnum, col] = s:columnmove.search_char_in_section_backward(char, charlist, sectionhead, sectiontail, curswant, l:count, ignorecase)
  call g:assert.equals(lnum, 0, 'failed at #5')
  call g:assert.equals(col,  0, 'failed at #5')
  %delete

  " #6
  call append(0, ['abc', 'def', 'ghi'])
  let char        = 'b'
  let charlist    = []
  let sectionhead = 3
  let sectiontail = 1
  let curswant    = 2
  let l:count     = 1
  let ignorecase  = 0
  let [lnum, col] = s:columnmove.search_char_in_section_backward(char, charlist, sectionhead, sectiontail, curswant, l:count, ignorecase)
  call g:assert.equals(lnum, 1, 'failed at #6')
  call g:assert.equals(col,  2, 'failed at #6')
  %delete

  " #7
  call append(0, ['abc', 'def', 'ghi'])
  let char        = 'e'
  let charlist    = []
  let sectionhead = 3
  let sectiontail = 1
  let curswant    = 2
  let l:count     = 1
  let ignorecase  = 0
  let [lnum, col] = s:columnmove.search_char_in_section_backward(char, charlist, sectionhead, sectiontail, curswant, l:count, ignorecase)
  call g:assert.equals(lnum, 2, 'failed at #7')
  call g:assert.equals(col,  2, 'failed at #7')
  %delete

  " #8
  call append(0, ['abc', 'def', 'ghi'])
  let char        = 'h'
  let charlist    = []
  let sectionhead = 3
  let sectiontail = 1
  let curswant    = 2
  let l:count     = 1
  let ignorecase  = 0
  let [lnum, col] = s:columnmove.search_char_in_section_backward(char, charlist, sectionhead, sectiontail, curswant, l:count, ignorecase)
  call g:assert.equals(lnum, 3, 'failed at #8')
  call g:assert.equals(col,  2, 'failed at #8')
  %delete

  " #9
  call append(0, ['abc', 'def', 'ghi'])
  let char        = 'g'
  let charlist    = []
  let sectionhead = 3
  let sectiontail = 1
  let curswant    = 2
  let l:count     = 1
  let ignorecase  = 0
  let [lnum, col] = s:columnmove.search_char_in_section_backward(char, charlist, sectionhead, sectiontail, curswant, l:count, ignorecase)
  call g:assert.equals(lnum, 0, 'failed at #9')
  call g:assert.equals(col,  0, 'failed at #9')
  %delete

  " #10
  call append(0, ['abc', 'def', 'ghi'])
  let char        = 'c'
  let charlist    = []
  let sectionhead = 3
  let sectiontail = 1
  let curswant    = 3
  let l:count     = 1
  let ignorecase  = 0
  let [lnum, col] = s:columnmove.search_char_in_section_backward(char, charlist, sectionhead, sectiontail, curswant, l:count, ignorecase)
  call g:assert.equals(lnum, 1, 'failed at #10')
  call g:assert.equals(col,  3, 'failed at #10')
  %delete

  " #11
  call append(0, ['abc', 'def', 'ghi'])
  let char        = 'f'
  let charlist    = []
  let sectionhead = 3
  let sectiontail = 1
  let curswant    = 3
  let l:count     = 1
  let ignorecase  = 0
  let [lnum, col] = s:columnmove.search_char_in_section_backward(char, charlist, sectionhead, sectiontail, curswant, l:count, ignorecase)
  call g:assert.equals(lnum, 2, 'failed at #11')
  call g:assert.equals(col,  3, 'failed at #11')
  %delete

  " #12
  call append(0, ['abc', 'def', 'ghi'])
  let char        = 'i'
  let charlist    = []
  let sectionhead = 3
  let sectiontail = 1
  let curswant    = 3
  let l:count     = 1
  let ignorecase  = 0
  let [lnum, col] = s:columnmove.search_char_in_section_backward(char, charlist, sectionhead, sectiontail, curswant, l:count, ignorecase)
  call g:assert.equals(lnum, 3, 'failed at #12')
  call g:assert.equals(col,  3, 'failed at #12')
  %delete

  " #13
  call append(0, ['abc', 'def', 'ghi'])
  let char        = 'a'
  let charlist    = []
  let sectionhead = 3
  let sectiontail = 1
  let curswant    = 3
  let l:count     = 1
  let ignorecase  = 0
  let [lnum, col] = s:columnmove.search_char_in_section_backward(char, charlist, sectionhead, sectiontail, curswant, l:count, ignorecase)
  call g:assert.equals(lnum, 0, 'failed at #13')
  call g:assert.equals(col,  0, 'failed at #13')
  %delete

  " #14
  call append(0, ['a', 'a', 'A'])
  let char        = 'a'
  let charlist    = []
  let sectionhead = 3
  let sectiontail = 1
  let curswant    = 1
  let l:count     = 2
  let ignorecase  = 0
  let [lnum, col] = s:columnmove.search_char_in_section_backward(char, charlist, sectionhead, sectiontail, curswant, l:count, ignorecase)
  call g:assert.equals(lnum, 1, 'failed at #14')
  call g:assert.equals(col,  1, 'failed at #14')
  %delete

  " #15
  call append(0, ['a', 'a', 'A'])
  let char        = 'a'
  let charlist    = []
  let sectionhead = 3
  let sectiontail = 1
  let curswant    = 1
  let l:count     = 3
  let ignorecase  = 0
  let [lnum, col] = s:columnmove.search_char_in_section_backward(char, charlist, sectionhead, sectiontail, curswant, l:count, ignorecase)
  call g:assert.equals(lnum, 0, 'failed at #15')
  call g:assert.equals(col,  0, 'failed at #15')
  %delete

  " #16
  call append(0, ['a', 'a', 'A'])
  let char        = 'a'
  let charlist    = []
  let sectionhead = 3
  let sectiontail = 1
  let curswant    = 1
  let l:count     = 2
  let ignorecase  = 1
  let [lnum, col] = s:columnmove.search_char_in_section_backward(char, charlist, sectionhead, sectiontail, curswant, l:count, ignorecase)
  call g:assert.equals(lnum, 2, 'failed at #16')
  call g:assert.equals(col,  1, 'failed at #16')
  %delete

  " #17
  call append(0, ['a', 'a', 'A'])
  let char        = 'a'
  let charlist    = []
  let sectionhead = 3
  let sectiontail = 1
  let curswant    = 1
  let l:count     = 3
  let ignorecase  = 1
  let [lnum, col] = s:columnmove.search_char_in_section_backward(char, charlist, sectionhead, sectiontail, curswant, l:count, ignorecase)
  call g:assert.equals(lnum, 1, 'failed at #17')
  call g:assert.equals(col,  1, 'failed at #17')
  %delete
endfunction
"}}}
" function! s:suite.scroll_down_view() abort  "{{{
"   new
"   resize 3

"   " #1
"   call append(0, ['a', 'b', 'c'])
"   $delete
"   normal! 1Gzt
"   call s:columnmove.scroll_down_view(1)
"   call g:assert.equals(line('w0'), 1, 'failed at #1')
"   call g:assert.equals(line('w$'), 3, 'failed at #1')
"   %delete

"   " #2
"   call append(0, ['a', 'b', 'c', 'd'])
"   $delete
"   normal! 1Gzt
"   call s:columnmove.scroll_down_view(1)
"   call g:assert.equals(line('w0'), 2, 'failed at #2')
"   call g:assert.equals(line('w$'), 4, 'failed at #2')
"   %delete

"   " #3
"   call append(0, ['a', 'b'])
"   $delete
"   normal! 1Gzt
"   call s:columnmove.scroll_down_view(1)
"   call g:assert.equals(line('w0'), 1, 'failed at #3')
"   call g:assert.equals(line('w$'), 2, 'failed at #3')
"   %delete

"   " #4
"   call append(0, ['a', 'b', 'c'])
"   $delete
"   normal! 1Gzt
"   call s:columnmove.scroll_down_view(3)
"   call g:assert.equals(line('w0'), 1, 'failed at #4')
"   call g:assert.equals(line('w$'), 3, 'failed at #4')
"   %delete

"   " #5
"   call append(0, ['a', 'b', 'c', 'd', 'e', 'f'])
"   $delete
"   normal! 1Gzt
"   call s:columnmove.scroll_down_view(3)
"   call g:assert.equals(line('w0'), 4, 'failed at #5')
"   call g:assert.equals(line('w$'), 6, 'failed at #5')
"   %delete

"   " #6
"   call append(0, ['a', 'b', 'c', 'd', 'e'])
"   $delete
"   normal! 1Gzt
"   call s:columnmove.scroll_down_view(3)
"   call g:assert.equals(line('w0'), 3, 'failed at #6')
"   call g:assert.equals(line('w$'), 5, 'failed at #6')
"   %delete

"   " #7
"   call append(0, ['a', 'b', 'c', 'd'])
"   $delete
"   normal! 1Gzt
"   call s:columnmove.scroll_down_view(3)
"   call g:assert.equals(line('w0'), 2, 'failed at #7')
"   call g:assert.equals(line('w$'), 4, 'failed at #7')
"   %delete

"   " #8
"   call append(0, ['a', 'b'])
"   $delete
"   normal! 1Gzt
"   call s:columnmove.scroll_down_view(3)
"   call g:assert.equals(line('w0'), 1, 'failed at #8')
"   call g:assert.equals(line('w$'), 2, 'failed at #8')
"   %delete
" endfunction
" "}}}
" function! s:suite.scroll_up_view() abort  "{{{
"   new
"   resize 3

"   " #1
"   call append(0, ['a', 'b', 'c'])
"   $delete
"   normal! Gzb
"   call s:columnmove.scroll_up_view(1)
"   call g:assert.equals(line('w0'), 1, 'failed at #1')
"   call g:assert.equals(line('w$'), 3, 'failed at #1')
"   %delete

"   " #2
"   call append(0, ['a', 'b', 'c', 'd'])
"   $delete
"   normal! Gzb
"   call s:columnmove.scroll_up_view(1)
"   call g:assert.equals(line('w0'), 1, 'failed at #2')
"   call g:assert.equals(line('w$'), 3, 'failed at #2')
"   %delete

"   " #3
"   call append(0, ['a', 'b'])
"   $delete
"   normal! Gzb
"   call s:columnmove.scroll_up_view(1)
"   call g:assert.equals(line('w0'), 1, 'failed at #3')
"   call g:assert.equals(line('w$'), 2, 'failed at #3')
"   %delete

"   " #4
"   call append(0, ['a', 'b', 'c'])
"   $delete
"   normal! Gzb
"   call s:columnmove.scroll_up_view(3)
"   call g:assert.equals(line('w0'), 1, 'failed at #4')
"   call g:assert.equals(line('w$'), 3, 'failed at #4')
"   %delete

"   " #5
"   call append(0, ['a', 'b', 'c', 'd', 'e', 'f'])
"   $delete
"   normal! Gzb
"   call s:columnmove.scroll_up_view(3)
"   call g:assert.equals(line('w0'), 1, 'failed at #5')
"   call g:assert.equals(line('w$'), 3, 'failed at #5')
"   %delete

"   " #6
"   call append(0, ['a', 'b', 'c', 'd', 'e'])
"   $delete
"   normal! Gzb
"   call s:columnmove.scroll_up_view(3)
"   call g:assert.equals(line('w0'), 1, 'failed at #6')
"   call g:assert.equals(line('w$'), 3, 'failed at #6')
"   %delete

"   " #7
"   call append(0, ['a', 'b', 'c', 'd'])
"   $delete
"   normal! Gzb
"   call s:columnmove.scroll_up_view(3)
"   call g:assert.equals(line('w0'), 1, 'failed at #7')
"   call g:assert.equals(line('w$'), 3, 'failed at #7')
"   %delete

"   " #8
"   call append(0, ['a', 'b'])
"   $delete
"   normal! Gzb
"   call s:columnmove.scroll_up_view(3)
"   call g:assert.equals(line('w0'), 1, 'failed at #8')
"   call g:assert.equals(line('w$'), 2, 'failed at #8')
"   %delete
" endfunction
" "}}}
function! s:suite.search_beyond_border_in_section_forward() abort "{{{
  let opt = {'strict_wbege': 1}

  " #1
  call append(0, ['a'])
  $delete
  let current     = {'lnum': 1, 'col': 0, 'class': -1, 'count': 0, 'dest': 0}
  let last        = {}
  let sectionhead = 1
  let sectiontail = 1
  let Check_char  = s:columnmove.check_char_w
  let curswant    = 1
  let l:count     = 1
  let opt.fold_treatment = 0
  let opt.stop_on_space  = 1
  let [current, last] = s:columnmove.search_beyond_border_in_section_forward(current, last, Check_char, sectionhead, sectiontail, curswant, l:count, opt)
  call g:assert.equals(current.dest, 0, 'failed at #1 (current.dest)')
  %delete

  " #2
  call append(0, ['a', 'b'])
  $delete
  let current     = {'lnum': 1, 'col': 0, 'class': -1, 'count': 0, 'dest': 0}
  let last        = {}
  let sectionhead = 1
  let sectiontail = line('$')
  let Check_char  = s:columnmove.check_char_w
  let curswant    = 1
  let l:count     = 1
  let opt.fold_treatment = 0
  let opt.stop_on_space  = 1
  let [current, last] = s:columnmove.search_beyond_border_in_section_forward(current, last, Check_char, sectionhead, sectiontail, curswant, l:count, opt)
  call g:assert.equals(current.lnum, 3, 'failed at #2 (current.lnum)')
  call g:assert.equals(current.dest, 0, 'failed at #2 (current.dest)')
  call g:assert.equals(last.lnum,    2, 'failed at #2 (last.lnum)')
  %delete

  " #3
  call append(0, ['a', ':'])
  $delete
  let current     = {'lnum': 1, 'col': 0, 'class': -1, 'count': 0, 'dest': 0}
  let last        = {}
  let sectionhead = 1
  let sectiontail = line('$')
  let Check_char  = s:columnmove.check_char_w
  let curswant    = 1
  let l:count     = 1
  let opt.fold_treatment = 0
  let opt.stop_on_space  = 1
  let [current, last] = s:columnmove.search_beyond_border_in_section_forward(current, last, Check_char, sectionhead, sectiontail, curswant, l:count, opt)
  call g:assert.equals(current.lnum, 2, 'failed at #3 (current.lnum)')
  call g:assert.equals(current.col,  1, 'failed at #3 (current.col)')
  call g:assert.equals(current.dest, 1, 'failed at #3 (current.dest)')
  call g:assert.equals(last.lnum,    1, 'failed at #3 (last.lnum)')
  %delete

  " #4
  call append(0, ['a', ' '])
  $delete
  let current     = {'lnum': 1, 'col': 0, 'class': -1, 'count': 0, 'dest': 0}
  let last        = {}
  let sectionhead = 1
  let sectiontail = line('$')
  let Check_char  = s:columnmove.check_char_w
  let curswant    = 1
  let l:count     = 1
  let opt.fold_treatment = 0
  let opt.stop_on_space  = 1
  let [current, last] = s:columnmove.search_beyond_border_in_section_forward(current, last, Check_char, sectionhead, sectiontail, curswant, l:count, opt)
  call g:assert.equals(current.lnum, 3, 'failed at #4 (current.lnum)')
  call g:assert.equals(current.dest, 0, 'failed at #4 (current.dest)')
  call g:assert.equals(last.lnum,    2, 'failed at #4 (last.lnum)')
  %delete

  " #5
  call append(0, ['a', ''])
  $delete
  let current     = {'lnum': 1, 'col': 0, 'class': -1, 'count': 0, 'dest': 0}
  let last        = {}
  let sectionhead = 1
  let sectiontail = line('$')
  let Check_char  = s:columnmove.check_char_w
  let curswant    = 1
  let l:count     = 1
  let opt.fold_treatment = 0
  let opt.stop_on_space  = 1
  let [current, last] = s:columnmove.search_beyond_border_in_section_forward(current, last, Check_char, sectionhead, sectiontail, curswant, l:count, opt)
  call g:assert.equals(current.lnum, 3, 'failed at #5 (current.lnum)')
  call g:assert.equals(current.dest, 0, 'failed at #5 (current.dest)')
  call g:assert.equals(last.lnum,    2, 'failed at #5 (last.lnum)')
  %delete

  " #6
  call append(0, [' ', 'b'])
  $delete
  let current     = {'lnum': 1, 'col': 0, 'class': -1, 'count': 0, 'dest': 0}
  let last        = {}
  let sectionhead = 1
  let sectiontail = line('$')
  let Check_char  = s:columnmove.check_char_w
  let curswant    = 1
  let l:count     = 1
  let opt.fold_treatment = 0
  let opt.stop_on_space  = 1
  let [current, last] = s:columnmove.search_beyond_border_in_section_forward(current, last, Check_char, sectionhead, sectiontail, curswant, l:count, opt)
  call g:assert.equals(current.lnum, 2, 'failed at #6 (current.lnum)')
  call g:assert.equals(current.col,  1, 'failed at #6 (current.col)')
  call g:assert.equals(current.dest, 1, 'failed at #6 (current.dest)')
  call g:assert.equals(last.lnum,    1, 'failed at #6 (last.lnum)')
  %delete

  " #7
  call append(0, [' ', ':'])
  $delete
  let current     = {'lnum': 1, 'col': 0, 'class': -1, 'count': 0, 'dest': 0}
  let last        = {}
  let sectionhead = 1
  let sectiontail = line('$')
  let Check_char  = s:columnmove.check_char_w
  let curswant    = 1
  let l:count     = 1
  let opt.fold_treatment = 0
  let opt.stop_on_space  = 1
  let [current, last] = s:columnmove.search_beyond_border_in_section_forward(current, last, Check_char, sectionhead, sectiontail, curswant, l:count, opt)
  call g:assert.equals(current.lnum, 2, 'failed at #7 (current.lnum)')
  call g:assert.equals(current.col,  1, 'failed at #7 (current.col)')
  call g:assert.equals(current.dest, 1, 'failed at #7 (current.dest)')
  call g:assert.equals(last.lnum,    1, 'failed at #7 (last.lnum)')
  %delete

  " #8
  call append(0, [' ', ' '])
  $delete
  let current     = {'lnum': 1, 'col': 0, 'class': -1, 'count': 0, 'dest': 0}
  let last        = {}
  let sectionhead = 1
  let sectiontail = line('$')
  let Check_char  = s:columnmove.check_char_w
  let curswant    = 1
  let l:count     = 1
  let opt.fold_treatment = 0
  let opt.stop_on_space  = 1
  let [current, last] = s:columnmove.search_beyond_border_in_section_forward(current, last, Check_char, sectionhead, sectiontail, curswant, l:count, opt)
  call g:assert.equals(current.lnum, 3, 'failed at #8 (current.lnum)')
  call g:assert.equals(current.dest, 0, 'failed at #8 (current.dest)')
  call g:assert.equals(last.lnum,    2, 'failed at #8 (last.lnum)')
  %delete

  " #9
  call append(0, [' ', ''])
  $delete
  let current     = {'lnum': 1, 'col': 0, 'class': -1, 'count': 0, 'dest': 0}
  let last        = {}
  let sectionhead = 1
  let sectiontail = line('$')
  let Check_char  = s:columnmove.check_char_w
  let curswant    = 1
  let l:count     = 1
  let opt.fold_treatment = 0
  let opt.stop_on_space  = 1
  let [current, last] = s:columnmove.search_beyond_border_in_section_forward(current, last, Check_char, sectionhead, sectiontail, curswant, l:count, opt)
  call g:assert.equals(current.lnum, 3, 'failed at #9 (current.lnum)')
  call g:assert.equals(current.dest, 0, 'failed at #9 (current.dest)')
  call g:assert.equals(last.lnum,    2, 'failed at #9 (last.lnum)')
  %delete

  " #10
  call append(0, ['abc', 'def', 'ghi'])
  $delete
  let current     = {'lnum': 1, 'col': 0, 'class': -1, 'count': 0, 'dest': 0}
  let last        = {}
  let sectionhead = 1
  let sectiontail = line('$')
  let Check_char  = s:columnmove.check_char_w
  let curswant    = 2
  let l:count     = 1
  let opt.fold_treatment = 0
  let opt.stop_on_space  = 1
  let [current, last] = s:columnmove.search_beyond_border_in_section_forward(current, last, Check_char, sectionhead, sectiontail, curswant, l:count, opt)
  call g:assert.equals(current.lnum, 4, 'failed at #10 (current.lnum)')
  call g:assert.equals(current.dest, 0, 'failed at #10 (current.dest)')
  call g:assert.equals(last.lnum,    3, 'failed at #10 (last.lnum)')
  %delete

  " #11
  call append(0, ['abc', 'def', 'ghi'])
  $delete
  let current     = {'lnum': 1, 'col': 0, 'class': -1, 'count': 0, 'dest': 0}
  let last        = {}
  let sectionhead = 1
  let sectiontail = line('$')
  let Check_char  = s:columnmove.check_char_w
  let curswant    = 3
  let l:count     = 1
  let opt.fold_treatment = 0
  let opt.stop_on_space  = 1
  let [current, last] = s:columnmove.search_beyond_border_in_section_forward(current, last, Check_char, sectionhead, sectiontail, curswant, l:count, opt)
  call g:assert.equals(current.lnum, 4, 'failed at #11 (current.lnum)')
  call g:assert.equals(current.dest, 0, 'failed at #11 (current.dest)')
  call g:assert.equals(last.lnum,    3, 'failed at #11 (last.lnum)')
  %delete

  " #12
  call append(0, ['abc', ':::', 'def'])
  $delete
  let current     = {'lnum': 1, 'col': 0, 'class': -1, 'count': 0, 'dest': 0}
  let last        = {}
  let sectionhead = 1
  let sectiontail = line('$')
  let Check_char  = s:columnmove.check_char_w
  let curswant    = 2
  let l:count     = 1
  let opt.fold_treatment = 0
  let opt.stop_on_space  = 1
  let [current, last] = s:columnmove.search_beyond_border_in_section_forward(current, last, Check_char, sectionhead, sectiontail, curswant, l:count, opt)
  call g:assert.equals(current.lnum, 2, 'failed at #12 (current.lnum)')
  call g:assert.equals(current.col,  2, 'failed at #12 (current.col)')
  call g:assert.equals(current.dest, 1, 'failed at #12 (current.dest)')
  call g:assert.equals(last.lnum,    1, 'failed at #12 (last.lnum)')
  %delete

  " #13
  call append(0, ['abc', ':::', 'def'])
  $delete
  let current     = {'lnum': 1, 'col': 0, 'class': -1, 'count': 0, 'dest': 0}
  let last        = {}
  let sectionhead = 1
  let sectiontail = line('$')
  let Check_char  = s:columnmove.check_char_w
  let curswant    = 3
  let l:count     = 1
  let opt.fold_treatment = 0
  let opt.stop_on_space  = 1
  let [current, last] = s:columnmove.search_beyond_border_in_section_forward(current, last, Check_char, sectionhead, sectiontail, curswant, l:count, opt)
  call g:assert.equals(current.lnum, 2, 'failed at #13 (current.lnum)')
  call g:assert.equals(current.col,  3, 'failed at #13 (current.col)')
  call g:assert.equals(current.dest, 1, 'failed at #13 (current.dest)')
  call g:assert.equals(last.lnum,    1, 'failed at #13 (last.lnum)')
  %delete

  " #14
  call append(0, ['abc', '   ', 'def'])
  $delete
  let current     = {'lnum': 1, 'col': 0, 'class': -1, 'count': 0, 'dest': 0}
  let last        = {}
  let sectionhead = 1
  let sectiontail = line('$')
  let Check_char  = s:columnmove.check_char_w
  let curswant    = 2
  let l:count     = 1
  let opt.fold_treatment = 0
  let opt.stop_on_space  = 1
  let [current, last] = s:columnmove.search_beyond_border_in_section_forward(current, last, Check_char, sectionhead, sectiontail, curswant, l:count, opt)
  call g:assert.equals(current.lnum, 3, 'failed at #14 (current.lnum)')
  call g:assert.equals(current.col,  2, 'failed at #14 (current.col)')
  call g:assert.equals(current.dest, 1, 'failed at #14 (current.dest)')
  call g:assert.equals(last.lnum,    2, 'failed at #14 (last.lnum)')
  %delete

  " #15
  call append(0, ['abc', '   ', 'def'])
  $delete
  let current     = {'lnum': 1, 'col': 0, 'class': -1, 'count': 0, 'dest': 0}
  let last        = {}
  let sectionhead = 1
  let sectiontail = line('$')
  let Check_char  = s:columnmove.check_char_w
  let curswant    = 3
  let l:count     = 1
  let opt.fold_treatment = 0
  let opt.stop_on_space  = 1
  let [current, last] = s:columnmove.search_beyond_border_in_section_forward(current, last, Check_char, sectionhead, sectiontail, curswant, l:count, opt)
  call g:assert.equals(current.lnum, 3, 'failed at #15 (current.lnum)')
  call g:assert.equals(current.col,  3, 'failed at #15 (current.col)')
  call g:assert.equals(current.dest, 1, 'failed at #15 (current.dest)')
  call g:assert.equals(last.lnum,    2, 'failed at #15 (last.lnum)')
  %delete

  " #16
  call append(0, ['abc', '', 'def'])
  $delete
  let current     = {'lnum': 1, 'col': 0, 'class': -1, 'count': 0, 'dest': 0}
  let last        = {}
  let sectionhead = 1
  let sectiontail = line('$')
  let Check_char  = s:columnmove.check_char_w
  let curswant    = 2
  let l:count     = 1
  let opt.fold_treatment = 0
  let opt.stop_on_space  = 1
  let [current, last] = s:columnmove.search_beyond_border_in_section_forward(current, last, Check_char, sectionhead, sectiontail, curswant, l:count, opt)
  call g:assert.equals(current.lnum, 3, 'failed at #16 (current.lnum)')
  call g:assert.equals(current.col,  2, 'failed at #16 (current.col)')
  call g:assert.equals(current.dest, 1, 'failed at #16 (current.dest)')
  call g:assert.equals(last.lnum,    2, 'failed at #16 (last.lnum)')
  %delete

  " #17
  call append(0, ['abc', '', 'def'])
  $delete
  let current     = {'lnum': 1, 'col': 0, 'class': -1, 'count': 0, 'dest': 0}
  let last        = {}
  let sectionhead = 1
  let sectiontail = line('$')
  let Check_char  = s:columnmove.check_char_w
  let curswant    = 3
  let l:count     = 1
  let opt.fold_treatment = 0
  let opt.stop_on_space  = 1
  let [current, last] = s:columnmove.search_beyond_border_in_section_forward(current, last, Check_char, sectionhead, sectiontail, curswant, l:count, opt)
  call g:assert.equals(current.lnum, 3, 'failed at #17 (current.lnum)')
  call g:assert.equals(current.col,  3, 'failed at #17 (current.col)')
  call g:assert.equals(current.dest, 1, 'failed at #17 (current.dest)')
  call g:assert.equals(last.lnum,    2, 'failed at #17 (last.lnum)')
  %delete

  " #18
  call append(0, ['a', ':', 'b', '', 'c'])
  $delete
  let current     = {'lnum': 1, 'col': 0, 'class': -1, 'count': 0, 'dest': 0}
  let last        = {}
  let sectionhead = 1
  let sectiontail = line('$')
  let Check_char  = s:columnmove.check_char_w
  let curswant    = 1
  let l:count     = 2
  let opt.fold_treatment = 0
  let opt.stop_on_space  = 1
  let [current, last] = s:columnmove.search_beyond_border_in_section_forward(current, last, Check_char, sectionhead, sectiontail, curswant, l:count, opt)
  call g:assert.equals(current.lnum, 3, 'failed at #18 (current.lnum)')
  call g:assert.equals(current.col,  1, 'failed at #18 (current.col)')
  call g:assert.equals(current.dest, 1, 'failed at #18 (current.dest)')
  call g:assert.equals(last.lnum,    2, 'failed at #18 (last.lnum)')
  %delete

  " #19
  call append(0, ['a', ':', 'b', '', 'c'])
  $delete
  let current     = {'lnum': 1, 'col': 0, 'class': -1, 'count': 0, 'dest': 0}
  let last        = {}
  let sectionhead = 1
  let sectiontail = 3
  let Check_char  = s:columnmove.check_char_w
  let curswant    = 1
  let l:count     = 2
  let opt.fold_treatment = 0
  let opt.stop_on_space  = 1
  let [current, last] = s:columnmove.search_beyond_border_in_section_forward(current, last, Check_char, sectionhead, sectiontail, curswant, l:count, opt)
  call g:assert.equals(current.lnum, 3, 'failed at #19 (current.lnum)')
  call g:assert.equals(current.col,  1, 'failed at #19 (current.col)')
  call g:assert.equals(current.dest, 1, 'failed at #19 (current.dest)')
  call g:assert.equals(last.lnum,    2, 'failed at #19 (last.lnum)')
  %delete

  " #20
  call append(0, ['a', ':', 'b', '', 'c'])
  $delete
  let current     = {'lnum': 1, 'col': 0, 'class': -1, 'count': 0, 'dest': 0}
  let last        = {}
  let sectionhead = 1
  let sectiontail = 2
  let Check_char  = s:columnmove.check_char_w
  let curswant    = 1
  let l:count     = 2
  let opt.fold_treatment = 0
  let opt.stop_on_space  = 1
  let [current, last] = s:columnmove.search_beyond_border_in_section_forward(current, last, Check_char, sectionhead, sectiontail, curswant, l:count, opt)
  call g:assert.equals(current.lnum, 3, 'failed at #20 (current.lnum)')
  call g:assert.equals(current.dest, 0, 'failed at #20 (current.dest)')
  call g:assert.equals(last.lnum,    2, 'failed at #20 (last.lnum)')
  %delete

  " #21
  call append(0, ['a', ':', 'b', '', 'c'])
  $delete
  let current     = {'lnum': 2, 'col': 0, 'class': -1, 'count': 0, 'dest': 0}
  let last        = {}
  let sectionhead = 2
  let sectiontail = 5
  let Check_char  = s:columnmove.check_char_w
  let curswant    = 1
  let l:count     = 2
  let opt.fold_treatment = 0
  let opt.stop_on_space  = 1
  let [current, last] = s:columnmove.search_beyond_border_in_section_forward(current, last, Check_char, sectionhead, sectiontail, curswant, l:count, opt)
  call g:assert.equals(current.lnum, 5, 'failed at #21 (current.lnum)')
  call g:assert.equals(current.col,  1, 'failed at #21 (current.col)')
  call g:assert.equals(current.dest, 1, 'failed at #21 (current.dest)')
  call g:assert.equals(last.lnum,    4, 'failed at #21 (last.lnum)')
  %delete

  " #22
  call append(0, ['a', ':', 'b', '', 'c'])
  $delete
  let current     = {'lnum': 1, 'col': 0, 'class': -1, 'count': 0, 'dest': 0}
  let last        = {}
  let sectionhead = 1
  let sectiontail = 5
  let Check_char  = s:columnmove.check_char_w
  let curswant    = 1
  let l:count     = 3
  let opt.fold_treatment = 0
  let opt.stop_on_space  = 1
  let [current, last] = s:columnmove.search_beyond_border_in_section_forward(current, last, Check_char, sectionhead, sectiontail, curswant, l:count, opt)
  call g:assert.equals(current.lnum, 5, 'failed at #22 (current.lnum)')
  call g:assert.equals(current.col,  1, 'failed at #22 (current.col)')
  call g:assert.equals(current.dest, 1, 'failed at #22 (current.dest)')
  call g:assert.equals(last.lnum,    4, 'failed at #22 (last.lnum)')
  %delete

  " #23
  call append(0, ['a', ':', 'b', '', 'c'])
  $delete
  let current     = {'lnum': 1, 'col': 0, 'class': -1, 'count': 0, 'dest': 0}
  let last        = {}
  let sectionhead = 1
  let sectiontail = 5
  let Check_char  = s:columnmove.check_char_w
  let curswant    = 1
  let l:count     = 1
  let opt.fold_treatment = 0
  let opt.stop_on_space  = 1
  2,4fold
  let [current, last] = s:columnmove.search_beyond_border_in_section_forward(current, last, Check_char, sectionhead, sectiontail, curswant, l:count, opt)
  call g:assert.equals(current.lnum, 6, 'failed at #23 (current.lnum)')
  call g:assert.equals(current.dest, 0, 'failed at #23 (current.dest)')
  call g:assert.equals(last.lnum,    5, 'failed at #23 (last.lnum)')
  %delete

  " #24
  call append(0, ['a', ':', 'b', '', 'c'])
  $delete
  let current     = {'lnum': 1, 'col': 0, 'class': -1, 'count': 0, 'dest': 0}
  let last        = {}
  let sectionhead = 1
  let sectiontail = 5
  let Check_char  = s:columnmove.check_char_w
  let curswant    = 1
  let l:count     = 1
  let opt.fold_treatment = 1
  let opt.stop_on_space  = 1
  2,4fold
  let [current, last] = s:columnmove.search_beyond_border_in_section_forward(current, last, Check_char, sectionhead, sectiontail, curswant, l:count, opt)
  call g:assert.equals(current.lnum, 5, 'failed at #24 (current.lnum)')
  call g:assert.equals(current.col,  1, 'failed at #24 (current.col)')
  call g:assert.equals(current.dest, 1, 'failed at #24 (current.dest)')
  call g:assert.equals(last.lnum,    2, 'failed at #24 (last.lnum)')
  %delete

  " #25
  call append(0, ['a', ':', 'b', '', 'c'])
  $delete
  let current     = {'lnum': 1, 'col': 0, 'class': -1, 'count': 0, 'dest': 0}
  let last        = {}
  let sectionhead = 1
  let sectiontail = 5
  let Check_char  = s:columnmove.check_char_w
  let curswant    = 1
  let l:count     = 1
  let opt.fold_treatment = 1
  let opt.stop_on_space  = 1
  2,5fold
  let [current, last] = s:columnmove.search_beyond_border_in_section_forward(current, last, Check_char, sectionhead, sectiontail, curswant, l:count, opt)
  call g:assert.equals(current.lnum, 6, 'failed at #25 (current.lnum)')
  call g:assert.equals(current.dest, 0, 'failed at #25 (current.dest)')
  call g:assert.equals(last.lnum,    2, 'failed at #25 (last.lnum)')
  %delete
endfunction
"}}}
function! s:suite.search_beyond_border_in_section_backward() abort  "{{{
  let opt = {'strict_wbege': 1}

  " #1
  call append(0, ['a'])
  $delete
  let current     = {'lnum': line('$'), 'col': 0, 'class': -1, 'count': 0, 'dest': 0}
  let last        = {}
  let sectionhead = 1
  let sectiontail = 1
  let Check_char  = s:columnmove.check_char_w
  let curswant    = 1
  let l:count     = 1
  let opt.fold_treatment = 0
  let opt.stop_on_space  = 1
  let [current, last] = s:columnmove.search_beyond_border_in_section_backward(current, last, Check_char, sectionhead, sectiontail, curswant, l:count, opt)
  call g:assert.equals(current.dest, 0, 'failed at #1 (current.dest)')
  %delete

  " #2
  call append(0, ['a', 'b'])
  $delete
  let current     = {'lnum': line('$'), 'col': 0, 'class': -1, 'count': 0, 'dest': 0}
  let last        = {}
  let sectionhead = line('$')
  let sectiontail = 1
  let Check_char  = s:columnmove.check_char_w
  let curswant    = 1
  let l:count     = 1
  let opt.fold_treatment = 0
  let opt.stop_on_space  = 1
  let [current, last] = s:columnmove.search_beyond_border_in_section_backward(current, last, Check_char, sectionhead, sectiontail, curswant, l:count, opt)
  call g:assert.equals(current.lnum, 0, 'failed at #2 (current.lnum)')
  call g:assert.equals(current.dest, 0, 'failed at #2 (current.dest)')
  call g:assert.equals(last.lnum,    1, 'failed at #2 (last.lnum)')
  %delete

  " #3
  call append(0, ['a', ':'])
  $delete
  let current     = {'lnum': line('$'), 'col': 0, 'class': -1, 'count': 0, 'dest': 0}
  let last        = {}
  let sectionhead = line('$')
  let sectiontail = 1
  let Check_char  = s:columnmove.check_char_w
  let curswant    = 1
  let l:count     = 1
  let opt.fold_treatment = 0
  let opt.stop_on_space  = 1
  let [current, last] = s:columnmove.search_beyond_border_in_section_backward(current, last, Check_char, sectionhead, sectiontail, curswant, l:count, opt)
  call g:assert.equals(current.lnum, 1, 'failed at #3 (current.lnum)')
  call g:assert.equals(current.col,  1, 'failed at #3 (current.col)')
  call g:assert.equals(current.dest, 1, 'failed at #3 (current.dest)')
  call g:assert.equals(last.lnum,    2, 'failed at #3 (last.lnum)')
  %delete

  " #4
  call append(0, ['a', ' '])
  $delete
  let current     = {'lnum': line('$'), 'col': 0, 'class': -1, 'count': 0, 'dest': 0}
  let last        = {}
  let sectionhead = line('$')
  let sectiontail = 1
  let Check_char  = s:columnmove.check_char_w
  let curswant    = 1
  let l:count     = 1
  let opt.fold_treatment = 0
  let opt.stop_on_space  = 1
  let [current, last] = s:columnmove.search_beyond_border_in_section_backward(current, last, Check_char, sectionhead, sectiontail, curswant, l:count, opt)
  call g:assert.equals(current.lnum, 1, 'failed at #4 (current.lnum)')
  call g:assert.equals(current.col,  1, 'failed at #4 (current.col)')
  call g:assert.equals(current.dest, 1, 'failed at #4 (current.dest)')
  call g:assert.equals(last.lnum,    2, 'failed at #4 (last.lnum)')
  %delete

  " #5
  call append(0, ['a', ''])
  $delete
  let current     = {'lnum': line('$'), 'col': 0, 'class': -1, 'count': 0, 'dest': 0}
  let last        = {}
  let sectionhead = line('$')
  let sectiontail = 1
  let Check_char  = s:columnmove.check_char_w
  let curswant    = 1
  let l:count     = 1
  let opt.fold_treatment = 0
  let opt.stop_on_space  = 1
  let [current, last] = s:columnmove.search_beyond_border_in_section_backward(current, last, Check_char, sectionhead, sectiontail, curswant, l:count, opt)
  call g:assert.equals(current.lnum, 1, 'failed at #5 (current.lnum)')
  call g:assert.equals(current.col,  1, 'failed at #5 (current.col)')
  call g:assert.equals(current.dest, 1, 'failed at #5 (current.dest)')
  call g:assert.equals(last.lnum,    2, 'failed at #5 (last.lnum)')
  %delete

  " #6
  call append(0, [' ', 'b'])
  $delete
  let current     = {'lnum': line('$'), 'col': 0, 'class': -1, 'count': 0, 'dest': 0}
  let last        = {}
  let sectionhead = line('$')
  let sectiontail = 1
  let Check_char  = s:columnmove.check_char_w
  let curswant    = 1
  let l:count     = 1
  let opt.fold_treatment = 0
  let opt.stop_on_space  = 1
  let [current, last] = s:columnmove.search_beyond_border_in_section_backward(current, last, Check_char, sectionhead, sectiontail, curswant, l:count, opt)
  call g:assert.equals(current.lnum, 0, 'failed at #6 (current.lnum)')
  call g:assert.equals(current.dest, 0, 'failed at #6 (current.dest)')
  call g:assert.equals(last.lnum,    1, 'failed at #6 (last.lnum)')
  %delete

  " #7
  call append(0, [' ', ':'])
  $delete
  let current     = {'lnum': line('$'), 'col': 0, 'class': -1, 'count': 0, 'dest': 0}
  let last        = {}
  let sectionhead = line('$')
  let sectiontail = 1
  let Check_char  = s:columnmove.check_char_w
  let curswant    = 1
  let l:count     = 1
  let opt.fold_treatment = 0
  let opt.stop_on_space  = 1
  let [current, last] = s:columnmove.search_beyond_border_in_section_backward(current, last, Check_char, sectionhead, sectiontail, curswant, l:count, opt)
  call g:assert.equals(current.lnum, 0, 'failed at #7 (current.lnum)')
  call g:assert.equals(current.dest, 0, 'failed at #7 (current.dest)')
  call g:assert.equals(last.lnum,    1, 'failed at #7 (last.lnum)')
  %delete

  " #8
  call append(0, [' ', ' '])
  $delete
  let current     = {'lnum': line('$'), 'col': 0, 'class': -1, 'count': 0, 'dest': 0}
  let last        = {}
  let sectionhead = line('$')
  let sectiontail = 1
  let Check_char  = s:columnmove.check_char_w
  let curswant    = 1
  let l:count     = 1
  let opt.fold_treatment = 0
  let opt.stop_on_space  = 1
  let [current, last] = s:columnmove.search_beyond_border_in_section_backward(current, last, Check_char, sectionhead, sectiontail, curswant, l:count, opt)
  call g:assert.equals(current.lnum, 0, 'failed at #8 (current.lnum)')
  call g:assert.equals(current.dest, 0, 'failed at #8 (current.dest)')
  call g:assert.equals(last.lnum,    1, 'failed at #8 (last.lnum)')
  %delete

  " #9
  call append(0, [' ', ''])
  $delete
  let current     = {'lnum': line('$'), 'col': 0, 'class': -1, 'count': 0, 'dest': 0}
  let last        = {}
  let sectionhead = line('$')
  let sectiontail = 1
  let Check_char  = s:columnmove.check_char_w
  let curswant    = 1
  let l:count     = 1
  let opt.fold_treatment = 0
  let opt.stop_on_space  = 1
  let [current, last] = s:columnmove.search_beyond_border_in_section_backward(current, last, Check_char, sectionhead, sectiontail, curswant, l:count, opt)
  call g:assert.equals(current.lnum, 0, 'failed at #9 (current.lnum)')
  call g:assert.equals(current.dest, 0, 'failed at #9 (current.dest)')
  call g:assert.equals(last.lnum,    1, 'failed at #9 (last.lnum)')
  %delete

  " #10
  call append(0, ['abc', 'def', 'ghi'])
  $delete
  let current     = {'lnum': line('$'), 'col': 0, 'class': -1, 'count': 0, 'dest': 0}
  let last        = {}
  let sectionhead = line('$')
  let sectiontail = 1
  let Check_char  = s:columnmove.check_char_w
  let curswant    = 2
  let l:count     = 1
  let opt.fold_treatment = 0
  let opt.stop_on_space  = 1
  let [current, last] = s:columnmove.search_beyond_border_in_section_backward(current, last, Check_char, sectionhead, sectiontail, curswant, l:count, opt)
  call g:assert.equals(current.lnum, 0, 'failed at #10 (current.lnum)')
  call g:assert.equals(current.dest, 0, 'failed at #10 (current.dest)')
  call g:assert.equals(last.lnum,    1, 'failed at #10 (last.lnum)')
  %delete

  " #11
  call append(0, ['abc', 'def', 'ghi'])
  $delete
  let current     = {'lnum': line('$'), 'col': 0, 'class': -1, 'count': 0, 'dest': 0}
  let last        = {}
  let sectionhead = line('$')
  let sectiontail = 1
  let Check_char  = s:columnmove.check_char_w
  let curswant    = 3
  let l:count     = 1
  let opt.fold_treatment = 0
  let opt.stop_on_space  = 1
  let [current, last] = s:columnmove.search_beyond_border_in_section_backward(current, last, Check_char, sectionhead, sectiontail, curswant, l:count, opt)
  call g:assert.equals(current.lnum, 0, 'failed at #11 (current.lnum)')
  call g:assert.equals(current.dest, 0, 'failed at #11 (current.dest)')
  call g:assert.equals(last.lnum,    1, 'failed at #11 (last.lnum)')
  %delete

  " #12
  call append(0, ['abc', ':::', 'def'])
  $delete
  let current     = {'lnum': line('$'), 'col': 0, 'class': -1, 'count': 0, 'dest': 0}
  let last        = {}
  let sectionhead = line('$')
  let sectiontail = 1
  let Check_char  = s:columnmove.check_char_w
  let curswant    = 2
  let l:count     = 1
  let opt.fold_treatment = 0
  let opt.stop_on_space  = 1
  let [current, last] = s:columnmove.search_beyond_border_in_section_backward(current, last, Check_char, sectionhead, sectiontail, curswant, l:count, opt)
  call g:assert.equals(current.lnum, 2, 'failed at #12 (current.lnum)')
  call g:assert.equals(current.col,  2, 'failed at #12 (current.col)')
  call g:assert.equals(current.dest, 1, 'failed at #12 (current.dest)')
  call g:assert.equals(last.lnum,    3, 'failed at #12 (last.lnum)')
  %delete

  " #13
  call append(0, ['abc', ':::', 'def'])
  $delete
  let current     = {'lnum': line('$'), 'col': 0, 'class': -1, 'count': 0, 'dest': 0}
  let last        = {}
  let sectionhead = line('$')
  let sectiontail = 1
  let Check_char  = s:columnmove.check_char_w
  let curswant    = 3
  let l:count     = 1
  let opt.fold_treatment = 0
  let opt.stop_on_space  = 1
  let [current, last] = s:columnmove.search_beyond_border_in_section_backward(current, last, Check_char, sectionhead, sectiontail, curswant, l:count, opt)
  call g:assert.equals(current.lnum, 2, 'failed at #13 (current.lnum)')
  call g:assert.equals(current.col,  3, 'failed at #13 (current.col)')
  call g:assert.equals(current.dest, 1, 'failed at #13 (current.dest)')
  call g:assert.equals(last.lnum,    3, 'failed at #13 (last.lnum)')
  %delete

  " #14
  call append(0, ['abc', '   ', 'def'])
  $delete
  let current     = {'lnum': line('$'), 'col': 0, 'class': -1, 'count': 0, 'dest': 0}
  let last        = {}
  let sectionhead = line('$')
  let sectiontail = 1
  let Check_char  = s:columnmove.check_char_w
  let curswant    = 2
  let l:count     = 1
  let opt.fold_treatment = 0
  let opt.stop_on_space  = 1
  let [current, last] = s:columnmove.search_beyond_border_in_section_backward(current, last, Check_char, sectionhead, sectiontail, curswant, l:count, opt)
  call g:assert.equals(current.lnum, 1, 'failed at #14 (current.lnum)')
  call g:assert.equals(current.col,  2, 'failed at #14 (current.col)')
  call g:assert.equals(current.dest, 1, 'failed at #14 (current.dest)')
  call g:assert.equals(last.lnum,    2, 'failed at #14 (last.lnum)')
  %delete

  " #15
  call append(0, ['abc', '   ', 'def'])
  $delete
  let current     = {'lnum': line('$'), 'col': 0, 'class': -1, 'count': 0, 'dest': 0}
  let last        = {}
  let sectionhead = line('$')
  let sectiontail = 1
  let Check_char  = s:columnmove.check_char_w
  let curswant    = 3
  let l:count     = 1
  let opt.fold_treatment = 0
  let opt.stop_on_space  = 1
  let [current, last] = s:columnmove.search_beyond_border_in_section_backward(current, last, Check_char, sectionhead, sectiontail, curswant, l:count, opt)
  call g:assert.equals(current.lnum, 1, 'failed at #15 (current.lnum)')
  call g:assert.equals(current.col,  3, 'failed at #15 (current.col)')
  call g:assert.equals(current.dest, 1, 'failed at #15 (current.dest)')
  call g:assert.equals(last.lnum,    2, 'failed at #15 (last.lnum)')
  %delete

  " #16
  call append(0, ['abc', '', 'def'])
  $delete
  let current     = {'lnum': line('$'), 'col': 0, 'class': -1, 'count': 0, 'dest': 0}
  let last        = {}
  let sectionhead = line('$')
  let sectiontail = 1
  let Check_char  = s:columnmove.check_char_w
  let curswant    = 2
  let l:count     = 1
  let opt.fold_treatment = 0
  let opt.stop_on_space  = 1
  let [current, last] = s:columnmove.search_beyond_border_in_section_backward(current, last, Check_char, sectionhead, sectiontail, curswant, l:count, opt)
  call g:assert.equals(current.lnum, 1, 'failed at #16 (current.lnum)')
  call g:assert.equals(current.col,  2, 'failed at #16 (current.col)')
  call g:assert.equals(current.dest, 1, 'failed at #16 (current.dest)')
  call g:assert.equals(last.lnum,    2, 'failed at #16 (last.lnum)')
  %delete

  " #17
  call append(0, ['abc', '', 'def'])
  $delete
  let current     = {'lnum': line('$'), 'col': 0, 'class': -1, 'count': 0, 'dest': 0}
  let last        = {}
  let sectionhead = line('$')
  let sectiontail = 1
  let Check_char  = s:columnmove.check_char_w
  let curswant    = 3
  let l:count     = 1
  let opt.fold_treatment = 0
  let opt.stop_on_space  = 1
  let [current, last] = s:columnmove.search_beyond_border_in_section_backward(current, last, Check_char, sectionhead, sectiontail, curswant, l:count, opt)
  call g:assert.equals(current.lnum, 1, 'failed at #17 (current.lnum)')
  call g:assert.equals(current.col,  3, 'failed at #17 (current.col)')
  call g:assert.equals(current.dest, 1, 'failed at #17 (current.dest)')
  call g:assert.equals(last.lnum,    2, 'failed at #17 (last.lnum)')
  %delete

  " #18
  call append(0, ['a', ':', 'b', '', 'c'])
  $delete
  let current     = {'lnum': line('$'), 'col': 0, 'class': -1, 'count': 0, 'dest': 0}
  let last        = {}
  let sectionhead = line('$')
  let sectiontail = 1
  let Check_char  = s:columnmove.check_char_w
  let curswant    = 1
  let l:count     = 2
  let opt.fold_treatment = 0
  let opt.stop_on_space  = 1
  let [current, last] = s:columnmove.search_beyond_border_in_section_backward(current, last, Check_char, sectionhead, sectiontail, curswant, l:count, opt)
  call g:assert.equals(current.lnum, 2, 'failed at #18 (current.lnum)')
  call g:assert.equals(current.col,  1, 'failed at #18 (current.col)')
  call g:assert.equals(current.dest, 1, 'failed at #18 (current.dest)')
  call g:assert.equals(last.lnum,    3, 'failed at #18 (last.lnum)')
  %delete

  " #19
  call append(0, ['a', ':', 'b', '', 'c'])
  $delete
  let current     = {'lnum': 5, 'col': 0, 'class': -1, 'count': 0, 'dest': 0}
  let last        = {}
  let sectionhead = 5
  let sectiontail = 2
  let Check_char  = s:columnmove.check_char_w
  let curswant    = 1
  let l:count     = 2
  let opt.fold_treatment = 0
  let opt.stop_on_space  = 1
  let [current, last] = s:columnmove.search_beyond_border_in_section_backward(current, last, Check_char, sectionhead, sectiontail, curswant, l:count, opt)
  call g:assert.equals(current.lnum, 2, 'failed at #19 (current.lnum)')
  call g:assert.equals(current.col,  1, 'failed at #19 (current.col)')
  call g:assert.equals(current.dest, 1, 'failed at #19 (current.dest)')
  call g:assert.equals(last.lnum,    3, 'failed at #19 (last.lnum)')
  %delete

  " #20
  call append(0, ['a', ':', 'b', '', 'c'])
  $delete
  let current     = {'lnum': 5, 'col': 0, 'class': -1, 'count': 0, 'dest': 0}
  let last        = {}
  let sectionhead = 5
  let sectiontail = 3
  let Check_char  = s:columnmove.check_char_w
  let curswant    = 1
  let l:count     = 2
  let opt.fold_treatment = 0
  let opt.stop_on_space  = 1
  let [current, last] = s:columnmove.search_beyond_border_in_section_backward(current, last, Check_char, sectionhead, sectiontail, curswant, l:count, opt)
  call g:assert.equals(current.lnum, 2, 'failed at #20 (current.lnum)')
  call g:assert.equals(current.dest, 0, 'failed at #20 (current.dest)')
  call g:assert.equals(last.lnum,    3, 'failed at #20 (last.lnum)')
  %delete

  " #21
  call append(0, ['a', ':', 'b', '', 'c'])
  $delete
  let current     = {'lnum': 4, 'col': 0, 'class': -1, 'count': 0, 'dest': 0}
  let last        = {}
  let sectionhead = 4
  let sectiontail = 2
  let Check_char  = s:columnmove.check_char_w
  let curswant    = 1
  let l:count     = 2
  let opt.fold_treatment = 0
  let opt.stop_on_space  = 1
  let [current, last] = s:columnmove.search_beyond_border_in_section_backward(current, last, Check_char, sectionhead, sectiontail, curswant, l:count, opt)
  call g:assert.equals(current.lnum, 2, 'failed at #21 (current.lnum)')
  call g:assert.equals(current.col,  1, 'failed at #21 (current.col)')
  call g:assert.equals(current.dest, 1, 'failed at #21 (current.dest)')
  call g:assert.equals(last.lnum,    3, 'failed at #21 (last.lnum)')
  %delete

  " #22
  call append(0, ['a', ':', 'b', '', 'c'])
  $delete
  let current     = {'lnum': 5, 'col': 0, 'class': -1, 'count': 0, 'dest': 0}
  let last        = {}
  let sectionhead = 5
  let sectiontail = 1
  let Check_char  = s:columnmove.check_char_w
  let curswant    = 1
  let l:count     = 3
  let opt.fold_treatment = 0
  let opt.stop_on_space  = 1
  let [current, last] = s:columnmove.search_beyond_border_in_section_backward(current, last, Check_char, sectionhead, sectiontail, curswant, l:count, opt)
  call g:assert.equals(current.lnum, 1, 'failed at #22 (current.lnum)')
  call g:assert.equals(current.col,  1, 'failed at #22 (current.col)')
  call g:assert.equals(current.dest, 1, 'failed at #22 (current.dest)')
  call g:assert.equals(last.lnum,    2, 'failed at #22 (last.lnum)')
  %delete

  " #23
  call append(0, ['a', ':', 'b', '', 'c'])
  $delete
  let current     = {'lnum': 5, 'col': 0, 'class': -1, 'count': 0, 'dest': 0}
  let last        = {}
  let sectionhead = 5
  let sectiontail = 1
  let Check_char  = s:columnmove.check_char_w
  let curswant    = 1
  let l:count     = 1
  let opt.fold_treatment = 0
  let opt.stop_on_space  = 1
  2,4fold
  let [current, last] = s:columnmove.search_beyond_border_in_section_backward(current, last, Check_char, sectionhead, sectiontail, curswant, l:count, opt)
  call g:assert.equals(current.lnum, 0, 'failed at #23 (current.lnum)')
  call g:assert.equals(current.dest, 0, 'failed at #23 (current.dest)')
  call g:assert.equals(last.lnum,    1, 'failed at #23 (last.lnum)')
  %delete

  " #24
  call append(0, ['a', ':', 'b', '', 'c'])
  $delete
  let current     = {'lnum': 5, 'col': 0, 'class': -1, 'count': 0, 'dest': 0}
  let last        = {}
  let sectionhead = 5
  let sectiontail = 1
  let Check_char  = s:columnmove.check_char_w
  let curswant    = 1
  let l:count     = 1
  let opt.fold_treatment = 1
  let opt.stop_on_space  = 1
  2,4fold
  let [current, last] = s:columnmove.search_beyond_border_in_section_backward(current, last, Check_char, sectionhead, sectiontail, curswant, l:count, opt)
  call g:assert.equals(current.lnum, 1, 'failed at #24 (current.lnum)')
  call g:assert.equals(current.col,  1, 'failed at #24 (current.col)')
  call g:assert.equals(current.dest, 1, 'failed at #24 (current.dest)')
  call g:assert.equals(last.lnum,    4, 'failed at #24 (last.lnum)')
  %delete

  " #25
  call append(0, ['a', ':', 'b', '', 'c'])
  $delete
  let current     = {'lnum': 5, 'col': 0, 'class': -1, 'count': 0, 'dest': 0}
  let last        = {}
  let sectionhead = 5
  let sectiontail = 1
  let Check_char  = s:columnmove.check_char_w
  let curswant    = 1
  let l:count     = 1
  let opt.fold_treatment = 1
  let opt.stop_on_space  = 1
  1,4fold
  let [current, last] = s:columnmove.search_beyond_border_in_section_backward(current, last, Check_char, sectionhead, sectiontail, curswant, l:count, opt)
  call g:assert.equals(current.lnum, 0, 'failed at #25 (current.lnum)')
  call g:assert.equals(current.dest, 0, 'failed at #25 (current.dest)')
  call g:assert.equals(last.lnum,    4, 'failed at #25 (last.lnum)')
  %delete
endfunction
"}}}
function! s:suite.search_short_of_border_in_section_forward() abort "{{{
  let opt = {'strict_wbege': 1}

  " #1
  call append(0, ['a'])
  $delete
  let current     = {'lnum': 1, 'col': 0, 'class': -1, 'count': 0, 'dest': 0}
  let tip         = {}
  let sectionhead = 1
  let sectiontail = 1
  let Check_char  = s:columnmove.check_char_w
  let curswant    = 1
  let l:count     = 1
  let opt.fold_treatment = 0
  let opt.stop_on_space  = 1
  let [current, tip] = s:columnmove.search_short_of_border_in_section_forward(current, tip, Check_char, sectionhead, sectiontail, curswant, l:count, opt)
  call g:assert.equals(current.dest, 0, 'failed at #1 (current.dest)')
  %delete

  " #2
  call append(0, ['a', 'b'])
  $delete
  let current     = {'lnum': 1, 'col': 0, 'class': -1, 'count': 0, 'dest': 0}
  let tip         = {}
  let sectionhead = 1
  let sectiontail = line('$')
  let Check_char  = s:columnmove.check_char_w
  let curswant    = 1
  let l:count     = 1
  let opt.fold_treatment = 0
  let opt.stop_on_space  = 1
  let [current, tip] = s:columnmove.search_short_of_border_in_section_forward(current, tip, Check_char, sectionhead, sectiontail, curswant, l:count, opt)
  call g:assert.equals(current.lnum, 2, 'failed at #2 (current.lnum)')
  call g:assert.equals(current.col,  1, 'failed at #2 (current.col)')
  call g:assert.equals(current.dest, 1, 'failed at #2 (current.dest)')
  call g:assert.equals(tip.lnum,     3, 'failed at #2 (tip.lnum)')
  %delete

  " #3
  call append(0, ['a', ':'])
  $delete
  let current     = {'lnum': 1, 'col': 0, 'class': -1, 'count': 0, 'dest': 0}
  let tip         = {}
  let sectionhead = 1
  let sectiontail = line('$')
  let Check_char  = s:columnmove.check_char_w
  let curswant    = 1
  let l:count     = 1
  let opt.fold_treatment = 0
  let opt.stop_on_space  = 1
  let [current, tip] = s:columnmove.search_short_of_border_in_section_forward(current, tip, Check_char, sectionhead, sectiontail, curswant, l:count, opt)
  call g:assert.equals(current.lnum, 2, 'failed at #3 (current.lnum)')
  call g:assert.equals(current.col,  1, 'failed at #3 (current.col)')
  call g:assert.equals(current.dest, 1, 'failed at #3 (current.dest)')
  call g:assert.equals(tip.lnum,     3, 'failed at #3 (tip.lnum)')
  %delete

  " #4
  call append(0, ['a', ' '])
  $delete
  let current     = {'lnum': 1, 'col': 0, 'class': -1, 'count': 0, 'dest': 0}
  let tip         = {}
  let sectionhead = 1
  let sectiontail = line('$')
  let Check_char  = s:columnmove.check_char_w
  let curswant    = 1
  let l:count     = 1
  let opt.fold_treatment = 0
  let opt.stop_on_space  = 1
  let [current, tip] = s:columnmove.search_short_of_border_in_section_forward(current, tip, Check_char, sectionhead, sectiontail, curswant, l:count, opt)
  call g:assert.equals(current.lnum, 3, 'failed at #4 (current.lnum)')
  call g:assert.equals(current.dest, 0, 'failed at #4 (current.dest)')
  call g:assert.equals(tip.lnum,     4, 'failed at #4 (tip.lnum)')
  %delete

  " #5
  call append(0, ['a', ''])
  $delete
  let current     = {'lnum': 1, 'col': 0, 'class': -1, 'count': 0, 'dest': 0}
  let tip         = {}
  let sectionhead = 1
  let sectiontail = line('$')
  let Check_char  = s:columnmove.check_char_w
  let curswant    = 1
  let l:count     = 1
  let opt.fold_treatment = 0
  let opt.stop_on_space  = 1
  let [current, tip] = s:columnmove.search_short_of_border_in_section_forward(current, tip, Check_char, sectionhead, sectiontail, curswant, l:count, opt)
  call g:assert.equals(current.lnum, 3, 'failed at #5 (current.lnum)')
  call g:assert.equals(current.dest, 0, 'failed at #5 (current.dest)')
  call g:assert.equals(tip.lnum,     4, 'failed at #5 (tip.lnum)')
  %delete

  " #6
  call append(0, [' ', 'b'])
  $delete
  let current     = {'lnum': 1, 'col': 0, 'class': -1, 'count': 0, 'dest': 0}
  let tip         = {}
  let sectionhead = 1
  let sectiontail = line('$')
  let Check_char  = s:columnmove.check_char_w
  let curswant    = 1
  let l:count     = 1
  let opt.fold_treatment = 0
  let opt.stop_on_space  = 1
  let [current, tip] = s:columnmove.search_short_of_border_in_section_forward(current, tip, Check_char, sectionhead, sectiontail, curswant, l:count, opt)
  call g:assert.equals(current.lnum, 2, 'failed at #6 (current.lnum)')
  call g:assert.equals(current.col,  1, 'failed at #6 (current.col)')
  call g:assert.equals(current.dest, 1, 'failed at #6 (current.dest)')
  call g:assert.equals(tip.lnum,     3, 'failed at #6 (tip.lnum)')
  %delete

  " #7
  call append(0, [' ', ':'])
  $delete
  let current     = {'lnum': 1, 'col': 0, 'class': -1, 'count': 0, 'dest': 0}
  let tip         = {}
  let sectionhead = 1
  let sectiontail = line('$')
  let Check_char  = s:columnmove.check_char_w
  let curswant    = 1
  let l:count     = 1
  let opt.fold_treatment = 0
  let opt.stop_on_space  = 1
  let [current, tip] = s:columnmove.search_short_of_border_in_section_forward(current, tip, Check_char, sectionhead, sectiontail, curswant, l:count, opt)
  call g:assert.equals(current.lnum, 2, 'failed at #7 (current.lnum)')
  call g:assert.equals(current.col,  1, 'failed at #7 (current.col)')
  call g:assert.equals(current.dest, 1, 'failed at #7 (current.dest)')
  call g:assert.equals(tip.lnum,     3, 'failed at #7 (tip.lnum)')
  %delete

  " #8
  call append(0, [' ', ' '])
  $delete
  let current     = {'lnum': 1, 'col': 0, 'class': -1, 'count': 0, 'dest': 0}
  let tip         = {}
  let sectionhead = 1
  let sectiontail = line('$')
  let Check_char  = s:columnmove.check_char_w
  let curswant    = 1
  let l:count     = 1
  let opt.fold_treatment = 0
  let opt.stop_on_space  = 1
  let [current, tip] = s:columnmove.search_short_of_border_in_section_forward(current, tip, Check_char, sectionhead, sectiontail, curswant, l:count, opt)
  call g:assert.equals(current.lnum, 3, 'failed at #8 (current.lnum)')
  call g:assert.equals(current.dest, 0, 'failed at #8 (current.dest)')
  call g:assert.equals(tip.lnum,     4, 'failed at #8 (tip.lnum)')
  %delete

  " #9
  call append(0, [' ', ''])
  $delete
  let current     = {'lnum': 1, 'col': 0, 'class': -1, 'count': 0, 'dest': 0}
  let tip         = {}
  let sectionhead = 1
  let sectiontail = line('$')
  let Check_char  = s:columnmove.check_char_w
  let curswant    = 1
  let l:count     = 1
  let opt.fold_treatment = 0
  let opt.stop_on_space  = 1
  let [current, tip] = s:columnmove.search_short_of_border_in_section_forward(current, tip, Check_char, sectionhead, sectiontail, curswant, l:count, opt)
  call g:assert.equals(current.lnum, 3, 'failed at #9 (current.lnum)')
  call g:assert.equals(current.dest, 0, 'failed at #9 (current.dest)')
  call g:assert.equals(tip.lnum,     4, 'failed at #9 (tip.lnum)')
  %delete

  " #10
  call append(0, ['abc', 'def', 'ghi'])
  $delete
  let current     = {'lnum': 1, 'col': 0, 'class': -1, 'count': 0, 'dest': 0}
  let tip         = {}
  let sectionhead = 1
  let sectiontail = line('$')
  let Check_char  = s:columnmove.check_char_w
  let curswant    = 2
  let l:count     = 1
  let opt.fold_treatment = 0
  let opt.stop_on_space  = 1
  let [current, tip] = s:columnmove.search_short_of_border_in_section_forward(current, tip, Check_char, sectionhead, sectiontail, curswant, l:count, opt)
  call g:assert.equals(current.lnum, 3, 'failed at #10 (current.lnum)')
  call g:assert.equals(current.col,  2, 'failed at #10 (current.col)')
  call g:assert.equals(current.dest, 1, 'failed at #10 (current.dest)')
  call g:assert.equals(tip.lnum,     4, 'failed at #10 (tip.lnum)')
  %delete

  " #11
  call append(0, ['abc', 'def', 'ghi'])
  $delete
  let current     = {'lnum': 1, 'col': 0, 'class': -1, 'count': 0, 'dest': 0}
  let tip         = {}
  let sectionhead = 1
  let sectiontail = line('$')
  let Check_char  = s:columnmove.check_char_w
  let curswant    = 3
  let l:count     = 1
  let opt.fold_treatment = 0
  let opt.stop_on_space  = 1
  let [current, tip] = s:columnmove.search_short_of_border_in_section_forward(current, tip, Check_char, sectionhead, sectiontail, curswant, l:count, opt)
  call g:assert.equals(current.lnum, 3, 'failed at #11 (current.lnum)')
  call g:assert.equals(current.col,  3, 'failed at #11 (current.col)')
  call g:assert.equals(current.dest, 1, 'failed at #11 (current.dest)')
  call g:assert.equals(tip.lnum,     4, 'failed at #11 (tip.lnum)')
  %delete

  " #12
  call append(0, ['abc', ':::', 'def'])
  $delete
  let current     = {'lnum': 1, 'col': 0, 'class': -1, 'count': 0, 'dest': 0}
  let tip         = {}
  let sectionhead = 1
  let sectiontail = line('$')
  let Check_char  = s:columnmove.check_char_w
  let curswant    = 2
  let l:count     = 1
  let opt.fold_treatment = 0
  let opt.stop_on_space  = 1
  let [current, tip] = s:columnmove.search_short_of_border_in_section_forward(current, tip, Check_char, sectionhead, sectiontail, curswant, l:count, opt)
  call g:assert.equals(current.lnum, 2, 'failed at #12 (current.lnum)')
  call g:assert.equals(current.col,  2, 'failed at #12 (current.col)')
  call g:assert.equals(current.dest, 1, 'failed at #12 (current.dest)')
  call g:assert.equals(tip.lnum,     3, 'failed at #12 (tip.lnum)')
  %delete

  " #13
  call append(0, ['abc', ':::', 'def'])
  $delete
  let current     = {'lnum': 1, 'col': 0, 'class': -1, 'count': 0, 'dest': 0}
  let tip         = {}
  let sectionhead = 1
  let sectiontail = line('$')
  let Check_char  = s:columnmove.check_char_w
  let curswant    = 3
  let l:count     = 1
  let opt.fold_treatment = 0
  let opt.stop_on_space  = 1
  let [current, tip] = s:columnmove.search_short_of_border_in_section_forward(current, tip, Check_char, sectionhead, sectiontail, curswant, l:count, opt)
  call g:assert.equals(current.lnum, 2, 'failed at #13 (current.lnum)')
  call g:assert.equals(current.col,  3, 'failed at #13 (current.col)')
  call g:assert.equals(current.dest, 1, 'failed at #13 (current.dest)')
  call g:assert.equals(tip.lnum,     3, 'failed at #13 (tip.lnum)')
  %delete

  " #14
  call append(0, ['abc', '   ', 'def'])
  $delete
  let current     = {'lnum': 1, 'col': 0, 'class': -1, 'count': 0, 'dest': 0}
  let tip         = {}
  let sectionhead = 1
  let sectiontail = line('$')
  let Check_char  = s:columnmove.check_char_w
  let curswant    = 2
  let l:count     = 1
  let opt.fold_treatment = 0
  let opt.stop_on_space  = 1
  let [current, tip] = s:columnmove.search_short_of_border_in_section_forward(current, tip, Check_char, sectionhead, sectiontail, curswant, l:count, opt)
  call g:assert.equals(current.lnum, 3, 'failed at #14 (current.lnum)')
  call g:assert.equals(current.col,  2, 'failed at #14 (current.col)')
  call g:assert.equals(current.dest, 1, 'failed at #14 (current.dest)')
  call g:assert.equals(tip.lnum,     4, 'failed at #14 (tip.lnum)')
  %delete

  " #15
  call append(0, ['abc', '   ', 'def'])
  $delete
  let current     = {'lnum': 1, 'col': 0, 'class': -1, 'count': 0, 'dest': 0}
  let tip         = {}
  let sectionhead = 1
  let sectiontail = line('$')
  let Check_char  = s:columnmove.check_char_w
  let curswant    = 3
  let l:count     = 1
  let opt.fold_treatment = 0
  let opt.stop_on_space  = 1
  let [current, tip] = s:columnmove.search_short_of_border_in_section_forward(current, tip, Check_char, sectionhead, sectiontail, curswant, l:count, opt)
  call g:assert.equals(current.lnum, 3, 'failed at #15 (current.lnum)')
  call g:assert.equals(current.col,  3, 'failed at #15 (current.col)')
  call g:assert.equals(current.dest, 1, 'failed at #15 (current.dest)')
  call g:assert.equals(tip.lnum,     4, 'failed at #15 (tip.lnum)')
  %delete

  " #16
  call append(0, ['abc', '', 'def'])
  $delete
  let current     = {'lnum': 1, 'col': 0, 'class': -1, 'count': 0, 'dest': 0}
  let tip         = {}
  let sectionhead = 1
  let sectiontail = line('$')
  let Check_char  = s:columnmove.check_char_w
  let curswant    = 2
  let l:count     = 1
  let opt.fold_treatment = 0
  let opt.stop_on_space  = 1
  let [current, tip] = s:columnmove.search_short_of_border_in_section_forward(current, tip, Check_char, sectionhead, sectiontail, curswant, l:count, opt)
  call g:assert.equals(current.lnum, 3, 'failed at #16 (current.lnum)')
  call g:assert.equals(current.col,  2, 'failed at #16 (current.col)')
  call g:assert.equals(current.dest, 1, 'failed at #16 (current.dest)')
  call g:assert.equals(tip.lnum,     4, 'failed at #16 (tip.lnum)')
  %delete

  " #17
  call append(0, ['abc', '', 'def'])
  $delete
  let current     = {'lnum': 1, 'col': 0, 'class': -1, 'count': 0, 'dest': 0}
  let tip         = {}
  let sectionhead = 1
  let sectiontail = line('$')
  let Check_char  = s:columnmove.check_char_w
  let curswant    = 3
  let l:count     = 1
  let opt.fold_treatment = 0
  let opt.stop_on_space  = 1
  let [current, tip] = s:columnmove.search_short_of_border_in_section_forward(current, tip, Check_char, sectionhead, sectiontail, curswant, l:count, opt)
  call g:assert.equals(current.lnum, 3, 'failed at #17 (current.lnum)')
  call g:assert.equals(current.col,  3, 'failed at #17 (current.col)')
  call g:assert.equals(current.dest, 1, 'failed at #17 (current.dest)')
  call g:assert.equals(tip.lnum,     4, 'failed at #17 (tip.lnum)')
  %delete

  " #18
  call append(0, ['a', ':', 'b', '', 'c'])
  $delete
  let current     = {'lnum': 1, 'col': 0, 'class': -1, 'count': 0, 'dest': 0}
  let tip         = {}
  let sectionhead = 1
  let sectiontail = line('$')
  let Check_char  = s:columnmove.check_char_w
  let curswant    = 1
  let l:count     = 2
  let opt.fold_treatment = 0
  let opt.stop_on_space  = 1
  let [current, tip] = s:columnmove.search_short_of_border_in_section_forward(current, tip, Check_char, sectionhead, sectiontail, curswant, l:count, opt)
  call g:assert.equals(current.lnum, 3, 'failed at #18 (current.lnum)')
  call g:assert.equals(current.col,  1, 'failed at #18 (current.col)')
  call g:assert.equals(current.dest, 1, 'failed at #18 (current.dest)')
  call g:assert.equals(tip.lnum,     4, 'failed at #18 (tip.lnum)')
  %delete

  " #19
  call append(0, ['a', ':', 'b', '', 'c'])
  $delete
  let current     = {'lnum': 1, 'col': 0, 'class': -1, 'count': 0, 'dest': 0}
  let tip         = {}
  let sectionhead = 1
  let sectiontail = 3
  let Check_char  = s:columnmove.check_char_w
  let curswant    = 1
  let l:count     = 2
  let opt.fold_treatment = 0
  let opt.stop_on_space  = 1
  let [current, tip] = s:columnmove.search_short_of_border_in_section_forward(current, tip, Check_char, sectionhead, sectiontail, curswant, l:count, opt)
  call g:assert.equals(current.lnum, 3, 'failed at #19 (current.lnum)')
  call g:assert.equals(current.col,  1, 'failed at #19 (current.col)')
  call g:assert.equals(current.dest, 1, 'failed at #19 (current.dest)')
  call g:assert.equals(tip.lnum,     4, 'failed at #19 (tip.lnum)')
  %delete

  " #20
  call append(0, ['a', ':', 'b', '', 'c'])
  $delete
  let current     = {'lnum': 1, 'col': 0, 'class': -1, 'count': 0, 'dest': 0}
  let tip         = {}
  let sectionhead = 1
  let sectiontail = 2
  let Check_char  = s:columnmove.check_char_w
  let curswant    = 1
  let l:count     = 2
  let opt.fold_treatment = 0
  let opt.stop_on_space  = 1
  let [current, tip] = s:columnmove.search_short_of_border_in_section_forward(current, tip, Check_char, sectionhead, sectiontail, curswant, l:count, opt)
  call g:assert.equals(current.lnum, 3, 'failed at #20 (current.lnum)')
  call g:assert.equals(current.dest, 0, 'failed at #20 (current.dest)')
  call g:assert.equals(tip.lnum,     4, 'failed at #20 (tip.lnum)')
  %delete

  " #21
  call append(0, ['a', ':', 'b', '', 'c'])
  $delete
  let current     = {'lnum': 2, 'col': 0, 'class': -1, 'count': 0, 'dest': 0}
  let tip         = {}
  let sectionhead = 2
  let sectiontail = 5
  let Check_char  = s:columnmove.check_char_w
  let curswant    = 1
  let l:count     = 2
  let opt.fold_treatment = 0
  let opt.stop_on_space  = 1
  let [current, tip] = s:columnmove.search_short_of_border_in_section_forward(current, tip, Check_char, sectionhead, sectiontail, curswant, l:count, opt)
  call g:assert.equals(current.lnum, 5, 'failed at #21 (current.lnum)')
  call g:assert.equals(current.col,  1, 'failed at #21 (current.col)')
  call g:assert.equals(current.dest, 1, 'failed at #21 (current.dest)')
  call g:assert.equals(tip.lnum,     6, 'failed at #21 (tip.lnum)')
  %delete

  " #22
  call append(0, ['a', ':', 'b', '', 'c'])
  $delete
  let current     = {'lnum': 1, 'col': 0, 'class': -1, 'count': 0, 'dest': 0}
  let tip         = {}
  let sectionhead = 1
  let sectiontail = 5
  let Check_char  = s:columnmove.check_char_w
  let curswant    = 1
  let l:count     = 3
  let opt.fold_treatment = 0
  let opt.stop_on_space  = 1
  let [current, tip] = s:columnmove.search_short_of_border_in_section_forward(current, tip, Check_char, sectionhead, sectiontail, curswant, l:count, opt)
  call g:assert.equals(current.lnum, 5, 'failed at #22 (current.lnum)')
  call g:assert.equals(current.col,  1, 'failed at #22 (current.col)')
  call g:assert.equals(current.dest, 1, 'failed at #22 (current.dest)')
  call g:assert.equals(tip.lnum,     6, 'failed at #22 (tip.lnum)')
  %delete

  " #23
  call append(0, ['a', ':', 'b', '', 'c'])
  $delete
  let current     = {'lnum': 1, 'col': 0, 'class': -1, 'count': 0, 'dest': 0}
  let tip         = {}
  let sectionhead = 1
  let sectiontail = 5
  let Check_char  = s:columnmove.check_char_w
  let curswant    = 1
  let l:count     = 1
  let opt.fold_treatment = 0
  let opt.stop_on_space  = 1
  2,4fold
  let [current, tip] = s:columnmove.search_short_of_border_in_section_forward(current, tip, Check_char, sectionhead, sectiontail, curswant, l:count, opt)
  call g:assert.equals(current.lnum, 5, 'failed at #23 (current.lnum)')
  call g:assert.equals(current.col,  1, 'failed at #23 (current.col)')
  call g:assert.equals(current.dest, 1, 'failed at #23 (current.dest)')
  call g:assert.equals(tip.lnum,     6, 'failed at #23 (tip.lnum)')
  %delete

  " #24
  call append(0, ['a', ':', 'b', '', 'c'])
  $delete
  let current     = {'lnum': 1, 'col': 0, 'class': -1, 'count': 0, 'dest': 0}
  let tip         = {}
  let sectionhead = 1
  let sectiontail = 5
  let Check_char  = s:columnmove.check_char_w
  let curswant    = 1
  let l:count     = 1
  let opt.fold_treatment = 1
  let opt.stop_on_space  = 1
  2,4fold
  let [current, tip] = s:columnmove.search_short_of_border_in_section_forward(current, tip, Check_char, sectionhead, sectiontail, curswant, l:count, opt)
  call g:assert.equals(current.lnum, 5, 'failed at #24 (current.lnum)')
  call g:assert.equals(current.col,  1, 'failed at #24 (current.col)')
  call g:assert.equals(current.dest, 1, 'failed at #24 (current.dest)')
  call g:assert.equals(tip.lnum,     6, 'failed at #24 (tip.lnum)')
  %delete

  " #25
  call append(0, ['a', ':', 'b', '', 'c'])
  $delete
  let current     = {'lnum': 1, 'col': 0, 'class': -1, 'count': 0, 'dest': 0}
  let tip         = {}
  let sectionhead = 1
  let sectiontail = 5
  let Check_char  = s:columnmove.check_char_w
  let curswant    = 1
  let l:count     = 1
  let opt.fold_treatment = 1
  let opt.stop_on_space  = 1
  2,5fold
  let [current, tip] = s:columnmove.search_short_of_border_in_section_forward(current, tip, Check_char, sectionhead, sectiontail, curswant, l:count, opt)
  call g:assert.equals(current.lnum, 6, 'failed at #25 (current.lnum)')
  call g:assert.equals(current.dest, 0, 'failed at #25 (current.dest)')
  call g:assert.equals(tip.lnum,     7, 'failed at #25 (tip.lnum)')
  %delete
endfunction
"}}}
function! s:suite.search_short_of_border_in_section_backward() abort  "{{{
  let opt = {'strict_wbege': 1}

  " #1
  call append(0, ['a'])
  $delete
  let current     = {'lnum': 1, 'col': 0, 'class': -1, 'count': 0, 'dest': 0}
  let tip         = {}
  let sectionhead = 1
  let sectiontail = 1
  let Check_char  = s:columnmove.check_char_w
  let curswant    = 1
  let l:count     = 1
  let opt.fold_treatment = 0
  let opt.stop_on_space  = 1
  let [current, tip] = s:columnmove.search_short_of_border_in_section_backward(current, tip, Check_char, sectionhead, sectiontail, curswant, l:count, opt)
  call g:assert.equals(current.dest, 0, 'failed at #1 (current.dest)')
  %delete

  " #2
  call append(0, ['a', 'b'])
  $delete
  let current     = {'lnum': line('$'), 'col': 0, 'class': -1, 'count': 0, 'dest': 0}
  let tip         = {}
  let sectionhead = line('$')
  let sectiontail = 1
  let Check_char  = s:columnmove.check_char_w
  let curswant    = 1
  let l:count     = 1
  let opt.fold_treatment = 0
  let opt.stop_on_space  = 1
  let [current, tip] = s:columnmove.search_short_of_border_in_section_backward(current, tip, Check_char, sectionhead, sectiontail, curswant, l:count, opt)
  call g:assert.equals(current.lnum, 1, 'failed at #2 (current.lnum)')
  call g:assert.equals(current.col,  1, 'failed at #2 (current.col)')
  call g:assert.equals(current.dest, 1, 'failed at #2 (current.dest)')
  call g:assert.equals(tip.lnum,     0, 'failed at #2 (tip.lnum)')
  %delete

  " #3
  call append(0, ['a', ':'])
  $delete
  let current     = {'lnum': line('$'), 'col': 0, 'class': -1, 'count': 0, 'dest': 0}
  let tip         = {}
  let sectionhead = line('$')
  let sectiontail = 1
  let Check_char  = s:columnmove.check_char_w
  let curswant    = 1
  let l:count     = 1
  let opt.fold_treatment = 0
  let opt.stop_on_space  = 1
  let [current, tip] = s:columnmove.search_short_of_border_in_section_backward(current, tip, Check_char, sectionhead, sectiontail, curswant, l:count, opt)
  call g:assert.equals(current.lnum, 1, 'failed at #3 (current.lnum)')
  call g:assert.equals(current.col,  1, 'failed at #3 (current.col)')
  call g:assert.equals(current.dest, 1, 'failed at #3 (current.dest)')
  call g:assert.equals(tip.lnum,     0, 'failed at #3 (tip.lnum)')
  %delete

  " #4
  call append(0, ['a', ' '])
  $delete
  let current     = {'lnum': line('$'), 'col': 0, 'class': -1, 'count': 0, 'dest': 0}
  let tip         = {}
  let sectionhead = line('$')
  let sectiontail = 1
  let Check_char  = s:columnmove.check_char_w
  let curswant    = 1
  let l:count     = 1
  let opt.fold_treatment = 0
  let opt.stop_on_space  = 1
  let [current, tip] = s:columnmove.search_short_of_border_in_section_backward(current, tip, Check_char, sectionhead, sectiontail, curswant, l:count, opt)
  call g:assert.equals(current.lnum, 1, 'failed at #4 (current.lnum)')
  call g:assert.equals(current.col,  1, 'failed at #4 (current.col)')
  call g:assert.equals(current.dest, 1, 'failed at #4 (current.dest)')
  call g:assert.equals(tip.lnum,     0, 'failed at #4 (tip.lnum)')
  %delete

  " #5
  call append(0, ['a', ''])
  $delete
  let current     = {'lnum': line('$'), 'col': 0, 'class': -1, 'count': 0, 'dest': 0}
  let tip         = {}
  let sectionhead = line('$')
  let sectiontail = 1
  let Check_char  = s:columnmove.check_char_w
  let curswant    = 1
  let l:count     = 1
  let opt.fold_treatment = 0
  let opt.stop_on_space  = 1
  let [current, tip] = s:columnmove.search_short_of_border_in_section_backward(current, tip, Check_char, sectionhead, sectiontail, curswant, l:count, opt)
  call g:assert.equals(current.lnum, 1, 'failed at #5 (current.lnum)')
  call g:assert.equals(current.col,  1, 'failed at #5 (current.col)')
  call g:assert.equals(current.dest, 1, 'failed at #5 (current.dest)')
  call g:assert.equals(tip.lnum,     0, 'failed at #5 (tip.lnum)')
  %delete

  " #6
  call append(0, [' ', 'b'])
  $delete
  let current     = {'lnum': line('$'), 'col': 0, 'class': -1, 'count': 0, 'dest': 0}
  let tip         = {}
  let sectionhead = line('$')
  let sectiontail = 1
  let Check_char  = s:columnmove.check_char_w
  let curswant    = 1
  let l:count     = 1
  let opt.fold_treatment = 0
  let opt.stop_on_space  = 1
  let [current, tip] = s:columnmove.search_short_of_border_in_section_backward(current, tip, Check_char, sectionhead, sectiontail, curswant, l:count, opt)
  call g:assert.equals(current.lnum, 0, 'failed at #6 (current.lnum)')
  call g:assert.equals(current.dest, 0, 'failed at #6 (current.dest)')
  call g:assert.equals(tip.lnum,    -1, 'failed at #6 (tip.lnum)')
  %delete

  " #7
  call append(0, [' ', ':'])
  $delete
  let current     = {'lnum': line('$'), 'col': 0, 'class': -1, 'count': 0, 'dest': 0}
  let tip         = {}
  let sectionhead = line('$')
  let sectiontail = 1
  let Check_char  = s:columnmove.check_char_w
  let curswant    = 1
  let l:count     = 1
  let opt.fold_treatment = 0
  let opt.stop_on_space  = 1
  let [current, tip] = s:columnmove.search_short_of_border_in_section_backward(current, tip, Check_char, sectionhead, sectiontail, curswant, l:count, opt)
  call g:assert.equals(current.lnum, 0, 'failed at #7 (current.lnum)')
  call g:assert.equals(current.dest, 0, 'failed at #7 (current.dest)')
  call g:assert.equals(tip.lnum,    -1, 'failed at #7 (tip.lnum)')
  %delete

  " #8
  call append(0, [' ', ' '])
  $delete
  let current     = {'lnum': line('$'), 'col': 0, 'class': -1, 'count': 0, 'dest': 0}
  let tip         = {}
  let sectionhead = line('$')
  let sectiontail = 1
  let Check_char  = s:columnmove.check_char_w
  let curswant    = 1
  let l:count     = 1
  let opt.fold_treatment = 0
  let opt.stop_on_space  = 1
  let [current, tip] = s:columnmove.search_short_of_border_in_section_backward(current, tip, Check_char, sectionhead, sectiontail, curswant, l:count, opt)
  call g:assert.equals(current.lnum, 0, 'failed at #8 (current.lnum)')
  call g:assert.equals(current.dest, 0, 'failed at #8 (current.dest)')
  call g:assert.equals(tip.lnum,    -1, 'failed at #8 (tip.lnum)')
  %delete

  " #9
  call append(0, [' ', ''])
  $delete
  let current     = {'lnum': line('$'), 'col': 0, 'class': -1, 'count': 0, 'dest': 0}
  let tip         = {}
  let sectionhead = line('$')
  let sectiontail = 1
  let Check_char  = s:columnmove.check_char_w
  let curswant    = 1
  let l:count     = 1
  let opt.fold_treatment = 0
  let opt.stop_on_space  = 1
  let [current, tip] = s:columnmove.search_short_of_border_in_section_backward(current, tip, Check_char, sectionhead, sectiontail, curswant, l:count, opt)
  call g:assert.equals(current.lnum, 0, 'failed at #9 (current.lnum)')
  call g:assert.equals(current.dest, 0, 'failed at #9 (current.dest)')
  call g:assert.equals(tip.lnum,    -1, 'failed at #9 (tip.lnum)')
  %delete

  " #10
  call append(0, ['abc', 'def', 'ghi'])
  $delete
  let current     = {'lnum': line('$'), 'col': 0, 'class': -1, 'count': 0, 'dest': 0}
  let tip         = {}
  let sectionhead = line('$')
  let sectiontail = 1
  let Check_char  = s:columnmove.check_char_w
  let curswant    = 2
  let l:count     = 1
  let opt.fold_treatment = 0
  let opt.stop_on_space  = 1
  let [current, tip] = s:columnmove.search_short_of_border_in_section_backward(current, tip, Check_char, sectionhead, sectiontail, curswant, l:count, opt)
  call g:assert.equals(current.lnum, 1, 'failed at #10 (current.lnum)')
  call g:assert.equals(current.col,  2, 'failed at #10 (current.col)')
  call g:assert.equals(current.dest, 1, 'failed at #10 (current.dest)')
  call g:assert.equals(tip.lnum,     0, 'failed at #10 (tip.lnum)')
  %delete

  " #11
  call append(0, ['abc', 'def', 'ghi'])
  $delete
  let current     = {'lnum': line('$'), 'col': 0, 'class': -1, 'count': 0, 'dest': 0}
  let tip         = {}
  let sectionhead = line('$')
  let sectiontail = 1
  let Check_char  = s:columnmove.check_char_w
  let curswant    = 3
  let l:count     = 1
  let opt.fold_treatment = 0
  let opt.stop_on_space  = 1
  let [current, tip] = s:columnmove.search_short_of_border_in_section_backward(current, tip, Check_char, sectionhead, sectiontail, curswant, l:count, opt)
  call g:assert.equals(current.lnum, 1, 'failed at #11 (current.lnum)')
  call g:assert.equals(current.col,  3, 'failed at #11 (current.col)')
  call g:assert.equals(current.dest, 1, 'failed at #11 (current.dest)')
  call g:assert.equals(tip.lnum,     0, 'failed at #11 (tip.lnum)')
  %delete

  " #12
  call append(0, ['abc', ':::', 'def'])
  $delete
  let current     = {'lnum': line('$'), 'col': 0, 'class': -1, 'count': 0, 'dest': 0}
  let tip         = {}
  let sectionhead = line('$')
  let sectiontail = 1
  let Check_char  = s:columnmove.check_char_w
  let curswant    = 2
  let l:count     = 1
  let opt.fold_treatment = 0
  let opt.stop_on_space  = 1
  let [current, tip] = s:columnmove.search_short_of_border_in_section_backward(current, tip, Check_char, sectionhead, sectiontail, curswant, l:count, opt)
  call g:assert.equals(current.lnum, 2, 'failed at #12 (current.lnum)')
  call g:assert.equals(current.col,  2, 'failed at #12 (current.col)')
  call g:assert.equals(current.dest, 1, 'failed at #12 (current.dest)')
  call g:assert.equals(tip.lnum,     1, 'failed at #12 (tip.lnum)')
  %delete

  " #13
  call append(0, ['abc', ':::', 'def'])
  $delete
  let current     = {'lnum': line('$'), 'col': 0, 'class': -1, 'count': 0, 'dest': 0}
  let tip         = {}
  let sectionhead = line('$')
  let sectiontail = 1
  let Check_char  = s:columnmove.check_char_w
  let curswant    = 3
  let l:count     = 1
  let opt.fold_treatment = 0
  let opt.stop_on_space  = 1
  let [current, tip] = s:columnmove.search_short_of_border_in_section_backward(current, tip, Check_char, sectionhead, sectiontail, curswant, l:count, opt)
  call g:assert.equals(current.lnum, 2, 'failed at #13 (current.lnum)')
  call g:assert.equals(current.col,  3, 'failed at #13 (current.col)')
  call g:assert.equals(current.dest, 1, 'failed at #13 (current.dest)')
  call g:assert.equals(tip.lnum,     1, 'failed at #13 (tip.lnum)')
  %delete

  " #14
  call append(0, ['abc', '   ', 'def'])
  $delete
  let current     = {'lnum': line('$'), 'col': 0, 'class': -1, 'count': 0, 'dest': 0}
  let tip         = {}
  let sectionhead = line('$')
  let sectiontail = 1
  let Check_char  = s:columnmove.check_char_w
  let curswant    = 2
  let l:count     = 1
  let opt.fold_treatment = 0
  let opt.stop_on_space  = 1
  let [current, tip] = s:columnmove.search_short_of_border_in_section_backward(current, tip, Check_char, sectionhead, sectiontail, curswant, l:count, opt)
  call g:assert.equals(current.lnum, 1, 'failed at #14 (current.lnum)')
  call g:assert.equals(current.col,  2, 'failed at #14 (current.col)')
  call g:assert.equals(current.dest, 1, 'failed at #14 (current.dest)')
  call g:assert.equals(tip.lnum,     0, 'failed at #14 (tip.lnum)')
  %delete

  " #15
  call append(0, ['abc', '   ', 'def'])
  $delete
  let current     = {'lnum': line('$'), 'col': 0, 'class': -1, 'count': 0, 'dest': 0}
  let tip         = {}
  let sectionhead = line('$')
  let sectiontail = 1
  let Check_char  = s:columnmove.check_char_w
  let curswant    = 3
  let l:count     = 1
  let opt.fold_treatment = 0
  let opt.stop_on_space  = 1
  let [current, tip] = s:columnmove.search_short_of_border_in_section_backward(current, tip, Check_char, sectionhead, sectiontail, curswant, l:count, opt)
  call g:assert.equals(current.lnum, 1, 'failed at #15 (current.lnum)')
  call g:assert.equals(current.col,  3, 'failed at #15 (current.col)')
  call g:assert.equals(current.dest, 1, 'failed at #15 (current.dest)')
  call g:assert.equals(tip.lnum,     0, 'failed at #15 (tip.lnum)')
  %delete

  " #16
  call append(0, ['abc', '', 'def'])
  $delete
  let current     = {'lnum': line('$'), 'col': 0, 'class': -1, 'count': 0, 'dest': 0}
  let tip         = {}
  let sectionhead = line('$')
  let sectiontail = 1
  let Check_char  = s:columnmove.check_char_w
  let curswant    = 2
  let l:count     = 1
  let opt.fold_treatment = 0
  let opt.stop_on_space  = 1
  let [current, tip] = s:columnmove.search_short_of_border_in_section_backward(current, tip, Check_char, sectionhead, sectiontail, curswant, l:count, opt)
  call g:assert.equals(current.lnum, 1, 'failed at #16 (current.lnum)')
  call g:assert.equals(current.col,  2, 'failed at #16 (current.col)')
  call g:assert.equals(current.dest, 1, 'failed at #16 (current.dest)')
  call g:assert.equals(tip.lnum,     0, 'failed at #16 (tip.lnum)')
  %delete

  " #17
  call append(0, ['abc', '', 'def'])
  $delete
  let current     = {'lnum': line('$'), 'col': 0, 'class': -1, 'count': 0, 'dest': 0}
  let tip         = {}
  let sectionhead = line('$')
  let sectiontail = 1
  let Check_char  = s:columnmove.check_char_w
  let curswant    = 3
  let l:count     = 1
  let opt.fold_treatment = 0
  let opt.stop_on_space  = 1
  let [current, tip] = s:columnmove.search_short_of_border_in_section_backward(current, tip, Check_char, sectionhead, sectiontail, curswant, l:count, opt)
  call g:assert.equals(current.lnum, 1, 'failed at #17 (current.lnum)')
  call g:assert.equals(current.col,  3, 'failed at #17 (current.col)')
  call g:assert.equals(current.dest, 1, 'failed at #17 (current.dest)')
  call g:assert.equals(tip.lnum,     0, 'failed at #17 (tip.lnum)')
  %delete

  " #18
  call append(0, ['a', ':', 'b', '', 'c'])
  $delete
  let current     = {'lnum': line('$'), 'col': 0, 'class': -1, 'count': 0, 'dest': 0}
  let tip         = {}
  let sectionhead = line('$')
  let sectiontail = 1
  let Check_char  = s:columnmove.check_char_w
  let curswant    = 1
  let l:count     = 2
  let opt.fold_treatment = 0
  let opt.stop_on_space  = 1
  let [current, tip] = s:columnmove.search_short_of_border_in_section_backward(current, tip, Check_char, sectionhead, sectiontail, curswant, l:count, opt)
  call g:assert.equals(current.lnum, 2, 'failed at #18 (current.lnum)')
  call g:assert.equals(current.col,  1, 'failed at #18 (current.col)')
  call g:assert.equals(current.dest, 1, 'failed at #18 (current.dest)')
  call g:assert.equals(tip.lnum,     1, 'failed at #18 (tip.lnum)')
  %delete

  " #19
  call append(0, ['a', ':', 'b', '', 'c'])
  $delete
  let current     = {'lnum': 5, 'col': 0, 'class': -1, 'count': 0, 'dest': 0}
  let tip         = {}
  let sectionhead = 5
  let sectiontail = 2
  let Check_char  = s:columnmove.check_char_w
  let curswant    = 1
  let l:count     = 2
  let opt.fold_treatment = 0
  let opt.stop_on_space  = 1
  let [current, tip] = s:columnmove.search_short_of_border_in_section_backward(current, tip, Check_char, sectionhead, sectiontail, curswant, l:count, opt)
  call g:assert.equals(current.lnum, 2, 'failed at #19 (current.lnum)')
  call g:assert.equals(current.col,  1, 'failed at #19 (current.col)')
  call g:assert.equals(current.dest, 1, 'failed at #19 (current.dest)')
  call g:assert.equals(tip.lnum,     1, 'failed at #19 (tip.lnum)')
  %delete

  " #20
  call append(0, ['a', ':', 'b', '', 'c'])
  $delete
  let current     = {'lnum': 5, 'col': 0, 'class': -1, 'count': 0, 'dest': 0}
  let tip         = {}
  let sectionhead = 5
  let sectiontail = 3
  let Check_char  = s:columnmove.check_char_w
  let curswant    = 1
  let l:count     = 2
  let opt.fold_treatment = 0
  let opt.stop_on_space  = 1
  let [current, tip] = s:columnmove.search_short_of_border_in_section_backward(current, tip, Check_char, sectionhead, sectiontail, curswant, l:count, opt)
  call g:assert.equals(current.lnum, 2, 'failed at #20 (current.lnum)')
  call g:assert.equals(current.dest, 0, 'failed at #20 (current.dest)')
  call g:assert.equals(tip.lnum,     1, 'failed at #20 (tip.lnum)')
  %delete

  " #21
  call append(0, ['a', ':', 'b', '', 'c'])
  $delete
  let current     = {'lnum': 4, 'col': 0, 'class': -1, 'count': 0, 'dest': 0}
  let tip         = {}
  let sectionhead = 4
  let sectiontail = 1
  let Check_char  = s:columnmove.check_char_w
  let curswant    = 1
  let l:count     = 2
  let opt.fold_treatment = 0
  let opt.stop_on_space  = 1
  let [current, tip] = s:columnmove.search_short_of_border_in_section_backward(current, tip, Check_char, sectionhead, sectiontail, curswant, l:count, opt)
  call g:assert.equals(current.lnum, 2, 'failed at #21 (current.lnum)')
  call g:assert.equals(current.col,  1, 'failed at #21 (current.col)')
  call g:assert.equals(current.dest, 1, 'failed at #21 (current.dest)')
  call g:assert.equals(tip.lnum,     1, 'failed at #21 (tip.lnum)')
  %delete

  " #22
  call append(0, ['a', ':', 'b', '', 'c'])
  $delete
  let current     = {'lnum': 5, 'col': 0, 'class': -1, 'count': 0, 'dest': 0}
  let tip         = {}
  let sectionhead = 5
  let sectiontail = 1
  let Check_char  = s:columnmove.check_char_w
  let curswant    = 1
  let l:count     = 3
  let opt.fold_treatment = 0
  let opt.stop_on_space  = 1
  let [current, tip] = s:columnmove.search_short_of_border_in_section_backward(current, tip, Check_char, sectionhead, sectiontail, curswant, l:count, opt)
  call g:assert.equals(current.lnum, 1, 'failed at #22 (current.lnum)')
  call g:assert.equals(current.col,  1, 'failed at #22 (current.col)')
  call g:assert.equals(current.dest, 1, 'failed at #22 (current.dest)')
  call g:assert.equals(tip.lnum,     0, 'failed at #22 (tip.lnum)')
  %delete

  " #23
  call append(0, ['a', ':', 'b', '', 'c'])
  $delete
  let current     = {'lnum': 5, 'col': 0, 'class': -1, 'count': 0, 'dest': 0}
  let tip         = {}
  let sectionhead = 5
  let sectiontail = 1
  let Check_char  = s:columnmove.check_char_w
  let curswant    = 1
  let l:count     = 1
  let opt.fold_treatment = 0
  let opt.stop_on_space  = 1
  2,4fold
  let [current, tip] = s:columnmove.search_short_of_border_in_section_backward(current, tip, Check_char, sectionhead, sectiontail, curswant, l:count, opt)
  call g:assert.equals(current.lnum, 1, 'failed at #23 (current.lnum)')
  call g:assert.equals(current.col,  1, 'failed at #23 (current.col)')
  call g:assert.equals(current.dest, 1, 'failed at #23 (current.dest)')
  call g:assert.equals(tip.lnum,     0, 'failed at #23 (tip.lnum)')
  %delete

  " #24
  call append(0, ['a', ':', 'b', '', 'c'])
  $delete
  let current     = {'lnum': 5, 'col': 0, 'class': -1, 'count': 0, 'dest': 0}
  let tip         = {}
  let sectionhead = 5
  let sectiontail = 1
  let Check_char  = s:columnmove.check_char_w
  let curswant    = 1
  let l:count     = 1
  let opt.fold_treatment = 1
  let opt.stop_on_space  = 1
  2,4fold
  let [current, tip] = s:columnmove.search_short_of_border_in_section_backward(current, tip, Check_char, sectionhead, sectiontail, curswant, l:count, opt)
  call g:assert.equals(current.lnum, 1, 'failed at #24 (current.lnum)')
  call g:assert.equals(current.col,  1, 'failed at #24 (current.col)')
  call g:assert.equals(current.dest, 1, 'failed at #24 (current.dest)')
  call g:assert.equals(tip.lnum,     0, 'failed at #24 (tip.lnum)')
  %delete

  " #25
  call append(0, ['a', ':', 'b', '', 'c'])
  $delete
  let current     = {'lnum': 5, 'col': 0, 'class': -1, 'count': 0, 'dest': 0}
  let tip         = {}
  let sectionhead = 5
  let sectiontail = 1
  let Check_char  = s:columnmove.check_char_w
  let curswant    = 1
  let l:count     = 1
  let opt.fold_treatment = 1
  let opt.stop_on_space  = 1
  1,4fold
  let [current, tip] = s:columnmove.search_short_of_border_in_section_backward(current, tip, Check_char, sectionhead, sectiontail, curswant, l:count, opt)
  call g:assert.equals(current.lnum, 0, 'failed at #25 (current.lnum)')
  call g:assert.equals(current.dest, 0, 'failed at #25 (current.dest)')
  call g:assert.equals(tip.lnum,    -1, 'failed at #25 (tip.lnum)')
  %delete
endfunction
"}}}

" vim:set foldmethod=marker:
" vim:set commentstring="%s:
" vim:set ts=2 sts=2 sw=2 et:
