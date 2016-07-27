" columnmove.vim - bring cursor vertically in similar ways as line-wise commands

let s:save_cpo = &cpo
set cpo&vim

" types
let s:type_num  = type(0)
let s:type_list = type([])
let s:type_dict = type({})
let s:null_pos  = [0, 0, 0, 0, 0]

" patches
if v:version > 704 || (v:version == 704 && has('patch237'))
  let s:has_patch_7_4_310 = has('patch-7.4.310')
  let s:has_patch_7_4_311 = has('patch-7.4.311')
  let s:has_patch_7_4_362 = has('patch-7.4.362')
  let s:has_patch_7_4_457 = has('patch-7.4.457')
  let s:has_patch_7_4_578 = has('patch-7.4.578')
else
  let s:has_patch_7_4_310 = v:version == 704 && has('patch310')
  let s:has_patch_7_4_311 = v:version == 704 && has('patch311')
  let s:has_patch_7_4_362 = v:version == 704 && has('patch362')
  let s:has_patch_7_4_457 = v:version == 704 && has('patch457')
  let s:has_patch_7_4_578 = v:version == 704 && has('patch578')
endif

" features
let s:has_gui_running = has('gui_running')

" common funcs
function! s:object(f_or_w, ...) abort "{{{
  " NOTE: s:object(f_or_w)
  "         -> return the current object, if it does not exist then return
  "            an empty dictionary.
  " NOTE: s:object(f_or_w, kind, mode, mwise)
  "         -> return a object initialized by the arguments.
  " NOTE: s:object(kind, mode, mwise, update_history)
  "         -> return a object initialized by the arguments. If
  "            a:update_history is false, do not set it to s:columnmove.
  if a:0 < 3
    let object = get(s:columnmove, a:f_or_w, {})
  else
    let [kind, mode, mwise] = a:000[0:2]
    if get(a:000, 3, 1)
      if get(s:columnmove, a:f_or_w, {}) == {}
        " create a new object
        let s:columnmove[a:f_or_w] = deepcopy(s:prototype[a:f_or_w])
      endif
      let g:columnmove[a:f_or_w] = s:columnmove[a:f_or_w]
    else
      " create but do not set a new object to s:columnmove
      let g:columnmove[a:f_or_w] = s:prototype[a:f_or_w]
    endif
    let object = g:columnmove[a:f_or_w]
    let object.kind  = kind
    let object.mode  = mode
    let object.mwise = mwise
    let object.state = 1
    let object.destination = copy(s:null_pos)
    let object.opened_fold = []
  endif
  let hoge = s:columnmove
  return object
endfunction
"}}}
function! s:c_move() dict abort "{{{
  if self.state == 0
    let [_, cursorline, _, _, curswant] = s:getcurpos()
    if self.kind =~? '[ft]'
      let startline = cursorline + (self.kind ==? 'f' ? 1 : 2)*(self.kind =~# '[[:upper:]]' ? -1 : 1)
    else
      let startline = cursorline
    endif
    let l:count = v:count == 0 ? self.count : v:count1
    let self.count = l:count
    let self.destination = copy(s:null_pos)
    call self._search(cursorline, startline, curswant, l:count)
  endif

  if self.mode ==# 'x'
    " re-enter to visual mode
    normal! gv
    call winrestview(self.view)
    let self.view = {}
  endif

  if self.destination != s:null_pos
    " step back if self.kind == 't' or 'T'
    if self.kind ==# 't'
      let self.destination[1] -= 1
    elseif self.kind ==# 'T'
      let self.destination[1] += 1
    endif

    if self.mode ==# 'o' && self.mwise !=# ''
      execute 'normal! ' . self.mwise
    endif

    call s:setcurpos(self.destination)
  endif
  call self._close_fold()
  let self.state = 0

  " flash echoing
  echo ''
endfunction
"}}}
function! s:c__open_fold_forward(baseline, startline, ...) dict abort "{{{
  " This function updates self.opened_fold and return the updated endline.
  " NOTE: s:f__open_fold(baseline, startline)
  "         -> open foldings in an range, from startline to line('w$').
  " NOTE: s:f__open_fold(baseline, startline, endline)
  "         -> open foldings in an fixed range, from a:startline to a:endline.
  if !self.opt.fold_open
    return
  endif

  if a:0 < 1
    let [startline, endline] = [a:startline, line('w$')]
    let quit_by_view = 1
  else
    let [startline, endline] = [a:startline, a:1]
    let quit_by_view = 0
  endif
  if startline > endline
    let [startline, endline] = [0, 0]
  endif

  if startline > 0 && endline > 0
    let self.opened_fold += s:open_fold_forward(a:baseline, startline, endline, self.opt.fold_open, quit_by_view)
  endif
endfunction
"}}}
function! s:c__open_fold_backward(baseline, startline, ...) dict abort "{{{
  " This function updates self.opened_fold and return the updated endline.
  " NOTE: s:f__open_fold(baseline, startline)
  "         -> open foldings in an range, from startline to line('w$').
  " NOTE: s:f__open_fold(baseline, startline, endline)
  "         -> open foldings in an fixed range, from a:startline to a:endline.
  if !self.opt.fold_open
    return
  endif

  if a:0 < 1
    let [startline, endline] = [a:startline, line('w0')]
    let quit_by_view = 1
  else
    let [startline, endline] = [a:startline, a:1]
    let quit_by_view = 0
  endif
  if startline < endline
    let [startline, endline] = [0, 0]
  endif

  if startline > 0 && endline > 0
    let self.opened_fold += s:open_fold_backward(a:baseline, startline, endline, self.opt.fold_open, quit_by_view)
  endif
endfunction
"}}}
function! s:c__close_fold(...) dict abort "{{{
  if !self.opt.fold_open
    return
  endif

  let exceptline = get(a:000, 0, line('.'))
  call s:fold_closer(exceptline, self.opened_fold)
endfunction
"}}}
function! s:user_conf(name, arg, default) abort    "{{{
  let user_conf = a:default

  if !empty(a:arg)
    if type(a:arg) == s:type_dict && has_key(a:arg, a:name)
      return a:arg[a:name]
    endif
  endif

  if exists('g:columnmove_' . a:name)
    let user_conf = g:columnmove_{a:name}
  endif

  if exists('b:columnmove_' . a:name)
    let user_conf = b:columnmove_{a:name}
  endif

  return user_conf
endfunction
"}}}
function! s:user_mode_conf(name, arg, default, mode) abort    "{{{
  let user_conf = a:default

  if !empty(a:arg)
    if type(a:arg) == s:type_dict && has_key(a:arg, a:name)
      if type(a:arg[a:name]) == s:type_dict
        return get(a:arg[a:name], a:mode, a:default)
      elseif type(a:arg[a:name]) == s:type_num
        return a:arg[a:name]
      endif
    endif
  endif

  if exists('g:columnmove_' . a:name)
    let type_val = type(g:columnmove_{a:name})

    if type_val == s:type_dict
      let user_conf = get(g:columnmove_{a:name}, a:mode, a:default)
    elseif type_val == s:type_num
      let user_conf = g:columnmove_{a:name}
    endif
  endif

  if exists('b:columnmove_' . a:name)
    let type_val = type(b:columnmove_{a:name})

    if type_val == s:type_dict
      let user_conf = get(b:columnmove_{a:name}, a:mode, a:default)
    elseif type_val == s:type_num
      let user_conf = b:columnmove_{a:name}
    endif
  endif

  return user_conf
endfunction
"}}}
function! s:open_fold_forward(baseline, startline, endline, level, ...) abort "{{{
  let opened_fold = []
  if a:startline > 0 && a:endline > 0 && a:startline <= a:endline
    let quit_by_view = get(a:000, 0, 0)
    for lnum in range(a:startline, a:endline)
      if quit_by_view && lnum > line('w$')
        break
      endif
      let opened_fold += s:fold_opener(lnum, a:baseline, a:level)
    endfor
  endif
  return opened_fold
endfunction
"}}}
function! s:open_fold_backward(baseline, startline, endline, level, ...) abort "{{{
  let opened_fold = []
  if a:startline > 0 && a:endline > 0 && a:startline >= a:endline
    let quit_by_view = get(a:000, 0, 0)
    for lnum in range(a:startline, a:endline, -1)
      if quit_by_view && lnum < line('w0')
        break
      endif
      let opened_fold += s:fold_opener(lnum, a:baseline, a:level)
    endfor
  endif
  return opened_fold
endfunction
"}}}
function! s:fold_opener(targetline, baseline, level) abort  "{{{
  let foldlevel = foldlevel(a:targetline)
  if foldlevel < 0 | return [] | endif

  if a:level < 0
    let currentlevel = foldlevel(a:baseline)
    if currentlevel < 0 | return [] | endif
    let rel_depth   = foldlevel - currentlevel

    if rel_depth < 0
      let n = foldlevel
    elseif rel_depth <= (-1)*a:level
      let n = rel_depth
    else
      let n = 0
    endif
  elseif foldlevel <= a:level
    let n = a:level - foldlevel + 1
  else
    return []
  endif

  let opened_fold = []
  while n > 0
    let fold_start = foldclosed(a:targetline)
    if fold_start < 0 | return opened_fold | endif
    let fold_end   = foldclosedend(a:targetline)

    execute a:targetline . 'foldopen'
    let opened_fold += [[fold_start, fold_end]]
    let n -= 1
  endwhile

  return opened_fold
endfunction
"}}}
function! s:fold_closer(line, opened_fold) abort  "{{{
  for fold in reverse(a:opened_fold)
    if a:line < fold[0] || a:line > fold[1]
      execute fold[0] . 'foldclose'
    endif
  endfor
endfunction
"}}}
function! s:pick_up_char(text, thr_col, ...) abort  "{{{
  " This function returns the first character same with or beyond 'thr_col' which is the
  " column width on a display.

  " early-quit conditions
  if a:text ==# '' || strdisplaywidth(a:text) < a:thr_col
    return ['', 0]
  endif
  if a:thr_col <= 0
    return [a:text[0], 1]
  endif
  let indent_to_empty = get(a:000, 0, 0)
  if indent_to_empty && strdisplaywidth(matchstr(a:text, '^\s*')) >= a:thr_col
    " indentations are regarded as non-character, same as empty line
    return ['', a:thr_col]
  endif

  " NOTE: 'cutup' is the maximum byte-length of a string within a 'thr_col'
  "       column.
  " NOTE: The last a few characters of a:text[: cutup] might not be valid
  "       characters. No guaranty to cut by character.
  " FIXME: Byte-length of a character depends on &encoding. Probably almost
  "        all the characters are less than 3 byte, but some of them might
  "        reach 5~6 byte?
  let map_rule   = '[a:text[: v:val], strdisplaywidth(a:text[: v:val])]'
  let candidates = map([a:thr_col*2, a:thr_col*3], map_rule)
  call filter(candidates, 'v:val[1] >= a:thr_col')
  let [text, text_width] = candidates != [] ? candidates[0] : [a:text, strdisplaywidth(a:text)]

  if match(text, '\%([^\x01-\x7E]\|\t\)') < 0
    return s:_pick_up_char_no_multibyte(text, a:thr_col)
  elseif abs(text_width - a:thr_col) < 12
    return s:_pick_up_char_sequential(text, a:thr_col)
  else
    return s:_pick_up_char_binary(text, a:thr_col)
  endif
endfunction
"}}}
function! s:_pick_up_char_no_multibyte(text, thr_col) abort  "{{{
  " NOTE: It is promissed that
  "         1. a:text !=# ''
  "         2. strdisplaywidth(a:text) >= a:thr_col
  "         3. a:thr_col >= 1.
  return [a:text[a:thr_col-1], a:thr_col]
endfunction
"}}}
function! s:_pick_up_char_sequential(text, thr_col) abort  "{{{
  " NOTE: It is promissed that
  "         1. a:text !=# ''
  "         2. strdisplaywidth(a:text) >= a:thr_col
  "         3. a:thr_col >= 1.
  let charlist = split(a:text, '\zs')
  let end = strlen(a:text)
  let idx = max([0, min([a:thr_col, len(charlist)-1])])
  if strdisplaywidth(join(charlist[: idx], '')) < a:thr_col
    let idx += 1
    while idx < end
      if strdisplaywidth(join(charlist[: idx], '')) >= a:thr_col
        break
      endif
      let idx += 1
    endwhile
  else
    while idx > 0
      if strdisplaywidth(join(charlist[: idx-1], '')) < a:thr_col
        break
      endif
      let idx -= 1
    endwhile
  endif

  if idx <= 0
    return [charlist[0], 1]
  elseif idx >= end
    return ['', 0]
  else
    return [charlist[idx], strlen(join(charlist[: idx-1], ''))+1]
  endif
endfunction
"}}}
function! s:_pick_up_char_binary(text, thr_col) abort  "{{{
  " NOTE: It is promissed that
  "         1. a:text !=# ''
  "         2. strdisplaywidth(a:text) >= a:thr_col
  "         3. a:thr_col >= 1.
  let charlist = split(a:text, '\zs')
  let head = 0
  let tail = len(charlist) - 1
  if strdisplaywidth(join(charlist[: head], '')) >= a:thr_col
    return [charlist[head], 1]
  elseif strdisplaywidth(join(charlist[: tail], '')) == a:thr_col
    return [charlist[tail], strlen(join(charlist[: -2], ''))+1]
  elseif tail == 1
    " a:text is two characters and the second character exceeds a:thr_col.
    return [charlist[tail], strlen(join(charlist[: -2], ''))+1]
  endif

  while 1
    let idx = (head + tail)/2
    let width = strdisplaywidth(join(charlist[: idx], ''))
    if tail - head == 1
      let idx = width >= a:thr_col ? head : tail
      break
    elseif width == a:thr_col
      break
    elseif width < a:thr_col
      let head = idx
    else
      let tail = idx
    endif
  endwhile
  let col = idx == 0 ? 1 : strlen(join(charlist[: idx-1], ''))+1
  return [charlist[idx], col]
endfunction
"}}}
function! s:virtcurscol() abort "{{{
  " NOTE: Different from virtcol() func, this func returns the head column of
  "       cursor on display.
  let lnum = line('.')
  let col  = col('.')
  let curstail = virtcol('.')
  let prevtail = curstail
  while prevtail >= 1 && prevtail == curstail
    let col -= 1
    let prevtail = virtcol([lnum, col])
  endwhile
  return prevtail + 1
endfunction
"}}}
" function! s:getcurpos() abort  "{{{
if s:has_patch_7_4_578
  function! s:getcurpos() abort
    return getcurpos()
  endfunction
else
  function! s:getcurpos() abort
    let view = winsaveview()
    return [0, view.lnum, view.col+1, view.coladd, view.curswant+1]
  endfunction
endif
"}}}
" function! s:setcurpos(pos) abort  "{{{
if s:has_patch_7_4_310
  function! s:setcurpos(pos) abort
    return setpos('.', a:pos)
  endfunction
else
  function! s:setcurpos(pos) abort
    let pos = a:pos[1:2]
    call cursor(pos)
    let view = winsaveview()
    let dest = {'lnum': a:pos[1], 'col': a:pos[2]-1, 'curswant': a:pos[4]-1}
    call winrestview(extend(dest, view, 'keep'))
  endfunction
endif
"}}}
function! s:goto(lnum) abort  "{{{
  let [_, _, _, _, curswant] = s:getcurpos()
  let [col, off] = s:getcol(a:lnum, curswant)
  call s:setcurpos([0, a:lnum, col, off, curswant])
endfunction
"}}}
function! s:getcol(lnum, virtcol) abort  "{{{
  let text  = getline(a:lnum)
  let width = strdisplaywidth(text) + 1   " the last 1 is for \n.
  if width >= a:virtcol
    let [_, col] = s:pick_up_char(text, a:virtcol)
    let off = 0
  else
    let col = col([a:lnum, '$']) - 1
    let off = a:virtcol - width
  endif
  return [col, off]
endfunction
"}}}
function! s:escape(string) abort  "{{{
  return escape(a:string, '~"\.^$[]*')
endfunction
"}}}
function! s:list_belowlines(baseline, endline, ...) abort "{{{
  " NOTE s:list_belowlines(baseline, endline)
  "         -> return a list of displayed line numbers under a:baseline to
  "            a:endline.
  " NOTE s:list_belowlines(baseline, endline, count)
  "         -> return a list of no more than a:count of displayed line numbers
  "            under a:baseline to a:endline.
  let view    = winsaveview()
  let lines   = []
  let max_len = get(a:000, 0, 1/0)
  let foldend = foldclosedend(a:baseline)
  let lnum    = foldend < 1 ? a:baseline+1 : foldend+1
  call cursor(lnum, 1)
  let winline = winline()
  while len(lines) < max_len && lnum <= a:endline
    " folded lines
    let foldend = foldclosedend(lnum)
    if foldend < 1
      let lines += [lnum]
      let lnum  += 1
    else
      let lines += [foldclosed(lnum)]
      let lnum   = foldend + 1
    endif

    " wrapped lines
    call cursor(lnum, 1)
    if winline() - winline > 1
      let lines += repeat([lines[-1]], winline() - winline - 1)
    endif
    let winline = winline()
  endwhile
  call winrestview(view)
  return lines
endfunction
"}}}
function! s:list_abovelines(baseline, endline, ...) abort "{{{
  " NOTE s:list_abovelines(baseline, endline)
  "         -> return a list of displayed line numbers above a:baseline to
  "            a:endline.
  " NOTE s:list_abovelines(baseline, endline, count)
  "         -> return a list of no more than a:count of displayed line numbers
  "            above a:baseline to a:endline.
  let view      = winsaveview()
  let lines     = []
  let max_len   = get(a:000, 0, 1/0)
  let foldstart = foldclosed(a:baseline)
  let lnum      = foldstart < 1 ? a:baseline-1 : foldstart-1
  call cursor(lnum, 1)
  let winline   = winline()
  while len(lines) < max_len && lnum >= a:endline
    " folded lines
    let foldstart = foldclosed(lnum)
    if foldstart < 1
      let lines += [lnum]
      let lnum  -= 1
    else
      let lines += [foldstart]
      let lnum   = foldstart - 1
    endif

    " wrapped lines
    call cursor(lnum, 1)
    if winline - winline() > 1
      let lines += repeat([lines[-1]], winline - winline() - 1)
    endif
    let winline = winline()
  endwhile
  call winrestview(view)
  return lines
endfunction
"}}}

let s:prototype  = {'f': {}, 'w': {}}
let s:columnmove = {'f': {}, 'w': {}} " for preserving the last object
let g:columnmove = {'f': {}, 'w': {}} " for temporal use as an argument of columnmove#move()

" f series
" vertical 'f' commands "{{{
function! columnmove#f(mode, mwise, ...) abort
  let opt = s:f_get_opt(a:mode, get(a:000, 1, {}))

  " get object
  let f_object = s:f_object('f', a:mode, a:mwise, opt.update_history)

  " instant info
  let cursorline = line('.')
  let curswant   = s:virtcurscol()
  let startline  = cursorline + 1
  let l:count    = get(a:000, 0, 0)
  let l:count    = l:count < 1 ? v:count1 : l:count

  " alignment
  let f_object.char  = get(a:000, 2, '')
  let f_object.opt   = opt
  let f_object.count = l:count
  let f_object._open_fold = function('s:c__open_fold_forward')
  let f_object._scan      = function('s:f__scan_forward')
  let f_object._search    = function('s:f__search_forward')

  return f_object.start(cursorline, startline, curswant, l:count)
endfunction
"}}}
" vertical 'F' commands "{{{
function! columnmove#F(mode, mwise, ...) abort
  let opt = s:f_get_opt(a:mode, get(a:000, 1, {}))

  " get object
  let f_object = s:f_object('F', a:mode, a:mwise, opt.update_history)

  " instant info
  let cursorline = line('.')
  let curswant   = s:virtcurscol()
  let startline  = cursorline - 1
  let l:count    = get(a:000, 0, 0)
  let l:count    = l:count < 1 ? v:count1 : l:count

  " alignment
  let f_object.char  = get(a:000, 2, '')
  let f_object.opt   = opt
  let f_object.count = l:count
  let f_object._open_fold = function('s:c__open_fold_backward')
  let f_object._scan      = function('s:f__scan_backward')
  let f_object._search    = function('s:f__search_backward')

  return f_object.start(cursorline, startline, curswant, l:count)
endfunction
"}}}
" vertical 't' commands "{{{
function! columnmove#t(mode, mwise, ...) abort
  let opt = s:f_get_opt(a:mode, get(a:000, 1, {}))

  " get object
  let f_object = s:f_object('t', a:mode, a:mwise, opt.update_history)

  " instant info
  let cursorline = line('.')
  let curswant   = s:virtcurscol()
  let startline  = cursorline + 2
  let l:count    = get(a:000, 0, 0)
  let l:count    = l:count < 1 ? v:count1 : l:count

  " alignment
  let f_object.char  = get(a:000, 2, '')
  let f_object.opt   = opt
  let f_object.count = l:count
  let f_object._open_fold = function('s:c__open_fold_forward')
  let f_object._scan      = function('s:f__scan_forward')
  let f_object._search    = function('s:f__search_forward')

  return f_object.start(cursorline, startline, curswant, l:count)
endfunction
"}}}
" vertical 'T' commands "{{{
function! columnmove#T(mode, mwise, ...) abort
  let opt = s:f_get_opt(a:mode, get(a:000, 1, {}))

  " get object
  let f_object = s:f_object('T', a:mode, a:mwise, opt.update_history)

  " instant info
  let cursorline = line('.')
  let curswant   = s:virtcurscol()
  let startline  = cursorline - 2
  let l:count    = get(a:000, 0, 0)
  let l:count    = l:count < 1 ? v:count1 : l:count

  " alignment
  let f_object.char  = get(a:000, 2, '')
  let f_object.opt   = opt
  let f_object.count = l:count
  let f_object._open_fold = function('s:c__open_fold_backward')
  let f_object._scan      = function('s:f__scan_backward')
  let f_object._search    = function('s:f__search_backward')

  return f_object.start(cursorline, startline, curswant, l:count)
endfunction
"}}}
" vertical ';' commands "{{{
function! columnmove#semicolon(mode, mwise, ...) abort
  let f_object = s:f_object()
  if f_object != {}
    let kind = f_object.kind
    let char = f_object.char
    let l:count = get(a:000, 0, v:count1)
    let opt = extend(s:f_get_opt(a:mode, get(a:000, 1, {})), {'update_history': 0, 'auto_scroll': 0}, 'force')
    let cmd = columnmove#{kind}(a:mode, a:mwise, l:count, opt, char)
  else
    let cmd = a:mode ==# 'o' ? "\<Esc>" : "\<Plug>(columnmove-nop)"
  endif
  return cmd
endfunction
"}}}
" vertical ',' commands "{{{
function! columnmove#comma(mode, mwise, ...) abort
  let f_object = s:f_object()
  if f_object != {}
    let kind = f_object.kind
    let char = f_object.char
    let l:count = get(a:000, 0, v:count1)
    let opt = extend(s:f_get_opt(a:mode, get(a:000, 1, {})), {'update_history': 0, 'auto_scroll': 0}, 'force')
    let cmd = columnmove#{tr(kind, 'ftFT', 'FTft')}(a:mode, a:mwise, l:count, opt, char)
  else
    let cmd = a:mode ==# 'o' ? "\<Esc>" : "\<Plug>(columnmove-nop)"
  endif
  return cmd
endfunction
"}}}
function! columnmove#move(object) abort "{{{
  if has_key(a:object, 'move')
    call a:object.move()
  endif
endfunction
"}}}
" object for 'f' series commands  "{{{
function! s:f_object(...) abort "{{{
  " NOTE: s:f_object()
  "         -> return the current f_object, if it does not exist then return
  "            an empty dictionary.
  " NOTE: s:f_object(kind, mode, mwise)
  "         -> return a f_object characterized by the arguments.
  " NOTE: s:f_object(kind, mode, mwise, update_history)
  "         -> return a f_object characterized by the arguments. If
  "            a:update_history is false, do not set it to s:columnmove.
  let arg = ['f']
  if a:0 == 3
    let arg += a:000[0:2]
  elseif a:0 >= 4
    let arg += a:000[0:3]
  endif
  return call('s:object', arg)
endfunction
"}}}
function! s:f_get_opt(mode, force_opt) abort  "{{{
  let opt = {}
  let opt.fold_open      = s:user_mode_conf('fold_open', a:force_opt, 0, a:mode)
  let opt.ignore_case    = s:user_conf('ignore_case',    a:force_opt, 0)
  let opt.highlight      = s:user_conf('highlight',      a:force_opt, 1)
  let opt.auto_scroll    = s:user_conf('auto_scroll',    a:force_opt, 0)
  let opt.update_history = s:user_conf('update_history', a:force_opt, 1)
  return opt
endfunction
"}}}
function! s:f_start(cursorline, startline, curswant, count) dict abort  "{{{
  let view = winsaveview()
  let scrolled_view = view
  let options = s:shift_options()
  let dummy_cursor = s:put_dummy_cursor(view.lnum, view.col+1)
  let errormsg = ''
  try
    let candidates = []
    while self._look_around(a:cursorline, a:startline)
      let scrolled_view = winsaveview()
      call self._scan(candidates, a:startline, a:curswant, a:count)
      call self._show(candidates)
      call self._query()
    endwhile
  catch
    let errormsg = printf('vim-columnmove: Unanticipated error. [%s] %s', v:throwpoint, v:exception)
    call self._close_fold(a:cursorline)
    call winrestview(view)
  finally
    call self._clear(candidates)
    call s:clear_dummy_cursor(dummy_cursor)
    call s:restore_options(options)
    if errormsg !=# ''
      echoerr errormsg
    endif
  endtry

  if !self._quit() && (self._elect(candidates, a:curswant) || self._search(a:cursorline, a:startline, a:curswant, a:count, candidates))
    if self.mode ==# 'x'
      let self.view = scrolled_view
    else
      call winrestview(scrolled_view)
    endif

    let call = self.mode ==# 'i' ? "\<C-r>=" : ":\<C-u>call "
    " NOTE: Do *not* give mwise here as o_v, o_V, o_CTRL-V!
    "       It makes impossible to cancel motion in dot-repeating.
    "       Inclusive character-wise, line-wise, block-wise motion takes a
    "       character (or a line) under the cursor as a valid target region
    "       even if the cursor was not moved.
    let cmd  = printf("%scolumnmove#move(g:columnmove.f)\<CR>", call)
  else
    call winrestview(view)
    call self._close_fold(a:cursorline)
    let cmd = self.mode ==# 'o' ? "\<Esc>" : "\<Plug>(columnmove-nop)"
    let self.state = 0
  endif
  return cmd
endfunction
"}}}
function! s:f__scan_forward(candidates, startline, curswant, count) dict abort "{{{
  " Scan an induced range to gather candidates.
  " This function updates a:candidates directly,
  " candidates = [{'c': c, 'lnum': lnum, 'col': col}, ...].
  " NOTE: This function treats displayed lines. The number of lines should not
  "       be so large since it is bound by a hardware display. Probably, even
  "       over-estimating, it would be less than 200 or so.
  let [startline, endline] = s:unprocessed_forward(a:startline, a:candidates)
  if startline > 0 && endline > 0
    call s:scan_forward(a:candidates, startline, endline, a:curswant, a:count, self.opt.ignore_case)
  endif
endfunction
"}}}
function! s:f__scan_backward(candidates, startline, curswant, count) dict abort "{{{
  " Scan an induced range to gather candidates.
  " This function updates a:candidates directly,
  " candidates = [{'c': c, 'lnum': lnum, 'col': col}, ...].
  " NOTE: This function treats displayed lines. The number of lines should not
  "       be so large since it is bound by a hardware display. Probably, even
  "       over-estimating, it would be less than 200 or so.
  let [startline, endline] = s:unprocessed_backward(a:startline, a:candidates)
  if startline > 0 && endline > 0
    call s:scan_backward(a:candidates, startline, endline, a:curswant, a:count, self.opt.ignore_case)
  endif
endfunction
"}}}
function! s:f__show(candidates, ...) dict abort "{{{
  let cursorlineopt = get(a:000, 0, 0)
  if self.opt.highlight
    let top = line('w0')
    let bot = line('w$')
    for candidate in a:candidates
      if top <= candidate.lnum && candidate.lnum <= bot
        call candidate.hl_add()
      endif
    endfor
    redraw
  endif
endfunction
"}}}
function! s:f__clear(candidates) dict abort "{{{
  if self.opt.highlight
    for candidate in a:candidates
      call candidate.hl_clear()
    endfor
  endif
endfunction
"}}}
function! s:f__query() dict abort  "{{{
  " This func updates self.char.
  if self.char ==# ''
    let key = ''
    try
      while 1
        let key = getchar()
        if key != s:cursorhold | break | endif
      endwhile
    catch /^Vim:Interrupt$/
      let self.char = "\<C-c>"
    finally
      let self.char = type(key) == s:type_num ? nr2char(key) : key
    endtry
  endif
endfunction

" cursorhold key
if s:has_patch_7_4_457
  let s:cursorhold = "\<cursorhold>"
else
  let s:cursorhold = "\x80\xfd`"
endif
"}}}
function! s:f__look_around(cursorline, startline) dict abort  "{{{
  if self.char ==# ''
    call self._open_fold(a:cursorline, a:startline)
  elseif match(keys(s:look_around_key_table), s:escape(self.char)) > -1
    call s:look_around_key_table[self.char](self, a:cursorline)
    let self.char = ''
  endif
  return self.char ==# '' ? 1 : 0
endfunction
"}}}
function! s:f__scroll_down(cursorline, count, kind) dict abort "{{{
  let open_fold = a:kind =~# '[ft]' ? 1 : 0
  let fileend = line('$')
  let viewbot = line('w$')
  if viewbot == fileend || a:count < 1
    return
  endif

  for i in range(a:count)
    let viewbot = line('w$')
    if viewbot == fileend
      break
    endif
    if open_fold
      let lnum = viewbot + 1
      call self._open_fold(a:cursorline, lnum, lnum)
    endif
    call s:scroll_down_view(a:cursorline)
  endfor
  call self._open_fold(a:cursorline, line('w$'), line('w$'))
  call s:roll_back_cursor(a:cursorline)
endfunction
"}}}
function! s:f__scroll_up(cursorline, count, kind) dict abort "{{{
  let open_fold = a:kind =~# '[ft]' ? 0 : 1
  let filehead = 1
  let viewtop  = line('w0')
  if viewtop == filehead || a:count < 1
    return
  endif

  for i in range(a:count)
    let viewtop = line('w0')
    if viewtop == filehead
      break
    endif
    if open_fold
      let lnum = viewtop - 1
      call self._open_fold(a:cursorline, lnum, lnum)
    endif
    call s:scroll_up_view(a:cursorline)
  endfor
  call self._open_fold(a:cursorline, line('w0'), line('w0'))
  call s:roll_back_cursor(a:cursorline)
endfunction
"}}}
function! s:f__quit() dict abort  "{{{
  if self.char ==# '' || self.char ==# "\<Esc>" || self.char ==# "\<C-c>"
    return 1
  endif
  return 0
endfunction
"}}}
function! s:f__elect(candidates, curswant) dict abort "{{{
  call filter(a:candidates, 'v:val.c ==# self.char')
  if a:candidates != []
    let elected = a:candidates[0]
    let self.destination = [0, elected.lnum, elected.col, 0, a:curswant]
    return 1
  else
    return 0
  endif
endfunction
"}}}
function! s:f__search_forward(cursorline, startline, curswant, count, ...) dict abort "{{{
  if self.char !=# ''
    let candidates = get(a:000, 0, [])
    let charlist = map(copy(candidates), 'v:val.c')
    let lnum     = candidates != [] ? candidates[-1].lnum+1 : a:startline
    let col      = 0
    let stride   = 100
    let fileend  = line('$')
    let found    = 0
    while lnum <= fileend
      let sectionhead = lnum
      let sectiontail = min([lnum + stride - 1, fileend])
      call self._open_fold(a:cursorline, sectionhead, sectiontail)
      let [lnum, col] = s:search_char_in_section_forward(self.char, charlist, sectionhead, sectiontail, a:curswant, a:count, self.opt.ignore_case)
      if col > 0
        let self.destination = [0, lnum, col, 0, a:curswant]
        return 1
      endif
    endwhile
  endif
  return 0
endfunction
"}}}
function! s:f__search_backward(cursorline, startline, curswant, count, ...) dict abort "{{{
  if self.char !=# ''
    let candidates = get(a:000, 0, [])
    let charlist = map(copy(candidates), 'v:val.c')
    let lnum     = candidates != [] ? candidates[-1].lnum-1 : a:startline
    let col      = 0
    let stride   = 100
    let filehead = 1
    let found    = 0
    while lnum >= filehead
      let sectionhead = lnum
      let sectiontail = max([filehead, lnum - stride + 1])
      call self._open_fold(a:cursorline, sectionhead, sectiontail)
      let [lnum, col] = s:search_char_in_section_backward(self.char, charlist, sectionhead, sectiontail, a:curswant, a:count, self.opt.ignore_case)
      if col > 0
        let self.destination = [0, lnum, col, 0, a:curswant]
        return 1
      endif
    endwhile
  endif
  return 0
endfunction
"}}}
function! s:scan_forward(candidates, startline, endline, curswant, count, ignorecase) abort "{{{
  " This function updates a:candidates directly,
  " candidates = [{'c': c, 'lnum': lnum, 'col': col}, ...].
  if a:startline > 0 && a:endline > 0 && a:startline <= a:endline
    let charlist = map(copy(a:candidates), 'v:val.c')
    let lnum = a:startline
    while lnum <= a:endline
      let foldend = foldclosedend(lnum)
      if foldend < 1
        let [c, col] = s:pick_up_char(getline(lnum), a:curswant)
        if c !=# ''
          let charlist += [c]
          if count(charlist, c, a:ignorecase) == a:count
            call add(a:candidates, s:candidate(c, lnum, col))
          endif
        endif
      else
        let lnum = foldend
      endif
      let lnum += 1
    endwhile
  endif
  return a:candidates
endfunction
"}}}
function! s:scan_backward(candidates, startline, endline, curswant, count, ignorecase) abort "{{{
  " This function updates a:candidates directly,
  " candidates = [{'c': c, 'lnum': lnum, 'col': col}, ...].
  if a:startline > 0 && a:endline > 0 && a:startline >= a:endline
    let charlist = map(copy(a:candidates), 'v:val.c')
    let lnum = a:startline
    while lnum >= a:endline
      let foldstart = foldclosed(lnum)
      if foldstart < 1
        let [c, col] = s:pick_up_char(getline(lnum), a:curswant)
        if c !=# ''
          let charlist += [c]
          if count(charlist, c, a:ignorecase) == a:count
            call add(a:candidates, s:candidate(c, lnum, col))
          endif
        endif
      else
        let lnum = foldstart
      endif
      let lnum -= 1
    endwhile
  endif
  return a:candidates
endfunction
"}}}
function! s:search_char_in_section_forward(char, charlist, sectionhead, sectiontail, curswant, count, ignorecase) abort  "{{{
  " NOTE: This func updates a:charlist!
  "       Prefered to pass 'candidates', but give 'charlist' instead for performace.
  let lines = getline(a:sectionhead, a:sectiontail)

  let lnum = a:sectionhead
  let col  = 0
  while lnum <= a:sectiontail
    let foldend = foldclosedend(lnum)
    if foldend < 1
      let idx  = lnum - a:sectionhead
      let line = lines[idx]
      let [c, col] = s:pick_up_char(line, a:curswant)
      if c !=# ''
        call add(a:charlist, c)
        if count(a:charlist, a:char, a:ignorecase) == a:count
          break
        endif
      endif
    else
      let lnum = foldend
    endif
    let lnum += 1
    let col = 0
  endwhile
  return [lnum, col]
endfunction
"}}}
function! s:search_char_in_section_backward(char, charlist, sectionhead, sectiontail, curswant, count, ignorecase) abort  "{{{
  " NOTE: This func updates a:charlist!
  "       Prefered to pass 'candidates', but give 'charlist' instead for performace.
  let lines = reverse(getline(a:sectiontail, a:sectionhead))

  let lnum = a:sectionhead
  let col  = 0
  while lnum >= a:sectiontail
    let foldstart = foldclosed(lnum)
    if foldstart < 1
      let idx  = a:sectionhead - lnum
      let line = lines[idx]
      let [c, col] = s:pick_up_char(line, a:curswant)
      if c !=# ''
        call add(a:charlist, c)
        if count(a:charlist, a:char, a:ignorecase) == a:count
          break
        endif
      endif
    else
      let lnum = foldstart
    endif
    let lnum -= 1
    let col = 0
  endwhile
  return [lnum, col]
endfunction
"}}}
function! s:unprocessed_forward(startline, candidates) abort "{{{
  let [startline, endline] = [a:startline, line('w$')]
  if a:candidates != []
    let lastline = a:candidates[-1].lnum
    if endline > lastline
      let startline = lastline + 1
    else
      let [startline, endline] = [0, 0]
    endif
  else
    if startline > endline
      let [startline, endline] = [0, 0]
    endif
  endif

  return [startline, endline]
endfunction
"}}}
function! s:unprocessed_backward(startline, candidates) abort "{{{
  let [startline, endline] = [a:startline, line('w0')]
  if a:candidates != []
    let lastline = a:candidates[-1].lnum
    if endline < lastline
      let startline = lastline - 1
    else
      let [startline, endline] = [0, 0]
    endif
  else
    if startline < endline
      let [startline, endline] = [0, 0]
    endif
  endif

  return [startline, endline]
endfunction
"}}}
function! s:shift_options() abort  "{{{
  let options = {}
  let options.virtualedit = &virtualedit
  let options.cursorline  = &l:cursorline
  if s:has_gui_running
    let options.cursor = &guicursor
    set guicursor+=n-v-o:block-NONE
  else
    let options.cursor = &t_ve
    set t_ve=
  endif
  set virtualedit=all
  setlocal nocursorline

  return options
endfunction
"}}}
function! s:restore_options(options) abort "{{{
  let &virtualedit  = a:options.virtualedit
  let &l:cursorline = a:options.cursorline
  if s:has_gui_running
    set guicursor&
    let &guicursor = a:options.cursor
  else
    let &t_ve = a:options.cursor
  endif
endfunction
"}}}
function! s:put_dummy_cursor(lnum, col) abort "{{{
  return hlexists('Cursor') ? s:matchaddpos('Cursor', [[a:lnum, a:col]]) : []
endfunction
"}}}
function! s:clear_dummy_cursor(id_list) abort  "{{{
  if filter(a:id_list, 'v:val > 0') != []
    call s:matchdelete(a:id_list)
  endif
endfunction
"}}}
" function! s:matchaddpos(group, order, ...) abort "{{{
" NOTE: s:matchaddpos(group, order)
"         -> highlight as order
" NOTE: s:matchaddpos(group, order, id)
"         -> highlight as order and force to return a:id
if s:has_patch_7_4_362
  function! s:matchaddpos(group, order, ...) abort
    let id = get(a:000, 1, -1)
    return [matchaddpos(a:group, a:order, id)]
  endfunction
else
  function! s:matchaddpos(group, order, ...) abort
    let id = get(a:000, 1, -1)
    let id_list = []
    for item in a:order
      if len(item) == 1
        let id_list += [matchadd(a:group, printf('\%%%dl', item[0]), id)]
      elseif len(item) == 2
        let id_list += [matchadd(a:group, printf('\%%%dl\%%%dc.', item[0], item[1]), id)]
      else
        let id_list += [matchadd(a:group, printf('\%%%dl\%%>%dc.*\%%<%dc', item[0], item[1]-1, item[1]+item[2]), id)]
      endif
    endfor
    return id_list
  endfunction
endif
"}}}
function! s:matchdelete(id_list) abort  "{{{
  call filter(map(a:id_list, 'matchdelete(v:val)'), 'v:val > 0')
endfunction
"}}}
function! s:normalcmd_CTRL_E(f_object, cursorline) dict abort  "{{{
  call a:f_object._scroll_down(a:cursorline, 1, a:f_object.kind)
endfunction
"}}}
function! s:normalcmd_CTRL_Y(f_object, cursorline) dict abort  "{{{
  call a:f_object._scroll_up(a:cursorline, 1, a:f_object.kind)
endfunction
"}}}
function! s:normalcmd_CTRL_D(f_object, cursorline) dict abort  "{{{
  " NOTE: Actually this is not exactly same as CTRL-D.
  "       This func moves view, not cursor.
  call a:f_object._scroll_down(a:cursorline, &scroll, a:f_object.kind)
endfunction
"}}}
function! s:normalcmd_CTRL_U(f_object, cursorline) dict abort  "{{{
  " NOTE: Actually this is not exactly same as CTRL-U.
  "       This func moves view, not cursor.
  call a:f_object._scroll_up(a:cursorline, &scroll, a:f_object.kind)
endfunction
"}}}
function! s:normalcmd_CTRL_F(f_object, cursorline) dict abort  "{{{
  " NOTE: Actually this is not exactly same as CTRL-F.
  "       This func moves view, not cursor.
  call a:f_object._scroll_down(a:cursorline, winheight(0), a:f_object.kind)
endfunction
"}}}
function! s:normalcmd_CTRL_B(f_object, cursorline) dict abort  "{{{
  " NOTE: Actually this is not exactly same as CTRL-B.
  "       This func moves view, not cursor.
  call a:f_object._scroll_up(a:cursorline, winheight(0), a:f_object.kind)
endfunction
"}}}
function! s:scroll_down_view(cursorline) abort "{{{
  let viewtop = line('w0')
  let viewbot = line('w$')
  let fileend = line('$')
  if viewbot == fileend
    return
  endif

  if &scrolloff == 0
    let lines = s:list_belowlines(viewbot, fileend, 1)
  elseif winheight(0) < &scrolloff*2
    let lines = s:list_belowlines(a:cursorline, fileend, 1)
  else
    let lines = s:list_abovelines(viewbot+1, a:cursorline, &scrolloff)
  endif

  if lines != []
    let lnum = lines[-1]
    call s:goto(lnum)
  endif
endfunction
"}}}
function! s:scroll_up_view(cursorline) abort "{{{
  let filehead = 1
  let viewtop  = line('w0')
  let viewbot  = line('w$')
  if viewtop == filehead
    return
  endif

  if &scrolloff == 0
    let lines = s:list_abovelines(viewtop, filehead, 1)
  elseif winheight(0) < &scrolloff*2
    let lines = s:list_abovelines(a:cursorline, filehead, 1)
  else
    let lines = s:list_belowlines(viewtop-1, a:cursorline, &scrolloff)
  endif

  if lines != []
    let lnum = lines[-1]
    call s:goto(lnum)
  endif
endfunction
"}}}
function! s:roll_back_cursor(originalline) abort  "{{{
  if winheight(0) < &scrolloff*2
    return
  endif

  let filehead = 1
  let viewtop  = line('w0')
  let viewbot  = line('w$')
  let fileend  = line('$')
  if &scrolloff == 0
    let habitabletop = viewtop
    let habitablebot = viewbot
  else
    let toplines = s:list_belowlines(viewtop, viewbot, &scrolloff)
    let botlines = s:list_abovelines(viewbot, viewtop, &scrolloff)
    let habitabletop = get(toplines, -1, -1)
    let habitablebot = get(botlines, -1, -1)
  endif

  if habitabletop > 0 && habitablebot > 0 && habitabletop < habitablebot
    if habitabletop <= a:originalline && a:originalline <= habitablebot
      call s:goto(a:originalline)
    elseif line('.') > a:originalline
      call s:goto(habitabletop)
    elseif line('.') < a:originalline
      call s:goto(habitablebot)
    endif
  endif
endfunction
"}}}
let s:prototype.f = {
      \   'kind': '',
      \   'state': 0,
      \   'mode': '',
      \   'mwise': '',
      \   'char': '',
      \   'opt': {},
      \   'view': {},
      \   'destination': copy(s:null_pos),
      \   'opened_fold': [],
      \   'start': function('s:f_start'),
      \   'move': function('s:c_move'),
      \   '_close_fold': function('s:c__close_fold'),
      \   '_show': function('s:f__show'),
      \   '_clear': function('s:f__clear'),
      \   '_query': function('s:f__query'),
      \   '_look_around': function('s:f__look_around'),
      \   '_scroll_down': function('s:f__scroll_down'),
      \   '_scroll_up': function('s:f__scroll_up'),
      \   '_quit': function('s:f__quit'),
      \   '_elect': function('s:f__elect'),
      \ }
let s:look_around_key_table = {
      \   "\<C-e>": function('s:normalcmd_CTRL_E'),
      \   "\<C-y>": function('s:normalcmd_CTRL_Y'),
      \   "\<C-d>": function('s:normalcmd_CTRL_D'),
      \   "\<C-u>": function('s:normalcmd_CTRL_U'),
      \   "\<C-f>": function('s:normalcmd_CTRL_F'),
      \   "\<C-b>": function('s:normalcmd_CTRL_B'),
      \ }

" candidate object  "{{{
" NOTE: A candidate of destination for columnmove-f and its variants.
function! s:candidate(...) abort "{{{
  let candidate = deepcopy(s:candidate)
  if a:0 == 3
    let candidate.c    = a:1
    let candidate.lnum = a:2
    let candidate.col  = a:3
  endif
  return candidate
endfunction
"}}}
function! s:c_hi_add() dict abort "{{{
  if !self.hl_state
    let self.hl_id = s:matchaddpos('ColumnmoveCandidates', [[self.lnum, self.col]], self.hl_id)
    let self.hl_state = 1
  endif
endfunction
"}}}
function! s:c_hi_clear() dict abort "{{{
  if self.hl_state
    call s:matchdelete(filter(self.hl_id, 'v:val > 0'))
    let self.hl_state = 0
  endif
endfunction
"}}}
let s:candidate = {
      \   'c': '',
      \   'lnum': 0,
      \   'col': 0,
      \   'hl_id': [],
      \   'hl_state': 0,
      \   'hl_add': function('s:c_hi_add'),
      \   'hl_clear': function('s:c_hi_clear'),
      \ }
"}}}
"}}}

" w series
" vertical 'w' commands "{{{
function! columnmove#w(mode, mwise, ...) abort
  let w_object = s:w_object('w', a:mode, a:mwise)

  " alignment
  let w_object.opt = s:w_get_opt(a:mode, get(a:000, 1, {}))
  let w_object.search = function('s:w_search_forward')
  let w_object._search_section = function('s:search_beyond_border_in_section_forward')
  let w_object._check_char = function('s:check_char_w')
  let w_object._check_char_spoiled = function('s:check_char_w_spoiled')
  let w_object._open_fold = function('s:c__open_fold_forward')

  " instant info
  let l:count = get(a:000, 0, 0)
  let l:count = l:count < 1 ? v:count1 : l:count
  let [cursorline, curswant] = s:virtcurpos(a:mode)

  call w_object.start(cursorline, curswant, l:count)
endfunction
"}}}
" vertical 'b' commands "{{{
function! columnmove#b(mode, mwise, ...) abort
  let w_object = s:w_object('b', a:mode, a:mwise)

  " alignment
  let w_object.opt = s:w_get_opt(a:mode, get(a:000, 1, {}))
  let w_object.search = function('s:w_search_backward')
  let w_object._search_section = function('s:search_short_of_border_in_section_backward')
  let w_object._check_char = function('s:check_char_w')
  let w_object._check_char_spoiled = function('s:check_char_w_spoiled')
  let w_object._open_fold = function('s:c__open_fold_backward')

  " instant info
  let l:count = get(a:000, 0, 0)
  let l:count = l:count < 1 ? v:count1 : l:count
  let [cursorline, curswant] = s:virtcurpos(a:mode)

  call w_object.start(cursorline, curswant, l:count)
endfunction
"}}}
" vertical 'e' commands "{{{
function! columnmove#e(mode, mwise, ...) abort
  let w_object = s:w_object('e', a:mode, a:mwise)

  " alignment
  let w_object.opt = s:w_get_opt(a:mode, get(a:000, 1, {}))
  let w_object.search = function('s:w_search_forward')
  let w_object._search_section = function('s:search_short_of_border_in_section_forward')
  let w_object._check_char = function('s:check_char_w')
  let w_object._check_char_spoiled = function('s:check_char_w_spoiled')
  let w_object._open_fold = function('s:c__open_fold_forward')

  " instant info
  let l:count = get(a:000, 0, 0)
  let l:count = l:count < 1 ? v:count1 : l:count
  let [cursorline, curswant] = s:virtcurpos(a:mode)

  call w_object.start(cursorline, curswant, l:count)
endfunction
"}}}
" vertical 'ge' commands  "{{{
function! columnmove#ge(mode, mwise, ...) abort
  let w_object = s:w_object('ge', a:mode, a:mwise)

  " alignment
  let w_object.opt = s:w_get_opt(a:mode, get(a:000, 1, {}))
  let w_object.search = function('s:w_search_backward')
  let w_object._search_section = function('s:search_beyond_border_in_section_backward')
  let w_object._check_char = function('s:check_char_w')
  let w_object._check_char_spoiled = function('s:check_char_w_spoiled')
  let w_object._open_fold = function('s:c__open_fold_backward')

  " instant info
  let l:count = get(a:000, 0, 0)
  let l:count = l:count < 1 ? v:count1 : l:count
  let [cursorline, curswant] = s:virtcurpos(a:mode)

  call w_object.start(cursorline, curswant, l:count)
endfunction
"}}}
" vertical 'W' commands "{{{
function! columnmove#W(mode, mwise, ...) abort
  let w_object = s:w_object('W', a:mode, a:mwise)

  " alignment
  let w_object.opt = s:w_get_opt(a:mode, get(a:000, 1, {}))
  let w_object.opt.strict_wbege = 1
  let w_object.search = function('s:w_search_forward')
  let w_object._search_section = function('s:search_beyond_border_in_section_forward')
  let w_object._check_char = function('s:check_char_W')
  let w_object._check_char_spoiled = function('s:check_char_W')
  let w_object._open_fold = function('s:c__open_fold_forward')

  " instant info
  let l:count = get(a:000, 0, 0)
  let l:count = l:count < 1 ? v:count1 : l:count
  let [cursorline, curswant] = s:virtcurpos(a:mode)

  call w_object.start(cursorline, curswant, l:count)
endfunction
"}}}
" vertical 'B' commands "{{{
function! columnmove#B(mode, mwise, ...) abort
  let w_object = s:w_object('B', a:mode, a:mwise)

  " alignment
  let w_object.opt = s:w_get_opt(a:mode, get(a:000, 1, {}))
  let w_object.opt.strict_wbege = 1
  let w_object.search = function('s:w_search_backward')
  let w_object._search_section = function('s:search_short_of_border_in_section_backward')
  let w_object._check_char = function('s:check_char_W')
  let w_object._check_char_spoiled = function('s:check_char_W')
  let w_object._open_fold = function('s:c__open_fold_backward')

  " instant info
  let l:count = get(a:000, 0, 0)
  let l:count = l:count < 1 ? v:count1 : l:count
  let [cursorline, curswant] = s:virtcurpos(a:mode)

  call w_object.start(cursorline, curswant, l:count)
endfunction
"}}}
" vertical 'E' commands "{{{
function! columnmove#E(mode, mwise, ...) abort
  let w_object = s:w_object('E', a:mode, a:mwise)

  " alignment
  let w_object.opt = s:w_get_opt(a:mode, get(a:000, 1, {}))
  let w_object.opt.strict_wbege = 1
  let w_object.search = function('s:w_search_forward')
  let w_object._search_section = function('s:search_short_of_border_in_section_forward')
  let w_object._check_char = function('s:check_char_W')
  let w_object._check_char_spoiled = function('s:check_char_W')
  let w_object._open_fold = function('s:c__open_fold_forward')

  " instant info
  let l:count = get(a:000, 0, 0)
  let l:count = l:count < 1 ? v:count1 : l:count
  let [cursorline, curswant] = s:virtcurpos(a:mode)

  call w_object.start(cursorline, curswant, l:count)
endfunction
"}}}
" vertical 'gE' commands "{{{
function! columnmove#gE(mode, mwise, ...) abort
  let w_object = s:w_object('gE', a:mode, a:mwise)

  " alignment
  let w_object.opt = s:w_get_opt(a:mode, get(a:000, 1, {}))
  let w_object.opt.strict_wbege = 1
  let w_object.search = function('s:w_search_backward')
  let w_object._search_section = function('s:search_beyond_border_in_section_backward')
  let w_object._check_char = function('s:check_char_W')
  let w_object._check_char_spoiled = function('s:check_char_W')
  let w_object._open_fold = function('s:c__open_fold_backward')

  " instant info
  let l:count = get(a:000, 0, 0)
  let l:count = l:count < 1 ? v:count1 : l:count
  let [cursorline, curswant] = s:virtcurpos(a:mode)

  call w_object.start(cursorline, curswant, l:count)
endfunction
"}}}
" object for 'w' series commands  "{{{
function! s:w_object(...) abort "{{{
  " NOTE: s:w_object()
  "         -> return the current w_object, if it does not exist then return
  "            an empty dictionary.
  " NOTE: s:w_object(kind, mode, mwise)
  "         -> return a w_object characterized by the arguments.
  let arg = ['w']
  if a:0 >= 3
    let arg += a:000[0:2]
  endif

  return call('s:object', arg)
endfunction
"}}}
function! s:w_get_opt(mode, force_opt) abort  "{{{
  let opt = {}
  let opt.fold_open      = s:user_mode_conf('fold_open', a:force_opt, 0, a:mode)
  let opt.strict_wbege   = s:user_conf('strict_wbege',   a:force_opt, 1)
  let opt.fold_treatment = s:user_conf('fold_treatment', a:force_opt, 0)
  let opt.stop_on_space  = s:user_conf('stop_on_space',  a:force_opt, 1)
  return opt
endfunction
"}}}
function! s:w_start(cursorline, curswant, count) dict abort "{{{
  " NOTE: Different from default j/k, columnmove-w series do not always
  "       respect curswant since these commands depending on a character under
  "       the cursor. Thus these commands start to move along virtcol('.'),
  "       and then respect curswant in following motion if user use them
  "       successively.
  let curswant = self.successive ? a:curswant : s:virtcurscol()
  if self.search(a:cursorline, curswant, a:count)
    call self.move()
    call self.continued()
  else
    call self._close_fold(a:cursorline)
    let self.state = 0
  endif
endfunction
"}}}
function! s:w_search_forward(cursorline, curswant, count) dict abort "{{{
  let stride    = 100
  let filehead  = 1
  let fileend   = line('$')
  let Check_c   = self.opt.strict_wbege ? self._check_char : self._check_char_spoiled
  let current   = {'lnum': a:cursorline, 'col': 0, 'class': -1, 'count': 0, 'dest': 0}
  let reference = {}
  while current.lnum <= fileend
    let sectionhead = max([current.lnum, get(reference, 'lnum', filehead)])
    let sectiontail = min([sectionhead + stride - 1, fileend])
    call self._open_fold(a:cursorline, sectionhead, sectiontail)
    let [current, reference] = self._search_section(current, reference, Check_c, sectionhead, sectiontail, a:curswant, a:count, self.opt)
    if current.dest
      if current.lnum != a:cursorline
        let self.destination = [0, current.lnum, current.col, 0, a:curswant]
        return 1
      endif
    endif
  endwhile
  return 0
endfunction
"}}}
function! s:w_search_backward(cursorline, curswant, count) dict abort "{{{
  let stride    = 100
  let filehead  = 1
  let fileend   = line('$')
  let Check_c   = self.opt.strict_wbege ? self._check_char : self._check_char_spoiled
  let current   = {'lnum': a:cursorline, 'col': 0, 'class': -1, 'count': 0, 'dest': 0}
  let reference = {}
  while current.lnum >= filehead
    let sectionhead = min([current.lnum, get(reference, 'lnum', fileend)])
    let sectiontail = max([filehead, sectionhead - stride + 1])
    call self._open_fold(a:cursorline, sectionhead, sectiontail)
    let [current, reference] = self._search_section(current, reference, Check_c, sectionhead, sectiontail, a:curswant, a:count, self.opt)
    if current.dest
      if current.lnum != a:cursorline
        let self.destination = [0, current.lnum, current.col, 0, a:curswant]
        return 1
      endif
    endif
  endwhile
  return 0
endfunction
"}}}
function! s:w_continued() dict abort  "{{{
  " FIXME In principle, self.successive should be a window-local info. However
  "       there is no way to set autocommands window-locally, so it is
  "       difficult to manage.
  let self.successive = 1
  augroup columnmove-w
    autocmd! * <buffer>
    autocmd CursorMoved <buffer> autocmd columnmove-w CursorMoved,InsertEnter,TextChanged,TabLeave,WinLeave <buffer> call columnmove#interrupt()
  augroup END
endfunction
"}}}
function! s:w_interrupted() dict abort  "{{{
  " FIXME In principle, self.successive should be a window-local info. However
  "       there is no way to set autocommands window-locally, so it is
  "       difficult to manage.
  let self.successive = 0
  augroup columnmove-w
    autocmd! * <buffer>
  augroup END
endfunction
"}}}
function! s:search_beyond_border_in_section_forward(current, last, check_char, sectionhead, sectiontail, curswant, count, opt) abort  "{{{
  let lines   = getline(a:sectionhead, a:sectiontail)
  let current = a:current
  let last    = a:last != {} ? a:last : {'class': -1}
  let indent_to_empty = a:opt.strict_wbege && a:opt.stop_on_space

  while current.lnum <= a:sectiontail
    let foldend = foldclosedend(current.lnum)
    if foldend < 1
      let idx  = current.lnum - a:sectionhead
      let line = lines[idx]
      let [c, col] = s:pick_up_char(line, a:curswant, indent_to_empty)
      let current.class = a:check_char(c)
      let current.col   = col
      let current.count += s:is_over_a_border(current, last, a:opt.stop_on_space)
      if current.count == a:count
        let current.dest = 1
        break
      endif
      let last = copy(current)
    else
      if a:opt.fold_treatment || last.class == -1
        let current.class = 0
        let current.col   = 0
        let last = copy(current)
      endif
      let current.lnum = foldend
    endif
    let current.lnum += 1
  endwhile
  return [current, last]
endfunction
"}}}
function! s:search_beyond_border_in_section_backward(current, last, check_char, sectionhead, sectiontail, curswant, count, opt) abort  "{{{
  let lines   = reverse(getline(a:sectiontail, a:sectionhead))
  let current = a:current
  let last    = a:last != {} ? a:last : {'class': -1}
  let indent_to_empty = a:opt.strict_wbege && a:opt.stop_on_space

  while current.lnum >= a:sectiontail
    let foldstart = foldclosed(current.lnum)
    if foldstart < 1
      let idx  = a:sectionhead - current.lnum
      let line = lines[idx]
      let [c, col] = s:pick_up_char(line, a:curswant, indent_to_empty)
      let current.class = a:check_char(c)
      let current.col   = col
      let current.count += s:is_over_a_border(current, last, a:opt.stop_on_space)
      if current.count == a:count
        let current.dest = 1
        break
      endif
      let last = copy(current)
    else
      if a:opt.fold_treatment || last.class == -1
        let current.class = 0
        let current.col   = 0
        let last = copy(current)
      endif
      let current.lnum = foldstart
    endif
    let current.lnum -= 1
  endwhile
  return [current, last]
endfunction
"}}}
function! s:search_short_of_border_in_section_forward(current, tip, check_char, sectionhead, sectiontail, curswant, count, opt) abort  "{{{
  let sectiontail = a:sectiontail + 1
  let lines   = getline(a:sectionhead, sectiontail)
  let current = a:current
  let tip     = a:tip != {} ? a:tip : {'lnum': current.lnum+1, 'col': 0, 'class': -1, 'count': 0, 'dest': 0}
  let indent_to_empty = a:opt.strict_wbege && a:opt.stop_on_space

  while tip.lnum <= sectiontail
    let foldend = foldclosedend(tip.lnum)
    if foldend < 1
      let idx  = tip.lnum - a:sectionhead
      let line = get(lines, idx, '')
      let [c, col] = s:pick_up_char(line, a:curswant, indent_to_empty)
      let tip.class = a:check_char(c)
      let tip.col   = col
      let tip.count += s:is_in_front_of_a_border(current, tip, a:opt.stop_on_space)
      if tip.count >= a:count
        let current.dest = 1
        break
      endif
      let current = copy(tip)
    else
      if a:opt.fold_treatment
        let tip.class = 0
        let tip.col   = 0
        let tip.count += s:is_in_front_of_a_border(current, tip, a:opt.stop_on_space)
        if tip.count >= a:count
          let current.dest = 1
          break
        endif
        let current = copy(tip)
      endif
      let tip.lnum = foldend
    endif
    let tip.lnum += 1
  endwhile
  return [current, tip]
endfunction
"}}}
function! s:search_short_of_border_in_section_backward(current, tip, check_char, sectionhead, sectiontail, curswant, count, opt) abort  "{{{
  let sectiontail = a:sectiontail - 1
  let lines   = reverse(getline(sectiontail, a:sectionhead))
  let current = a:current
  let tip     = a:tip != {} ? a:tip : {'lnum': current.lnum-1, 'col': 0, 'class': -1, 'count': 0, 'dest': 0}
  let indent_to_empty = a:opt.strict_wbege && a:opt.stop_on_space

  while tip.lnum >= sectiontail
    let foldstart = foldclosed(tip.lnum)
    if foldstart < 1
      let idx  = a:sectionhead - tip.lnum
      let line = get(lines, idx, '')
      let [c, col]  = s:pick_up_char(line, a:curswant, indent_to_empty)
      let tip.class = a:check_char(c)
      let tip.col   = col
      let tip.count += s:is_in_front_of_a_border(current, tip, a:opt.stop_on_space)
      if tip.count >= a:count
        let current.dest = 1
        break
      endif
      let current = copy(tip)
    else
      if a:opt.fold_treatment
        let tip.class = 0
        let tip.col   = 0
        let tip.count += s:is_in_front_of_a_border(current, tip, a:opt.stop_on_space)
        if tip.count >= a:count
          let current.dest = 1
          break
        endif
        let current = copy(tip)
      endif
      let tip.lnum = foldstart
    endif
    let tip.lnum -= 1
  endwhile
  return [current, tip]
endfunction
"}}}
function! s:check_char_w(c) abort  "{{{
  " strict w, b, e, ge
  " nothing       : 0
  " space, tab    : 1
  " keyword chars : 2
  " other chars   : 3
  return a:c ==# '' ? 0
     \ : a:c =~# '\m\s' ? 1
     \ : a:c =~# '\m\k' ? 2
     \ : 3
endfunction
"}}}
function! s:check_char_w_spoiled(c) abort  "{{{
  " spoiled w, b, e, ge
  " nothing :  0
  " chars   :  2
  return a:c ==# '' ? 0 : 2
endfunction
"}}}
function! s:check_char_W(c) abort  "{{{
  " W, B, E, gE
  " nothing       : 0
  " space, tab    : 1
  " other chars   : 2
  return a:c ==# '' ? 0
     \ : a:c =~# '\m\s' ? 1
     \ : 2
endfunction
"}}}
function! s:is_over_a_border(current, last, stop_on_space) abort  "{{{
  return a:last.class > -1 && ((a:current.class > 1 && a:current.class != a:last.class) || (a:stop_on_space && a:current.class == 1 && a:last.class == 0)) ? 1 : 0
endfunction
"}}}
function! s:is_in_front_of_a_border(current, tip, stop_on_space) abort "{{{
  return (a:current.class > 1 && a:current.class != a:tip.class) || (a:stop_on_space && a:current.class == 1 && a:tip.class == 0)? 1 : 0
endfunction
"}}}
function! columnmove#interrupt() abort  "{{{
  let w_object = s:object('w')
  if w_object != {}
    call w_object.interrupted()
  endif
endfunction
"}}}
function! s:virtcurpos(mode) abort "{{{
  if a:mode ==# 'x'
    normal! gv
    let [_, cursorline, _, _, curswant] = s:getcurpos()
  else
    let [_, cursorline, _, _, curswant] = s:getcurpos()
  endif
  return [cursorline, curswant]
endfunction
"}}}
let s:prototype.w = {
      \   'kind': '',
      \   'state': 0,
      \   'mode': '',
      \   'mwise': '',
      \   'curswant': 0,
      \   'successive': 0,
      \   'opt': {},
      \   'view': {},
      \   'destination': copy(s:null_pos),
      \   'opened_fold': [],
      \   'start': function('s:w_start'),
      \   'move': function('s:c_move'),
      \   '_close_fold': function('s:c__close_fold'),
      \   'continued': function('s:w_continued'),
      \   'interrupted': function('s:w_interrupted'),
      \ }
"}}}

let &cpo = s:save_cpo
unlet s:save_cpo

" vim:set foldmethod=marker:
" vim:set commentstring="%s:
" vim:set ts=2 sts=2 sw=2 et:
