" columnmove.vim - bring cursor vertically in similar ways as line-wise
"                    commands

" Because of my preference these commands ignore folded lines in default.

" Vertical f, t, F, T commands would only take into account the range
" displayed. Because I assumed no one can remember precise characters in the
" same column out of one's sight.

" If there are vicinal lines with no character in the same column (for
" example, vicinal empty line), vertical w, b, e, ge assume there is a space.

" TODO: want to replace the searching method of w, b, e, ge to the one using
"       normal expression, but I could not find out an appropriate one...
"       -> Got it! w, ge : \%(\<\S\|\>\zs\S\|\s\zs\S\|^\S\)
"                  b, e  : \%(\S\>\|\S\ze\s\|\S\ze\<\|\S$\)

" NOTE: As for the "columnfix", it looks like dirty hack! It is to clear
"       preserved column position at the end of line. Is there any
"       alternatives?

let s:type_num  = type(0)
let s:type_str  = type('')
let s:type_list = type([])
let s:type_dict = type({})

" for vertical ';', ',' commands
" first factor is the kind of command (f, t, F, T)
" second factor is the character searched last.
let s:search_history = ['', '']

" load vital
let s:V  = vital#of('columnmove')
let s:Sl = s:V.import('Data.List')
let s:s  = s:V.import('Prelude')
unlet s:V

""" mapping functions
" vertical 'f' commands "{{{
function! columnmove#f(mode, ...)
  " count assginment
  let l:count = (a:0 > 1 && a:2 > 0) ? a:2 : v:count1

  " re-entering to the visual mode (if necessary)
  if (a:mode ==# 'x') && ((mode() !=? 'v') && (mode() != "\<C-v>"))
    normal! gv
  endif

  " searching for the user configuration
  let options_dict = (a:0 > 2) ? a:3 : {}

  " target character assignment
  let char = (a:0 > 0) ? a:1 : ''

  let output = s:columnmove_ftFT('f', a:mode, char, l:count, options_dict, 'j')

  return output
endfunction
"}}}
" vertical 't' commands "{{{
function! columnmove#t(mode, ...)
  " count assginment
  let l:count = (a:0 > 1 && a:2 > 0) ? a:2 : v:count1

  " re-entering to the visual mode (if necessary)
  if (a:mode ==# 'x') && ((mode() !=? 'v') && (mode() != "\<C-v>"))
    normal! gv
  endif

  " searching for the user configuration
  let options_dict = (a:0 > 2) ? a:3 : {}

  " target character assignment
  let char = (a:0 > 0) ? a:1 : ''

  let output = s:columnmove_ftFT('t', a:mode, char, l:count, options_dict, 'j')

  return output
endfunction
"}}}
" vertical 'F' commands "{{{
function! columnmove#F(mode, ...)
  " count assginment
  let l:count = (a:0 > 1 && a:2 > 0) ? a:2 : v:count1

  " re-entering to the visual mode (if necessary)
  if (a:mode ==# 'x') && ((mode() !=? 'v') && (mode() != "\<C-v>"))
    normal! gv
  endif

  " searching for the user configuration
  let options_dict = (a:0 > 2) ? a:3 : {}

  " target character assignment
  let char = (a:0 > 0) ? a:1 : ''

  let output = s:columnmove_ftFT('F', a:mode, char, l:count, options_dict, 'k')

  return output
endfunction
"}}}
" vertical 'T' commands "{{{
function! columnmove#T(mode, ...)
  " count assginment
  let l:count = (a:0 > 1 && a:2 > 0) ? a:2 : v:count1

  " re-entering to the visual mode (if necessary)
  if (a:mode ==# 'x') && ((mode() !=? 'v') && (mode() != "\<C-v>"))
    normal! gv
  endif

  " searching for the user configuration
  let options_dict = (a:0 > 2) ? a:3 : {}

  " target character assignment
  let char = (a:0 > 0) ? a:1 : ''

  let output = s:columnmove_ftFT('T', a:mode, char, l:count, options_dict, 'k')

  return output
endfunction
"}}}
" vertical ';' commands "{{{
function! columnmove#semicolon(mode, ...)
  let kind   = s:search_history[0]
  let char   = s:search_history[1]

  if kind != ''
    " count assginment
    let l:count = (a:0 > 0 && a:1 > 0) ? a:1 : v:count1

    " for the user configuration
    let options_dict = (a:0 > 1) ? a:2 : {}

    " do not update history
    call extend(options_dict, {'update_history' : 0})

    " call well-suited command
    let output = columnmove#{kind}(a:mode, char, l:count, options_dict)
  else
    let output = ''
  endif

  return output
endfunction
"}}}
" vertical ',' commands "{{{
function! columnmove#comma(mode, ...)
  let kind = s:search_history[0]
  let char = s:search_history[1]

  if kind != ''
    " count assginment
    let l:count = (a:0 > 0 && a:1 > 0) ? a:1 : v:count1

    " for the user configuration
    let options_dict = (a:0 > 1) ? a:2 : {}

    " do not update history
    call extend(options_dict, {'update_history' : 0})

    " call well-suited command
    let output = columnmove#{tr(kind, 'ftFT', 'FTft')}(a:mode, char, l:count, options_dict)
  else
    let output = ''
  endif

  return output
endfunction
"}}}
" vertical 'w' commands "{{{
function! columnmove#w(mode, ...)
  " count assginment
  let l:count = (a:0 > 0 && a:1 > 0) ? a:1 : v:count1

  " re-entering to the visual mode (if necessary)
  if (a:mode ==# 'x') && ((mode() !=? 'v') && (mode() != "\<C-v>"))
    normal! gv
  endif

  " searching for the user configuration
  let options_dict = (a:0 > 1) ? a:2 : {}

  let output = s:columnmove_wbege('w', a:mode, l:count, options_dict, 'j')

  return output
endfunction
"}}}
" vertical 'b' commands "{{{
function! columnmove#b(mode, ...)
  " count assginment
  let l:count = (a:0 > 0 && a:1 > 0) ? a:1 : v:count1

  " re-entering to the visual mode (if necessary)
  if (a:mode ==# 'x') && ((mode() !=? 'v') && (mode() != "\<C-v>"))
    normal! gv
  endif

  " searching for the user configuration
  let options_dict = (a:0 > 1) ? a:2 : {}

  let output = s:columnmove_wbege('b', a:mode, l:count, options_dict, 'k')

  return output
endfunction
"}}}
" vertical 'e' commands "{{{
function! columnmove#e(mode, ...)
  " count assginment
  let l:count = (a:0 > 0 && a:1 > 0) ? a:1 : v:count1

  " re-entering to the visual mode (if necessary)
  if (a:mode ==# 'x') && ((mode() !=? 'v') && (mode() != "\<C-v>"))
    normal! gv
  endif

  " searching for the user configuration
  let options_dict = (a:0 > 1) ? a:2 : {}

  let output = s:columnmove_wbege('e', a:mode, l:count, options_dict, 'j')

  return output
endfunction
"}}}
" vertical 'ge' commands  "{{{
function! columnmove#ge(mode, ...)
  " count assginment
  let l:count = (a:0 > 0 && a:1 > 0) ? a:1 : v:count1

  " re-entering to the visual mode (if necessary)
  if (a:mode ==# 'x') && ((mode() !=? 'v') && (mode() != "\<C-v>"))
    normal! gv
  endif

  " searching for the user configuration
  let options_dict = (a:0 > 1) ? a:2 : {}

  let output = s:columnmove_wbege('ge', a:mode, l:count, options_dict, 'k')

  return output
endfunction
"}}}

""" subfuncs
" common
function! s:user_conf(name, arg, default)    "{{{
  let user_conf = a:default

  if !empty(a:arg)
    if type(a:arg) == s:type_dict
      if has_key(a:arg, a:name)
        return a:arg[a:name]
      endif
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
    if type(a:arg) == s:type_dict
      if has_key(a:arg, a:name)
        if type(a:arg[a:name]) == s:type_dict
          return get(a:arg[a:name], a:mode, a:default)
        elseif type(a:arg[a:name]) == s:type_num
          return a:arg[a:name]
        endif
      endif
    endif
  endif

  if exists('g:columnmove_' . a:name)
    let type_val = g:columnmove_{a:name}

    if type(type_val) == s:type_dict
      let user_conf = get(g:columnmove_{a:name}, a:mode, a:default)
    elseif type(type_val) == s:type_num
      let user_conf = g:columnmove_{a:name}
    endif
  endif

  if exists('t:columnmove_' . a:name)
    let type_val = t:columnmove_{a:name}

    if type(type_val) == s:type_dict
      let user_conf = get(t:columnmove_{a:name}, a:mode, a:default)
    elseif type(type_val) == s:type_num
      let user_conf = t:columnmove_{a:name}
    endif
  endif

  if exists('w:columnmove_' . a:name)
    let type_val = w:columnmove_{a:name}

    if type(type_val) == s:type_dict
      let user_conf = get(w:columnmove_{a:name}, a:mode, a:default)
    elseif type(type_val) == s:type_num
      let user_conf = w:columnmove_{a:name}
    endif
  endif

  if exists('b:columnmove_' . a:name)
    let type_val = b:columnmove_{a:name}

    if type(type_val) == s:type_dict
      let user_conf = get(b:columnmove_{a:name}, a:mode, a:default)
    elseif type(type_val) == s:type_num
      let user_conf = b:columnmove_{a:name}
    endif
  endif

  return user_conf
endfunction
"}}}
function! s:check_raw(arg)    "{{{
  if has_key(a:arg, 'raw')
    return a:arg['raw']
  endif

  return 0
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

" vertical f, t, F, T
function! s:columnmove_ftFT(kind, mode, char, count, options_dict, command) "{{{
  " searching for destinations
  let col         = col(".")
  let currentline = line(".")

  if a:char != ''
    let dest = s:get_dest_ftFT_with_char(a:kind, a:mode, a:char, currentline, col, a:count, a:options_dict)
  else
    let dest = s:get_dest_ftFT(a:kind, a:mode, currentline, col, a:count, a:options_dict)
  endif

  let opt_raw = s:check_raw(a:options_dict)

  if opt_raw != 1
    let output = ''
    if dest[0] > 0
      if a:mode =~# '[nxo]'
        if foldclosed(currentline) < 0
          let columnfix = ((col == col('$')) && (col == 1)) ? '0' : ((col == col('$') - 1) ? 'hl' : '')
        else
          let columnfix = ''
        endif

        execute 'normal! ' . columnfix . dest[0] . a:command
      elseif a:mode ==# 'i'
        call cursor(dest[1])
      endif
    endif
  endif

  if opt_raw
    let output = {'displacement' : dest[0], 'destination' : dest[1], 'opened_fold' : dest[2]}
  endif

  " close unnecessary fold
  if dest[2] != []
    call s:fold_closer(line('.'), dest[2])
  endif

  return output
endfunction
"}}}
function! s:get_dest_ftFT(kind, mode, currentline, col, count, options_dict)  "{{{
  " resolving user configuration
  let opt_fold_open      = s:user_mode_conf('fold_open', a:options_dict, 0, a:mode)
  let opt_ignore_case    = s:user_conf(   'ignore_case', a:options_dict, &ignorecase)
  let opt_highlight      = s:user_conf(     'highlight', a:options_dict, 1)
  let opt_update_history = s:user_conf('update_history', a:options_dict, 1)
  let opt_expand_range   = s:user_conf(  'expand_range', a:options_dict, 0)
  let opt_auto_scroll    = s:user_conf(   'auto_scroll', a:options_dict, 0)

  " gather buffer lines
  if a:kind =~# '[ft]'
    " down
    if opt_auto_scroll
      let room = screenrow() - &scrolloff - 1

      if room > 0
        execute "normal! " . room . "\<C-e>"
      endif
    endif

    let startline = (a:kind ==# 'f') ? a:currentline + 1 : a:currentline + 2

    if opt_expand_range < 0
      let endline = line("$")
    else
      let fileend = line("$")
      let endline = line("w$") + opt_expand_range
      let endline = (endline > fileend) ? fileend : endline
    endif

    let inc  = 1
    let edge = 'end'

    let whole_lines = getline(startline, endline)
    let line_num    = endline - startline
  elseif a:kind =~# '[FT]'
    " up
    if opt_auto_scroll
      let winheight = winheight(0)
      let room      = winheight - screenrow() - &scrolloff

      if room > 0
        execute "normal! " . room . "\<C-y>"
      endif
    endif

    let startline = (a:kind ==# 'F') ? a:currentline - 1 : a:currentline - 2

    if opt_expand_range < 0
      let endline = 1
    else
      let endline = line("w0") - opt_expand_range
      let endline = (endline < 1) ? 1 : endline
    endif

    let inc  = -1
    let edge = 'start'

    let whole_lines = reverse(getline(endline, startline))
    let line_num    = startline - endline
  endif

  " collecting characters in same column as cursor
  let idx         = 0
  let line        = startline

  let chars       = []
  let lines       = []
  let opened_fold = []

  if (opt_fold_open != 0) && (a:kind =~# '[tT]')
    " fold opening
    let opened_fold += s:fold_opener(a:currentline + inc, a:currentline, opt_fold_open)
  endif

  while idx <= line_num
    let fold_start = foldclosed(line)
    let fold_end   = foldclosedend(line)
    if fold_start < 0
      let chars += [whole_lines[idx][a:col-1]]
      let lines += [line]
      let idx   += 1
      let line  += inc
    else
      if opt_fold_open != 0
        let opened_fold += s:fold_opener(line, a:currentline, opt_fold_open)
        let fold_start   = foldclosed(line)
        let fold_end     = foldclosedend(line)
      endif

      if opt_expand_range >= 0
        if a:kind =~# '[ft]'
          let endline  = line("w$") + opt_expand_range
          let endline  = (endline > fileend) ? fileend : endline
          let line_num = endline - startline
        elseif a:kind =~# '[FT]'
          let endline  = line("w0") - opt_expand_range
          let endline  = (endline < 1) ? 1 : endline
          let line_num = startline - endline
        endif
      endif

      if fold_start < 0
        continue
      else
        let chars += ['']
        let lines += [line]
        let idx   += (fold_{edge} - line) * inc + 1
        let line   = fold_{edge} + inc
      endif
    endif
  endwhile

  " picking up candidates
  let prefix = opt_ignore_case ? '\c' : '\C'

  let displacements  = []
  let highlight_rows = []
  let uniq_chars     = s:Sl.uniq_by(filter(copy(chars), '!empty(v:val)'), 'v:val')
  for c in copy(uniq_chars)
    let pattern = prefix . s:s.escape_pattern(c)
    let idx     = match(chars, pattern, 0, a:count)
    if idx >= 0
      let displacements  += [idx + 1]
      let highlight_rows += [lines[idx]]
    else
      call remove(uniq_chars, match(uniq_chars, pattern))
    endif
  endfor
  if displacements == []| return [-1, [], opened_fold] | endif

  " highlighting candidates
  if opt_highlight
    let id_list = map(copy(highlight_rows), "s:highlight_add(v:val, a:col)")
    redraw
  endif

  " target character assginment
  let key = nr2char(getchar())

  " delete highlighting
  if opt_highlight
    call map(id_list, "s:highlight_del(v:val)")
    redraw
  endif

  if key == "" | return [-1, -1, opened_fold] | endif

  " update history
  if opt_update_history
    let s:search_history = [a:kind, key]
  endif

  let pattern = prefix . s:s.escape_pattern(key)
  let idx     = match(uniq_chars, pattern)
  if idx < 0 | return [-1, -1, opened_fold] | endif

  if a:kind ==# 't'
    let output = [displacements[idx], [highlight_rows[idx] - 1, a:col], opened_fold]
  elseif a:kind ==# 'T'
    let output = [displacements[idx], [highlight_rows[idx] + 1, a:col], opened_fold]
  else
    let output = [displacements[idx], [highlight_rows[idx], a:col], opened_fold]
  endif

  return output
endfunction
"}}}
function! s:get_dest_ftFT_with_char(kind, mode, c, currentline, col, count, options_dict)  "{{{
  " resolving user configuration
  let opt_fold_open      = s:user_mode_conf('fold_open', a:options_dict, 0, a:mode)
  let opt_ignore_case    = s:user_conf(   'ignore_case', a:options_dict, &ignorecase)
  let opt_update_history = s:user_conf('update_history', a:options_dict, 1)
  let opt_expand_range   = s:user_conf(  'expand_range', a:options_dict, 0)
  let opt_auto_scroll    = s:user_conf(   'auto_scroll', a:options_dict, 0)

  " update history
  if opt_update_history
    let s:search_history = [a:kind, a:c]
  endif

  " defining the searching range
  if a:kind =~# '[ft]'
    " down
    if opt_auto_scroll
      let room = screenrow() - &scrolloff - 1

      if room > 0
        execute "normal! " . room . "\<C-e>"
      endif
    endif

    let startline = (a:kind ==# 'f') ? a:currentline + 1 : a:currentline + 2

    if opt_expand_range < 0
      let endline = line("$")
    else
      let fileend = line("$")
      let endline = line("w$") + opt_expand_range

      let endline = (endline > fileend) ? fileend : endline
    endif

    let inc  = 1
    let edge = 'end'

    let whole_lines = getline(startline, endline)
  elseif a:kind =~# '[FT]'
    " up
    if opt_auto_scroll
      let winheight = winheight(0)
      let room      = winheight - screenrow() - &scrolloff

      if room > 0
        execute "normal! " . room . "\<C-y>"
      endif
    endif

    let startline = (a:kind ==# 'F') ? a:currentline - 1 : a:currentline - 2

    if opt_expand_range < 0
      let endline = 1
    else
      let endline = line("w0") - opt_expand_range

      let endline = (endline < 1) ? 1 : endline
    endif

    let inc  = -1
    let edge = 'start'

    let whole_lines = reverse(getline(endline, startline))
  endif

  " searching for the destination
  let idx      = 0
  let line     = startline
  let displ    = 1
  let prefix   = opt_ignore_case ? '\c' : '\C'
  let pattern  = prefix . s:s.escape_pattern(a:c)
  let line_num = len(whole_lines) - 1

  let opened_fold = []

  if (opt_fold_open != 0) && (a:kind =~# '[tT]')
    " fold opening
    let opened_fold += s:fold_opener(a:currentline + inc, a:currentline, opt_fold_open)
  endif

  while idx <= line_num
    let fold_start = foldclosed(line)
    let fold_end   = foldclosedend(line)
    if fold_start < 0
      let c = whole_lines[idx][a:col-1]
      if c =~ pattern | break | endif " found!
      let idx   += 1
      let line  += inc
      let displ += 1
    else
      if opt_fold_open != 0
        let opened_fold += s:fold_opener(line, a:currentline, opt_fold_open)
        let fold_start   = foldclosed(line)
        let fold_end     = foldclosedend(line)
      endif

      if opt_expand_range >= 0
        if a:kind =~# '[ft]'
          let endline  = line("w$") + opt_expand_range
          let endline  = (endline > fileend) ? fileend : endline
          let line_num = endline - startline
        elseif a:kind =~# '[FT]'
          let endline  = line("w0") - opt_expand_range
          let endline  = (endline < 1) ? 1 : endline
          let line_num = startline - endline
        endif
      endif

      if fold_start < 0
        continue
      else
        let idx   += (fold_{edge} - line) * inc + 1
        let line   = fold_{edge} + inc
        let displ += 1
      endif
    endif
  endwhile

  " could not find
  if idx > line_num | return [-1, [], opened_fold] | endif

  if a:kind ==# 't'
    let output = [displ, [line - 1, a:col], opened_fold]
  elseif a:kind ==# 'T'
    let output = [displ, [line + 1, a:col], opened_fold]
  else
    let output = [displ, [line, a:col], opened_fold]
  endif

  return output
endfunction
"}}}
function! s:highlight_add(row, col) "{{{
  let pattern   = '\%' . a:row . 'l\%' . a:col . 'c.'
  let id = matchadd("IncSearch", pattern)
  return id
endfunction
"}}}
function! s:highlight_del(id) "{{{
  call matchdelete(a:id)

  return
endfunction
"}}}

" vertical w, b, e, ge
function! s:columnmove_wbege(kind, mode, count, options_dict, command) "{{{
  " searching for the destination
  let col         = col(".")
  let currentline = line(".")

  " resolving user configuration
  let opt_fold_open      = s:user_mode_conf('fold_open', a:options_dict, 0, a:mode)
  let opt_strict_wbege   = s:user_conf(  'strict_wbege', a:options_dict, 1)
  let opt_fold_treatment = s:user_conf('fold_treatment', a:options_dict, 0)
  let opt_raw            = s:check_raw(a:options_dict)

  if opt_strict_wbege
    if a:kind =~# '\%(w\|ge\)'
      let dest = s:get_dest_wge(a:kind, col, currentline, a:count, opt_fold_open, opt_fold_treatment)
    elseif a:kind =~# '[be]'
      let dest = s:get_dest_be(a:kind, col, currentline, a:count, opt_fold_open, opt_fold_treatment)
    endif
  else
    if a:kind =~# '\%(w\|ge\)'
      let dest = s:get_dest_spoiled_wge(a:kind, col, currentline, a:count, opt_fold_open, opt_fold_treatment)
    elseif a:kind =~# '[be]'
      let dest = s:get_dest_spoiled_be(a:kind, col, currentline, a:count, opt_fold_open, opt_fold_treatment)
    endif
  endif

  if opt_raw != 1
    let output = ''
    if dest[0] > 0
      if a:mode =~# '[nxo]'
        if foldclosed(currentline) < 0
          let columnfix = ((col == col('$')) && (col == 1)) ? '0' : ((col == col('$') - 1) ? 'hl' : '')
        else
          let columnfix = ''
        endif

        execute 'normal! ' . columnfix . dest[0] . a:command
      elseif a:mode ==# 'i'
        call cursor(dest[1])
      endif
    endif
  endif

  if opt_raw
    let output = {'displacement' : dest[0], 'destination' : dest[1], 'opened_fold' : dest[2]}
  endif

  " close unnecessary fold
  if dest[2] != []
    call s:fold_closer(line('.'), dest[2])
  endif

  return output
endfunction
"}}}
function! s:get_dest_wge(kind, col, currentline, count, level, opt_fold_treatment)  "{{{
  let col         = a:col
  let l:count     = a:count
  let opened_fold = []

  if a:kind ==# 'w'
    " the case for w command
    let inc       = 1
    let edge      = 'end'
    let endline   = line('$')
    let lines     = getline(a:currentline, endline)
    let threshold = endline - a:currentline
  elseif a:kind ==# 'ge'
    " the case for ge command
    let inc       = -1
    let edge      = 'start'
    let lines     = reverse(getline(1, a:currentline))
    let threshold = a:currentline - 1
  endif

  if a:level != 0
    " fold opening
    let opened_fold += s:fold_opener(a:currentline, a:currentline, a:level)
  endif

  let fold_start = foldclosed(a:currentline)
  let fold_end   = foldclosedend(a:currentline)

  if fold_{edge} >= 0
    " The current line is still folded
    let line = fold_{edge}    " line number of the destination
    let idx  = (fold_{edge} - line) * inc
  else
    let line = a:currentline  " line number of the destination
    let idx  = 0
  endif
  let displ = 0  " displacement from current line to the destination
  let c     = ((col <= len(lines[0])) && (fold_{edge} < 0)) ? lines[idx][col-1] : ' '
  let is_keyword_cur = (c == ' ') ? -1 : ((c =~ '\k') ? 1 : 0)

  let output = [-1, [], opened_fold]
  while l:count > 0
    let idx  += 1
    if idx > threshold
      return output
    endif
    let line  += inc
    let displ += 1

    if a:level != 0
      " fold opening
      let opened_fold += s:fold_opener(line, a:currentline, a:level)
    endif

    let fold_start = foldclosed(line)
    let fold_end   = foldclosedend(line)

    if (fold_{edge} >= 0) && (a:opt_fold_treatment == 0)
      " skip folded lines
      while 1
        let idx += (fold_{edge} - line) * inc + 1
        let line = fold_{edge} + inc  " line number of the destination

        if a:kind ==# 'w'
          if (line > endline) | return [-1, [], opened_fold] | endif
        elseif a:kind ==# 'ge'
          if (line < 1) | return [-1, [], opened_fold] | endif
        endif

        if a:level != 0
          " fold opening
          let opened_fold += s:fold_opener(line, a:currentline, a:level)
        endif

        let fold_start = foldclosed(line)
        let fold_end   = foldclosedend(line)

        let displ += 1

        if (fold_{edge} < 0) | break | endif
      endwhile
    endif

    let is_keyword_pre = is_keyword_cur

    let c = ((col <= len(lines[idx])) && (fold_{edge} < 0)) ? lines[idx][col-1] : ' '

    let is_keyword_cur = (c == ' ') ? -1 : ((c =~ '\k') ? 1 : 0)

    if fold_{edge} >= 0
      " The current line is folded
      let idx  += (fold_{edge} - line) * inc
      let line  = fold_{edge}
      continue
    elseif is_keyword_pre < 0
      " The previous is empty or space
      if is_keyword_cur >= 0
        let l:count -= 1
        let output = [displ, [line, col], opened_fold]
      endif
    elseif is_keyword_pre == is_keyword_cur
      " a same kind of character as previous one
      continue
    else
      " a different kind of character as previous one
      if is_keyword_cur >= 0
        let l:count -= 1
        let output = [displ, [line, col], opened_fold]
      endif
    endif
  endwhile

  return output
endfunction
"}}}
function! s:get_dest_be(kind, col, currentline, count, level, opt_fold_treatment)  "{{{
  let col         = a:col
  let l:count     = a:count
  let opened_fold = []

  if a:kind ==# 'e'
    " the case for e command
    let inc       = 1
    let edge      = 'end'
    let endline   = line('$')
    let lines     = getline(a:currentline, endline) + [' ']
    let threshold = endline - a:currentline + 1
  elseif a:kind ==# 'b'
    " the case for b command
    let inc       = -1
    let edge      = 'start'
    let lines     = reverse([' '] + getline(1, a:currentline))
    let threshold = a:currentline
  endif

  if a:level != 0
    " fold opening
    let opened_fold += s:fold_opener(a:currentline, a:currentline, a:level)
  endif

  let fold_start = foldclosed(a:currentline)
  let fold_end   = foldclosedend(a:currentline)

  if fold_{edge} >= 0
    " The current line is still folded
    let line = fold_{edge}  " line number of the destination
    let idx  = (fold_{edge} - line) * inc
  else
    let line = a:currentline   " line number of the destination
    let idx  = 0
  endif
  let displ = 0  " displacement from current line to the destination
  let c     = ((col <= len(lines[0])) && (fold_{edge} < 0)) ? lines[idx][col-1] : ' '
  let is_keyword_cur = (c == ' ') ? -1 : ((c =~ '\k') ? 1 : 0)

  let output = [-1, [], opened_fold]
  while l:count > 0
    let idx  += 1
    if idx > threshold
      return output
    endif
    let line  += inc
    let displ += 1

    if a:level != 0
      " fold opening
      let opened_fold += s:fold_opener(line, a:currentline, a:level)
    endif

    let fold_start = foldclosed(line)
    let fold_end   = foldclosedend(line)

    let foldedblock = 0
    if (fold_{edge} >= 0) && (a:opt_fold_treatment == 0)
      " skip folded lines
      while 1
        let idx += (fold_{edge} - line) * inc + 1
        let line = fold_{edge} + inc  " line number of the destination

        if a:kind ==# 'e'
          if (line > endline) | return [-1, [], opened_fold] | endif
        elseif a:kind ==# 'b'
          if (line < 1) | return [-1, [], opened_fold] | endif
        endif

        if a:level != 0
          " fold opening
          let opened_fold += s:fold_opener(line, a:currentline, a:level)
        endif

        let fold_start = foldclosed(line)
        let fold_end   = foldclosedend(line)

        let foldedblock += 1

        if (fold_{edge} < 0) | let displ += foldedblock | break | endif
      endwhile
    endif

    let is_keyword_pre = is_keyword_cur

    let c = ((col <= len(lines[idx])) && (fold_{edge} < 0)) ? lines[idx][col-1] : ' '

    let is_keyword_cur = (c == ' ') ? -1 : ((c =~ '\k') ? 1 : 0)

    if fold_{edge} >= 0
      " The current line is folded
      if is_keyword_pre >= 0
        " The previous character is not space
        if displ > 1
          let l:count -= 1
          let output = [displ - 1, [line - inc, col], opened_fold]

          if l:count <= 0 | break | endif
        endif
      endif

      let idx  += (fold_{edge} - line) * inc
      let line  = fold_{edge}
    elseif is_keyword_pre < 0
      " The previous is empty or space
      continue
    elseif is_keyword_pre == is_keyword_cur
      " a same kind of character as previous one
      continue
    else
      " a different kind of character as previous one
      if displ - foldedblock > 1
        let l:count -= 1
        let output = [displ - 1, [line - inc, col], opened_fold]
      endif
    endif
  endwhile

  return output
endfunction
"}}}
function! s:get_dest_spoiled_wge(kind, col, currentline, count, level, opt_fold_treatment)  "{{{
  let col         = a:col
  let l:count     = a:count
  let opened_fold = []

  if a:kind ==# 'w'
    " the case for w command
    let inc       = 1
    let edge      = 'end'
    let endline   = line('$')
    let lines     = getline(a:currentline, endline)
    let threshold = endline - a:currentline
  elseif a:kind ==# 'ge'
    " the case for ge command
    let inc       = -1
    let edge      = 'start'
    let lines     = reverse(getline(1, a:currentline))
    let threshold = a:currentline - 1
  endif

  if a:level != 0
    " fold opening
    let opened_fold += s:fold_opener(a:currentline, a:currentline, a:level)
  endif

  let fold_start = foldclosed(a:currentline)
  let fold_end   = foldclosedend(a:currentline)

  if fold_{edge} >= 0
    " The current line is still folded
    let idx  = (fold_{edge} - a:currentline) * inc
    let line = fold_{edge}  " line number of the destination
  else
    let idx  = 0
    let line = a:currentline   " line number of the destination
  endif
  let displ = 0  " displacement from current line to the destination
  let c     = ((col <= len(lines[0])) && (fold_{edge} < 0)) ? lines[idx][col-1] : ''
  let is_empty_cur = (c == '') ? 1 : 0

  let output = [-1, [], opened_fold]
  while l:count > 0
    let idx += 1
    if idx > threshold
      return output
    endif
    let line  += inc
    let displ += 1

    if a:level != 0
      " fold opening
      let opened_fold += s:fold_opener(line, a:currentline, a:level)
    endif

    let fold_start = foldclosed(line)
    let fold_end   = foldclosedend(line)

    if (fold_{edge} >= 0) && (a:opt_fold_treatment == 0)
      " skip folded lines
      while 1
        let idx += (fold_{edge} - line) * inc + 1
        let line = fold_{edge} + inc  " line number of the destination

        if a:kind ==# 'w'
          if (line > endline) | return [-1, [], opened_fold] | endif
        elseif a:kind ==# 'ge'
          if (line < 1) | return [-1, [], opened_fold] | endif
        endif

        if a:level != 0
          " fold opening
          let opened_fold += s:fold_opener(line, a:currentline, a:level)
        endif

        let fold_start = foldclosed(line)
        let fold_end   = foldclosedend(line)

        let displ += 1

        if (fold_{edge} < 0) | break | endif
      endwhile
    endif

    let is_empty_pre = is_empty_cur

    let c = ((col <= len(lines[idx])) && (fold_{edge} < 0)) ? lines[idx][col-1] : ''

    let is_empty_cur = (c == '') ? 1 : 0

    if fold_{edge} >= 0
      " The current line is folded
      let idx  += (fold_{edge} - line) * inc
      let line  = fold_{edge}
      continue
    elseif (is_empty_pre && !is_empty_cur)
      " The previous line is empty and the current line is not empty
      let l:count -= 1
      let output = [displ, [line, col], opened_fold]
    else
      continue
    endif
  endwhile

  return [displ, [line, col], opened_fold]
endfunction
"}}}
function! s:get_dest_spoiled_be(kind, col, currentline, count, level, opt_fold_treatment)  "{{{
  let col         = a:col
  let l:count     = a:count
  let opened_fold = []

  if a:kind ==# 'e'
    " the case for e command
    let inc       = 1
    let edge      = 'end'
    let endline   = line('$')
    let lines     = getline(a:currentline, endline) + ['']
    let threshold = endline - a:currentline + 1
  else
    " the case for b command
    let inc       = -1
    let edge      = 'start'
    let lines     = reverse([''] + getline(1, a:currentline))
    let threshold = a:currentline
  endif

  if a:level != 0
    " fold opening
    let opened_fold += s:fold_opener(a:currentline, a:currentline, a:level)
  endif

  let fold_start = foldclosed(a:currentline)
  let fold_end   = foldclosedend(a:currentline)

  if fold_{edge} >= 0
    " The current line is still folded
    let idx  = (fold_{edge} - a:currentline) * inc
    let line = fold_{edge}     " line number of the destination
  else
    let idx  = 0
    let line = a:currentline  " line number of the destination
  endif
  let displ = 0  " displacement from current line to the destination
  let c     = ((col <= len(lines[0])) && (fold_{edge} < 0)) ? lines[idx][col-1] : ''
  let is_empty_cur = (c == '') ? 1 : 0

  let output = [-1, [], opened_fold]
  while l:count > 0
    let idx  += 1
    if idx > threshold
      return output
    endif
    let line  += inc
    let displ += 1

    if a:level != 0
      " fold opening
      let opened_fold += s:fold_opener(line, a:currentline, a:level)
    endif

    let fold_start = foldclosed(line)
    let fold_end   = foldclosedend(line)

    let foldedblock = 0
    if (fold_{edge} >= 0) && (a:opt_fold_treatment == 0)
      " skip folded lines
      while 1
        let idx += (fold_{edge} - line) * inc + 1
        let line = fold_{edge} + inc  " line number of the destination

        if a:kind ==# 'e'
          if (line > endline) | return [-1, [], opened_fold] | endif
        elseif a:kind ==# 'b'
          if (line < 1) | return [-1, [], opened_fold] | endif
        endif

        if a:level != 0
          " fold opening
          let opened_fold += s:fold_opener(line, a:currentline, a:level)
        endif

        let fold_start = foldclosed(line)
        let fold_end   = foldclosedend(line)

        let foldedblock += 1

        if (fold_{edge} < 0) | let displ += foldedblock | break | endif
      endwhile
    endif

    let is_empty_pre = is_empty_cur

    let c = ((col <= len(lines[idx])) && (fold_{edge} < 0)) ? lines[idx][col-1] : ''

    let is_empty_cur = (c == '') ? 1 : 0

    if fold_{edge} >= 0
      " The current line is folded
      if !is_empty_pre && displ > 1
        let l:count -= 1
        let output   = [displ - 1, [line - inc, col], opened_fold]

        if l:count <= 0 | break | endif
      endif

      let idx  += (fold_{edge} - line) * inc
      let line  = fold_{edge}
    elseif (is_empty_cur && !is_empty_pre)
      " The current line is empty and the previous line is not empty
      if displ - foldedblock > 1
        let l:count -= 1
        let output = [displ - 1 - foldedblock, [line - inc, col], opened_fold]
      endif
    endif
  endwhile

  return output
endfunction
"}}}

" vim:set foldcolumn=2:
" vim:set foldmethod=marker:
" vim:set commentstring="%s:
