let s:save_cpo = &cpo
set cpo&vim

function! columnmove#utility#map(mode, kind, lhs, ...) abort
  let kind = a:kind ==# ';' ? 'semicolon'
         \ : a:kind ==# ',' ? 'comma'
         \ : a:kind

  if a:kind =~# '[fFtT;,]'
    let target  = get(a:000, 1, '')
    let l:count = get(a:000, 2, 0)
    let options_dict = get(a:000, 3, {})

    for c in ['i', 'n', 'x']
      if stridx(a:mode, c) >= 0
        execute printf('%snoremap <silent><expr> %s columnmove#%s("%s", "", ''%s'', %d, %s)'
              \ , c, a:lhs, kind, c, target, l:count,
              \   type(options_dict) == type('') ? options_dict
              \ : type(options_dict) == type({}) ? string(options_dict)
              \ : '{}')
      endif
    endfor

    if stridx(a:mode, 'o') >= 0
      let v = s:get_v(a:000)

      if v != []
        let o_v = ['', 'v', 'V', '<C-v>']
        for i in range(4)
          execute printf('onoremap <silent><expr> %s%s columnmove#%s("o", "%s", ''%s'', %d, %s)',
                \ o_v[i], a:lhs, kind, v[i], target, l:count,
                \   type(options_dict) == type('') ? options_dict
                \ : type(options_dict) == type({}) ? string(options_dict)
                \ : '{}')
        endfor
      endif
    endif
  elseif a:kind =~? '[wbe]' || a:kind =~# 'g[eE]'
    let l:count = get(a:000, 1, 0)
    let options_dict = get(a:000, 2, {})

    for [c, cmd] in [['i', '<C-r>='], ['n', ':<C-u>call '], ['x', ':<C-u>call ']]
      if stridx(a:mode, c) >= 0
        execute printf('%snoremap <silent> %s %scolumnmove#%s("%s", "", %d, %s)<CR>',
              \ c, a:lhs, cmd, kind, c, l:count,
              \   type(options_dict) == type('') ? options_dict
              \ : type(options_dict) == type({}) ? string(options_dict)
              \ : '{}')
      endif
    endfor

    if stridx(a:mode, 'o') >= 0
      let v = s:get_v(a:000)

      if v != []
        let o_v = ['', 'v', 'V', '<C-v>']
        for i in range(4)
          execute printf('onoremap <silent> %s%s :<C-u>call columnmove#%s("o", "%s", %s, %s)<CR>',
                \ o_v[i], a:lhs, kind, v[i], l:count,
                \   type(options_dict) == type('') ? options_dict
                \ : type(options_dict) == type({}) ? string(options_dict)
                \ : '{}')
        endfor
      endif
    endif
  endif
endfunction

function! s:get_v(arg) abort
  " set linewise as default
  let motionwise = get(a:arg, 0, 'V')

  if motionwise ==# ''
    let v = ['', 'v', 'V', '<Bslash><lt>C-v>']
  elseif motionwise ==# 'v' || motionwise ==# 'char'
    let v = ['v', '', 'V', '<Bslash><lt>C-v>']
  elseif motionwise ==# 'V' || motionwise ==# 'line'
    let v = ['V', '', 'V', '<Bslash><lt>C-v>']
  elseif motionwise ==# "\<C-v>" || motionwise ==# 'block'
    let v = ['<Bslash><lt>C-v>', '', 'V', '<Bslash><lt>C-v>']
  else
    let v = []
  endif

  return v
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo
