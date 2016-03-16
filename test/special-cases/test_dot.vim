scriptencoding utf-8
if has('win16') || has('win32') || has('win64') || has('win95')
  set shellslash
endif
execute 'set runtimepath+=' . expand('<sfile>:p:h:h:h')
source <sfile>:p:h:h:h/plugin/columnmove.vim

function! s:assert(a1, a2, kind) abort
  if type(a:a1) == type(a:a2) && string(a:a1) ==# string(a:a2)
    return
  endif

  %delete
  call append(0, ['Got:', string(a:a1)])
  call append(0, [printf('Failured at "%s"', a:kind), '', 'Expect:', string(a:a2)])
  $delete
  execute printf('1,%dprint', line('$'))
  cquit
endfunction



""" columnmove-f  "{{{
mapclear
mapclear!
call columnmove#utility#map('o', 'f', '\f')

" normal usage
call append(0, ['a', 'b', 'a', 'b', 'a', 'b'])
$delete
normal 1G0d\fb
call s:assert(getline(1, '$'), ['a', 'b', 'a', 'b'], 'columnmove-f: normal usage #1')
normal! .
call s:assert(getline(1, '$'), ['a', 'b'], 'columnmove-f: normal usage #2')
%delete

" count
call append(0, ['a', 'b', 'a', 'b', 'a', 'b', 'a', 'b', 'a', 'b', 'a', 'b'])
$delete
normal 1G0d2\fb
call s:assert(getline(1, '$'), ['a', 'b', 'a', 'b', 'a', 'b', 'a', 'b'], 'columnmove-f: count #1')
normal! .
call s:assert(getline(1, '$'), ['a', 'b', 'a', 'b'], 'columnmove-f: count #2')
%delete

call append(0, ['a', 'b', 'a', 'b', 'a', 'b', 'a', 'b', 'a', 'b', 'a', 'b'])
$delete
normal 1G0d2\fb
call s:assert(getline(1, '$'), ['a', 'b', 'a', 'b', 'a', 'b', 'a', 'b'], 'columnmove-f: count #3')
normal! 3.
call s:assert(getline(1, '$'), ['a', 'b'], 'columnmove-f: count #4')
%delete

" motionwise
call append(0, ['aaa', 'bbb', 'aaa', 'bbb', 'aaa', 'bbb'])
$delete
normal 1G0ld\fb
call s:assert(getline(1, '$'), ['aaa', 'bbb', 'aaa', 'bbb'], 'columnmove-f: motionwise #1 (default:linewise)')
normal! .
call s:assert(getline(1, '$'), ['aaa', 'bbb'], 'columnmove-f: motionwise #2 (default:linewise)')
%delete

call append(0, ['aaa', 'bbb', 'aaa', 'bbb', 'aaa', 'bbb'])
$delete
normal 1G0ldv\fb
call s:assert(getline(1, '$'), ['abb', 'aaa', 'bbb', 'aaa', 'bbb'], 'columnmove-f: motionwise #3 (characterwise)')
normal! .
call s:assert(getline(1, '$'), ['abb', 'aaa', 'bbb'], 'columnmove-f: motionwise #4 (characterwise)')
%delete

call append(0, ['aaa', 'bbb', 'aaa', 'bbb', 'aaa', 'bbb'])
$delete
normal 1G0ldV\fb
call s:assert(getline(1, '$'), ['aaa', 'bbb', 'aaa', 'bbb'], 'columnmove-f: motionwise #5 (linewise)')
normal! .
call s:assert(getline(1, '$'), ['aaa', 'bbb'], 'columnmove-f: motionwise #6 (linewise)')
%delete

call append(0, ['aaa', 'bbb', 'aaa', 'bbb', 'aaa', 'bbb'])
$delete
execute "normal 1G0ld\<C-v>\\fb"
call s:assert(getline(1, '$'), ['aa', 'bb', 'aaa', 'bbb', 'aaa', 'bbb'], 'columnmove-f: motionwise #7 (blockwise)')
normal! .
call s:assert(getline(1, '$'), ['a', 'b', 'aaa', 'bbb', 'aaa', 'bbb'], 'columnmove-f: motionwise #8 (blockwise)')
%delete
"}}}

""" columnmove-t  "{{{
mapclear
mapclear!
call columnmove#utility#map('o', 't', '\t')

" normal usage
call append(0, ['a', 'b', 'a', 'b', 'a', 'b'])
$delete
normal 1G0d\tb
call s:assert(getline(1, '$'), ['b', 'a', 'b'], 'columnmove-t: normal usage #1')
normal! .
call s:assert(getline(1, '$'), ['b'], 'columnmove-t: normal usage #2')
%delete

" count
call append(0, ['a', 'b', 'a', 'b', 'a', 'b', 'a', 'b', 'a', 'b', 'a', 'b'])
$delete
normal 1G0d2\tb
call s:assert(getline(1, '$'), ['b', 'a', 'b', 'a', 'b', 'a', 'b'], 'columnmove-t: count #1')
normal! .
call s:assert(getline(1, '$'), ['b', 'a', 'b'], 'columnmove-t: count #2')
%delete

call append(0, ['a', 'b', 'a', 'b', 'a', 'b', 'a', 'b', 'a', 'b', 'a', 'b', 'a', 'b'])
$delete
normal 1G0d2\tb
call s:assert(getline(1, '$'), ['b', 'a', 'b', 'a', 'b', 'a', 'b', 'a', 'b'], 'columnmove-t: count #3')
normal! 3.
call s:assert(getline(1, '$'), ['b', 'a', 'b'], 'columnmove-t: count #4')
%delete

" motionwise
call append(0, ['aaa', 'bbb', 'aaa', 'bbb', 'aaa', 'bbb'])
$delete
normal 1G0ld\tb
call s:assert(getline(1, '$'), ['bbb', 'aaa', 'bbb'], 'columnmove-t: motionwise #1 (default:linewise)')
normal! .
call s:assert(getline(1, '$'), ['bbb'], 'columnmove-t: motionwise #2 (default:linewise)')
%delete

call append(0, ['aaa', 'bbb', 'aaa', 'bbb', 'aaa', 'bbb'])
$delete
normal 1G0ldv\tb
call s:assert(getline(1, '$'), ['aaa', 'bbb', 'aaa', 'bbb'], 'columnmove-t: motionwise #3 (characterwise)')
normal! .
call s:assert(getline(1, '$'), ['aaa', 'bbb'], 'columnmove-t: motionwise #4 (characterwise)')
%delete

call append(0, ['aaa', 'bbb', 'aaa', 'bbb', 'aaa', 'bbb'])
$delete
normal 1G0ldV\tb
call s:assert(getline(1, '$'), ['bbb', 'aaa', 'bbb'], 'columnmove-t: motionwise #5 (linewise)')
normal! .
call s:assert(getline(1, '$'), ['bbb'], 'columnmove-t: motionwise #6 (linewise)')
%delete

call append(0, ['aaa', 'bbb', 'aaa', 'bbb', 'aaa', 'bbb'])
$delete
execute "normal 1G0ld\<C-v>\\tb"
call s:assert(getline(1, '$'), ['aa', 'bb', 'aa', 'bbb', 'aaa', 'bbb'], 'columnmove-t: motionwise #7 (blockwise)')
normal! .
call s:assert(getline(1, '$'), ['a', 'b', 'a', 'bbb', 'aaa', 'bbb'], 'columnmove-t: motionwise #8 (blockwise)')
%delete
"}}}

""" columnmove-F  "{{{
mapclear
mapclear!
call columnmove#utility#map('o', 'F', '\F')

" normal usage
call append(0, ['a', 'b', 'a', 'b', 'a', 'b'])
$delete
normal G0d\Fb
call s:assert(getline(1, '$'), ['a', 'b', 'a'], 'columnmove-F: normal usage #1')
normal! .
call s:assert(getline(1, '$'), ['a'], 'columnmove-F: normal usage #2')
%delete

" count
call append(0, ['a', 'b', 'a', 'b', 'a', 'b', 'a', 'b', 'a', 'b', 'a', 'b'])
$delete
normal G0d2\Fb
call s:assert(getline(1, '$'), ['a', 'b', 'a', 'b', 'a', 'b', 'a'], 'columnmove-F: count #1')
normal! .
call s:assert(getline(1, '$'), ['a', 'b', 'a'], 'columnmove-F: count #2')
%delete

call append(0, ['a', 'b', 'a', 'b', 'a', 'b', 'a', 'b', 'a', 'b', 'a', 'b'])
$delete
normal G0d2\Fb
call s:assert(getline(1, '$'), ['a', 'b', 'a', 'b', 'a', 'b', 'a'], 'columnmove-F: count #3')
normal! 3.
call s:assert(getline(1, '$'), ['a'], 'columnmove-F: count #4')
%delete

" motionwise
call append(0, ['aaa', 'bbb', 'aaa', 'bbb', 'aaa', 'bbb'])
$delete
normal G0ld\Fb
call s:assert(getline(1, '$'), ['aaa', 'bbb', 'aaa'], 'columnmove-F: motionwise #1 (default:linewise)')
normal! .
call s:assert(getline(1, '$'), ['aaa'], 'columnmove-F: motionwise #2 (default:linewise)')
%delete

call append(0, ['aaa', 'bbb', 'aaa', 'bbb', 'aaa', 'bbb'])
$delete
normal G0ldv\Fb
call s:assert(getline(1, '$'), ['aaa', 'bbb', 'aaa', 'bbb'], 'columnmove-F: motionwise #3 (characterwise)')
normal! .
call s:assert(getline(1, '$'), ['aaa', 'bbb'], 'columnmove-f: motionwise #4 (characterwise)')
%delete

call append(0, ['aaa', 'bbb', 'aaa', 'bbb', 'aaa', 'bbb'])
$delete
normal G0ldV\Fb
call s:assert(getline(1, '$'), ['aaa', 'bbb', 'aaa'], 'columnmove-F: motionwise #5 (linewise)')
normal! .
call s:assert(getline(1, '$'), ['aaa'], 'columnmove-F: motionwise #6 (linewise)')
%delete

call append(0, ['aaa', 'bbb', 'aaa', 'bbb', 'aaa', 'bbb'])
$delete
execute "normal G0ld\<C-v>\\Fb"
call s:assert(getline(1, '$'), ['aaa', 'bbb', 'aaa', 'bb', 'aa', 'bb'], 'columnmove-F: motionwise #7 (blockwise)')
normal! .
call s:assert(getline(1, '$'), ['aaa', 'bb', 'aa', 'b', 'aa', 'bb'], 'columnmove-F: motionwise #8 (blockwise)')
%delete
"}}}

""" columnmove-T  "{{{
mapclear
mapclear!
call columnmove#utility#map('o', 'T', '\T')

" normal usage
call append(0, ['a', 'b', 'a', 'b', 'a', 'b'])
$delete
normal G0d\Tb
call s:assert(getline(1, '$'), ['a', 'b', 'a', 'b'], 'columnmove-T: normal usage #1')
normal! .
call s:assert(getline(1, '$'), ['a', 'b'], 'columnmove-T: normal usage #2')
%delete

" count
call append(0, ['a', 'b', 'a', 'b', 'a', 'b', 'a', 'b', 'a', 'b', 'a', 'b'])
$delete
normal G0d2\Tb
call s:assert(getline(1, '$'), ['a', 'b', 'a', 'b', 'a', 'b', 'a', 'b'], 'columnmove-T: count #1')
normal! .
call s:assert(getline(1, '$'), ['a', 'b', 'a', 'b'], 'columnmove-T: count #2')
%delete

call append(0, ['a', 'b', 'a', 'b', 'a', 'b', 'a', 'b', 'a', 'b', 'a', 'b'])
$delete
normal G0d2\Tb
call s:assert(getline(1, '$'), ['a', 'b', 'a', 'b', 'a', 'b', 'a', 'b'], 'columnmove-T: count #3')
normal! 3.
call s:assert(getline(1, '$'), ['a', 'b'], 'columnmove-T: count #4')
%delete

" motionwise
call append(0, ['aaa', 'bbb', 'aaa', 'bbb', 'aaa', 'bbb'])
$delete
normal G0ld\Tb
call s:assert(getline(1, '$'), ['aaa', 'bbb', 'aaa', 'bbb'], 'columnmove-T: motionwise #1 (default:linewise)')
normal! .
call s:assert(getline(1, '$'), ['aaa', 'bbb'], 'columnmove-T: motionwise #2 (default:linewise)')
%delete

call append(0, ['aaa', 'bbb', 'aaa', 'bbb', 'aaa', 'bbb'])
$delete
normal G0ldv\Tb
call s:assert(getline(1, '$'), ['aaa', 'bbb', 'aaa', 'bbb', 'abb'], 'columnmove-T: motionwise #3 (characterwise)')
normal! .
call s:assert(getline(1, '$'), ['aaa', 'bbb', 'abb'], 'columnmove-T: motionwise #4 (characterwise)')
%delete

call append(0, ['aaa', 'bbb', 'aaa', 'bbb', 'aaa', 'bbb'])
$delete
normal G0ldV\Tb
call s:assert(getline(1, '$'), ['aaa', 'bbb', 'aaa', 'bbb'], 'columnmove-T: motionwise #5 (linewise)')
normal! .
call s:assert(getline(1, '$'), ['aaa', 'bbb'], 'columnmove-T: motionwise #6 (linewise)')
%delete

call append(0, ['aaa', 'bbb', 'aaa', 'bbb', 'aaa', 'bbb'])
$delete
execute "normal G0ld\<C-v>\\Tb"
call s:assert(getline(1, '$'), ['aaa', 'bbb', 'aaa', 'bbb', 'aa', 'bb'], 'columnmove-T: motionwise #7 (blockwise)')
normal! .
call s:assert(getline(1, '$'), ['aaa', 'bbb', 'aa', 'bb', 'a', 'bb'], 'columnmove-T: motionwise #8 (blockwise)')
%delete
"}}}

""" columnmove-;  "{{{
mapclear
mapclear!
call columnmove#utility#map('o', 'f', '\f')
call columnmove#utility#map('o', ';', '\;')

call append(0, ['a', 'b'])
normal 1G0d\fb
%delete

" normal usage
call append(0, ['a', 'b', 'a', 'b', 'a', 'b'])
$delete
normal 1G0d\;
call s:assert(getline(1, '$'), ['a', 'b', 'a', 'b'], 'columnmove-;: normal usage #1')
normal! .
call s:assert(getline(1, '$'), ['a', 'b'], 'columnmove-;: normal usage #2')
%delete

" count
call append(0, ['a', 'b', 'a', 'b', 'a', 'b', 'a', 'b', 'a', 'b', 'a', 'b'])
$delete
normal 1G0d2\;
call s:assert(getline(1, '$'), ['a', 'b', 'a', 'b', 'a', 'b', 'a', 'b'], 'columnmove-;: count #1')
normal! .
call s:assert(getline(1, '$'), ['a', 'b', 'a', 'b'], 'columnmove-;: count #2')
%delete

call append(0, ['a', 'b', 'a', 'b', 'a', 'b', 'a', 'b', 'a', 'b', 'a', 'b'])
$delete
normal 1G0d2\;
call s:assert(getline(1, '$'), ['a', 'b', 'a', 'b', 'a', 'b', 'a', 'b'], 'columnmove-;: count #3')
normal! 3.
call s:assert(getline(1, '$'), ['a', 'b'], 'columnmove-;: count #4')
%delete

" motionwise
call append(0, ['aaa', 'bbb', 'aaa', 'bbb', 'aaa', 'bbb'])
$delete
normal 1G0ld\;
call s:assert(getline(1, '$'), ['aaa', 'bbb', 'aaa', 'bbb'], 'columnmove-;: motionwise #1 (default:linewise)')
normal! .
call s:assert(getline(1, '$'), ['aaa', 'bbb'], 'columnmove-;: motionwise #2 (default:linewise)')
%delete

call append(0, ['aaa', 'bbb', 'aaa', 'bbb', 'aaa', 'bbb'])
$delete
normal 1G0ldv\;
call s:assert(getline(1, '$'), ['abb', 'aaa', 'bbb', 'aaa', 'bbb'], 'columnmove-;: motionwise #3 (characterwise)')
normal! .
call s:assert(getline(1, '$'), ['abb', 'aaa', 'bbb'], 'columnmove-;: motionwise #4 (characterwise)')
%delete

call append(0, ['aaa', 'bbb', 'aaa', 'bbb', 'aaa', 'bbb'])
$delete
normal 1G0ldV\;
call s:assert(getline(1, '$'), ['aaa', 'bbb', 'aaa', 'bbb'], 'columnmove-;: motionwise #5 (linewise)')
normal! .
call s:assert(getline(1, '$'), ['aaa', 'bbb'], 'columnmove-;: motionwise #6 (linewise)')
%delete

call append(0, ['aaa', 'bbb', 'aaa', 'bbb', 'aaa', 'bbb'])
$delete
execute "normal 1G0ld\<C-v>\\;"
call s:assert(getline(1, '$'), ['aa', 'bb', 'aaa', 'bbb', 'aaa', 'bbb'], 'columnmove-;: motionwise #7 (blockwise)')
normal! .
call s:assert(getline(1, '$'), ['a', 'b', 'aaa', 'bbb', 'aaa', 'bbb'], 'columnmove-;: motionwise #8 (blockwise)')
%delete
"}}}

""" columnmove-,  "{{{
mapclear
mapclear!
call columnmove#utility#map('o', 'F', '\F')
call columnmove#utility#map('o', ',', '\,')

call append(0, ['a', 'b', 'a'])
normal G0d\Fb
%delete

" normal usage
call append(0, ['a', 'b', 'a', 'b', 'a', 'b'])
$delete
normal 1G0d\,
call s:assert(getline(1, '$'), ['a', 'b', 'a', 'b'], 'columnmove-,: normal usage #1')
normal! .
call s:assert(getline(1, '$'), ['a', 'b'], 'columnmove-,: normal usage #2')
%delete

" count
call append(0, ['a', 'b', 'a', 'b', 'a', 'b', 'a', 'b', 'a', 'b', 'a', 'b'])
$delete
normal 1G0d2\,
call s:assert(getline(1, '$'), ['a', 'b', 'a', 'b', 'a', 'b', 'a', 'b'], 'columnmove-,: count #1')
normal! .
call s:assert(getline(1, '$'), ['a', 'b', 'a', 'b'], 'columnmove-,: count #2')
%delete

call append(0, ['a', 'b', 'a', 'b', 'a', 'b', 'a', 'b', 'a', 'b', 'a', 'b'])
$delete
normal 1G0d2\,
call s:assert(getline(1, '$'), ['a', 'b', 'a', 'b', 'a', 'b', 'a', 'b'], 'columnmove-,: count #3')
normal! 3.
call s:assert(getline(1, '$'), ['a', 'b'], 'columnmove-,: count #4')
%delete

" motionwise
call append(0, ['aaa', 'bbb', 'aaa', 'bbb', 'aaa', 'bbb'])
$delete
normal 1G0ld\,
call s:assert(getline(1, '$'), ['aaa', 'bbb', 'aaa', 'bbb'], 'columnmove-,: motionwise #1 (default:linewise)')
normal! .
call s:assert(getline(1, '$'), ['aaa', 'bbb'], 'columnmove-,: motionwise #2 (default:linewise)')
%delete

call append(0, ['aaa', 'bbb', 'aaa', 'bbb', 'aaa', 'bbb'])
$delete
normal 1G0ldv\,
call s:assert(getline(1, '$'), ['abb', 'aaa', 'bbb', 'aaa', 'bbb'], 'columnmove-,: motionwise #3 (characterwise)')
normal! .
call s:assert(getline(1, '$'), ['abb', 'aaa', 'bbb'], 'columnmove-,: motionwise #4 (characterwise)')
%delete

call append(0, ['aaa', 'bbb', 'aaa', 'bbb', 'aaa', 'bbb'])
$delete
normal 1G0ldV\,
call s:assert(getline(1, '$'), ['aaa', 'bbb', 'aaa', 'bbb'], 'columnmove-,: motionwise #5 (linewise)')
normal! .
call s:assert(getline(1, '$'), ['aaa', 'bbb'], 'columnmove-,: motionwise #6 (linewise)')
%delete

call append(0, ['aaa', 'bbb', 'aaa', 'bbb', 'aaa', 'bbb'])
$delete
execute "normal 1G0ld\<C-v>\\,"
call s:assert(getline(1, '$'), ['aa', 'bb', 'aaa', 'bbb', 'aaa', 'bbb'], 'columnmove-,: motionwise #7 (blockwise)')
normal! .
call s:assert(getline(1, '$'), ['a', 'b', 'aaa', 'bbb', 'aaa', 'bbb'], 'columnmove-,: motionwise #8 (blockwise)')
%delete
"}}}

""" columnmove-w "{{{
mapclear
mapclear!
call columnmove#utility#map('o', 'w', '\w')

" normal usage
call append(0, ['a', '', 'a', '', 'a', '', 'a'])
$delete
normal 1G0d\w
call s:assert(getline(1, '$'), ['', 'a', '', 'a'], 'columnmove-w: normal usage #1')
normal! .
call s:assert(getline(1, '$'), ['', 'a'], 'columnmove-w: normal usage #2')
%delete

" count
call append(0, ['a', '', 'a', '', 'a', '', 'a', '', 'a', '', 'a', '', 'a'])
$delete
normal 1G0d2\w
call s:assert(getline(1, '$'), ['', 'a', '', 'a', '', 'a', '', 'a'], 'columnmove-w: count #1')
normal! 2.
call s:assert(getline(1, '$'), ['', 'a', '', 'a'], 'columnmove-w: count #2')
%delete

call append(0, ['a', '', 'a', '', 'a', '', 'a', '', 'a', '', 'a', '', 'a'])
$delete
normal 1G0d2\w
call s:assert(getline(1, '$'), ['', 'a', '', 'a', '', 'a', '', 'a'], 'columnmove-w: count #3')
normal! 3.
call s:assert(getline(1, '$'), ['', 'a'], 'columnmove-w: count #4')
%delete

" motionwise
call append(0, ['aaa', ':::', 'aaa', ':::', 'aaa'])
$delete
normal 1G0ld\w
call s:assert(getline(1, '$'), ['aaa', ':::', 'aaa'], 'columnmove-w: motionwise #1 (default:linewise)')
normal! .
call s:assert(getline(1, '$'), ['aaa'], 'columnmove-w: motionwise #2 (default:linewise)')
%delete

call append(0, ['aaa', ':::', 'aaa', ':::', 'aaa'])
$delete
normal 1G0ldv\w
call s:assert(getline(1, '$'), ['a::', 'aaa', ':::', 'aaa'], 'columnmove-w: motionwise #3 (characterwise)')
normal! .
call s:assert(getline(1, '$'), ['aaa', ':::', 'aaa'], 'columnmove-w: motionwise #4 (characterwise)')
%delete

call append(0, ['aaa', ':::', 'aaa', ':::', 'aaa'])
$delete
normal 1G0ldV\w
call s:assert(getline(1, '$'), ['aaa', ':::', 'aaa'], 'columnmove-w: motionwise #5 (linewise)')
normal! .
call s:assert(getline(1, '$'), ['aaa'], 'columnmove-w: motionwise #6 (linewise)')
%delete

call append(0, ['aaa', ':::', 'aaa', ':::', 'aaa'])
$delete
execute "normal 1G0ld\<C-v>\\w"
call s:assert(getline(1, '$'), ['aa', '::', 'aaa', ':::', 'aaa'], 'columnmove-w: motionwise #7 (blockwise)')
normal! .
call s:assert(getline(1, '$'), ['a', ':', 'aaa', ':::', 'aaa'], 'columnmove-w: motionwise #8 (blockwise)')
%delete
"}}}

""" columnmove-b "{{{
mapclear
mapclear!
call columnmove#utility#map('o', 'b', '\b')

" normal usage
call append(0, ['a', '', 'a', '', 'a', '', 'a'])
$delete
normal G0d\b
call s:assert(getline(1, '$'), ['a', '', 'a', ''], 'columnmove-b: normal usage #1')
normal! .
call s:assert(getline(1, '$'), ['a', ''], 'columnmove-b: normal usage #2')
%delete

" count
call append(0, ['a', '', 'a', '', 'a', '', 'a', '', 'a', '', 'a', '', 'a'])
$delete
normal G0d2\b
call s:assert(getline(1, '$'), ['a', '', 'a', '', 'a', '', 'a', ''], 'columnmove-b: count #1')
normal! 2.
call s:assert(getline(1, '$'), ['a', '', 'a', ''], 'columnmove-b: count #2')
%delete

call append(0, ['a', '', 'a', '', 'a', '', 'a', '', 'a', '', 'a', '', 'a'])
$delete
normal G0d2\b
call s:assert(getline(1, '$'), ['a', '', 'a', '', 'a', '', 'a', ''], 'columnmove-b: count #3')
normal! 3.
call s:assert(getline(1, '$'), ['a', ''], 'columnmove-b: count #4')
%delete

" motionwise
call append(0, ['aaa', ':::', 'aaa', ':::', 'aaa'])
$delete
normal G0ld\b
call s:assert(getline(1, '$'), ['aaa', ':::', 'aaa'], 'columnmove-b: motionwise #1 (default:linewise)')
normal! .
call s:assert(getline(1, '$'), ['aaa'], 'columnmove-b: motionwise #2 (default:linewise)')
%delete

call append(0, ['aaa', ':::', 'aaa', ':::', 'aaa'])
$delete
normal G0ldv\b
call s:assert(getline(1, '$'), ['aaa', ':::', 'aaa', ':aa'], 'columnmove-b: motionwise #3 (characterwise)')
normal! .
call s:assert(getline(1, '$'), ['aaa', ':::', 'aaa'], 'columnmove-b: motionwise #4 (characterwise)')
%delete

call append(0, ['aaa', ':::', 'aaa', ':::', 'aaa'])
$delete
normal G0ldV\b
call s:assert(getline(1, '$'), ['aaa', ':::', 'aaa'], 'columnmove-b: motionwise #5 (linewise)')
normal! .
call s:assert(getline(1, '$'), ['aaa'], 'columnmove-b: motionwise #6 (linewise)')
%delete

call append(0, ['aaa', ':::', 'aaa', ':::', 'aaa'])
$delete
execute "normal G0ld\<C-v>\\b"
call s:assert(getline(1, '$'), ['aaa', ':::', 'aaa', '::', 'aa'], 'columnmove-b: motionwise #7 (blockwise)')
normal! .
call s:assert(getline(1, '$'), ['aaa', ':::', 'aa', ':', 'aa'], 'columnmove-b: motionwise #8 (blockwise)')
%delete
"}}}

""" columnmove-e "{{{
mapclear
mapclear!
call columnmove#utility#map('o', 'e', '\e')

" normal usage
call append(0, ['a', '', 'a', '', 'a', '', 'a'])
$delete
normal 1G0d\e
call s:assert(getline(1, '$'), ['', 'a', '', 'a'], 'columnmove-e: normal usage #1')
normal! .
call s:assert(getline(1, '$'), ['', 'a'], 'columnmove-e: normal usage #2')
%delete

" count
call append(0, ['a', '', 'a', '', 'a', '', 'a', '', 'a', '', 'a', '', 'a'])
$delete
normal 1G0d2\e
call s:assert(getline(1, '$'), ['', 'a', '', 'a', '', 'a', '', 'a'], 'columnmove-e: count #1')
normal! 2.
call s:assert(getline(1, '$'), ['', 'a', '', 'a'], 'columnmove-e: count #2')
%delete

call append(0, ['a', '', 'a', '', 'a', '', 'a', '', 'a', '', 'a', '', 'a'])
$delete
normal 1G0d2\e
call s:assert(getline(1, '$'), ['', 'a', '', 'a', '', 'a', '', 'a'], 'columnmove-e: count #3')
normal! 3.
call s:assert(getline(1, '$'), ['', 'a'], 'columnmove-e: count #4')
%delete

" motionwise
call append(0, ['aaa', ':::', 'aaa', ':::', 'aaa'])
$delete
normal 1G0ld\e
call s:assert(getline(1, '$'), ['aaa', ':::', 'aaa'], 'columnmove-e: motionwise #1 (default:linewise)')
normal! .
call s:assert(getline(1, '$'), ['aaa'], 'columnmove-e: motionwise #2 (default:linewise)')
%delete

call append(0, ['aaa', ':::', 'aaa', ':::', 'aaa'])
$delete
normal 1G0ldv\e
call s:assert(getline(1, '$'), ['a::', 'aaa', ':::', 'aaa'], 'columnmove-e: motionwise #3 (characterwise)')
normal! .
call s:assert(getline(1, '$'), ['aaa', ':::', 'aaa'], 'columnmove-e: motionwise #4 (characterwise)')
%delete

call append(0, ['aaa', ':::', 'aaa', ':::', 'aaa'])
$delete
normal 1G0ldV\e
call s:assert(getline(1, '$'), ['aaa', ':::', 'aaa'], 'columnmove-e: motionwise #5 (linewise)')
normal! .
call s:assert(getline(1, '$'), ['aaa'], 'columnmove-e: motionwise #6 (linewise)')
%delete

call append(0, ['aaa', ':::', 'aaa', ':::', 'aaa'])
$delete
execute "normal 1G0ld\<C-v>\\e"
call s:assert(getline(1, '$'), ['aa', '::', 'aaa', ':::', 'aaa'], 'columnmove-e: motionwise #7 (blockwise)')
normal! .
call s:assert(getline(1, '$'), ['a', ':', 'aaa', ':::', 'aaa'], 'columnmove-e: motionwise #8 (blockwise)')
%delete
"}}}

""" columnmove-ge "{{{
mapclear
mapclear!
call columnmove#utility#map('o', 'ge', '\ge')

" normal usage
call append(0, ['a', '', 'a', '', 'a', '', 'a'])
$delete
normal G0d\ge
call s:assert(getline(1, '$'), ['a', '', 'a', ''], 'columnmove-ge: normal usage #1')
normal! .
call s:assert(getline(1, '$'), ['a', ''], 'columnmove-ge: normal usage #2')
%delete

" count
call append(0, ['a', '', 'a', '', 'a', '', 'a', '', 'a', '', 'a', '', 'a'])
$delete
normal G0d2\ge
call s:assert(getline(1, '$'), ['a', '', 'a', '', 'a', '', 'a', ''], 'columnmove-ge: count #1')
normal! 2.
call s:assert(getline(1, '$'), ['a', '', 'a', ''], 'columnmove-ge: count #2')
%delete

call append(0, ['a', '', 'a', '', 'a', '', 'a', '', 'a', '', 'a', '', 'a'])
$delete
normal G0d2\ge
call s:assert(getline(1, '$'), ['a', '', 'a', '', 'a', '', 'a', ''], 'columnmove-ge: count #3')
normal! 3.
call s:assert(getline(1, '$'), ['a', ''], 'columnmove-ge: count #4')
%delete

" motionwise
call append(0, ['aaa', ':::', 'aaa', ':::', 'aaa'])
$delete
normal G0ld\ge
call s:assert(getline(1, '$'), ['aaa', ':::', 'aaa'], 'columnmove-ge: motionwise #1 (default:linewise)')
normal! .
call s:assert(getline(1, '$'), ['aaa'], 'columnmove-ge: motionwise #2 (default:linewise)')
%delete

call append(0, ['aaa', ':::', 'aaa', ':::', 'aaa'])
$delete
normal G0ldv\ge
call s:assert(getline(1, '$'), ['aaa', ':::', 'aaa', ':aa'], 'columnmove-ge: motionwise #3 (characterwise)')
normal! .
call s:assert(getline(1, '$'), ['aaa', ':aa'], 'columnmove-ge: motionwise #4 (characterwise)')
%delete

call append(0, ['aaa', ':::', 'aaa', ':::', 'aaa'])
$delete
normal G0ldV\ge
call s:assert(getline(1, '$'), ['aaa', ':::', 'aaa'], 'columnmove-ge: motionwise #5 (linewise)')
normal! .
call s:assert(getline(1, '$'), ['aaa'], 'columnmove-ge: motionwise #6 (linewise)')
%delete

call append(0, ['aaa', ':::', 'aaa', ':::', 'aaa'])
$delete
execute "normal G0ld\<C-v>\\ge"
call s:assert(getline(1, '$'), ['aaa', ':::', 'aaa', '::', 'aa'], 'columnmove-ge: motionwise #7 (blockwise)')
normal! .
call s:assert(getline(1, '$'), ['aaa', ':::', 'aa', ':', 'aa'], 'columnmove-ge: motionwise #8 (blockwise)')
%delete
"}}}

""" columnmove-W "{{{
mapclear
mapclear!
call columnmove#utility#map('o', 'W', '\W')

" normal usage
call append(0, ['a', '', 'a', '', 'a', '', 'a'])
$delete
normal 1G0d\W
call s:assert(getline(1, '$'), ['', 'a', '', 'a'], 'columnmove-W: normal usage #1')
normal! .
call s:assert(getline(1, '$'), ['', 'a'], 'columnmove-W: normal usage #2')
%delete

" count
call append(0, ['a', '', 'a', '', 'a', '', 'a', '', 'a', '', 'a', '', 'a'])
$delete
normal 1G0d2\W
call s:assert(getline(1, '$'), ['', 'a', '', 'a', '', 'a', '', 'a'], 'columnmove-W: count #1')
normal! 2.
call s:assert(getline(1, '$'), ['', 'a', '', 'a'], 'columnmove-W: count #2')
%delete

call append(0, ['a', '', 'a', '', 'a', '', 'a', '', 'a', '', 'a', '', 'a'])
$delete
normal 1G0d2\W
call s:assert(getline(1, '$'), ['', 'a', '', 'a', '', 'a', '', 'a'], 'columnmove-W: count #3')
normal! 3.
call s:assert(getline(1, '$'), ['', 'a'], 'columnmove-W: count #4')
%delete

" motionwise
call append(0, ['aaa', '', 'aaa', '', 'aaa', '', 'aaa'])
$delete
normal 1G0ld\W
call s:assert(getline(1, '$'), ['', 'aaa', '', 'aaa'], 'columnmove-W: motionwise #1 (default:linewise)')
normal! .
call s:assert(getline(1, '$'), ['', 'aaa'], 'columnmove-W: motionwise #2 (default:linewise)')
%delete

call append(0, ['aaa', '', 'aaa', '', 'aaa'])
$delete
normal 1G0ldv\W
call s:assert(getline(1, '$'), ['aaa', '', 'aaa'], 'columnmove-W: motionwise #3 (characterwise)')
normal! .
call s:assert(getline(1, '$'), ['aaa'], 'columnmove-W: motionwise #4 (characterwise)')
%delete

call append(0, ['aaa', '', 'aaa', '', 'aaa', '', 'aaa'])
$delete
normal 1G0ldV\W
call s:assert(getline(1, '$'), ['', 'aaa', '', 'aaa'], 'columnmove-W: motionwise #5 (linewise)')
normal! .
call s:assert(getline(1, '$'), ['', 'aaa'], 'columnmove-W: motionwise #6 (linewise)')
%delete

call append(0, ['aaa', '', 'aaa', '', 'aaa'])
$delete
execute "normal 1G0ld\<C-v>\\W"
call s:assert(getline(1, '$'), ['aa', '', 'aa', '', 'aaa'], 'columnmove-W: motionwise #7 (blockwise)')
normal! .
call s:assert(getline(1, '$'), ['a', '', 'a', '', 'aaa'], 'columnmove-W: motionwise #8 (blockwise)')
%delete
"}}}

""" columnmove-B "{{{
mapclear
mapclear!
call columnmove#utility#map('o', 'B', '\B')

" normal usage
call append(0, ['a', '', 'a', '', 'a', '', 'a'])
$delete
normal G0d\B
call s:assert(getline(1, '$'), ['a', '', 'a', ''], 'columnmove-B: normal usage #1')
normal! .
call s:assert(getline(1, '$'), ['a', ''], 'columnmove-B: normal usage #2')
%delete

" count
call append(0, ['a', '', 'a', '', 'a', '', 'a', '', 'a', '', 'a', '', 'a'])
$delete
normal G0d2\B
call s:assert(getline(1, '$'), ['a', '', 'a', '', 'a', '', 'a', ''], 'columnmove-B: count #1')
normal! 2.
call s:assert(getline(1, '$'), ['a', '', 'a', ''], 'columnmove-B: count #2')
%delete

call append(0, ['a', '', 'a', '', 'a', '', 'a', '', 'a', '', 'a', '', 'a'])
$delete
normal G0d2\B
call s:assert(getline(1, '$'), ['a', '', 'a', '', 'a', '', 'a', ''], 'columnmove-B: count #3')
normal! 3.
call s:assert(getline(1, '$'), ['a', ''], 'columnmove-B: count #4')
%delete

" motionwise
call append(0, ['aaa', '', 'aaa', '', 'aaa', '', 'aaa'])
$delete
normal G0ld\B
call s:assert(getline(1, '$'), ['aaa', '', 'aaa', ''], 'columnmove-B: motionwise #1 (default:linewise)')
normal! .
call s:assert(getline(1, '$'), ['aaa', ''], 'columnmove-B: motionwise #2 (default:linewise)')
%delete

call append(0, ['aaa', '', 'aaa', '', 'aaa'])
$delete
normal G0ldv\B
call s:assert(getline(1, '$'), ['aaa', '', 'aaa'], 'columnmove-B: motionwise #3 (characterwise)')
normal! .
call s:assert(getline(1, '$'), ['aaa'], 'columnmove-B: motionwise #4 (characterwise)')
%delete

call append(0, ['aaa', '', 'aaa', '', 'aaa', '', 'aaa'])
$delete
normal G0ldV\B
call s:assert(getline(1, '$'), ['aaa', '', 'aaa', ''], 'columnmove-B: motionwise #5 (linewise)')
normal! .
call s:assert(getline(1, '$'), ['aaa', ''], 'columnmove-B: motionwise #6 (linewise)')
%delete

call append(0, ['aaa', '', 'aaa', '', 'aaa'])
$delete
execute "normal G0ld\<C-v>\\B"
call s:assert(getline(1, '$'), ['aaa', '', 'aa', '', 'aa'], 'columnmove-B: motionwise #7 (blockwise)')
normal! .
call s:assert(getline(1, '$'), ['aa', '', 'a', '', 'aa'], 'columnmove-B: motionwise #8 (blockwise)')
%delete
"}}}

""" columnmove-E "{{{
mapclear
mapclear!
call columnmove#utility#map('o', 'E', '\E')

" normal usage
call append(0, ['a', '', 'a', '', 'a', '', 'a'])
$delete
normal 1G0d\E
call s:assert(getline(1, '$'), ['', 'a', '', 'a'], 'columnmove-E: normal usage #1')
normal! .
call s:assert(getline(1, '$'), ['', 'a'], 'columnmove-E: normal usage #2')
%delete

" count
call append(0, ['a', '', 'a', '', 'a', '', 'a', '', 'a', '', 'a', '', 'a'])
$delete
normal 1G0d2\E
call s:assert(getline(1, '$'), ['', 'a', '', 'a', '', 'a', '', 'a'], 'columnmove-E: count #1')
normal! 2.
call s:assert(getline(1, '$'), ['', 'a', '', 'a'], 'columnmove-E: count #2')
%delete

call append(0, ['a', '', 'a', '', 'a', '', 'a', '', 'a', '', 'a', '', 'a'])
$delete
normal 1G0d2\E
call s:assert(getline(1, '$'), ['', 'a', '', 'a', '', 'a', '', 'a'], 'columnmove-E: count #3')
normal! 3.
call s:assert(getline(1, '$'), ['', 'a'], 'columnmove-E: count #4')
%delete

" motionwise
call append(0, ['aaa', '', 'aaa', '', 'aaa', '', 'aaa'])
$delete
normal 1G0ld\E
call s:assert(getline(1, '$'), ['', 'aaa', '', 'aaa'], 'columnmove-E: motionwise #1 (default:linewise)')
normal! .
call s:assert(getline(1, '$'), ['', 'aaa'], 'columnmove-E: motionwise #2 (default:linewise)')
%delete

call append(0, ['aaa', '', 'aaa', '', 'aaa'])
$delete
normal 1G0ldv\E
call s:assert(getline(1, '$'), ['aaa', '', 'aaa'], 'columnmove-E: motionwise #3 (characterwise)')
normal! .
call s:assert(getline(1, '$'), ['aaa'], 'columnmove-E: motionwise #4 (characterwise)')
%delete

call append(0, ['aaa', '', 'aaa', '', 'aaa', '', 'aaa'])
$delete
normal 1G0ldV\E
call s:assert(getline(1, '$'), ['', 'aaa', '', 'aaa'], 'columnmove-E: motionwise #5 (linewise)')
normal! .
call s:assert(getline(1, '$'), ['', 'aaa'], 'columnmove-E: motionwise #6 (linewise)')
%delete

call append(0, ['aaa', '', 'aaa', '', 'aaa'])
$delete
execute "normal 1G0ld\<C-v>\\E"
call s:assert(getline(1, '$'), ['aa', '', 'aa', '', 'aaa'], 'columnmove-E: motionwise #7 (blockwise)')
normal! .
call s:assert(getline(1, '$'), ['a', '', 'a', '', 'aaa'], 'columnmove-E: motionwise #8 (blockwise)')
%delete
"}}}

""" columnmove-ge "{{{
mapclear
mapclear!
call columnmove#utility#map('o', 'ge', '\ge')

" normal usage
call append(0, ['a', '', 'a', '', 'a', '', 'a'])
$delete
normal G0d\ge
call s:assert(getline(1, '$'), ['a', '', 'a', ''], 'columnmove-ge: normal usage #1')
normal! .
call s:assert(getline(1, '$'), ['a', ''], 'columnmove-ge: normal usage #2')
%delete

" count
call append(0, ['a', '', 'a', '', 'a', '', 'a', '', 'a', '', 'a', '', 'a'])
$delete
normal G0d2\ge
call s:assert(getline(1, '$'), ['a', '', 'a', '', 'a', '', 'a', ''], 'columnmove-ge: count #1')
normal! 2.
call s:assert(getline(1, '$'), ['a', '', 'a', ''], 'columnmove-ge: count #2')
%delete

call append(0, ['a', '', 'a', '', 'a', '', 'a', '', 'a', '', 'a', '', 'a'])
$delete
normal G0d2\ge
call s:assert(getline(1, '$'), ['a', '', 'a', '', 'a', '', 'a', ''], 'columnmove-ge: count #3')
normal! 3.
call s:assert(getline(1, '$'), ['a', ''], 'columnmove-ge: count #4')
%delete

" motionwise
call append(0, ['aaa', ':::', 'aaa', ':::', 'aaa'])
$delete
normal G0ld\ge
call s:assert(getline(1, '$'), ['aaa', ':::', 'aaa'], 'columnmove-ge: motionwise #1 (default:linewise)')
normal! .
call s:assert(getline(1, '$'), ['aaa'], 'columnmove-ge: motionwise #2 (default:linewise)')
%delete

call append(0, ['aaa', ':::', 'aaa', ':::', 'aaa'])
$delete
normal G0ldv\ge
call s:assert(getline(1, '$'), ['aaa', ':::', 'aaa', ':aa'], 'columnmove-ge: motionwise #3 (characterwise)')
normal! .
call s:assert(getline(1, '$'), ['aaa', ':aa'], 'columnmove-ge: motionwise #4 (characterwise)')
%delete

call append(0, ['aaa', ':::', 'aaa', ':::', 'aaa'])
$delete
normal G0ldV\ge
call s:assert(getline(1, '$'), ['aaa', ':::', 'aaa'], 'columnmove-ge: motionwise #5 (linewise)')
normal! .
call s:assert(getline(1, '$'), ['aaa'], 'columnmove-ge: motionwise #6 (linewise)')
%delete

call append(0, ['aaa', ':::', 'aaa', ':::', 'aaa'])
$delete
execute "normal G0ld\<C-v>\\ge"
call s:assert(getline(1, '$'), ['aaa', ':::', 'aaa', '::', 'aa'], 'columnmove-ge: motionwise #7 (blockwise)')
normal! .
call s:assert(getline(1, '$'), ['aaa', ':::', 'aa', ':', 'aa'], 'columnmove-ge: motionwise #8 (blockwise)')
%delete
"}}}



qall!

" vim:set foldmethod=marker:
" vim:set commentstring="%s:
" vim:set ts=2 sts=2 sw=2 et:
