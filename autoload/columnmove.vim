" columnmove.vim - bring cursor vertically in similar ways as line-wise
"                    commands

" Because of my preference these commands ignore folded lines in default.

" Vertical f, t, F, T commands would only take into account the range
" displayed. Because I assumed no one can remember precise characters in the
" same column out of one's sight.

" If there are vicinal lines with no character in the same column (for
" example, vicinal empty line), vertical w, b, e, ge assume there is a space.

let s:save_cpo = &cpo
set cpo&vim

let s:null_dest = {'lnum': -1, 'col': -1, 'curswant': -1}

" s:last_searched: for vertical 'f', 't', 'F', 'T', ';', ','commands
" 'kind' key: the kind of command (f, t, F, T)
" 'char' key: the character searched last
" 'dest' key: the dictionary to assign the destination
"             this would be used only to pass the target information from
"             fixer to executer
" 'args' key: the list of arguments for s:get_dest_ftFT_with_char().
"             this would be used only when 'char' is given.
"             this would be used only to pass the target information from
"             fixer to executer or dot-repeat
let s:last_searched = {'kind': '', 'char': '', 'dest': {}, 'args': [], 'wise': ''}

" To distinguish whether keymapping call or dot-repeat
" s:state == 1  : keymapping
" s:state <= 0  : dot-repeat
let s:state = 0

" load vital
let s:V  = vital#of('columnmove')
let s:Sl = s:V.import('Data.List')
let s:s  = s:V.import('Prelude')
unlet s:V

""" mapping functions
" vertical 'f' commands "{{{
function! columnmove#f(mode, wise, ...)
  return s:columnmove_ftFT_fixer('f', a:mode, a:wise, a:0, a:000)
endfunction
"}}}
" vertical 't' commands "{{{
function! columnmove#t(mode, wise, ...)
  return s:columnmove_ftFT_fixer('t', a:mode, a:wise, a:0, a:000)
endfunction
"}}}
" vertical 'F' commands "{{{
function! columnmove#F(mode, wise, ...)
  return s:columnmove_ftFT_fixer('F', a:mode, a:wise, a:0, a:000)
endfunction
"}}}
" vertical 'T' commands "{{{
function! columnmove#T(mode, wise, ...)
  return s:columnmove_ftFT_fixer('T', a:mode, a:wise, a:0, a:000)
endfunction
"}}}
" vertical ';' commands "{{{
function! columnmove#semicolon(mode, wise, ...)
  let kind   = s:last_searched.kind
  let char   = s:last_searched.char

  if kind != ''
    " count assginment
    let l:count = (a:0 > 0 && a:1 > 0) ? a:1 : v:count1

    " for the user configuration
    let options_dict = (a:0 > 1) ? a:2 : {}

    " do not update history
    call extend(options_dict, {'update_history' : 0})

    " call well-suited command
    let output = columnmove#{kind}(a:mode, a:wise, char, l:count, options_dict)
  else
    let output = (a:mode == 'o') ? "\<Esc>" : ''
  endif

  return output
endfunction
"}}}
" vertical ',' commands "{{{
function! columnmove#comma(mode, wise, ...)
  let kind = s:last_searched.kind
  let char = s:last_searched.char

  if kind != ''
    " count assginment
    let l:count = (a:0 > 0 && a:1 > 0) ? a:1 : v:count1

    " for the user configuration
    let options_dict = (a:0 > 1) ? a:2 : {}

    " do not update history
    call extend(options_dict, {'update_history' : 0})

    " call well-suited command
    let output = columnmove#{tr(kind, 'ftFT', 'FTft')}(a:mode, a:wise, char, l:count, options_dict)
  else
    let output = (a:mode == 'o') ? "\<Esc>" : ''
  endif

  return output
endfunction
"}}}
" vertical 'w' commands "{{{
function! columnmove#w(mode, wise, ...)
  return s:columnmove_wbege('w', a:mode, a:wise, a:0, a:000)
endfunction
"}}}
" vertical 'b' commands "{{{
function! columnmove#b(mode, wise, ...)
  return s:columnmove_wbege('b', a:mode, a:wise, a:0, a:000)
endfunction
"}}}
" vertical 'e' commands "{{{
function! columnmove#e(mode, wise, ...)
  return s:columnmove_wbege('e', a:mode, a:wise, a:0, a:000)
endfunction
"}}}
" vertical 'ge' commands  "{{{
function! columnmove#ge(mode, wise, ...)
  return s:columnmove_wbege('ge', a:mode, a:wise, a:0, a:000)
endfunction
"}}}
" vertical 'W' commands "{{{
function! columnmove#W(mode, wise, ...)
  return s:columnmove_wbege('W', a:mode, a:wise, a:0, a:000)
endfunction
"}}}
" vertical 'B' commands "{{{
function! columnmove#B(mode, wise, ...)
  return s:columnmove_wbege('B', a:mode, a:wise, a:0, a:000)
endfunction
"}}}
" vertical 'E' commands "{{{
function! columnmove#E(mode, wise, ...)
  return s:columnmove_wbege('E', a:mode, a:wise, a:0, a:000)
endfunction
"}}}
" vertical 'gE' commands  "{{{
function! columnmove#gE(mode, wise, ...)
  return s:columnmove_wbege('gE', a:mode, a:wise, a:0, a:000)
endfunction
"}}}

""" subfuncs
" common
function! s:user_conf(name, arg, default)    "{{{
  let user_conf = a:default

  if !empty(a:arg)
    if s:s.is_dict(a:arg) && has_key(a:arg, a:name)
      return a:arg[a:name]
    endif
  endif

  if exists('g:columnmove_' . a:name)
    let user_conf = g:columnmove_{a:name}
  endif

  if exists('t:columnmove_' . a:name)
    let user_conf = t:columnmove_{a:name}
  endif

  if exists('w:columnmove_' . a:name)
    let user_conf = w:columnmove_{a:name}
  endif

  if exists('b:columnmove_' . a:name)
    let user_conf = b:columnmove_{a:name}
  endif

  return user_conf
endfunction
"}}}
function! s:user_mode_conf(name, arg, default, mode)    "{{{
  let user_conf = a:default

  if !empty(a:arg)
    if s:s.is_dict(a:arg) && has_key(a:arg, a:name)
      if s:s.is_dict(a:arg[a:name])
        return get(a:arg[a:name], a:mode, a:default)
      elseif s:s.is_number(a:arg[a:name])
        return a:arg[a:name]
      endif
    endif
  endif

  if exists('g:columnmove_' . a:name)
    let type_val = g:columnmove_{a:name}

    if s:s.is_dict(type_val)
      let user_conf = get(g:columnmove_{a:name}, a:mode, a:default)
    elseif s:s.is_number(type_val)
      let user_conf = g:columnmove_{a:name}
    endif
  endif

  if exists('t:columnmove_' . a:name)
    let type_val = t:columnmove_{a:name}

    if s:s.is_dict(type_val)
      let user_conf = get(t:columnmove_{a:name}, a:mode, a:default)
    elseif s:s.is_number(type_val)
      let user_conf = t:columnmove_{a:name}
    endif
  endif

  if exists('w:columnmove_' . a:name)
    let type_val = w:columnmove_{a:name}

    if s:s.is_dict(type_val)
      let user_conf = get(w:columnmove_{a:name}, a:mode, a:default)
    elseif s:s.is_number(type_val)
      let user_conf = w:columnmove_{a:name}
    endif
  endif

  if exists('b:columnmove_' . a:name)
    let type_val = b:columnmove_{a:name}

    if s:s.is_dict(type_val)
      let user_conf = get(b:columnmove_{a:name}, a:mode, a:default)
    elseif s:s.is_number(type_val)
      let user_conf = b:columnmove_{a:name}
    endif
  endif

  return user_conf
endfunction
"}}}
function! s:fold_opener(line, currentline, level)  "{{{
  let foldlevel   = foldlevel(a:line)
  if foldlevel < 0 | return [] | endif

  if a:level < 0
    let currentlevel = foldlevel(a:currentline)
    if currentlevel < 0 | return [] | endif
    let rel_depth   = foldlevel - currentlevel

    if rel_depth < 0
      let nth = foldlevel
    elseif rel_depth <= (-1)*a:level
      let nth = rel_depth
    else
      let nth = 0
    endif
  elseif foldlevel <= a:level
    let nth = a:level - foldlevel + 1
  else
    return []
  endif

  let opened_fold = []
  while nth > 0
    let fold_start = foldclosed(a:line)
    if fold_start < 0 | return opened_fold | endif
    let fold_end   = foldclosedend(a:line)

    execute a:line . 'foldopen'
    let opened_fold += [[fold_start, fold_end]]
    let nth -= 1
  endwhile

  return opened_fold
endfunction
"}}}
function! s:fold_closer(line, opened_fold)  "{{{
  for fold in reverse(a:opened_fold)
    if a:line < fold[0] || a:line > fold[1]
      execute fold[0] . 'foldclose'
    endif
  endfor
endfunction
"}}}
function! s:getchar_from_same_column(string, thr_col, cutup, null)  "{{{
  " This function returns the first character beyond 'thr_col' which is the
  " column width on a display.

  " NOTE: 'cutup' is the maximum number of characters which can be put within
  "       'thr_col' bytes. It should be 1 or larger.

  if match(a:string[: a:cutup], '\%([^\x01-\x7E]\|\t\)') < 0
    let col = a:thr_col
    if strlen(a:string) <= a:thr_col
      return a:null
    else
      return [a:string[col], col]
    endif
  else
    let chars = split(a:string, '\zs')[: a:cutup]
    let len   = len(chars)
    let top   = len - 1
    let bot   = -top
    let idx   = top

    if a:string == ''
      return a:null
    endif

    if a:thr_col == 0
      return [chars[0], 0]
    endif

    if strdisplaywidth(a:string) <= a:thr_col
      return a:null
    endif

    if strdisplaywidth(join(chars[: a:thr_col-1], '')) == a:thr_col
      return [chars[a:thr_col], a:thr_col]
    endif

    if strdisplaywidth(chars[0]) > a:thr_col
      return [chars[0], 0]
    endif

    " binary search
    while 1
      let width = strdisplaywidth(join(chars[: idx], ''))

      if width == a:thr_col
        let idx += 1
        break
      elseif top - bot <= 1
        let idx = top
        break
      elseif width < a:thr_col
        let bot = idx
      else
        let top = idx
      endif

      let idx = (top + bot)/2
    endwhile

    let col = (idx > 0) ? strlen(join(chars[: idx - 1], '')) : 0

    return [chars[idx], col]
  endif
endfunction
"}}}
function! s:add_topline(dest_view) "{{{
  let dest_view = a:dest_view
  let line = a:dest_view.lnum
  let col  = a:dest_view.col

  let err = setpos('.', [0, line, col, 0])
  if !err
    return extend(dest_view, winsaveview(), 'keep')
  else
    return a:dest_view
  endif
endfunction
"}}}

" vertical f, t, F, T
inoremap <Plug>(columnmove-nop) <Nop>
nnoremap <Plug>(columnmove-nop) <Nop>
xnoremap <Plug>(columnmove-nop) <Nop>

let s:plug_cap = "\<Plug>"
let s:cursorhold = s:plug_cap[0:1] . '`'
unlet s:plug_cap

function! s:columnmove_ftFT_fixer(kind, mode, wise, argn, args) "{{{
  " count assginment
  let l:count = (a:argn > 1 && a:args[1] > 0) ? a:args[1] : v:count1
  let s:state = 1

  " searching for the user configuration
  let options_dict = (a:argn > 2) ? a:args[2] : {}

  " target character assignment
  let char = (a:argn > 0) ? a:args[0] : ''

  " save view
  let view = winsaveview()

  " resolving user configuration
  let opt = {}
  let opt.fold_open      = s:user_mode_conf('fold_open', options_dict, 0, a:mode)
  let opt.ignore_case    = s:user_conf(   'ignore_case', options_dict, &ignorecase)
  let opt.highlight      = s:user_conf(     'highlight', options_dict, 1)
  let opt.update_history = s:user_conf('update_history', options_dict, 1)
  let opt.expand_range   = s:user_conf(  'expand_range', options_dict, 0)
  let opt.auto_scroll    = s:user_conf(   'auto_scroll', options_dict, 0)

  " searching for destinations
  if char != ''
    let s:last_searched.dest = copy(s:null_dest)
    let s:last_searched.args = [a:kind, a:mode, char, l:count, deepcopy(view), deepcopy(opt)]

    if a:mode == 'i'
      let call_method = "\<C-r>="
    else
      let call_method = ":\<C-u>call "
    endif

    let cmd = call_method . "columnmove#ftFT_executer()\<CR>"
  else
    let [dest_view, opened_fold] = s:get_dest_ftFT(a:kind, a:mode, l:count, view, opt)

    " close unnecessary fold
    if opened_fold != []
      call s:fold_closer(line('.'), opened_fold)
    endif

    if dest_view != s:null_dest
      let s:last_searched.dest = dest_view
      let s:last_searched.args = [a:kind, a:mode, s:last_searched.char, l:count, deepcopy(view), deepcopy(opt)]
      let s:last_searched.wise  = a:wise

      if a:mode == 'i'
        let call_method = "\<C-r>="
      else
        let call_method = ":\<C-u>call "
      endif

      let cmd = call_method . "columnmove#ftFT_executer()\<CR>"
    else
      call winrestview(view)
      redraw
      let cmd = (a:mode == 'o') ? "\<Esc>" : "\<Plug>(columnmove-nop)"
    endif
  endif

  return cmd
endfunction
"}}}
function! columnmove#ftFT_executer()  "{{{
  " determine the destination
  let dest = copy(s:null_dest)
  if s:last_searched.dest != s:null_dest
    let dest = copy(s:last_searched.dest)
    let s:last_searched.dest = copy(s:null_dest)
  else
    " when the function is called from dot-repeat, update count, view, and opt.
    if s:state <= 0
      let s:last_searched.args[3] = v:count1
      let s:last_searched.args[4] = winsaveview()

      " resolving user configuration
      let opt = s:last_searched.args[5]
      let opt.fold_open      = s:user_mode_conf('fold_open', opt, 0, 'o')
      let opt.ignore_case    = s:user_conf(   'ignore_case', opt, &ignorecase)
      let opt.highlight      = s:user_conf(     'highlight', opt, 1)
      let opt.update_history = s:user_conf('update_history', opt, 1)
      let opt.expand_range   = s:user_conf(  'expand_range', opt, 0)
      let opt.auto_scroll    = s:user_conf(   'auto_scroll', opt, 0)
    endif

    let [dest, opened_fold] = call('s:get_dest_ftFT_with_char', s:last_searched.args)

    " close unnecessary fold
    if opened_fold != []
      call s:fold_closer(line('.'), opened_fold)
    endif
  endif

  " re-entering to the visual mode (if necessary)
  let mode = get(s:last_searched.args, 1, '')
  if (mode ==# 'x') && ((mode() !=? 'v') && (mode() != "\<C-v>"))
    normal! gv
  endif

  " move cursor
  if dest != s:null_dest
    " optimize the motion
    if s:last_searched.wise != ''
      execute 'normal! ' . s:last_searched.wise
    endif

    if (v:version > 704) || (v:version == 704 && has('patch310'))
      call setpos('.', [0, dest.lnum, dest.col+1, 0, dest.curswant+1])
    else
      call winrestview(s:add_topline(dest))
    endif
  endif

  let s:state -= 1
  return ''
endfunction
"}}}
function! s:get_dest_ftFT(kind, mode, count, view, opt)  "{{{
  let l:count  = a:count
  let virtcol  = virtcol(".")
  let initline = a:view.lnum
  let col      = a:view.col    " NOTE: not equal col('.')!
  let curswant = a:view.curswant
  let cutup    = max([virtcol, col('.')])

  " gather buffer lines
  if a:kind =~# '[ft]'
    " down
    if a:opt.auto_scroll
      " can not use normal! zt
      call s:auto_scroll_up()
    endif

    let startline = (a:kind ==# 'f') ? initline + 1 : initline + 2

    if a:opt.expand_range < 0
      let endline = line("$")
    else
      let fileend = line("$")
      let endline = line("w$") + a:opt.expand_range
      let endline = (endline > fileend) ? fileend : endline
    endif

    let inc  = 1
    let edge = 'end'

    let whole_lines = getline(startline, endline)
    let line_num    = endline - startline
  elseif a:kind =~# '[FT]'
    " up
    if a:opt.auto_scroll
      " can not use normal! zb
      call s:auto_scroll_down()
    endif

    let startline = (a:kind ==# 'F') ? initline - 1 : initline - 2

    if a:opt.expand_range < 0
      let endline = 1
    else
      let endline = line("w0") - a:opt.expand_range
      let endline = (endline < 1) ? 1 : endline
    endif

    let inc  = -1
    let edge = 'start'

    let whole_lines = reverse(getline(endline, startline))
    let line_num    = startline - endline
  endif

  " determine the threshold column (=curswant)
  let char_width     = strdisplaywidth(matchstr(getline(initline), '.', col))
  let acceptable_gap = char_width - 1
  let curswant       = (curswant - virtcol + char_width <= acceptable_gap)
        \            ? curswant : (virtcol - char_width)

  " collecting characters in same column as cursor
  let idx         = 0
  let line        = startline

  let chars       = []
  let cols        = []
  let lines       = []
  let opened_fold = []

  if (a:opt.fold_open != 0) && (a:kind =~# '[tT]')
    " fold opening
    let opened_fold += s:fold_opener(initline + inc, initline, a:opt.fold_open)
  endif

  while idx <= line_num
    let fold_start = foldclosed(line)
    let fold_end   = foldclosedend(line)
    if fold_start < 0
      let [c, col] = s:getchar_from_same_column(whole_lines[idx], curswant, cutup, ['', -1])
      let chars += [c]
      let cols  += [col]
      let lines += [line]
      let idx   += 1
      let line  += inc
    else
      if a:opt.fold_open != 0
        let opened_fold += s:fold_opener(line, initline, a:opt.fold_open)
        let fold_start   = foldclosed(line)
        let fold_end     = foldclosedend(line)
      endif

      if a:opt.expand_range >= 0
        if a:kind =~# '[ft]'
          let endline  = line("w$") + a:opt.expand_range
          let endline  = (endline > fileend) ? fileend : endline
          let line_num = endline - startline
        elseif a:kind =~# '[FT]'
          let endline  = line("w0") - a:opt.expand_range
          let endline  = (endline < 1) ? 1 : endline
          let line_num = startline - endline
        endif
      endif

      if fold_start < 0
        continue
      else
        let chars += ['']
        let cols  += [-1]
        let lines += [line]
        let idx   += (fold_{edge} - line) * inc + 1
        let line   = fold_{edge} + inc
      endif
    endif
  endwhile

  " picking up candidates
  let prefix = a:opt.ignore_case ? '\m\c' : '\m\C'

  let highlight_pos = []
  let uniq_chars    = s:Sl.uniq_by(filter(copy(chars), '!empty(v:val)'), 'v:val')
  for c in copy(uniq_chars)
    let pattern = prefix . s:s.escape_pattern(c)
    let idx     = match(chars, pattern, 0, a:count)
    if idx >= 0
      let highlight_pos += [[lines[idx], cols[idx]]]
    else
      call remove(uniq_chars, match(uniq_chars, pattern))
    endif
  endfor
  if highlight_pos == [] | return [copy(s:null_dest), opened_fold] | endif

  " highlighting candidates
  if a:opt.highlight
    let id_list = map(copy(highlight_pos), "s:highlight_add(v:val[0], v:val[1]+1)")
    redraw
  endif

  " target character assginment
  while 1
    let key = getchar()
    if key != s:cursorhold | break | endif
  endwhile
  let key = type(key) == type(0) ? nr2char(key) : key

  " delete highlighting
  if a:opt.highlight
    call map(id_list, "s:highlight_del(v:val)")
    redraw
  endif

  if key ==# "\<Esc>" || key ==# "\<C-c>" | return [copy(s:null_dest), opened_fold] | endif

  " update history
  if a:opt.update_history
    let s:last_searched.kind = a:kind
    let s:last_searched.char = key
  endif

  let pattern = prefix . s:s.escape_pattern(key)
  let idx     = match(uniq_chars, pattern)

  if idx < 0
    " can not find target
    if a:opt.auto_scroll
      call winrestview(a:view)
    endif

    return [copy(s:null_dest), opened_fold]
  endif

  if a:kind ==# 't'
    let output = [{'lnum': highlight_pos[idx][0] - 1, 'col': highlight_pos[idx][1], 'curswant': curswant}, opened_fold]
  elseif a:kind ==# 'T'
    let output = [{'lnum': highlight_pos[idx][0] + 1, 'col': highlight_pos[idx][1], 'curswant': curswant}, opened_fold]
  else
    let output = [{'lnum': highlight_pos[idx][0], 'col': highlight_pos[idx][1], 'curswant': curswant}, opened_fold]
  endif

  return output
endfunction
"}}}
function! s:get_dest_ftFT_with_char(kind, mode, c, count, view, opt)  "{{{
  let l:count  = a:count
  let virtcol  = virtcol(".")
  let initline = a:view.lnum
  let col      = a:view.col    " NOTE: not equal col('.')!
  let curswant = a:view.curswant

  " update history
  if a:opt.update_history
    let s:last_searched.kind = a:kind
    let s:last_searched.char = a:c
  endif

  " defining the searching range
  if a:kind =~# '[ft]'
    " down
    if a:opt.auto_scroll
      normal! zt
    endif

    let startline = (a:kind ==# 'f') ? initline + 1 : initline + 2

    if a:opt.expand_range < 0
      let endline = line("$")
    else
      let fileend = line("$")
      let endline = line("w$") + a:opt.expand_range

      let endline = (endline > fileend) ? fileend : endline
    endif

    let inc  = 1
    let edge = 'end'

    let whole_lines = getline(startline, endline)
  elseif a:kind =~# '[FT]'
    " up
    if a:opt.auto_scroll
      normal! zb
    endif

    let startline = (a:kind ==# 'F') ? initline - 1 : initline - 2

    if a:opt.expand_range < 0
      let endline = 1
    else
      let endline = line("w0") - a:opt.expand_range

      let endline = (endline < 1) ? 1 : endline
    endif

    let inc  = -1
    let edge = 'start'

    let whole_lines = reverse(getline(endline, startline))
  endif

  " determine the threshold column (=curswant)
  let char_width     = strdisplaywidth(matchstr(getline(initline), '.', col))
  let acceptable_gap = char_width - 1
  let curswant       = (curswant - virtcol + char_width <= acceptable_gap)
        \            ? curswant : (virtcol - char_width)
  let cutup          = max([virtcol, col('.')]) + acceptable_gap

  " searching for the destination
  let idx      = 0
  let line     = startline
  let prefix   = a:opt.ignore_case ? '\m\c' : '\m\C'
  let pattern  = prefix . s:s.escape_pattern(a:c)
  let line_num = len(whole_lines) - 1

  let opened_fold = []

  if (a:opt.fold_open != 0) && (a:kind =~# '[tT]')
    " fold opening
    let opened_fold += s:fold_opener(initline + inc, initline, a:opt.fold_open)
  endif

  while idx <= line_num
    let fold_start = foldclosed(line)
    let fold_end   = foldclosedend(line)
    if fold_start < 0
      let [c, col] = s:getchar_from_same_column(whole_lines[idx], curswant, cutup, ['', -1])

      if c =~ pattern
        " found!
        if l:count == 1
          break
        else
          let l:count -= 1
        endif
      endif

      let idx   += 1
      let line  += inc
    else
      if a:opt.fold_open != 0
        let opened_fold += s:fold_opener(line, initline, a:opt.fold_open)
        let fold_start   = foldclosed(line)
        let fold_end     = foldclosedend(line)
      endif

      if a:opt.expand_range >= 0
        if a:kind =~# '[ft]'
          let endline  = line("w$") + a:opt.expand_range
          let endline  = (endline > fileend) ? fileend : endline
          let line_num = endline - startline
        elseif a:kind =~# '[FT]'
          let endline  = line("w0") - a:opt.expand_range
          let endline  = (endline < 1) ? 1 : endline
          let line_num = startline - endline
        endif
      endif

      if fold_start < 0
        continue
      else
        let idx   += (fold_{edge} - line) * inc + 1
        let line   = fold_{edge} + inc
      endif
    endif
  endwhile

  " restore view
  call winrestview(a:view)

  " could not find
  if idx > line_num | return [copy(s:null_dest), opened_fold] | endif

  if a:kind ==# 't'
    let output = [{'lnum': line - 1, 'col': col, 'curswant': curswant}, opened_fold]
  elseif a:kind ==# 'T'
    let output = [{'lnum': line + 1, 'col': col, 'curswant': curswant}, opened_fold]
  else
    let output = [{'lnum': line, 'col': col, 'curswant': curswant}, opened_fold]
  endif

  return output
endfunction
"}}}
function! s:highlight_add(row, col) "{{{
  return matchadd("IncSearch", '\%' . a:row . 'l\%' . a:col . 'c.')
endfunction
"}}}
function! s:highlight_del(id) "{{{
  return matchdelete(a:id)
endfunction
"}}}
function! s:auto_scroll_up()  "{{{
  let current = line('.')
  let viewtop = line('w0')
  let lineend = line('$')
  let winline = winline()
  let offset  = &scrolloff

  if current - viewtop <= offset
    return
  endif

  let lnum = viewtop
  let winheight = winheight(0)
  let aim  = winline + winheight - 1
  let lines = []
  while aim > 0
    let fold_end = foldclosedend(lnum)
    let lines += [lnum]

    if fold_end < 0
      let lnum += 1
    else
      let lnum = fold_end + 1
    endif

    if lnum >= lineend
      break
    endif

    let aim -= 1
  endwhile

  let idx = 0
  for line in lines
    if line >= current
      break
    endif
    let idx += 1
  endfor

  if len(lines) - idx + offset >= winheight
    let topline = lines[idx - offset]
    call winrestview({'topline': topline})
    redraw
  endif
  return
endfunction
"}}}
function! s:auto_scroll_down()  "{{{
  let current = line('.')
  let viewbot = line('w$')
  let winline = winline()
  let offset  = &scrolloff

  if viewbot - current <= offset
    return
  endif

  let lnum = viewbot
  let winheight = winheight(0)
  let aim  = 2*winheight - winline
  let lines = []
  while aim > 0
    let fold_end = foldclosed(lnum)
    let lines += [lnum]

    if fold_end < 0
      let lnum -= 1
    else
      let lnum = fold_end - 1
    endif

    if lnum <= 1
      break
    endif

    let aim -= 1
  endwhile

  let idx = 0
  for line in lines
    if line <= current
      break
    endif
    let idx += 1
  endfor

  if winheight - idx + offset <= len(lines)
    let topline = lines[idx + winheight - offset - 1]
    call winrestview({'topline': topline})
    redraw
  endif
  return
endfunction
"}}}

" vertical w, b, e, ge, W, B, E, gE
function! s:columnmove_wbege(kind, mode, wise, argn, args) "{{{
  " count assginment
  let l:count = (a:argn > 0 && a:args[0] > 0) ? a:args[0] : v:count1

  " re-entering to the visual mode (if necessary)
  if (a:mode ==# 'x') && ((mode() !=? 'v') && (mode() != "\<C-v>"))
    normal! gv
  endif

  " searching for the user configuration
  let options_dict = (a:argn > 1) ? a:args[1] : {}

  " save view
  let init_view = winsaveview()

  " resolving user configuration
  let opt = {}
  let opt.fold_open      = s:user_mode_conf('fold_open', options_dict, 0, a:mode)
  let opt.strict_wbege   = s:user_conf(  'strict_wbege', options_dict, 1)
  let opt.fold_treatment = s:user_conf('fold_treatment', options_dict, 0)

  " searching for the destination
  let [dest_view, opened_fold] = s:get_dest_wbege(a:kind, l:count, init_view, opt)

  " move cursor
  if dest_view != s:null_dest
    " optimize the motion
    if a:wise != ''
      execute 'normal! ' . a:wise
    endif

    if (v:version > 704) || (v:version == 704 && has('patch310'))
      call setpos('.', [0, dest_view.lnum, dest_view.col+1, 0, dest_view.curswant+1])
    else
      call winrestview(s:add_topline(dest_view))
    endif
  endif

  " close unnecessary fold
  if opened_fold != []
    call s:fold_closer(line('.'), opened_fold)
  endif

  return ''
endfunction
"}}}
function! s:get_dest_wbege(kind, count, view, opt)  "{{{
  let l:count     = a:count
  let virtcol     = virtcol('.')
  let initline    = a:view.lnum
  let col         = a:view.col    " NOTE: not equal col('.')!
  let curswant    = a:view.curswant
  let opened_fold = []

  if a:kind ==# 'w'
    " the case for w command
    let inc       = 1
    let edge      = 'end'
    let endline   = line('$')
    let lines     = getline(initline, endline)
    let threshold = endline - initline
  elseif a:kind ==# 'b'
    " the case for b command
    let inc       = -1
    let edge      = 'start'
    let lines     = reverse([' '] + getline(1, initline))
    let threshold = initline
  elseif a:kind ==# 'e'
    " the case for e command
    let inc       = 1
    let edge      = 'end'
    let endline   = line('$')
    let lines     = getline(initline, endline) + [' ']
    let threshold = endline - initline + 1
  elseif a:kind ==# 'ge'
    " the case for ge command
    let inc       = -1
    let edge      = 'start'
    let lines     = reverse(getline(1, initline))
    let threshold = initline - 1
  elseif a:kind ==# 'W'
    " the case for W command
    let inc       = 1
    let edge      = 'end'
    let endline   = line('$')
    let lines     = getline(initline, endline)
    let threshold = endline - initline
  elseif a:kind ==# 'B'
    " the case for b command
    let inc       = -1
    let edge      = 'start'
    let lines     = reverse([''] + getline(1, initline))
    let threshold = initline
  elseif a:kind ==# 'E'
    " the case for e command
    let inc       = 1
    let edge      = 'end'
    let endline   = line('$')
    let lines     = getline(initline, endline) + ['']
    let threshold = endline - initline + 1
  elseif a:kind ==# 'gE'
    " the case for gE command
    let inc       = -1
    let edge      = 'start'
    let lines     = reverse(getline(1, initline))
    let threshold = initline - 1
  endif

  if ((a:kind =~# '[wbe]') || (a:kind ==# 'ge')) && (!a:opt.strict_wbege)
    let null_char = ['', -1]
  else
    let null_char = [' ', -1]
  endif

  " determine the threshold column (=curswant)
  let char_width     = strdisplaywidth(matchstr(lines[0], '.', col))
  let acceptable_gap = char_width - 1
  let curswant       = (lines[0] == '') ? 0
        \            : (curswant - virtcol + char_width <= acceptable_gap) ? curswant
        \            : (virtcol - char_width)
  let cutup          = max([virtcol, col('.')]) + acceptable_gap

  if a:opt.fold_open != 0
    " fold opening
    let opened_fold += s:fold_opener(initline, initline, a:opt.fold_open)
  endif

  " check folding
  let fold_start = foldclosed(initline)
  let fold_end   = foldclosedend(initline)

  " jump folded parts if necessary
  if fold_{edge} >= 0
    " The current line is still folded
    let line = fold_{edge}  " line number of the destination
    let idx  = (fold_{edge} - line) * inc
  else
    let line = initline  " line number of the destination
    let idx  = 0
  endif

  let [c, col] = (fold_{edge} < 0)
        \      ? s:getchar_from_same_column(lines[idx], curswant, cutup, null_char)
        \      : null_char
  let is_target_cur = s:check_c(a:kind, c, a:opt)

  let output = [copy(s:null_dest), opened_fold]
  while l:count > 0
    let idx  += 1
    if idx > threshold
      return output
    endif
    let line  += inc

    if a:opt.fold_open != 0
      " fold opening
      let opened_fold += s:fold_opener(line, initline, a:opt.fold_open)
    endif

    let fold_start = foldclosed(line)
    let fold_end   = foldclosedend(line)

    if (fold_{edge} >= 0) && (a:opt.fold_treatment == 0)
      " skip folded lines
      while 1
        let idx += (fold_{edge} - line) * inc + 1
        let line = fold_{edge} + inc  " line number of the destination

        if a:kind ==? 'w' || a:kind ==? 'e'
          if (line > endline) | return output | endif
        elseif a:kind ==? 'b' || a:kind =~# 'g[eE]'
          if (line < 1) | return output | endif
        endif

        if a:opt.fold_open != 0
          " fold opening
          let opened_fold += s:fold_opener(line, initline, a:opt.fold_open)
        endif

        let fold_start = foldclosed(line)
        let fold_end   = foldclosedend(line)

        if (fold_{edge} < 0) | break | endif
      endwhile
    endif

    let is_target_pre = is_target_cur
    let [c, col] = (fold_{edge} < 0)
          \      ? s:getchar_from_same_column(lines[idx], curswant, cutup, null_char)
          \      : null_char
    let is_target_cur = s:check_c(a:kind, c, a:opt)

    let [idx, line, l:count, output]
          \ = s:judge(a:kind, a:opt, fold_{edge}, is_target_pre, is_target_cur,
          \           l:count, inc, idx, line, col, curswant, opened_fold, output)
  endwhile

  return output
endfunction
"}}}
function! s:check_c(kind, c, opt) "{{{
  if a:kind =~# '[wbe]' || a:kind ==# 'ge'
    if a:opt.strict_wbege
      " strict w, b, e, ge
      " space, tab   : -1
      " keyword chars:  1
      " other chars  :  0
      return (a:c =~ '\m\s') ? -1 : ((a:c =~ '\m\k') ? 1 : 0)
    else
      " spoiled w, b, e, ge
      " empty    : 1
      " not empty: 0
      return (a:c == '') ? 1 : 0
    endif
  else
    " W, B, E, gE
    " space    : 1
    " not space: 0
    return (a:c =~ '\m\s') ? 1 : 0
  endif
endfunction
"}}}
function! s:judge(kind, opt, fold_edge, is_target_pre, is_target_cur, count, inc, idx, line, col, curswant, opened_fold, output)  "{{{
  " FIXME: Too much arguments!
  let idx     = a:idx
  let line    = a:line
  let l:count = a:count
  let output  = a:output
  let lnum    = a:output[0]['lnum']

  if a:kind ==# 'w' || a:kind ==# 'ge'
    if a:opt.strict_wbege
      " strict w, ge

      " the content of is_target_***
      " space, tab   : -1
      " keyword chars:  1
      " other chars  :  0

      if a:fold_edge >= 0
        " The current line is folded
        let idx  += (a:fold_edge - a:line) * a:inc
        let line  = a:fold_edge
      elseif a:is_target_pre < 0
        " The previous is empty or space
        if a:is_target_cur >= 0
          let l:count -= 1
          let output = [{'lnum': a:line, 'col': a:col, 'curswant': a:curswant}, a:opened_fold]
        endif
      elseif !(a:is_target_pre == a:is_target_cur)
        " a different kind of character as previous one
        if a:is_target_cur >= 0
          let l:count -= 1
          let output = [{'lnum': a:line, 'col': a:col, 'curswant': a:curswant}, a:opened_fold]
        endif
      endif
    else
      " spoiled w, ge

      " the content of is_target_***
      " empty    : 1
      " not empty: 0

      if a:fold_edge >= 0
        " The current line is folded
        let idx  += (a:fold_edge - a:line) * a:inc
        let line  = a:fold_edge
      elseif (a:is_target_pre && !a:is_target_cur)
        " The previous line is empty and the current line is not empty
        let l:count -= 1
        let output = [{'lnum': a:line, 'col': a:col, 'curswant': a:curswant}, a:opened_fold]
      endif
    endif
  elseif a:kind ==# 'b' || a:kind ==# 'e'
    if a:opt.strict_wbege
      " strict b, e

      " the content of is_target_***
      " space, tab   : -1
      " keyword chars:  1
      " other chars  :  0

      if a:fold_edge >= 0
        " The current line is folded
        if a:is_target_pre >= 0
          " The previous character is not space
          if lnum > 0
            let l:count -= 1
          endif
        endif

        let idx  += (a:fold_edge - a:line) * a:inc
        let line  = a:fold_edge
      elseif a:is_target_pre < 0
        " The previous is empty or space
        if a:is_target_cur > -1
          let output = [{'lnum': a:line, 'col': a:col, 'curswant': a:curswant}, a:opened_fold]
        endif
      elseif a:is_target_pre == a:is_target_cur
        " a same kind of character as previous one
        let output = [{'lnum': a:line, 'col': a:col, 'curswant': a:curswant}, a:opened_fold]
      else
        " a different kind of character as previous one
        if lnum > 0
          let l:count -= 1
        endif

        if (l:count > 0) && (a:is_target_cur > -1)
          let output = [{'lnum': a:line, 'col': a:col, 'curswant': a:curswant}, a:opened_fold]
        endif
      endif
    else
      " spoiled b, e

      " the content of is_target_***
      " empty    : 1
      " not empty: 0

      if a:fold_edge >= 0
        " The current line is folded
        if !a:is_target_pre && lnum > 0
          let l:count -= 1
        endif

        let idx  += (a:fold_edge - a:line) * a:inc
        let line  = a:fold_edge
      elseif (a:is_target_cur && !a:is_target_pre)
        " The current line is empty and the previous line is not empty
        if lnum > 0
          let l:count -= 1
        endif
      elseif !a:is_target_cur
        let output = [{'lnum': a:line, 'col': a:col, 'curswant': a:curswant}, a:opened_fold]
      endif
    endif
  elseif a:kind ==# 'W' || a:kind ==# 'gE'
    " W, gE

    " the content of is_target_***
    " space    : 1
    " not space: 0

    if a:fold_edge >= 0
      " The current line is folded
      let idx  += (a:fold_edge - a:line) * a:inc
      let line  = a:fold_edge
    elseif (a:is_target_pre && !a:is_target_cur)
      " The previous line is empty and the current line is not empty
      let l:count -= 1
      let output = [{'lnum': a:line, 'col': a:col, 'curswant': a:curswant}, a:opened_fold]
    endif
  elseif a:kind ==# 'B' || a:kind ==# 'E'
    " B, E

    " the content of is_target_***
    " space    : 1
    " not space: 0

    if a:fold_edge >= 0
      " The current line is folded
      if !a:is_target_pre && lnum > 0
        let l:count -= 1
      endif

      let idx  += (a:fold_edge - a:line) * a:inc
      let line  = a:fold_edge
    elseif a:is_target_cur && !a:is_target_pre
      " The current line is empty and the previous line is not empty
      if lnum > 0
        let l:count -= 1
      endif
    elseif !a:is_target_cur
      let output = [{'lnum': a:line, 'col': a:col, 'curswant': a:curswant}, a:opened_fold]
    endif
  endif

  return [idx, line, l:count, output]
endfunction
"}}}

let &cpo = s:save_cpo
unlet s:save_cpo

" vim:set foldmethod=marker:
" vim:set commentstring="%s:
" vim:set ts=2 sts=2 sw=2 et:
