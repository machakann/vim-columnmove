" vim:set foldmethod=marker:
" vim:set commentstring="%s:
" Last Change: 23-Jul-2014.

" なぜnormal!ではなくマクロを使ったのかというとそっちの方がちらちらして好きだ
" からです！
"
" バグ多過ぎやばい
"
" TODO: searchが失敗した場合に警告できるようにしてくれ
" TODO: test_infoにon/off用のプロパティを追加
" TODO: デバッグ用にもログ吐く場所があるといいなあって
" TODO: s:minimum_header_widthが小さい場合開いたり閉じたり（スライド）なUI
" TODO: 成功条件が「等しい」だけじゃちょっと。。。
" TODO: コメント普及させようね
" TODO: result取得が融通きかない
" TODO: 部分的にabort
" TODO: なぜ辞書なんだ…なぜリストにしなかった…

" Test information"{{{
" Test 1
let test_info         = {}

let test_info.general = {
    \   'test_script'           : 'test_field',
    \   'commentstring'         : '^\s*" ',
    \   'caption_test'          : 'Test',
    \   'caption_result'        : 'Result',
    \   'caption_expectation'   : 'Expectation',
    \   'minimum_caption_width' : 20,
    \   'split_command'         : 'vert new'
    \   }

let test_info.pre     = {
    \   'text'     : '*** The result ***',
    \   'commands' : [],
    \   'breaking' : 0
    \   }

let test_info.1       = {
    \   "pre"  : {'breaking' : 5, 'commands' : ['unlet! g:columnmove_fold_open']},
    \   "1"    : {'caption'     : 'line head',
    \             'result'      : 'getline(".")[col(".")]',
    \             'expectation' : '6',
    \             'key_input'   : "\<M-f>f",
    \             'breaking'    : 5,
    \             'abort'       : 0,
    \             'pre' : {}, 'post' : {}
    \             },
    \
    \   "2"    : {'caption'     : 'inside a line',
    \             'result'      : 'getline(".")[col(".")-2]',
    \             'expectation' : '6',
    \             'key_input'   : "l\<M-f>f",
    \             'breaking'    : 5,
    \             'abort'       : 0,
    \             'pre' : {}, 'post' : {}
    \             },
    \
    \   "3"    : {'caption'     : 'line end',
    \             'result'      : 'getline(".")[col(".")-2]',
    \             'expectation' : '6',
    \             'key_input'   : "l\<M-f>f",
    \             'breaking'    : 5,
    \             'abort'       : 0,
    \             'pre' : {}, 'post' : {}
    \             },
    \
    \   "4"    : {'caption'     : 'skip fold',
    \             'result'      : 'getline(".")[col(".")-2]',
    \             'expectation' : '7',
    \             'key_input'   : "jl\<M-f>f",
    \             'breaking'    : 7,
    \             'abort'       : 0,
    \             'pre' : {'commands' : [':let g:columnmove_fold_open = 0']}, 'post' : {}
    \             },
    \
    \   "5"    : {'caption'     : 'open fold',
    \             'result'      : 'getline(".")[col(".")-2]',
    \             'expectation' : '4',
    \             'key_input'   : "jl\<M-f>f",
    \             'breaking'    : 7,
    \             'abort'       : 0,
    \             'pre' : {'commands' : [':let g:columnmove_fold_open = 1']}, 'post' : {}
    \             },
    \
    \   "6"    : {'caption'     : 'open fold (beyond a fold)',
    \             'result'      : 'getline(".")[col(".")-2]',
    \             'expectation' : '7',
    \             'key_input'   : "jl\<M-f>f",
    \             'breaking'    : 6,
    \             'abort'       : 0,
    \             'pre' : {'commands' : [':let g:columnmove_fold_open = 1']}, 'post' : {}
    \             },
    \
    \   "7"    : {'caption'     : 'open fold (deep fold)',
    \             'result'      : 'getline(".")[col(".")-2]',
    \             'expectation' : '7',
    \             'key_input'   : "jl\<M-f>f",
    \             'breaking'    : 6,
    \             'abort'       : 0,
    \             'pre' : {'commands' : [':let g:columnmove_fold_open = 1']}, 'post' : {}
    \             },
    \
    \   "8"    : {'caption'     : 'open fold (deep fold)',
    \             'result'      : 'getline(".")[col(".")-2]',
    \             'expectation' : '4',
    \             'key_input'   : "jl\<M-f>f",
    \             'breaking'    : 7,
    \             'abort'       : 0,
    \             'pre' : {'commands' : [':let g:columnmove_fold_open = 2']}, 'post' : {}
    \             },
    \
    \   "9"    : {'caption'     : 'open fold (relatively)',
    \             'result'      : 'getline(".")[col(".")-2]',
    \             'expectation' : '5',
    \             'key_input'   : "jzol\<M-f>f",
    \             'breaking'    : 8,
    \             'abort'       : 0,
    \             'pre' : {'commands' : [':let g:columnmove_fold_open = -1']}, 'post' : {}
    \             },
    \
    \   "10"   : {'caption'     : 'open fold (relatively)',
    \             'result'      : 'getline(".")[col(".")-2]',
    \             'expectation' : '4',
    \             'key_input'   : "jzol\<M-f>f",
    \             'breaking'    : 9,
    \             'abort'       : 0,
    \             'pre' : {'commands' : [':let g:columnmove_fold_open = -2']}, 'post' : {}
    \             },
    \
    \   "11"   : {'caption'     : 'expand range',
    \             'result'      : 'getline(".")[col(".")-2]',
    \             'expectation' : '$',
    \             'key_input'   : "jl\<M-f>t",
    \             'breaking'    : 6,
    \             'abort'       : 0,
    \             'pre' : {'commands' : [':let g:columnmove_expand_range=-1']}, 'post' : {}
    \             },
    \
    \   "12"   : {'caption'     : 'expand range',
    \             'result'      : 'getline(".")[col(".")-2]',
    \             'expectation' : '4',
    \             'key_input'   : ":26,31yank\<CR>:3new scratch\<CR>Pl\<M-f>d",
    \             'breaking'    : 1,
    \             'abort'       : 0,
    \             'pre' : {'commands' : [':let g:columnmove_expand_range=1', 'set scrolloff=0']}, 'post' : {'commands' : ["q", 'bw! scratch']}
    \             },
    \
    \   "13"   : {'caption'     : 'expand range',
    \             'result'      : 'getline(".")[col(".")-2]',
    \             'expectation' : '1',
    \             'key_input'   : ":26,31yank\<CR>:3new scratch\<CR>Pl\<M-f>e",
    \             'breaking'    : 1,
    \             'abort'       : 0,
    \             'pre' : {'commands' : [':let g:columnmove_expand_range=1', 'set scrolloff=0']}, 'post' : {'commands' : ["q", 'bw! scratch']}
    \             },
    \
    \   "14"   : {'caption'     : 'expand range',
    \             'result'      : 'getline(".")[col(".")-2]',
    \             'expectation' : '5',
    \             'key_input'   : ":26,31yank\<CR>:3new scratch\<CR>Pl\<M-f>e",
    \             'breaking'    : 1,
    \             'abort'       : 0,
    \             'pre' : {'commands' : [':let g:columnmove_expand_range=2', 'set scrolloff=0']}, 'post' : {'commands' : ["q", 'bw! scratch']}
    \             },
    \
    \   "15"   : {'caption'     : 'count',
    \             'result'      : 'getline(".")[col(".")-2]',
    \             'expectation' : '8',
    \             'key_input'   : "l2\<M-f>b",
    \             'breaking'    : 7,
    \             'abort'       : 0,
    \             'pre' : {}, 'post' : {}
    \             },
    \
    \   "16"   : {'caption'     : 'preserved column position at line end',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : 'k',
    \             'key_input'   : "$j\<M-f>k",
    \             'breaking'    : 3,
    \             'abort'       : 0,
    \             'pre' : {}, 'post' : {}
    \             },
    \
    \   "17"   : {'caption'     : 'multi-width character',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : 'o',
    \             'key_input'   : "fa\<M-f>o",
    \             'breaking'    : 2,
    \             'abort'       : 0,
    \             'pre' : {'commands': ['setl tw=4']}, 'post' : {}
    \             },
    \
    \   "18"   : {'caption'     : 'multi-width character',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : 'o',
    \             'key_input'   : "fe\<M-f>o",
    \             'breaking'    : 2,
    \             'abort'       : 0,
    \             'pre' : {'commands': ['setl tw=4']}, 'post' : {}
    \             },
    \
    \   "post" : {'breaking' : 1},
    \   }

let test_info.2       = {
    \   "pre"  : {'breaking' : 1 , 'commands' : [':let g:columnmove_fold_open=0', ':let g:columnmove_expand_range=0']},
    \   "1"    : {'caption'     : 'line head',
    \             'result'      : 'getline(".")[col(".")]',
    \             'expectation' : '5',
    \             'key_input'   : "\<M-t>f",
    \             'breaking'    : 5,
    \             'abort'       : 0,
    \             'pre' : {}, 'post' : {}
    \             },
    \
    \   "2"    : {'caption'     : 'inside a line',
    \             'result'      : 'getline(".")[col(".")-2]',
    \             'expectation' : '5',
    \             'key_input'   : "l\<M-t>f",
    \             'breaking'    : 5,
    \             'abort'       : 0,
    \             'pre' : {}, 'post' : {}
    \             },
    \
    \   "3"    : {'caption'     : 'line end',
    \             'result'      : 'getline(".")[col(".")-2]',
    \             'expectation' : '5',
    \             'key_input'   : "l\<M-t>f",
    \             'breaking'    : 5,
    \             'abort'       : 0,
    \             'pre' : {}, 'post' : {}
    \             },
    \
    \   "4"    : {'caption'     : 'skip fold',
    \             'result'      : 'getline(".")[col(".")-2]',
    \             'expectation' : '6',
    \             'key_input'   : "jl\<M-t>f",
    \             'breaking'    : 7,
    \             'abort'       : 0,
    \             'pre' : {'commands' : [':let g:columnmove_fold_open = 0']}, 'post' : {}
    \             },
    \
    \   "5"    : {'caption'     : 'open fold',
    \             'result'      : 'getline(".")[col(".")-2]',
    \             'expectation' : '3',
    \             'key_input'   : "jl\<M-t>f",
    \             'breaking'    : 7,
    \             'abort'       : 0,
    \             'pre' : {'commands' : [':let g:columnmove_fold_open = 1']}, 'post' : {}
    \             },
    \
    \   "6"    : {'caption'     : 'open fold (beyond a fold)',
    \             'result'      : 'getline(".")[col(".")-2]',
    \             'expectation' : '7',
    \             'key_input'   : "jl\<M-t>g",
    \             'breaking'    : 7,
    \             'abort'       : 0,
    \             'pre' : {'commands' : [':let g:columnmove_fold_open = 1']}, 'post' : {}
    \             },
    \
    \   "7"    : {'caption'     : 'open fold (deep fold)',
    \             'result'      : 'getline(".")[col(".")-2]',
    \             'expectation' : '6',
    \             'key_input'   : "jl\<M-t>f",
    \             'breaking'    : 7,
    \             'abort'       : 0,
    \             'pre' : {'commands' : [':let g:columnmove_fold_open = 1']}, 'post' : {}
    \             },
    \
    \   "8"    : {'caption'     : 'open fold (deep fold)',
    \             'result'      : 'getline(".")[col(".")-2]',
    \             'expectation' : '3',
    \             'key_input'   : "jl\<M-t>f",
    \             'breaking'    : 7,
    \             'abort'       : 0,
    \             'pre' : {'commands' : [':let g:columnmove_fold_open = 2']}, 'post' : {}
    \             },
    \
    \   "9"    : {'caption'     : 'open fold (relatively)',
    \             'result'      : 'getline(".")[col(".")-2]',
    \             'expectation' : '5',
    \             'key_input'   : "jzol\<M-t>f",
    \             'breaking'    : 8,
    \             'abort'       : 0,
    \             'pre' : {'commands' : [':let g:columnmove_fold_open = -1']}, 'post' : {}
    \             },
    \
    \   "10"   : {'caption'     : 'open fold (relatively)',
    \             'result'      : 'getline(".")[col(".")-2]',
    \             'expectation' : '3',
    \             'key_input'   : "jzol\<M-t>f",
    \             'breaking'    : 8,
    \             'abort'       : 0,
    \             'pre' : {'commands' : [':let g:columnmove_fold_open = -2']}, 'post' : {}
    \             },
    \
    \   "11"   : {'caption'     : 'expand range',
    \             'result'      : 'getline(".")[col(".")-2]',
    \             'expectation' : '#',
    \             'key_input'   : "jl\<M-t>t",
    \             'breaking'    : 6,
    \             'abort'       : 0,
    \             'pre' : {'commands' : [':let g:columnmove_expand_range=-1']}, 'post' : {}
    \             },
    \
    \   "12"   : {'caption'     : 'expand range',
    \             'result'      : 'getline(".")[col(".")-2]',
    \             'expectation' : '3',
    \             'key_input'   : ":26,31yank\<CR>:3new scratch\<CR>Pl\<M-t>d",
    \             'breaking'    : 1,
    \             'abort'       : 0,
    \             'pre' : {'commands' : [':let g:columnmove_expand_range=1', 'set scrolloff=0']}, 'post' : {'commands' : ["q", 'bw! scratch']}
    \             },
    \
    \   "13"   : {'caption'     : 'expand range',
    \             'result'      : 'getline(".")[col(".")-2]',
    \             'expectation' : '1',
    \             'key_input'   : ":26,31yank\<CR>:3new scratch\<CR>Pl\<M-t>e",
    \             'breaking'    : 1,
    \             'abort'       : 0,
    \             'pre' : {'commands' : [':let g:columnmove_expand_range=1', 'set scrolloff=0']}, 'post' : {'commands' : ["q", 'bw! scratch']}
    \             },
    \
    \   "14"   : {'caption'     : 'expand range',
    \             'result'      : 'getline(".")[col(".")-2]',
    \             'expectation' : '4',
    \             'key_input'   : ":26,31yank\<CR>:3new scratch\<CR>Pl\<M-t>e",
    \             'breaking'    : 1,
    \             'abort'       : 0,
    \             'pre' : {'commands' : [':let g:columnmove_expand_range=2', 'set scrolloff=0']}, 'post' : {'commands' : ["q", 'bw! scratch']}
    \             },
    \
    \   "15"   : {'caption'     : 'count',
    \             'result'      : 'getline(".")[col(".")-2]',
    \             'expectation' : '8',
    \             'key_input'   : "l2\<M-t>c",
    \             'breaking'    : 8,
    \             'abort'       : 0,
    \             'pre' : {}, 'post' : {}
    \             },
    \
    \   "16"   : {'caption'     : 'preserved column position at line end',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : 'k',
    \             'key_input'   : "$j\<M-t>p",
    \             'breaking'    : 4,
    \             'abort'       : 0,
    \             'pre' : {}, 'post' : {}
    \             },
    \
    \   "17"   : {'caption'     : 'preserved column position at line end',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : 'k',
    \             'key_input'   : "$j\<M-t>kj",
    \             'breaking'    : 3,
    \             'abort'       : 0,
    \             'pre' : {}, 'post' : {}
    \             },
    \
    \   "post" : {'breaking' : 1},
    \   }

let test_info.3       = {
    \   "pre"  : {'breaking' : 1 , 'commands' : [':let g:columnmove_fold_open=0', ':let g:columnmove_expand_range=0']},
    \   "1"    : {'caption'     : 'line head',
    \             'result'      : 'getline(".")[col(".")]',
    \             'expectation' : '1',
    \             'key_input'   : "5j\<M-F>a",
    \             'breaking'    : 5,
    \             'abort'       : 0,
    \             'pre' : {}, 'post' : {}
    \             },
    \
    \   "2"    : {'caption'     : 'inside a line',
    \             'result'      : 'getline(".")[col(".")-2]',
    \             'expectation' : '1',
    \             'key_input'   : "5jl\<M-F>a",
    \             'breaking'    : 5,
    \             'abort'       : 0,
    \             'pre' : {}, 'post' : {}
    \             },
    \
    \   "3"    : {'caption'     : 'line end',
    \             'result'      : 'getline(".")[col(".")-2]',
    \             'expectation' : '1',
    \             'key_input'   : "5jl\<M-F>a",
    \             'breaking'    : 5,
    \             'abort'       : 0,
    \             'pre' : {}, 'post' : {}
    \             },
    \
    \   "4"    : {'caption'     : 'skip fold',
    \             'result'      : 'getline(".")[col(".")-2]',
    \             'expectation' : '1',
    \             'key_input'   : "5jl\<M-F>a",
    \             'breaking'    : 7,
    \             'abort'       : 0,
    \             'pre' : {'commands' : [':let g:columnmove_fold_open = 0']}, 'post' : {}
    \             },
    \
    \   "5"    : {'caption'     : 'open fold',
    \             'result'      : 'getline(".")[col(".")-2]',
    \             'expectation' : '4',
    \             'key_input'   : "5jl\<M-F>a",
    \             'breaking'    : 7,
    \             'abort'       : 0,
    \             'pre' : {'commands' : [':let g:columnmove_fold_open = 1']}, 'post' : {}
    \             },
    \
    \   "6"    : {'caption'     : 'open fold (beyond a fold)',
    \             'result'      : 'getline(".")[col(".")-2]',
    \             'expectation' : '1',
    \             'key_input'   : "3jl\<M-F>a",
    \             'breaking'    : 6,
    \             'abort'       : 0,
    \             'pre' : {'commands' : [':let g:columnmove_fold_open = 1']}, 'post' : {}
    \             },
    \
    \   "7"    : {'caption'     : 'open fold (deep fold)',
    \             'result'      : 'getline(".")[col(".")-2]',
    \             'expectation' : '1',
    \             'key_input'   : "2jl\<M-F>a",
    \             'breaking'    : 7,
    \             'abort'       : 0,
    \             'pre' : {'commands' : [':let g:columnmove_fold_open = 1']}, 'post' : {}
    \             },
    \
    \   "8"    : {'caption'     : 'open fold (deep fold)',
    \             'result'      : 'getline(".")[col(".")-2]',
    \             'expectation' : '4',
    \             'key_input'   : "2jl\<M-F>a",
    \             'breaking'    : 7,
    \             'abort'       : 0,
    \             'pre' : {'commands' : [':let g:columnmove_fold_open = 2']}, 'post' : {}
    \             },
    \
    \   "9"    : {'caption'     : 'open fold (relatively)',
    \             'result'      : 'getline(".")[col(".")-2]',
    \             'expectation' : '4',
    \             'key_input'   : "jzo3jl\<M-F>a",
    \             'breaking'    : 8,
    \             'abort'       : 0,
    \             'pre' : {'commands' : [':let g:columnmove_fold_open = -1']}, 'post' : {}
    \             },
    \
    \   "10"   : {'caption'     : 'open fold (relatively)',
    \             'result'      : 'getline(".")[col(".")-2]',
    \             'expectation' : '5',
    \             'key_input'   : "jzo3jl\<M-F>a",
    \             'breaking'    : 8,
    \             'abort'       : 0,
    \             'pre' : {'commands' : [':let g:columnmove_fold_open = -2']}, 'post' : {}
    \             },
    \
    \   "11"   : {'caption'     : 'expand range',
    \             'result'      : 'getline(".")[col(".")-2]',
    \             'expectation' : '0',
    \             'key_input'   : "6jl\<M-F>t",
    \             'breaking'    : 6,
    \             'abort'       : 0,
    \             'pre' : {'commands' : [':let g:columnmove_expand_range=-1']}, 'post' : {}
    \             },
    \
    \   "12"   : {'caption'     : 'expand range',
    \             'result'      : 'getline(".")[col(".")-2]',
    \             'expectation' : '4',
    \             'key_input'   : ":26,31yank\<CR>:3new scratch\<CR>PGkl\<M-F>d",
    \             'breaking'    : 1,
    \             'abort'       : 0,
    \             'pre' : {'commands' : [':let g:columnmove_expand_range=1', 'set scrolloff=0']}, 'post' : {'commands' : ["q", 'bw! scratch']}
    \             },
    \
    \   "13"   : {'caption'     : 'expand range',
    \             'result'      : 'getline(".")[col(".")-2]',
    \             'expectation' : '6',
    \             'key_input'   : ":26,31yank\<CR>:3new scratch\<CR>PGkl\<M-F>c",
    \             'breaking'    : 1,
    \             'abort'       : 0,
    \             'pre' : {'commands' : [':let g:columnmove_expand_range=1', 'set scrolloff=0']}, 'post' : {'commands' : ["q", 'bw! scratch']}
    \             },
    \
    \   "14"   : {'caption'     : 'expand range',
    \             'result'      : 'getline(".")[col(".")-2]',
    \             'expectation' : '3',
    \             'key_input'   : ":26,31yank\<CR>:3new scratch\<CR>PGkl\<M-F>c",
    \             'breaking'    : 1,
    \             'abort'       : 0,
    \             'pre' : {'commands' : [':let g:columnmove_expand_range=2', 'set scrolloff=0']}, 'post' : {'commands' : ["q", 'bw! scratch']}
    \             },
    \
    \   "15"   : {'caption'     : 'count',
    \             'result'      : 'getline(".")[col(".")-2]',
    \             'expectation' : '1',
    \             'key_input'   : "7jl2\<M-F>a",
    \             'breaking'    : 7,
    \             'abort'       : 0,
    \             'pre' : {}, 'post' : {}
    \             },
    \
    \   "16"   : {'caption'     : 'preserved column position at line end',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : 'c',
    \             'key_input'   : "3j$k\<M-F>c",
    \             'breaking'    : 3,
    \             'abort'       : 0,
    \             'pre' : {}, 'post' : {}
    \             },
    \
    \   "post" : {'breaking' : 1},
    \   }

let test_info.4       = {
    \   "pre"  : {'breaking' : 1 , 'commands' : [':let g:columnmove_fold_open=0', ':let g:columnmove_expand_range=0']},
    \   "1"    : {'caption'     : 'line head',
    \             'result'      : 'getline(".")[col(".")]',
    \             'expectation' : '2',
    \             'key_input'   : "5j\<M-T>a",
    \             'breaking'    : 5,
    \             'abort'       : 0,
    \             'pre' : {}, 'post' : {}
    \             },
    \
    \   "2"    : {'caption'     : 'inside a line',
    \             'result'      : 'getline(".")[col(".")-2]',
    \             'expectation' : '2',
    \             'key_input'   : "5jl\<M-T>a",
    \             'breaking'    : 5,
    \             'abort'       : 0,
    \             'pre' : {}, 'post' : {}
    \             },
    \
    \   "3"    : {'caption'     : 'line end',
    \             'result'      : 'getline(".")[col(".")-2]',
    \             'expectation' : '2',
    \             'key_input'   : "5jl\<M-T>a",
    \             'breaking'    : 5,
    \             'abort'       : 0,
    \             'pre' : {}, 'post' : {}
    \             },
    \
    \   "4"    : {'caption'     : 'skip fold',
    \             'result'      : 'getline(".")[col(".")-2]',
    \             'expectation' : '2',
    \             'key_input'   : "5jl\<M-T>a",
    \             'breaking'    : 7,
    \             'abort'       : 0,
    \             'pre' : {'commands' : [':let g:columnmove_fold_open = 0']}, 'post' : {}
    \             },
    \
    \   "5"    : {'caption'     : 'open fold',
    \             'result'      : 'getline(".")[col(".")-2]',
    \             'expectation' : '5',
    \             'key_input'   : "5jl\<M-T>a",
    \             'breaking'    : 7,
    \             'abort'       : 0,
    \             'pre' : {'commands' : [':let g:columnmove_fold_open = 1']}, 'post' : {}
    \             },
    \
    \   "6"    : {'caption'     : 'open fold (beyond a fold)',
    \             'result'      : 'getline(".")[col(".")-2]',
    \             'expectation' : '2',
    \             'key_input'   : "3jl\<M-T>a",
    \             'breaking'    : 6,
    \             'abort'       : 0,
    \             'pre' : {'commands' : [':let g:columnmove_fold_open = 1']}, 'post' : {}
    \             },
    \
    \   "7"    : {'caption'     : 'open fold (deep fold)',
    \             'result'      : 'getline(".")[col(".")-2]',
    \             'expectation' : '2',
    \             'key_input'   : "2jl\<M-T>a",
    \             'breaking'    : 7,
    \             'abort'       : 0,
    \             'pre' : {'commands' : [':let g:columnmove_fold_open = 1']}, 'post' : {}
    \             },
    \
    \   "8"    : {'caption'     : 'open fold (deep fold)',
    \             'result'      : 'getline(".")[col(".")-2]',
    \             'expectation' : '5',
    \             'key_input'   : "2jl\<M-T>a",
    \             'breaking'    : 7,
    \             'abort'       : 0,
    \             'pre' : {'commands' : [':let g:columnmove_fold_open = 2']}, 'post' : {}
    \             },
    \
    \   "9"    : {'caption'     : 'open fold (relatively)',
    \             'result'      : 'getline(".")[col(".")-2]',
    \             'expectation' : '5',
    \             'key_input'   : "jzo3jl\<M-T>a",
    \             'breaking'    : 8,
    \             'abort'       : 0,
    \             'pre' : {'commands' : [':let g:columnmove_fold_open = -1']}, 'post' : {}
    \             },
    \
    \   "10"   : {'caption'     : 'open fold (relatively)',
    \             'result'      : 'getline(".")[col(".")-2]',
    \             'expectation' : '6',
    \             'key_input'   : "jzo3jl\<M-T>a",
    \             'breaking'    : 8,
    \             'abort'       : 0,
    \             'pre' : {'commands' : [':let g:columnmove_fold_open = -2']}, 'post' : {}
    \             },
    \
    \   "11"   : {'caption'     : 'expand range',
    \             'result'      : 'getline(".")[col(".")-2]',
    \             'expectation' : '#',
    \             'key_input'   : "6jl\<M-T>t",
    \             'breaking'    : 6,
    \             'abort'       : 0,
    \             'pre' : {'commands' : [':let g:columnmove_expand_range=-1']}, 'post' : {}
    \             },
    \
    \   "12"   : {'caption'     : 'expand range',
    \             'result'      : 'getline(".")[col(".")-2]',
    \             'expectation' : '5',
    \             'key_input'   : ":26,31yank\<CR>:3new scratch\<CR>PGkl\<M-T>d",
    \             'breaking'    : 1,
    \             'abort'       : 0,
    \             'pre' : {'commands' : [':let g:columnmove_expand_range=1', 'set scrolloff=0']}, 'post' : {'commands' : ["q", 'bw! scratch']}
    \             },
    \
    \   "13"   : {'caption'     : 'expand range',
    \             'result'      : 'getline(".")[col(".")-2]',
    \             'expectation' : '6',
    \             'key_input'   : ":26,31yank\<CR>:3new scratch\<CR>PGkl\<M-T>c",
    \             'breaking'    : 1,
    \             'abort'       : 0,
    \             'pre' : {'commands' : [':let g:columnmove_expand_range=1', 'set scrolloff=0']}, 'post' : {'commands' : ["q", 'bw! scratch']}
    \             },
    \
    \   "14"   : {'caption'     : 'expand range',
    \             'result'      : 'getline(".")[col(".")-2]',
    \             'expectation' : '4',
    \             'key_input'   : ":26,31yank\<CR>:3new scratch\<CR>PGkl\<M-T>c",
    \             'breaking'    : 1,
    \             'abort'       : 0,
    \             'pre' : {'commands' : [':let g:columnmove_expand_range=2', 'set scrolloff=0']}, 'post' : {'commands' : ["q", 'bw! scratch']}
    \             },
    \
    \   "15"   : {'caption'     : 'count',
    \             'result'      : 'getline(".")[col(".")-2]',
    \             'expectation' : '2',
    \             'key_input'   : "8jl2\<M-T>a",
    \             'breaking'    : 8,
    \             'abort'       : 0,
    \             'pre' : {}, 'post' : {}
    \             },
    \
    \   "16"   : {'caption'     : 'preserved column position at line end',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : 'f',
    \             'key_input'   : "4j$k\<M-T>c",
    \             'breaking'    : 4,
    \             'abort'       : 0,
    \             'pre' : {}, 'post' : {}
    \             },
    \
    \   "17"   : {'caption'     : 'preserved column position at line end',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : 'c',
    \             'key_input'   : "3j$k\<M-T>ck",
    \             'breaking'    : 3,
    \             'abort'       : 0,
    \             'pre' : {}, 'post' : {}
    \             },
    \
    \   "post" : {'breaking' : 1},
    \   }

let test_info.5       = {
    \   "pre"  : {'breaking' : 1 , 'commands' : [':let g:columnmove_fold_open=0', ':let g:columnmove_expand_range=0']},
    \   "1"    : {'caption'     : 'After the columnmove-f',
    \             'result'      : 'getline(".")[col(".")-2]',
    \             'expectation' : '9',
    \             'key_input'   : "l5j\<M-f>a4k\<M-;>",
    \             'breaking'    : 8,
    \             'abort'       : 0,
    \             'pre' : {}, 'post' : {}
    \             },
    \
    \   "2"    : {'caption'     : 'After the columnmove-t',
    \             'result'      : 'getline(".")[col(".")-2]',
    \             'expectation' : '8',
    \             'key_input'   : "l5j\<M-t>a3k\<M-;>",
    \             'breaking'    : 8,
    \             'abort'       : 0,
    \             'pre' : {}, 'post' : {}
    \             },
    \
    \   "3"    : {'caption'     : 'After the columnmove-F',
    \             'result'      : 'getline(".")[col(".")-2]',
    \             'expectation' : '1',
    \             'key_input'   : "l5j\<M-F>a4j\<M-;>",
    \             'breaking'    : 8,
    \             'abort'       : 0,
    \             'pre' : {}, 'post' : {}
    \             },
    \
    \   "4"    : {'caption'     : 'After the columnmove-T',
    \             'result'      : 'getline(".")[col(".")-2]',
    \             'expectation' : '2',
    \             'key_input'   : "l5j\<M-T>a3j\<M-;>",
    \             'breaking'    : 7,
    \             'abort'       : 0,
    \             'pre' : {}, 'post' : {}
    \             },
    \
    \   "post" : {'breaking' : 0},
    \   }

let test_info.6       = {
    \   "pre"  : {'breaking' : 2 },
    \   "1"    : {'caption'     : 'After the columnmove-f',
    \             'result'      : 'getline(".")[col(".")-2]',
    \             'expectation' : '1',
    \             'key_input'   : "l5j\<M-f>a4k\<M-,>",
    \             'breaking'    : 8,
    \             'abort'       : 0,
    \             'pre' : {}, 'post' : {}
    \             },
    \
    \   "2"    : {'caption'     : 'After the columnmove-t',
    \             'result'      : 'getline(".")[col(".")-2]',
    \             'expectation' : '2',
    \             'key_input'   : "l5j\<M-t>a3k\<M-,>",
    \             'breaking'    : 8,
    \             'abort'       : 0,
    \             'pre' : {}, 'post' : {}
    \             },
    \
    \   "3"    : {'caption'     : 'After the columnmove-F',
    \             'result'      : 'getline(".")[col(".")-2]',
    \             'expectation' : '9',
    \             'key_input'   : "l5j\<M-F>a4j\<M-,>",
    \             'breaking'    : 8,
    \             'abort'       : 0,
    \             'pre' : {}, 'post' : {}
    \             },
    \
    \   "4"    : {'caption'     : 'After the columnmove-T',
    \             'result'      : 'getline(".")[col(".")-2]',
    \             'expectation' : '8',
    \             'key_input'   : "l5j\<M-T>a3j\<M-,>",
    \             'breaking'    : 7,
    \             'abort'       : 0,
    \             'pre' : {}, 'post' : {}
    \             },
    \
    \   "post" : {'breaking' : 1},
    \   }

let test_info.7       = {
    \   "pre"  : {'breaking' : 1 , 'commands' : [':let g:columnmove_fold_open=0', ':let g:columnmove_expand_range=0', ':let g:columnmove_fold_treatment=0']},
    \   "1"    : {'caption'     : 'iskeyword, space',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : 'd',
    \             'key_input'   : "\<M-w>",
    \             'breaking'    : 5,
    \             'abort'       : 0,
    \             'pre' : {'commands' : 'let g:columnmove_strict_wbege=1'}, 'post' : {}
    \             },
    \
    \   "2"    : {'caption'     : 'iskeyword, not-iskeyword',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : ';',
    \             'key_input'   : "\<M-w>",
    \             'breaking'    : 5,
    \             'abort'       : 0,
    \             'pre' : {'commands' : 'let g:columnmove_strict_wbege=1'}, 'post' : {}
    \             },
    \
    \   "3"    : {'caption'     : 'iskeyword, empty',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : 'd',
    \             'key_input'   : "\<M-w>",
    \             'breaking'    : 5,
    \             'abort'       : 0,
    \             'pre' : {'commands' : 'let g:columnmove_strict_wbege=1'}, 'post' : {}
    \             },
    \
    \   "4"    : {'caption'     : 'not-iskeyword, space',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : '/',
    \             'key_input'   : "\<M-w>",
    \             'breaking'    : 5,
    \             'abort'       : 0,
    \             'pre' : {'commands' : 'let g:columnmove_strict_wbege=1'}, 'post' : {}
    \             },
    \
    \   "5"    : {'caption'     : 'not-iskeyword, iskeyword',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : 'a',
    \             'key_input'   : "\<M-w>",
    \             'breaking'    : 5,
    \             'abort'       : 0,
    \             'pre' : {'commands' : 'let g:columnmove_strict_wbege=1'}, 'post' : {}
    \             },
    \
    \   "6"    : {'caption'     : 'not-iskeyword, empty',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : '/',
    \             'key_input'   : "\<M-w>",
    \             'breaking'    : 5,
    \             'abort'       : 0,
    \             'pre' : {'commands' : 'let g:columnmove_strict_wbege=1'}, 'post' : {}
    \             },
    \
    \   "7"    : {'caption'     : 'space, iskeyword',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : 'a',
    \             'key_input'   : "\<M-w>",
    \             'breaking'    : 5,
    \             'abort'       : 0,
    \             'pre' : {'commands' : 'let g:columnmove_strict_wbege=1'}, 'post' : {}
    \             },
    \
    \   "8"    : {'caption'     : 'space, not-iskeyword',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : ';',
    \             'key_input'   : "\<M-w>",
    \             'breaking'    : 5,
    \             'abort'       : 0,
    \             'pre' : {'commands' : 'let g:columnmove_strict_wbege=1'}, 'post' : {}
    \             },
    \
    \   "9"    : {'caption'     : 'space, empty',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : 'a',
    \             'key_input'   : "\<M-w>",
    \             'breaking'    : 6,
    \             'abort'       : 0,
    \             'pre' : {'commands' : 'let g:columnmove_strict_wbege=1'}, 'post' : {}
    \             },
    \
    \   "10"   : {'caption'     : 'iskeyword, space, folded lines',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : 'e',
    \             'key_input'   : "\<M-w>",
    \             'breaking'    : 6,
    \             'abort'       : 0,
    \             'pre' : {'commands' : ['let g:columnmove_strict_wbege=1', ':let g:columnmove_fold_treatment=0']}, 'post' : {}
    \             },
    \
    \   "11"   : {'caption'     : 'iskeyword, not-iskeyword, folded lines',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : ';',
    \             'key_input'   : "\<M-w>",
    \             'breaking'    : 6,
    \             'abort'       : 0,
    \             'pre' : {'commands' : 'let g:columnmove_strict_wbege=1'}, 'post' : {}
    \             },
    \
    \   "12"   : {'caption'     : 'iskeyword, empty, folded lines',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : 'e',
    \             'key_input'   : "\<M-w>",
    \             'breaking'    : 6,
    \             'abort'       : 0,
    \             'pre' : {'commands' : 'let g:columnmove_strict_wbege=1'}, 'post' : {}
    \             },
    \
    \   "13"   : {'caption'     : 'not-iskeyword, space, folded lines',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : '\',
    \             'key_input'   : "\<M-w>",
    \             'breaking'    : 6,
    \             'abort'       : 0,
    \             'pre' : {'commands' : 'let g:columnmove_strict_wbege=1'}, 'post' : {}
    \             },
    \
    \   "14"   : {'caption'     : 'not-iskeyword, iskeyword, folded lines',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : 'a',
    \             'key_input'   : "\<M-w>",
    \             'breaking'    : 6,
    \             'abort'       : 0,
    \             'pre' : {'commands' : 'let g:columnmove_strict_wbege=1'}, 'post' : {}
    \             },
    \
    \   "15"   : {'caption'     : 'not-iskeyword, empty, folded lines',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : '\',
    \             'key_input'   : "\<M-w>",
    \             'breaking'    : 6,
    \             'abort'       : 0,
    \             'pre' : {'commands' : 'let g:columnmove_strict_wbege=1'}, 'post' : {}
    \             },
    \
    \   "16"   : {'caption'     : 'space, iskeyword, folded lines',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : 'a',
    \             'key_input'   : "\<M-w>",
    \             'breaking'    : 6,
    \             'abort'       : 0,
    \             'pre' : {'commands' : 'let g:columnmove_strict_wbege=1'}, 'post' : {}
    \             },
    \
    \   "17"   : {'caption'     : 'space, not-iskeyword, folded lines',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : ';',
    \             'key_input'   : "\<M-w>",
    \             'breaking'    : 6,
    \             'abort'       : 0,
    \             'pre' : {'commands' : 'let g:columnmove_strict_wbege=1'}, 'post' : {}
    \             },
    \
    \   "18"   : {'caption'     : 'space, empty, folded lines',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : 'a',
    \             'key_input'   : "\<M-w>",
    \             'breaking'    : 6,
    \             'abort'       : 0,
    \             'pre' : {'commands' : 'let g:columnmove_strict_wbege=1'}, 'post' : {}
    \             },
    \
    \   "19"   : {'caption'     : 'iskeyword, space, folded lines',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : 'd',
    \             'key_input'   : "j\<M-w>",
    \             'breaking'    : 7,
    \             'abort'       : 0,
    \             'pre' : {'commands' : ['let g:columnmove_strict_wbege=1', 'let g:columnmove_fold_treatment=1']}, 'post' : {}
    \             },
    \
    \   "20"   : {'caption'     : 'iskeyword, not-iskeyword, folded lines',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : 'd',
    \             'key_input'   : "j\<M-w>",
    \             'breaking'    : 7,
    \             'abort'       : 0,
    \             'pre' : {'commands' : ['let g:columnmove_strict_wbege=1', 'let g:columnmove_fold_treatment=1']}, 'post' : {}
    \             },
    \
    \   "21"   : {'caption'     : 'iskeyword, empty, folded lines',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : 'd',
    \             'key_input'   : "j\<M-w>",
    \             'breaking'    : 7,
    \             'abort'       : 0,
    \             'pre' : {'commands' : ['let g:columnmove_strict_wbege=1', 'let g:columnmove_fold_treatment=1']}, 'post' : {}
    \             },
    \
    \   "22"   : {'caption'     : 'not-iskeyword, space, folded lines',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : '/',
    \             'key_input'   : "j\<M-w>",
    \             'breaking'    : 7,
    \             'abort'       : 0,
    \             'pre' : {'commands' : ['let g:columnmove_strict_wbege=1', 'let g:columnmove_fold_treatment=1']}, 'post' : {}
    \             },
    \
    \   "23"   : {'caption'     : 'not-iskeyword, iskeyword, folded lines',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : '/',
    \             'key_input'   : "j\<M-w>",
    \             'breaking'    : 7,
    \             'abort'       : 0,
    \             'pre' : {'commands' : ['let g:columnmove_strict_wbege=1', 'let g:columnmove_fold_treatment=1']}, 'post' : {}
    \             },
    \
    \   "24"   : {'caption'     : 'not-iskeyword, empty, folded lines',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : '/',
    \             'key_input'   : "j\<M-w>",
    \             'breaking'    : 7,
    \             'abort'       : 0,
    \             'pre' : {'commands' : ['let g:columnmove_strict_wbege=1', 'let g:columnmove_fold_treatment=1']}, 'post' : {}
    \             },
    \
    \   "25"   : {'caption'     : 'space, iskeyword, folded lines',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : 'a',
    \             'key_input'   : "j\<M-w>",
    \             'breaking'    : 7,
    \             'abort'       : 0,
    \             'pre' : {'commands' : ['let g:columnmove_strict_wbege=1', 'let g:columnmove_fold_treatment=1']}, 'post' : {}
    \             },
    \
    \   "26"   : {'caption'     : 'space, not-iskeyword, folded lines',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : ';',
    \             'key_input'   : "j\<M-w>",
    \             'breaking'    : 7,
    \             'abort'       : 0,
    \             'pre' : {'commands' : ['let g:columnmove_strict_wbege=1', 'let g:columnmove_fold_treatment=1']}, 'post' : {}
    \             },
    \
    \   "27"   : {'caption'     : 'space, empty, folded lines',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : 'a',
    \             'key_input'   : "j\<M-w>",
    \             'breaking'    : 7,
    \             'abort'       : 0,
    \             'pre' : {'commands' : ['let g:columnmove_strict_wbege=1', 'let g:columnmove_fold_treatment=1']}, 'post' : {}
    \             },
    \
    \   "28"   : {'caption'     : 'iskeyword, space',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : 'f',
    \             'key_input'   : "j\<M-w>",
    \             'breaking'    : 9,
    \             'abort'       : 0,
    \             'pre' : {'commands' : ['let g:columnmove_strict_wbege=0', 'let g:columnmove_fold_treatment=0']}, 'post' : {}
    \             },
    \
    \   "29"   : {'caption'     : 'iskeyword, not-iskeyword',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : 'f',
    \             'key_input'   : "j\<M-w>",
    \             'breaking'    : 9,
    \             'abort'       : 0,
    \             'pre' : {'commands' : ['let g:columnmove_strict_wbege=0', 'let g:columnmove_fold_treatment=0']}, 'post' : {}
    \             },
    \
    \   "30"   : {'caption'     : 'iskeyword, empty',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : 'd',
    \             'key_input'   : "j\<M-w>",
    \             'breaking'    : 6,
    \             'abort'       : 0,
    \             'pre' : {'commands' : ['let g:columnmove_strict_wbege=0', 'let g:columnmove_fold_treatment=0']}, 'post' : {}
    \             },
    \
    \   "31"   : {'caption'     : 'not-iskeyword, space',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : ';',
    \             'key_input'   : "j\<M-w>",
    \             'breaking'    : 9,
    \             'abort'       : 0,
    \             'pre' : {'commands' : ['let g:columnmove_strict_wbege=0', 'let g:columnmove_fold_treatment=0']}, 'post' : {}
    \             },
    \
    \   "32"   : {'caption'     : 'not-iskeyword, iskeyword',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : ';',
    \             'key_input'   : "j\<M-w>",
    \             'breaking'    : 9,
    \             'abort'       : 0,
    \             'pre' : {'commands' : ['let g:columnmove_strict_wbege=0', 'let g:columnmove_fold_treatment=0']}, 'post' : {}
    \             },
    \
    \   "33"   : {'caption'     : 'not-iskeyword, empty',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : '/',
    \             'key_input'   : "j\<M-w>",
    \             'breaking'    : 6,
    \             'abort'       : 0,
    \             'pre' : {'commands' : ['let g:columnmove_strict_wbege=0', 'let g:columnmove_fold_treatment=0']}, 'post' : {}
    \             },
    \
    \   "34"   : {'caption'     : 'space, iskeyword',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : ' ',
    \             'key_input'   : "j\<M-w>",
    \             'breaking'    : 9,
    \             'abort'       : 0,
    \             'pre' : {'commands' : ['let g:columnmove_strict_wbege=0', 'let g:columnmove_fold_treatment=0']}, 'post' : {}
    \             },
    \
    \   "35"   : {'caption'     : 'space, not-iskeyword',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : ' ',
    \             'key_input'   : "j\<M-w>",
    \             'breaking'    : 9,
    \             'abort'       : 0,
    \             'pre' : {'commands' : ['let g:columnmove_strict_wbege=0', 'let g:columnmove_fold_treatment=0']}, 'post' : {}
    \             },
    \
    \   "36"   : {'caption'     : 'space, empty',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : ' ',
    \             'key_input'   : "j\<M-w>",
    \             'breaking'    : 7,
    \             'abort'       : 0,
    \             'pre' : {'commands' : ['let g:columnmove_strict_wbege=0', 'let g:columnmove_fold_treatment=0']}, 'post' : {}
    \             },
    \
    \   "37"  : {'caption'     : 'iskeyword, space, folded lines',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : 'g',
    \             'key_input'   : "j\<M-w>",
    \             'breaking'    : 10,
    \             'abort'       : 0,
    \             'pre' : {'commands' : ['let g:columnmove_strict_wbege=0', 'let g:columnmove_fold_treatment=0']}, 'post' : {}
    \             },
    \
    \   "38"   : {'caption'     : 'iskeyword, not-iskeyword, folded lines',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : 'g',
    \             'key_input'   : "j\<M-w>",
    \             'breaking'    : 10,
    \             'abort'       : 0,
    \             'pre' : {'commands' : ['let g:columnmove_strict_wbege=0', 'let g:columnmove_fold_treatment=0']}, 'post' : {}
    \             },
    \
    \   "39"   : {'caption'     : 'iskeyword, empty, folded lines',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : 'e',
    \             'key_input'   : "j\<M-w>",
    \             'breaking'    : 6,
    \             'abort'       : 0,
    \             'pre' : {'commands' : ['let g:columnmove_strict_wbege=0', 'let g:columnmove_fold_treatment=0']}, 'post' : {}
    \             },
    \
    \   "40"   : {'caption'     : 'not-iskeyword, space, folded lines',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : ';',
    \             'key_input'   : "j\<M-w>",
    \             'breaking'    : 10,
    \             'abort'       : 0,
    \             'pre' : {'commands' : ['let g:columnmove_strict_wbege=0', 'let g:columnmove_fold_treatment=0']}, 'post' : {}
    \             },
    \
    \   "41"   : {'caption'     : 'not-iskeyword, iskeyword, folded lines',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : ';',
    \             'key_input'   : "j\<M-w>",
    \             'breaking'    : 10,
    \             'abort'       : 0,
    \             'pre' : {'commands' : ['let g:columnmove_strict_wbege=0', 'let g:columnmove_fold_treatment=0']}, 'post' : {}
    \             },
    \
    \   "42"   : {'caption'     : 'not-iskeyword, empty, folded lines',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : '\',
    \             'key_input'   : "j\<M-w>",
    \             'breaking'    : 7,
    \             'abort'       : 0,
    \             'pre' : {'commands' : ['let g:columnmove_strict_wbege=0', 'let g:columnmove_fold_treatment=0']}, 'post' : {}
    \             },
    \
    \   "43"   : {'caption'     : 'space, iskeyword, folded lines',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : ' ',
    \             'key_input'   : "j\<M-w>",
    \             'breaking'    : 10,
    \             'abort'       : 0,
    \             'pre' : {'commands' : ['let g:columnmove_strict_wbege=0', 'let g:columnmove_fold_treatment=0']}, 'post' : {}
    \             },
    \
    \   "44"   : {'caption'     : 'space, not-iskeyword, folded lines',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : ' ',
    \             'key_input'   : "j\<M-w>",
    \             'breaking'    : 10,
    \             'abort'       : 0,
    \             'pre' : {'commands' : ['let g:columnmove_strict_wbege=0', 'let g:columnmove_fold_treatment=0']}, 'post' : {}
    \             },
    \
    \   "45"   : {'caption'     : 'space, empty, folded lines',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : ' ',
    \             'key_input'   : "j\<M-w>",
    \             'breaking'    : 7,
    \             'abort'       : 0,
    \             'pre' : {'commands' : ['let g:columnmove_strict_wbege=0', 'let g:columnmove_fold_treatment=0']}, 'post' : {}
    \             },
    \
    \   "46"   : {'caption'     : 'iskeyword, space, folded lines',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : 'd',
    \             'key_input'   : "2j\<M-w>",
    \             'breaking'    : 8,
    \             'abort'       : 0,
    \             'pre' : {'commands' : ['let g:columnmove_strict_wbege=0', 'let g:columnmove_fold_treatment=1']}, 'post' : {}
    \             },
    \
    \   "47"   : {'caption'     : 'iskeyword, not-iskeyword, folded lines',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : 'd',
    \             'key_input'   : "2j\<M-w>",
    \             'breaking'    : 8,
    \             'abort'       : 0,
    \             'pre' : {'commands' : ['let g:columnmove_strict_wbege=0', 'let g:columnmove_fold_treatment=1']}, 'post' : {}
    \             },
    \
    \   "48"   : {'caption'     : 'iskeyword, empty, folded lines',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : 'd',
    \             'key_input'   : "2j\<M-w>",
    \             'breaking'    : 8,
    \             'abort'       : 0,
    \             'pre' : {'commands' : ['let g:columnmove_strict_wbege=0', 'let g:columnmove_fold_treatment=1']}, 'post' : {}
    \             },
    \
    \   "49"   : {'caption'     : 'not-iskeyword, space, folded lines',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : '/',
    \             'key_input'   : "2j\<M-w>",
    \             'breaking'    : 8,
    \             'abort'       : 0,
    \             'pre' : {'commands' : ['let g:columnmove_strict_wbege=0', 'let g:columnmove_fold_treatment=1']}, 'post' : {}
    \             },
    \
    \   "50"   : {'caption'     : 'not-iskeyword, iskeyword, folded lines',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : '/',
    \             'key_input'   : "2j\<M-w>",
    \             'breaking'    : 8,
    \             'abort'       : 0,
    \             'pre' : {'commands' : ['let g:columnmove_strict_wbege=0', 'let g:columnmove_fold_treatment=1']}, 'post' : {}
    \             },
    \
    \   "51"   : {'caption'     : 'not-iskeyword, empty, folded lines',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : '/',
    \             'key_input'   : "2j\<M-w>",
    \             'breaking'    : 8,
    \             'abort'       : 0,
    \             'pre' : {'commands' : ['let g:columnmove_strict_wbege=0', 'let g:columnmove_fold_treatment=1']}, 'post' : {}
    \             },
    \
    \   "52"  : {'caption'     : 'space, iskeyword, folded lines',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : ' ',
    \             'key_input'   : "2j\<M-w>",
    \             'breaking'    : 8,
    \             'abort'       : 0,
    \             'pre' : {'commands' : ['let g:columnmove_strict_wbege=0', 'let g:columnmove_fold_treatment=1']}, 'post' : {}
    \             },
    \
    \   "53"  : {'caption'     : 'space, not-iskeyword, folded lines',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : ' ',
    \             'key_input'   : "2j\<M-w>",
    \             'breaking'    : 8,
    \             'abort'       : 0,
    \             'pre' : {'commands' : ['let g:columnmove_strict_wbege=0', 'let g:columnmove_fold_treatment=1']}, 'post' : {}
    \             },
    \
    \   "54"  : {'caption'     : 'space, empty, folded lines',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : ' ',
    \             'key_input'   : "2j\<M-w>",
    \             'breaking'    : 8,
    \             'abort'       : 0,
    \             'pre' : {'commands' : ['let g:columnmove_strict_wbege=0', 'let g:columnmove_fold_treatment=1']}, 'post' : {}
    \             },
    \
    \   "55"   : {'caption'     : 'fold opening',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : ':',
    \             'key_input'   : "2j\<M-w>",
    \             'breaking'    : 9,
    \             'abort'       : 0,
    \             'pre' : {'commands' : ['let g:columnmove_strict_wbege=1', 'let g:columnmove_fold_treatment=0', 'let g:columnmove_fold_open=1']}, 'post' : {}
    \             },
    \
    \   "56"   : {'caption'     : 'fold opening',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : 'c',
    \             'key_input'   : "2j\<M-w>",
    \             'breaking'    : 9,
    \             'abort'       : 0,
    \             'pre' : {'commands' : ['let g:columnmove_strict_wbege=1', 'let g:columnmove_fold_treatment=0', 'let g:columnmove_fold_open=1']}, 'post' : {}
    \             },
    \
    \   "57"   : {'caption'     : 'fold opening',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : 'c',
    \             'key_input'   : "2j\<M-w>",
    \             'breaking'    : 9,
    \             'abort'       : 0,
    \             'pre' : {'commands' : ['let g:columnmove_strict_wbege=0', 'let g:columnmove_fold_treatment=0', 'let g:columnmove_fold_open=1']}, 'post' : {}
    \             },
    \
    \   "58"   : {'caption'     : 'folded lines',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : 'i',
    \             'key_input'   : "3j\<M-w>",
    \             'breaking'    : 15,
    \             'abort'       : 0,
    \             'pre' : {'commands' : ['let g:columnmove_strict_wbege=0', 'let g:columnmove_fold_treatment=0', 'let g:columnmove_fold_open=1']}, 'post' : {}
    \             },
    \
    \   "59"   : {'caption'     : 'preserved column position at line end',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : 'k',
    \             'key_input'   : "$j\<M-w>",
    \             'breaking'    : 3,
    \             'abort'       : 0,
    \             'pre' : {'commands' : ['let g:columnmove_strict_wbege=1']}, 'post' : {}
    \             },
    \
    \   "60"   : {'caption'     : 'preserved column position at line end',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : 'k',
    \             'key_input'   : "$j\<M-w>",
    \             'breaking'    : 3,
    \             'abort'       : 0,
    \             'pre' : {'commands' : ['let g:columnmove_strict_wbege=0']}, 'post' : {}
    \             },
    \
    \   "61"   : {'caption'     : 'multi-width character',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : 'o',
    \             'key_input'   : "faa\<M-w>\<Esc>",
    \             'breaking'    : 2,
    \             'abort'       : 0,
    \             'pre' : {'commands': ['setl tw=4']}, 'post' : {}
    \             },
    \
    \   "62"   : {'caption'     : 'multi-width character',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : 'o',
    \             'key_input'   : "fea\<M-w>\<Esc>",
    \             'breaking'    : 2,
    \             'abort'       : 0,
    \             'pre' : {'commands': ['setl tw=4']}, 'post' : {}
    \             },
    \
    \   "post" : {'breaking' : 1, 'commands' : ['let g:columnmove_strict_wbege=0', 'let g:columnmove_fold_treatment=1']},
    \   }

let test_info.8       = {
    \   "pre"  : {'breaking' : 1 , 'commands' : [':let g:columnmove_fold_open=0', ':let g:columnmove_expand_range=0', ':let g:columnmove_fold_treatment=0']},
    \   "1"    : {'caption'     : 'iskeyword, space',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : 'c',
    \             'key_input'   : "5j\<M-b>",
    \             'breaking'    : 5,
    \             'abort'       : 0,
    \             'pre' : {'commands' : 'let g:columnmove_strict_wbege=1'}, 'post' : {}
    \             },
    \
    \   "2"    : {'caption'     : 'iskeyword, not-iskeyword',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : 'd',
    \             'key_input'   : "5j\<M-b>",
    \             'breaking'    : 5,
    \             'abort'       : 0,
    \             'pre' : {'commands' : 'let g:columnmove_strict_wbege=1'}, 'post' : {}
    \             },
    \
    \   "3"    : {'caption'     : 'iskeyword, empty',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : 'd',
    \             'key_input'   : "5j\<M-b>",
    \             'breaking'    : 5,
    \             'abort'       : 0,
    \             'pre' : {'commands' : 'let g:columnmove_strict_wbege=1'}, 'post' : {}
    \             },
    \
    \   "4"    : {'caption'     : 'not-iskeyword, space',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : '/',
    \             'key_input'   : "5j\<M-b>",
    \             'breaking'    : 5,
    \             'abort'       : 0,
    \             'pre' : {'commands' : 'let g:columnmove_strict_wbege=1'}, 'post' : {}
    \             },
    \
    \   "5"    : {'caption'     : 'not-iskeyword, iskeyword',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : '/',
    \             'key_input'   : "5j\<M-b>",
    \             'breaking'    : 5,
    \             'abort'       : 0,
    \             'pre' : {'commands' : 'let g:columnmove_strict_wbege=1'}, 'post' : {}
    \             },
    \
    \   "6"    : {'caption'     : 'not-iskeyword, empty',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : '/',
    \             'key_input'   : "5j\<M-b>",
    \             'breaking'    : 5,
    \             'abort'       : 0,
    \             'pre' : {'commands' : 'let g:columnmove_strict_wbege=1'}, 'post' : {}
    \             },
    \
    \   "7"    : {'caption'     : 'space, iskeyword',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : 'a',
    \             'key_input'   : "5j\<M-b>",
    \             'breaking'    : 5,
    \             'abort'       : 0,
    \             'pre' : {'commands' : 'let g:columnmove_strict_wbege=1'}, 'post' : {}
    \             },
    \
    \   "8"    : {'caption'     : 'space, not-iskeyword',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : ';',
    \             'key_input'   : "5j\<M-b>",
    \             'breaking'    : 5,
    \             'abort'       : 0,
    \             'pre' : {'commands' : 'let g:columnmove_strict_wbege=1'}, 'post' : {}
    \             },
    \
    \   "9"    : {'caption'     : 'space, empty',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : 'a',
    \             'key_input'   : "6j\<M-b>",
    \             'breaking'    : 6,
    \             'abort'       : 0,
    \             'pre' : {'commands' : 'let g:columnmove_strict_wbege=1'}, 'post' : {}
    \             },
    \
    \   "10"   : {'caption'     : 'iskeyword, space, folded lines',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : 'c',
    \             'key_input'   : "5j\<M-b>",
    \             'breaking'    : 6,
    \             'abort'       : 0,
    \             'pre' : {'commands' : ['let g:columnmove_strict_wbege=1', ':let g:columnmove_fold_treatment=0']}, 'post' : {}
    \             },
    \
    \   "11"   : {'caption'     : 'iskeyword, not-iskeyword, folded lines',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : 'c',
    \             'key_input'   : "5j\<M-b>",
    \             'breaking'    : 6,
    \             'abort'       : 0,
    \             'pre' : {'commands' : 'let g:columnmove_strict_wbege=1'}, 'post' : {}
    \             },
    \
    \   "12"   : {'caption'     : 'iskeyword, empty, folded lines',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : 'a',
    \             'key_input'   : "4j\<M-b>",
    \             'breaking'    : 6,
    \             'abort'       : 0,
    \             'pre' : {'commands' : 'let g:columnmove_strict_wbege=1'}, 'post' : {}
    \             },
    \
    \   "13"   : {'caption'     : 'not-iskeyword, space, folded lines',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : ']',
    \             'key_input'   : "5j\<M-b>",
    \             'breaking'    : 6,
    \             'abort'       : 0,
    \             'pre' : {'commands' : 'let g:columnmove_strict_wbege=1'}, 'post' : {}
    \             },
    \
    \   "14"   : {'caption'     : 'not-iskeyword, iskeyword, folded lines',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : ']',
    \             'key_input'   : "5j\<M-b>",
    \             'breaking'    : 6,
    \             'abort'       : 0,
    \             'pre' : {'commands' : 'let g:columnmove_strict_wbege=1'}, 'post' : {}
    \             },
    \
    \   "15"   : {'caption'     : 'not-iskeyword, empty, folded lines',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : ']',
    \             'key_input'   : "5j\<M-b>",
    \             'breaking'    : 6,
    \             'abort'       : 0,
    \             'pre' : {'commands' : 'let g:columnmove_strict_wbege=1'}, 'post' : {}
    \             },
    \
    \   "16"   : {'caption'     : 'space, iskeyword, folded lines',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : 'a',
    \             'key_input'   : "5j\<M-b>",
    \             'breaking'    : 6,
    \             'abort'       : 0,
    \             'pre' : {'commands' : 'let g:columnmove_strict_wbege=1'}, 'post' : {}
    \             },
    \
    \   "17"   : {'caption'     : 'space, not-iskeyword, folded lines',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : ';',
    \             'key_input'   : "5j\<M-b>",
    \             'breaking'    : 6,
    \             'abort'       : 0,
    \             'pre' : {'commands' : 'let g:columnmove_strict_wbege=1'}, 'post' : {}
    \             },
    \
    \   "18"   : {'caption'     : 'space, empty, folded lines',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : 'a',
    \             'key_input'   : "5j\<M-b>",
    \             'breaking'    : 6,
    \             'abort'       : 0,
    \             'pre' : {'commands' : 'let g:columnmove_strict_wbege=1'}, 'post' : {}
    \             },
    \
    \   "19"   : {'caption'     : 'iskeyword, space, folded lines',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : 'f',
    \             'key_input'   : "6j\<M-b>",
    \             'breaking'    : 7,
    \             'abort'       : 0,
    \             'pre' : {'commands' : ['let g:columnmove_strict_wbege=1', 'let g:columnmove_fold_treatment=1']}, 'post' : {}
    \             },
    \
    \   "20"   : {'caption'     : 'iskeyword, not-iskeyword, folded lines',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : 'e',
    \             'key_input'   : "6j\<M-b>",
    \             'breaking'    : 7,
    \             'abort'       : 0,
    \             'pre' : {'commands' : ['let g:columnmove_strict_wbege=1', 'let g:columnmove_fold_treatment=1']}, 'post' : {}
    \             },
    \
    \   "21"   : {'caption'     : 'iskeyword, empty, folded lines',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : 'e',
    \             'key_input'   : "6j\<M-b>",
    \             'breaking'    : 7,
    \             'abort'       : 0,
    \             'pre' : {'commands' : ['let g:columnmove_strict_wbege=1', 'let g:columnmove_fold_treatment=1']}, 'post' : {}
    \             },
    \
    \   "22"   : {'caption'     : 'not-iskeyword, space, folded lines',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : '\',
    \             'key_input'   : "6j\<M-b>",
    \             'breaking'    : 7,
    \             'abort'       : 0,
    \             'pre' : {'commands' : ['let g:columnmove_strict_wbege=1', 'let g:columnmove_fold_treatment=1']}, 'post' : {}
    \             },
    \
    \   "23"   : {'caption'     : 'not-iskeyword, iskeyword, folded lines',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : '\',
    \             'key_input'   : "6j\<M-b>",
    \             'breaking'    : 7,
    \             'abort'       : 0,
    \             'pre' : {'commands' : ['let g:columnmove_strict_wbege=1', 'let g:columnmove_fold_treatment=1']}, 'post' : {}
    \             },
    \
    \   "24"   : {'caption'     : 'not-iskeyword, empty, folded lines',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : '\',
    \             'key_input'   : "6j\<M-b>",
    \             'breaking'    : 7,
    \             'abort'       : 0,
    \             'pre' : {'commands' : ['let g:columnmove_strict_wbege=1', 'let g:columnmove_fold_treatment=1']}, 'post' : {}
    \             },
    \
    \   "25"   : {'caption'     : 'space, iskeyword, folded lines',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : 'a',
    \             'key_input'   : "6j\<M-b>",
    \             'breaking'    : 7,
    \             'abort'       : 0,
    \             'pre' : {'commands' : ['let g:columnmove_strict_wbege=1', 'let g:columnmove_fold_treatment=1']}, 'post' : {}
    \             },
    \
    \   "26"   : {'caption'     : 'space, not-iskeyword, folded lines',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : ';',
    \             'key_input'   : "6j\<M-b>",
    \             'breaking'    : 7,
    \             'abort'       : 0,
    \             'pre' : {'commands' : ['let g:columnmove_strict_wbege=1', 'let g:columnmove_fold_treatment=1']}, 'post' : {}
    \             },
    \
    \   "27"   : {'caption'     : 'space, empty, folded lines',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : 'a',
    \             'key_input'   : "6j\<M-b>",
    \             'breaking'    : 7,
    \             'abort'       : 0,
    \             'pre' : {'commands' : ['let g:columnmove_strict_wbege=1', 'let g:columnmove_fold_treatment=1']}, 'post' : {}
    \             },
    \
    \   "28"   : {'caption'     : 'iskeyword, space',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : 'c',
    \             'key_input'   : "9j\<M-b>",
    \             'breaking'    : 9,
    \             'abort'       : 0,
    \             'pre' : {'commands' : ['let g:columnmove_strict_wbege=0', 'let g:columnmove_fold_treatment=0']}, 'post' : {}
    \             },
    \
    \   "29"   : {'caption'     : 'iskeyword, not-iskeyword',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : 'c',
    \             'key_input'   : "9j\<M-b>",
    \             'breaking'    : 9,
    \             'abort'       : 0,
    \             'pre' : {'commands' : ['let g:columnmove_strict_wbege=0', 'let g:columnmove_fold_treatment=0']}, 'post' : {}
    \             },
    \
    \   "30"   : {'caption'     : 'iskeyword, empty',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : 'c',
    \             'key_input'   : "5j\<M-b>",
    \             'breaking'    : 6,
    \             'abort'       : 0,
    \             'pre' : {'commands' : ['let g:columnmove_strict_wbege=0', 'let g:columnmove_fold_treatment=0']}, 'post' : {}
    \             },
    \
    \   "31"   : {'caption'     : 'not-iskeyword, space',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : ';',
    \             'key_input'   : "9j\<M-b>",
    \             'breaking'    : 9,
    \             'abort'       : 0,
    \             'pre' : {'commands' : ['let g:columnmove_strict_wbege=0', 'let g:columnmove_fold_treatment=0']}, 'post' : {}
    \             },
    \
    \   "32"   : {'caption'     : 'not-iskeyword, iskeyword',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : ';',
    \             'key_input'   : "9j\<M-b>",
    \             'breaking'    : 9,
    \             'abort'       : 0,
    \             'pre' : {'commands' : ['let g:columnmove_strict_wbege=0', 'let g:columnmove_fold_treatment=0']}, 'post' : {}
    \             },
    \
    \   "33"   : {'caption'     : 'not-iskeyword, empty',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : ']',
    \             'key_input'   : "6j\<M-b>",
    \             'breaking'    : 6,
    \             'abort'       : 0,
    \             'pre' : {'commands' : ['let g:columnmove_strict_wbege=0', 'let g:columnmove_fold_treatment=0']}, 'post' : {}
    \             },
    \
    \   "34"   : {'caption'     : 'space, iskeyword',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : ' ',
    \             'key_input'   : "9j\<M-b>",
    \             'breaking'    : 9,
    \             'abort'       : 0,
    \             'pre' : {'commands' : ['let g:columnmove_strict_wbege=0', 'let g:columnmove_fold_treatment=0']}, 'post' : {}
    \             },
    \
    \   "35"   : {'caption'     : 'space, not-iskeyword',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : ' ',
    \             'key_input'   : "9j\<M-b>",
    \             'breaking'    : 9,
    \             'abort'       : 0,
    \             'pre' : {'commands' : ['let g:columnmove_strict_wbege=0', 'let g:columnmove_fold_treatment=0']}, 'post' : {}
    \             },
    \
    \   "36"   : {'caption'     : 'space, empty',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : ' ',
    \             'key_input'   : "7j\<M-b>",
    \             'breaking'    : 7,
    \             'abort'       : 0,
    \             'pre' : {'commands' : ['let g:columnmove_strict_wbege=0', 'let g:columnmove_fold_treatment=0']}, 'post' : {}
    \             },
    \
    \   "37"  : {'caption'     : 'iskeyword, space, folded lines',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : 'c',
    \             'key_input'   : "8j\<M-b>",
    \             'breaking'    : 10,
    \             'abort'       : 0,
    \             'pre' : {'commands' : ['let g:columnmove_strict_wbege=0', 'let g:columnmove_fold_treatment=0']}, 'post' : {}
    \             },
    \
    \   "38"   : {'caption'     : 'iskeyword, not-iskeyword, folded lines',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : 'f',
    \             'key_input'   : "7j\<M-b>",
    \             'breaking'    : 10,
    \             'abort'       : 0,
    \             'pre' : {'commands' : ['let g:columnmove_strict_wbege=0', 'let g:columnmove_fold_treatment=0']}, 'post' : {}
    \             },
    \
    \   "39"   : {'caption'     : 'iskeyword, empty, folded lines',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : 'a',
    \             'key_input'   : "5j\<M-b>",
    \             'breaking'    : 7,
    \             'abort'       : 0,
    \             'pre' : {'commands' : ['let g:columnmove_strict_wbege=0', 'let g:columnmove_fold_treatment=0']}, 'post' : {}
    \             },
    \
    \   "40"   : {'caption'     : 'not-iskeyword, space, folded lines',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : ';',
    \             'key_input'   : "9j\<M-b>",
    \             'breaking'    : 10,
    \             'abort'       : 0,
    \             'pre' : {'commands' : ['let g:columnmove_strict_wbege=0', 'let g:columnmove_fold_treatment=0']}, 'post' : {}
    \             },
    \
    \   "41"   : {'caption'     : 'not-iskeyword, iskeyword, folded lines',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : ';',
    \             'key_input'   : "9j\<M-b>",
    \             'breaking'    : 10,
    \             'abort'       : 0,
    \             'pre' : {'commands' : ['let g:columnmove_strict_wbege=0', 'let g:columnmove_fold_treatment=0']}, 'post' : {}
    \             },
    \
    \   "42"   : {'caption'     : 'not-iskeyword, empty, folded lines',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : '\',
    \             'key_input'   : "6j\<M-b>",
    \             'breaking'    : 7,
    \             'abort'       : 0,
    \             'pre' : {'commands' : ['let g:columnmove_strict_wbege=0', 'let g:columnmove_fold_treatment=0']}, 'post' : {}
    \             },
    \
    \   "43"   : {'caption'     : 'space, iskeyword, folded lines',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : ' ',
    \             'key_input'   : "8j\<M-b>",
    \             'breaking'    : 10,
    \             'abort'       : 0,
    \             'pre' : {'commands' : ['let g:columnmove_strict_wbege=0', 'let g:columnmove_fold_treatment=0']}, 'post' : {}
    \             },
    \
    \   "44"   : {'caption'     : 'space, not-iskeyword, folded lines',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : ' ',
    \             'key_input'   : "8j\<M-b>",
    \             'breaking'    : 10,
    \             'abort'       : 0,
    \             'pre' : {'commands' : ['let g:columnmove_strict_wbege=0', 'let g:columnmove_fold_treatment=0']}, 'post' : {}
    \             },
    \
    \   "45"   : {'caption'     : 'space, empty, folded lines',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : 'a',
    \             'key_input'   : "7j\<M-b>",
    \             'breaking'    : 8,
    \             'abort'       : 0,
    \             'pre' : {'commands' : ['let g:columnmove_strict_wbege=0', 'let g:columnmove_fold_treatment=0']}, 'post' : {}
    \             },
    \
    \   "46"   : {'caption'     : 'iskeyword, space, folded lines',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : 'e',
    \             'key_input'   : "8j\<M-b>",
    \             'breaking'    : 9,
    \             'abort'       : 0,
    \             'pre' : {'commands' : ['let g:columnmove_strict_wbege=0', 'let g:columnmove_fold_treatment=1']}, 'post' : {}
    \             },
    \
    \   "47"   : {'caption'     : 'iskeyword, not-iskeyword, folded lines',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : 'e',
    \             'key_input'   : "8j\<M-b>",
    \             'breaking'    : 9,
    \             'abort'       : 0,
    \             'pre' : {'commands' : ['let g:columnmove_strict_wbege=0', 'let g:columnmove_fold_treatment=1']}, 'post' : {}
    \             },
    \
    \   "48"   : {'caption'     : 'iskeyword, empty, folded lines',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : 'e',
    \             'key_input'   : "7j\<M-b>",
    \             'breaking'    : 8,
    \             'abort'       : 0,
    \             'pre' : {'commands' : ['let g:columnmove_strict_wbege=0', 'let g:columnmove_fold_treatment=1']}, 'post' : {}
    \             },
    \
    \   "49"   : {'caption'     : 'not-iskeyword, space, folded lines',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : '/',
    \             'key_input'   : "8j\<M-b>",
    \             'breaking'    : 9,
    \             'abort'       : 0,
    \             'pre' : {'commands' : ['let g:columnmove_strict_wbege=0', 'let g:columnmove_fold_treatment=1']}, 'post' : {}
    \             },
    \
    \   "50"   : {'caption'     : 'not-iskeyword, iskeyword, folded lines',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : 'a',
    \             'key_input'   : "8j\<M-b>",
    \             'breaking'    : 9,
    \             'abort'       : 0,
    \             'pre' : {'commands' : ['let g:columnmove_strict_wbege=0', 'let g:columnmove_fold_treatment=1']}, 'post' : {}
    \             },
    \
    \   "51"   : {'caption'     : 'not-iskeyword, empty, folded lines',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : '\',
    \             'key_input'   : "7j\<M-b>",
    \             'breaking'    : 8,
    \             'abort'       : 0,
    \             'pre' : {'commands' : ['let g:columnmove_strict_wbege=0', 'let g:columnmove_fold_treatment=1']}, 'post' : {}
    \             },
    \
    \   "52"  : {'caption'     : 'space, iskeyword, folded lines',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : ' ',
    \             'key_input'   : "8j\<M-b>",
    \             'breaking'    : 9,
    \             'abort'       : 0,
    \             'pre' : {'commands' : ['let g:columnmove_strict_wbege=0', 'let g:columnmove_fold_treatment=1']}, 'post' : {}
    \             },
    \
    \   "53"  : {'caption'     : 'space, not-iskeyword, folded lines',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : ' ',
    \             'key_input'   : "8j\<M-b>",
    \             'breaking'    : 9,
    \             'abort'       : 0,
    \             'pre' : {'commands' : ['let g:columnmove_strict_wbege=0', 'let g:columnmove_fold_treatment=1']}, 'post' : {}
    \             },
    \
    \   "54"  : {'caption'     : 'space, empty, folded lines',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : ' ',
    \             'key_input'   : "6j\<M-b>",
    \             'breaking'    : 8,
    \             'abort'       : 0,
    \             'pre' : {'commands' : ['let g:columnmove_strict_wbege=0', 'let g:columnmove_fold_treatment=1']}, 'post' : {}
    \             },
    \
    \   "55"   : {'caption'     : 'fold opening',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : 'e',
    \             'key_input'   : "7j\<M-b>",
    \             'breaking'    : 9,
    \             'abort'       : 0,
    \             'pre' : {'commands' : ['let g:columnmove_strict_wbege=1', 'let g:columnmove_fold_treatment=0', 'let g:columnmove_fold_open=1']}, 'post' : {}
    \             },
    \
    \   "56"   : {'caption'     : 'fold opening',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : 'e',
    \             'key_input'   : "7j\<M-b>",
    \             'breaking'    : 9,
    \             'abort'       : 0,
    \             'pre' : {'commands' : ['let g:columnmove_strict_wbege=1', 'let g:columnmove_fold_treatment=0', 'let g:columnmove_fold_open=1']}, 'post' : {}
    \             },
    \
    \   "57"   : {'caption'     : 'fold opening',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : 'e',
    \             'key_input'   : "7j\<M-b>",
    \             'breaking'    : 9,
    \             'abort'       : 0,
    \             'pre' : {'commands' : ['let g:columnmove_strict_wbege=0', 'let g:columnmove_fold_treatment=0', 'let g:columnmove_fold_open=1']}, 'post' : {}
    \             },
    \
    \   "58"   : {'caption'     : 'folded lines',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : 'h',
    \             'key_input'   : "8j\<M-b>",
    \             'breaking'    : 11,
    \             'abort'       : 0,
    \             'pre' : {'commands' : ['let g:columnmove_strict_wbege=0', 'let g:columnmove_fold_treatment=0', 'let g:columnmove_fold_open=0']}, 'post' : {}
    \             },
    \
    \   "59"   : {'caption'     : 'folded lines',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : 'c',
    \             'key_input'   : "7j\<M-b>",
    \             'breaking'    : 14,
    \             'abort'       : 0,
    \             'pre' : {'commands' : ['let g:columnmove_strict_wbege=0', 'let g:columnmove_fold_treatment=0', 'let g:columnmove_fold_open=1']}, 'post' : {}
    \             },
    \
    \   "60"   : {'caption'     : 'preserved column position at line end',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : 'c',
    \             'key_input'   : "4j$k\<M-b>",
    \             'breaking'    : 4,
    \             'abort'       : 0,
    \             'pre' : {'commands' : ['let g:columnmove_strict_wbege=1']}, 'post' : {}
    \             },
    \
    \   "61"   : {'caption'     : 'preserved column position at line end',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : 'c',
    \             'key_input'   : "4j$k\<M-b>",
    \             'breaking'    : 2,
    \             'abort'       : 0,
    \             'pre' : {'commands' : ['let g:columnmove_strict_wbege=0']}, 'post' : {}
    \             },
    \
    \   "62"   : {'caption'     : 'multi-width character',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : 'a',
    \             'key_input'   : "jfa2ja\<M-b>\<Esc>",
    \             'breaking'    : 3,
    \             'abort'       : 0,
    \             'pre' : {'commands': ['setl tw=4']}, 'post' : {}
    \             },
    \
    \   "63"   : {'caption'     : 'multi-width character',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : 'e',
    \             'key_input'   : "jfe2ja\<M-b>\<Esc>",
    \             'breaking'    : 3,
    \             'abort'       : 0,
    \             'pre' : {'commands': ['setl tw=4']}, 'post' : {}
    \             },
    \
    \   "post" : {'breaking' : 1},
    \   }

let test_info.9       = {
    \   "pre"  : {'breaking' : 1 , 'commands' : [':let g:columnmove_fold_open=0', ':let g:columnmove_expand_range=0', ':let g:columnmove_fold_treatment=0']},
    \   "1"    : {'caption'     : 'iskeyword, space',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : 'c',
    \             'key_input'   : "\<M-e>",
    \             'breaking'    : 5,
    \             'abort'       : 0,
    \             'pre' : {'commands' : 'let g:columnmove_strict_wbege=1'}, 'post' : {}
    \             },
    \
    \   "2"    : {'caption'     : 'iskeyword, not-iskeyword',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : 'c',
    \             'key_input'   : "\<M-e>",
    \             'breaking'    : 5,
    \             'abort'       : 0,
    \             'pre' : {'commands' : 'let g:columnmove_strict_wbege=1'}, 'post' : {}
    \             },
    \
    \   "3"    : {'caption'     : 'iskeyword, empty',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : 'c',
    \             'key_input'   : "\<M-e>",
    \             'breaking'    : 5,
    \             'abort'       : 0,
    \             'pre' : {'commands' : 'let g:columnmove_strict_wbege=1'}, 'post' : {}
    \             },
    \
    \   "4"    : {'caption'     : 'not-iskeyword, space',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : ']',
    \             'key_input'   : "\<M-e>",
    \             'breaking'    : 5,
    \             'abort'       : 0,
    \             'pre' : {'commands' : 'let g:columnmove_strict_wbege=1'}, 'post' : {}
    \             },
    \
    \   "5"    : {'caption'     : 'not-iskeyword, iskeyword',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : ']',
    \             'key_input'   : "\<M-e>",
    \             'breaking'    : 5,
    \             'abort'       : 0,
    \             'pre' : {'commands' : 'let g:columnmove_strict_wbege=1'}, 'post' : {}
    \             },
    \
    \   "6"    : {'caption'     : 'not-iskeyword, empty',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : ']',
    \             'key_input'   : "\<M-e>",
    \             'breaking'    : 5,
    \             'abort'       : 0,
    \             'pre' : {'commands' : 'let g:columnmove_strict_wbege=1'}, 'post' : {}
    \             },
    \
    \   "7"    : {'caption'     : 'space, iskeyword',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : 'a',
    \             'key_input'   : "\<M-e>",
    \             'breaking'    : 5,
    \             'abort'       : 0,
    \             'pre' : {'commands' : 'let g:columnmove_strict_wbege=1'}, 'post' : {}
    \             },
    \
    \   "8"    : {'caption'     : 'space, not-iskeyword',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : ';',
    \             'key_input'   : "\<M-e>",
    \             'breaking'    : 5,
    \             'abort'       : 0,
    \             'pre' : {'commands' : 'let g:columnmove_strict_wbege=1'}, 'post' : {}
    \             },
    \
    \   "9"    : {'caption'     : 'space, empty',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : 'a',
    \             'key_input'   : "\<M-e>",
    \             'breaking'    : 6,
    \             'abort'       : 0,
    \             'pre' : {'commands' : 'let g:columnmove_strict_wbege=1'}, 'post' : {}
    \             },
    \
    \   "10"   : {'caption'     : 'iskeyword, space, folded lines',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : 'd',
    \             'key_input'   : "\<M-e>",
    \             'breaking'    : 6,
    \             'abort'       : 0,
    \             'pre' : {'commands' : ['let g:columnmove_strict_wbege=1', ':let g:columnmove_fold_treatment=0']}, 'post' : {}
    \             },
    \
    \   "11"   : {'caption'     : 'iskeyword, not-iskeyword, folded lines',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : 'd',
    \             'key_input'   : "\<M-e>",
    \             'breaking'    : 6,
    \             'abort'       : 0,
    \             'pre' : {'commands' : 'let g:columnmove_strict_wbege=1'}, 'post' : {}
    \             },
    \
    \   "12"   : {'caption'     : 'iskeyword, empty, folded lines',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : 'd',
    \             'key_input'   : "\<M-e>",
    \             'breaking'    : 6,
    \             'abort'       : 0,
    \             'pre' : {'commands' : 'let g:columnmove_strict_wbege=1'}, 'post' : {}
    \             },
    \
    \   "13"   : {'caption'     : 'not-iskeyword, space, folded lines',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : '/',
    \             'key_input'   : "\<M-e>",
    \             'breaking'    : 6,
    \             'abort'       : 0,
    \             'pre' : {'commands' : 'let g:columnmove_strict_wbege=1'}, 'post' : {}
    \             },
    \
    \   "14"   : {'caption'     : 'not-iskeyword, iskeyword, folded lines',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : '/',
    \             'key_input'   : "\<M-e>",
    \             'breaking'    : 6,
    \             'abort'       : 0,
    \             'pre' : {'commands' : 'let g:columnmove_strict_wbege=1'}, 'post' : {}
    \             },
    \
    \   "15"   : {'caption'     : 'not-iskeyword, empty, folded lines',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : '/',
    \             'key_input'   : "\<M-e>",
    \             'breaking'    : 6,
    \             'abort'       : 0,
    \             'pre' : {'commands' : 'let g:columnmove_strict_wbege=1'}, 'post' : {}
    \             },
    \
    \   "16"   : {'caption'     : 'space, iskeyword, folded lines',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : 'a',
    \             'key_input'   : "\<M-e>",
    \             'breaking'    : 6,
    \             'abort'       : 0,
    \             'pre' : {'commands' : 'let g:columnmove_strict_wbege=1'}, 'post' : {}
    \             },
    \
    \   "17"   : {'caption'     : 'space, not-iskeyword, folded lines',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : ';',
    \             'key_input'   : "\<M-e>",
    \             'breaking'    : 6,
    \             'abort'       : 0,
    \             'pre' : {'commands' : 'let g:columnmove_strict_wbege=1'}, 'post' : {}
    \             },
    \
    \   "18"   : {'caption'     : 'space, empty, folded lines',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : 'a',
    \             'key_input'   : "\<M-e>",
    \             'breaking'    : 6,
    \             'abort'       : 0,
    \             'pre' : {'commands' : 'let g:columnmove_strict_wbege=1'}, 'post' : {}
    \             },
    \
    \   "19"   : {'caption'     : 'iskeyword, space, folded lines',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : 'b',
    \             'key_input'   : "j\<M-e>",
    \             'breaking'    : 7,
    \             'abort'       : 0,
    \             'pre' : {'commands' : ['let g:columnmove_strict_wbege=1', 'let g:columnmove_fold_treatment=1']}, 'post' : {}
    \             },
    \
    \   "20"   : {'caption'     : 'iskeyword, not-iskeyword, folded lines',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : 'b',
    \             'key_input'   : "j\<M-e>",
    \             'breaking'    : 7,
    \             'abort'       : 0,
    \             'pre' : {'commands' : ['let g:columnmove_strict_wbege=1', 'let g:columnmove_fold_treatment=1']}, 'post' : {}
    \             },
    \
    \   "21"   : {'caption'     : 'iskeyword, empty, folded lines',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : 'b',
    \             'key_input'   : "j\<M-e>",
    \             'breaking'    : 7,
    \             'abort'       : 0,
    \             'pre' : {'commands' : ['let g:columnmove_strict_wbege=1', 'let g:columnmove_fold_treatment=1']}, 'post' : {}
    \             },
    \
    \   "22"   : {'caption'     : 'not-iskeyword, space, folded lines',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : ':',
    \             'key_input'   : "j\<M-e>",
    \             'breaking'    : 7,
    \             'abort'       : 0,
    \             'pre' : {'commands' : ['let g:columnmove_strict_wbege=1', 'let g:columnmove_fold_treatment=1']}, 'post' : {}
    \             },
    \
    \   "23"   : {'caption'     : 'not-iskeyword, iskeyword, folded lines',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : ':',
    \             'key_input'   : "j\<M-e>",
    \             'breaking'    : 7,
    \             'abort'       : 0,
    \             'pre' : {'commands' : ['let g:columnmove_strict_wbege=1', 'let g:columnmove_fold_treatment=1']}, 'post' : {}
    \             },
    \
    \   "24"   : {'caption'     : 'not-iskeyword, empty, folded lines',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : ':',
    \             'key_input'   : "j\<M-e>",
    \             'breaking'    : 7,
    \             'abort'       : 0,
    \             'pre' : {'commands' : ['let g:columnmove_strict_wbege=1', 'let g:columnmove_fold_treatment=1']}, 'post' : {}
    \             },
    \
    \   "25"   : {'caption'     : 'space, iskeyword, folded lines',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : 'a',
    \             'key_input'   : "j\<M-e>",
    \             'breaking'    : 7,
    \             'abort'       : 0,
    \             'pre' : {'commands' : ['let g:columnmove_strict_wbege=1', 'let g:columnmove_fold_treatment=1']}, 'post' : {}
    \             },
    \
    \   "26"   : {'caption'     : 'space, not-iskeyword, folded lines',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : ';',
    \             'key_input'   : "j\<M-e>",
    \             'breaking'    : 7,
    \             'abort'       : 0,
    \             'pre' : {'commands' : ['let g:columnmove_strict_wbege=1', 'let g:columnmove_fold_treatment=1']}, 'post' : {}
    \             },
    \
    \   "27"   : {'caption'     : 'space, empty, folded lines',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : 'a',
    \             'key_input'   : "j\<M-e>",
    \             'breaking'    : 7,
    \             'abort'       : 0,
    \             'pre' : {'commands' : ['let g:columnmove_strict_wbege=1', 'let g:columnmove_fold_treatment=1']}, 'post' : {}
    \             },
    \
    \   "28"   : {'caption'     : 'iskeyword, space',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : 'e',
    \             'key_input'   : "j\<M-e>",
    \             'breaking'    : 9,
    \             'abort'       : 0,
    \             'pre' : {'commands' : ['let g:columnmove_strict_wbege=0', 'let g:columnmove_fold_treatment=0']}, 'post' : {}
    \             },
    \
    \   "29"   : {'caption'     : 'iskeyword, not-iskeyword',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : 'e',
    \             'key_input'   : "j\<M-e>",
    \             'breaking'    : 9,
    \             'abort'       : 0,
    \             'pre' : {'commands' : ['let g:columnmove_strict_wbege=0', 'let g:columnmove_fold_treatment=0']}, 'post' : {}
    \             },
    \
    \   "30"   : {'caption'     : 'iskeyword, empty',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : 'c',
    \             'key_input'   : "j\<M-e>",
    \             'breaking'    : 6,
    \             'abort'       : 0,
    \             'pre' : {'commands' : ['let g:columnmove_strict_wbege=0', 'let g:columnmove_fold_treatment=0']}, 'post' : {}
    \             },
    \
    \   "31"   : {'caption'     : 'not-iskeyword, space',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : '\',
    \             'key_input'   : "j\<M-e>",
    \             'breaking'    : 9,
    \             'abort'       : 0,
    \             'pre' : {'commands' : ['let g:columnmove_strict_wbege=0', 'let g:columnmove_fold_treatment=0']}, 'post' : {}
    \             },
    \
    \   "32"   : {'caption'     : 'not-iskeyword, iskeyword',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : '\',
    \             'key_input'   : "j\<M-e>",
    \             'breaking'    : 9,
    \             'abort'       : 0,
    \             'pre' : {'commands' : ['let g:columnmove_strict_wbege=0', 'let g:columnmove_fold_treatment=0']}, 'post' : {}
    \             },
    \
    \   "33"   : {'caption'     : 'not-iskeyword, empty',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : ']',
    \             'key_input'   : "j\<M-e>",
    \             'breaking'    : 6,
    \             'abort'       : 0,
    \             'pre' : {'commands' : ['let g:columnmove_strict_wbege=0', 'let g:columnmove_fold_treatment=0']}, 'post' : {}
    \             },
    \
    \   "34"   : {'caption'     : 'space, iskeyword',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : ' ',
    \             'key_input'   : "j\<M-e>",
    \             'breaking'    : 9,
    \             'abort'       : 0,
    \             'pre' : {'commands' : ['let g:columnmove_strict_wbege=0', 'let g:columnmove_fold_treatment=0']}, 'post' : {}
    \             },
    \
    \   "35"   : {'caption'     : 'space, not-iskeyword',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : ' ',
    \             'key_input'   : "j\<M-e>",
    \             'breaking'    : 9,
    \             'abort'       : 0,
    \             'pre' : {'commands' : ['let g:columnmove_strict_wbege=0', 'let g:columnmove_fold_treatment=0']}, 'post' : {}
    \             },
    \
    \   "36"   : {'caption'     : 'space, empty',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : ' ',
    \             'key_input'   : "j\<M-e>",
    \             'breaking'    : 7,
    \             'abort'       : 0,
    \             'pre' : {'commands' : ['let g:columnmove_strict_wbege=0', 'let g:columnmove_fold_treatment=0']}, 'post' : {}
    \             },
    \
    \   "37"  : {'caption'     : 'iskeyword, space, folded lines',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : 'f',
    \             'key_input'   : "j\<M-e>",
    \             'breaking'    : 10,
    \             'abort'       : 0,
    \             'pre' : {'commands' : ['let g:columnmove_strict_wbege=0', 'let g:columnmove_fold_treatment=0']}, 'post' : {}
    \             },
    \
    \   "38"   : {'caption'     : 'iskeyword, not-iskeyword, folded lines',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : 'f',
    \             'key_input'   : "j\<M-e>",
    \             'breaking'    : 10,
    \             'abort'       : 0,
    \             'pre' : {'commands' : ['let g:columnmove_strict_wbege=0', 'let g:columnmove_fold_treatment=0']}, 'post' : {}
    \             },
    \
    \   "39"   : {'caption'     : 'iskeyword, empty, folded lines',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : 'd',
    \             'key_input'   : "j\<M-e>",
    \             'breaking'    : 6,
    \             'abort'       : 0,
    \             'pre' : {'commands' : ['let g:columnmove_strict_wbege=0', 'let g:columnmove_fold_treatment=0']}, 'post' : {}
    \             },
    \
    \   "40"   : {'caption'     : 'not-iskeyword, space, folded lines',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : ';',
    \             'key_input'   : "j\<M-e>",
    \             'breaking'    : 10,
    \             'abort'       : 0,
    \             'pre' : {'commands' : ['let g:columnmove_strict_wbege=0', 'let g:columnmove_fold_treatment=0']}, 'post' : {}
    \             },
    \
    \   "41"   : {'caption'     : 'not-iskeyword, iskeyword, folded lines',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : ';',
    \             'key_input'   : "j\<M-e>",
    \             'breaking'    : 10,
    \             'abort'       : 0,
    \             'pre' : {'commands' : ['let g:columnmove_strict_wbege=0', 'let g:columnmove_fold_treatment=0']}, 'post' : {}
    \             },
    \
    \   "42"   : {'caption'     : 'not-iskeyword, empty, folded lines',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : '/',
    \             'key_input'   : "j\<M-e>",
    \             'breaking'    : 7,
    \             'abort'       : 0,
    \             'pre' : {'commands' : ['let g:columnmove_strict_wbege=0', 'let g:columnmove_fold_treatment=0']}, 'post' : {}
    \             },
    \
    \   "43"   : {'caption'     : 'space, iskeyword, folded lines',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : ' ',
    \             'key_input'   : "j\<M-e>",
    \             'breaking'    : 10,
    \             'abort'       : 0,
    \             'pre' : {'commands' : ['let g:columnmove_strict_wbege=0', 'let g:columnmove_fold_treatment=0']}, 'post' : {}
    \             },
    \
    \   "44"   : {'caption'     : 'space, not-iskeyword, folded lines',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : ' ',
    \             'key_input'   : "j\<M-e>",
    \             'breaking'    : 10,
    \             'abort'       : 0,
    \             'pre' : {'commands' : ['let g:columnmove_strict_wbege=0', 'let g:columnmove_fold_treatment=0']}, 'post' : {}
    \             },
    \
    \   "45"   : {'caption'     : 'space, empty, folded lines',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : ' ',
    \             'key_input'   : "j\<M-e>",
    \             'breaking'    : 7,
    \             'abort'       : 0,
    \             'pre' : {'commands' : ['let g:columnmove_strict_wbege=0', 'let g:columnmove_fold_treatment=0']}, 'post' : {}
    \             },
    \
    \   "46"   : {'caption'     : 'iskeyword, space, folded lines',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : 'b',
    \             'key_input'   : "2j\<M-e>",
    \             'breaking'    : 8,
    \             'abort'       : 0,
    \             'pre' : {'commands' : ['let g:columnmove_strict_wbege=0', 'let g:columnmove_fold_treatment=1']}, 'post' : {}
    \             },
    \
    \   "47"   : {'caption'     : 'iskeyword, not-iskeyword, folded lines',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : 'b',
    \             'key_input'   : "2j\<M-e>",
    \             'breaking'    : 8,
    \             'abort'       : 0,
    \             'pre' : {'commands' : ['let g:columnmove_strict_wbege=0', 'let g:columnmove_fold_treatment=1']}, 'post' : {}
    \             },
    \
    \   "48"   : {'caption'     : 'iskeyword, empty, folded lines',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : 'b',
    \             'key_input'   : "2j\<M-e>",
    \             'breaking'    : 8,
    \             'abort'       : 0,
    \             'pre' : {'commands' : ['let g:columnmove_strict_wbege=0', 'let g:columnmove_fold_treatment=1']}, 'post' : {}
    \             },
    \
    \   "49"   : {'caption'     : 'not-iskeyword, space, folded lines',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : ':',
    \             'key_input'   : "2j\<M-e>",
    \             'breaking'    : 8,
    \             'abort'       : 0,
    \             'pre' : {'commands' : ['let g:columnmove_strict_wbege=0', 'let g:columnmove_fold_treatment=1']}, 'post' : {}
    \             },
    \
    \   "50"   : {'caption'     : 'not-iskeyword, iskeyword, folded lines',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : ':',
    \             'key_input'   : "2j\<M-e>",
    \             'breaking'    : 8,
    \             'abort'       : 0,
    \             'pre' : {'commands' : ['let g:columnmove_strict_wbege=0', 'let g:columnmove_fold_treatment=1']}, 'post' : {}
    \             },
    \
    \   "51"   : {'caption'     : 'not-iskeyword, empty, folded lines',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : ':',
    \             'key_input'   : "2j\<M-e>",
    \             'breaking'    : 8,
    \             'abort'       : 0,
    \             'pre' : {'commands' : ['let g:columnmove_strict_wbege=0', 'let g:columnmove_fold_treatment=1']}, 'post' : {}
    \             },
    \
    \   "52"  : {'caption'     : 'space, iskeyword, folded lines',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : ' ',
    \             'key_input'   : "2j\<M-e>",
    \             'breaking'    : 8,
    \             'abort'       : 0,
    \             'pre' : {'commands' : ['let g:columnmove_strict_wbege=0', 'let g:columnmove_fold_treatment=1']}, 'post' : {}
    \             },
    \
    \   "53"  : {'caption'     : 'space, not-iskeyword, folded lines',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : ' ',
    \             'key_input'   : "2j\<M-e>",
    \             'breaking'    : 8,
    \             'abort'       : 0,
    \             'pre' : {'commands' : ['let g:columnmove_strict_wbege=0', 'let g:columnmove_fold_treatment=1']}, 'post' : {}
    \             },
    \
    \   "54"  : {'caption'     : 'space, empty, folded lines',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : ' ',
    \             'key_input'   : "2j\<M-e>",
    \             'breaking'    : 8,
    \             'abort'       : 0,
    \             'pre' : {'commands' : ['let g:columnmove_strict_wbege=0', 'let g:columnmove_fold_treatment=1']}, 'post' : {}
    \             },
    \
    \   "55"   : {'caption'     : 'fold opening',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : 'b',
    \             'key_input'   : "2j\<M-e>",
    \             'breaking'    : 9,
    \             'abort'       : 0,
    \             'pre' : {'commands' : ['let g:columnmove_strict_wbege=1', 'let g:columnmove_fold_treatment=0', 'let g:columnmove_fold_open=1']}, 'post' : {}
    \             },
    \
    \   "56"   : {'caption'     : 'fold opening',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : 'b',
    \             'key_input'   : "2j\<M-e>",
    \             'breaking'    : 9,
    \             'abort'       : 0,
    \             'pre' : {'commands' : ['let g:columnmove_strict_wbege=1', 'let g:columnmove_fold_treatment=0', 'let g:columnmove_fold_open=1']}, 'post' : {}
    \             },
    \
    \   "57"   : {'caption'     : 'fold opening',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : 'b',
    \             'key_input'   : "2j\<M-e>",
    \             'breaking'    : 9,
    \             'abort'       : 0,
    \             'pre' : {'commands' : ['let g:columnmove_strict_wbege=0', 'let g:columnmove_fold_treatment=0', 'let g:columnmove_fold_open=1']}, 'post' : {}
    \             },
    \
    \   "58"   : {'caption'     : 'folded lines',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : 'b',
    \             'key_input'   : "2j\<M-e>",
    \             'breaking'    : 11,
    \             'abort'       : 0,
    \             'pre' : {'commands' : ['let g:columnmove_strict_wbege=0', 'let g:columnmove_fold_treatment=0', 'let g:columnmove_fold_open=0']}, 'post' : {}
    \             },
    \
    \   "59"   : {'caption'     : 'folded lines',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : 'h',
    \             'key_input'   : "3j\<M-e>",
    \             'breaking'    : 13,
    \             'abort'       : 0,
    \             'pre' : {'commands' : ['let g:columnmove_strict_wbege=0', 'let g:columnmove_fold_treatment=0', 'let g:columnmove_fold_open=1']}, 'post' : {}
    \             },
    \
    \   "60"   : {'caption'     : 'preserved column position at line end',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : 'k',
    \             'key_input'   : "$j\<M-e>",
    \             'breaking'    : 2,
    \             'abort'       : 0,
    \             'pre' : {'commands' : ['let g:columnmove_strict_wbege=1']}, 'post' : {}
    \             },
    \
    \   "61"   : {'caption'     : 'preserved column position at line end',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : 'k',
    \             'key_input'   : "$j\<M-e>",
    \             'breaking'    : 2,
    \             'abort'       : 0,
    \             'pre' : {'commands' : ['let g:columnmove_strict_wbege=0']}, 'post' : {}
    \             },
    \
    \   "post" : {'breaking' : 1, 'commands' : ['let g:columnmove_strict_wbege=0', 'let g:columnmove_fold_treatment=1']},
    \   }

let test_info.10      = {
    \   "pre"  : {'breaking' : 1 , 'commands' : [':let g:columnmove_fold_open=0', ':let g:columnmove_expand_range=0', ':let g:columnmove_fold_treatment=0']},
    \   "1"    : {'caption'     : 'iskeyword, space',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : 'b',
    \             'key_input'   : "5j\<M-g>e",
    \             'breaking'    : 5,
    \             'abort'       : 0,
    \             'pre' : {'commands' : 'let g:columnmove_strict_wbege=1'}, 'post' : {}
    \             },
    \
    \   "2"    : {'caption'     : 'iskeyword, not-iskeyword',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : ';',
    \             'key_input'   : "5j\<M-g>e",
    \             'breaking'    : 5,
    \             'abort'       : 0,
    \             'pre' : {'commands' : 'let g:columnmove_strict_wbege=1'}, 'post' : {}
    \             },
    \
    \   "3"    : {'caption'     : 'iskeyword, empty',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : 'b',
    \             'key_input'   : "5j\<M-g>e",
    \             'breaking'    : 5,
    \             'abort'       : 0,
    \             'pre' : {'commands' : 'let g:columnmove_strict_wbege=1'}, 'post' : {}
    \             },
    \
    \   "4"    : {'caption'     : 'not-iskeyword, space',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : ':',
    \             'key_input'   : "5j\<M-g>e",
    \             'breaking'    : 5,
    \             'abort'       : 0,
    \             'pre' : {'commands' : 'let g:columnmove_strict_wbege=1'}, 'post' : {}
    \             },
    \
    \   "5"    : {'caption'     : 'not-iskeyword, iskeyword',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : 'a',
    \             'key_input'   : "5j\<M-g>e",
    \             'breaking'    : 5,
    \             'abort'       : 0,
    \             'pre' : {'commands' : 'let g:columnmove_strict_wbege=1'}, 'post' : {}
    \             },
    \
    \   "6"    : {'caption'     : 'not-iskeyword, empty',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : ':',
    \             'key_input'   : "5j\<M-g>e",
    \             'breaking'    : 5,
    \             'abort'       : 0,
    \             'pre' : {'commands' : 'let g:columnmove_strict_wbege=1'}, 'post' : {}
    \             },
    \
    \   "7"    : {'caption'     : 'space, iskeyword',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : 'a',
    \             'key_input'   : "5j\<M-g>e",
    \             'breaking'    : 5,
    \             'abort'       : 0,
    \             'pre' : {'commands' : 'let g:columnmove_strict_wbege=1'}, 'post' : {}
    \             },
    \
    \   "8"    : {'caption'     : 'space, not-iskeyword',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : ';',
    \             'key_input'   : "5j\<M-g>e",
    \             'breaking'    : 5,
    \             'abort'       : 0,
    \             'pre' : {'commands' : 'let g:columnmove_strict_wbege=1'}, 'post' : {}
    \             },
    \
    \   "9"    : {'caption'     : 'space, empty',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : 'a',
    \             'key_input'   : "6j\<M-g>e",
    \             'breaking'    : 6,
    \             'abort'       : 0,
    \             'pre' : {'commands' : 'let g:columnmove_strict_wbege=1'}, 'post' : {}
    \             },
    \
    \   "10"   : {'caption'     : 'iskeyword, space, folded lines',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : 'b',
    \             'key_input'   : "5j\<M-g>e",
    \             'breaking'    : 6,
    \             'abort'       : 0,
    \             'pre' : {'commands' : ['let g:columnmove_strict_wbege=1', ':let g:columnmove_fold_treatment=0']}, 'post' : {}
    \             },
    \
    \   "11"   : {'caption'     : 'iskeyword, not-iskeyword, folded lines',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : ';',
    \             'key_input'   : "5j\<M-g>e",
    \             'breaking'    : 6,
    \             'abort'       : 0,
    \             'pre' : {'commands' : 'let g:columnmove_strict_wbege=1'}, 'post' : {}
    \             },
    \
    \   "12"   : {'caption'     : 'iskeyword, empty, folded lines',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : 'b',
    \             'key_input'   : "4j\<M-g>e",
    \             'breaking'    : 6,
    \             'abort'       : 0,
    \             'pre' : {'commands' : 'let g:columnmove_strict_wbege=1'}, 'post' : {}
    \             },
    \
    \   "13"   : {'caption'     : 'not-iskeyword, space, folded lines',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : ':',
    \             'key_input'   : "5j\<M-g>e",
    \             'breaking'    : 6,
    \             'abort'       : 0,
    \             'pre' : {'commands' : 'let g:columnmove_strict_wbege=1'}, 'post' : {}
    \             },
    \
    \   "14"   : {'caption'     : 'not-iskeyword, iskeyword, folded lines',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : 'a',
    \             'key_input'   : "5j\<M-g>e",
    \             'breaking'    : 6,
    \             'abort'       : 0,
    \             'pre' : {'commands' : 'let g:columnmove_strict_wbege=1'}, 'post' : {}
    \             },
    \
    \   "15"   : {'caption'     : 'not-iskeyword, empty, folded lines',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : ':',
    \             'key_input'   : "5j\<M-g>e",
    \             'breaking'    : 6,
    \             'abort'       : 0,
    \             'pre' : {'commands' : 'let g:columnmove_strict_wbege=1'}, 'post' : {}
    \             },
    \
    \   "16"   : {'caption'     : 'space, iskeyword, folded lines',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : 'a',
    \             'key_input'   : "5j\<M-g>e",
    \             'breaking'    : 6,
    \             'abort'       : 0,
    \             'pre' : {'commands' : 'let g:columnmove_strict_wbege=1'}, 'post' : {}
    \             },
    \
    \   "17"   : {'caption'     : 'space, not-iskeyword, folded lines',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : ';',
    \             'key_input'   : "5j\<M-g>e",
    \             'breaking'    : 6,
    \             'abort'       : 0,
    \             'pre' : {'commands' : 'let g:columnmove_strict_wbege=1'}, 'post' : {}
    \             },
    \
    \   "18"   : {'caption'     : 'space, empty, folded lines',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : 'a',
    \             'key_input'   : "5j\<M-g>e",
    \             'breaking'    : 6,
    \             'abort'       : 0,
    \             'pre' : {'commands' : 'let g:columnmove_strict_wbege=1'}, 'post' : {}
    \             },
    \
    \   "19"   : {'caption'     : 'iskeyword, space, folded lines',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : 'b',
    \             'key_input'   : "6j\<M-g>e",
    \             'breaking'    : 7,
    \             'abort'       : 0,
    \             'pre' : {'commands' : ['let g:columnmove_strict_wbege=1', 'let g:columnmove_fold_treatment=1']}, 'post' : {}
    \             },
    \
    \   "20"   : {'caption'     : 'iskeyword, not-iskeyword, folded lines',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : 'b',
    \             'key_input'   : "6j\<M-g>e",
    \             'breaking'    : 7,
    \             'abort'       : 0,
    \             'pre' : {'commands' : ['let g:columnmove_strict_wbege=1', 'let g:columnmove_fold_treatment=1']}, 'post' : {}
    \             },
    \
    \   "21"   : {'caption'     : 'iskeyword, empty, folded lines',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : 'b',
    \             'key_input'   : "6j\<M-g>e",
    \             'breaking'    : 7,
    \             'abort'       : 0,
    \             'pre' : {'commands' : ['let g:columnmove_strict_wbege=1', 'let g:columnmove_fold_treatment=1']}, 'post' : {}
    \             },
    \
    \   "22"   : {'caption'     : 'not-iskeyword, space, folded lines',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : ':',
    \             'key_input'   : "6j\<M-g>e",
    \             'breaking'    : 7,
    \             'abort'       : 0,
    \             'pre' : {'commands' : ['let g:columnmove_strict_wbege=1', 'let g:columnmove_fold_treatment=1']}, 'post' : {}
    \             },
    \
    \   "23"   : {'caption'     : 'not-iskeyword, iskeyword, folded lines',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : ':',
    \             'key_input'   : "6j\<M-g>e",
    \             'breaking'    : 7,
    \             'abort'       : 0,
    \             'pre' : {'commands' : ['let g:columnmove_strict_wbege=1', 'let g:columnmove_fold_treatment=1']}, 'post' : {}
    \             },
    \
    \   "24"   : {'caption'     : 'not-iskeyword, empty, folded lines',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : ':',
    \             'key_input'   : "6j\<M-g>e",
    \             'breaking'    : 7,
    \             'abort'       : 0,
    \             'pre' : {'commands' : ['let g:columnmove_strict_wbege=1', 'let g:columnmove_fold_treatment=1']}, 'post' : {}
    \             },
    \
    \   "25"   : {'caption'     : 'space, iskeyword, folded lines',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : 'a',
    \             'key_input'   : "6j\<M-g>e",
    \             'breaking'    : 7,
    \             'abort'       : 0,
    \             'pre' : {'commands' : ['let g:columnmove_strict_wbege=1', 'let g:columnmove_fold_treatment=1']}, 'post' : {}
    \             },
    \
    \   "26"   : {'caption'     : 'space, not-iskeyword, folded lines',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : ';',
    \             'key_input'   : "6j\<M-g>e",
    \             'breaking'    : 7,
    \             'abort'       : 0,
    \             'pre' : {'commands' : ['let g:columnmove_strict_wbege=1', 'let g:columnmove_fold_treatment=1']}, 'post' : {}
    \             },
    \
    \   "27"   : {'caption'     : 'space, empty, folded lines',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : 'a',
    \             'key_input'   : "6j\<M-g>e",
    \             'breaking'    : 7,
    \             'abort'       : 0,
    \             'pre' : {'commands' : ['let g:columnmove_strict_wbege=1', 'let g:columnmove_fold_treatment=1']}, 'post' : {}
    \             },
    \
    \   "28"   : {'caption'     : 'iskeyword, space',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : 'b',
    \             'key_input'   : "9j\<M-g>e",
    \             'breaking'    : 9,
    \             'abort'       : 0,
    \             'pre' : {'commands' : ['let g:columnmove_strict_wbege=0', 'let g:columnmove_fold_treatment=0']}, 'post' : {}
    \             },
    \
    \   "29"   : {'caption'     : 'iskeyword, not-iskeyword',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : 'b',
    \             'key_input'   : "9j\<M-g>e",
    \             'breaking'    : 9,
    \             'abort'       : 0,
    \             'pre' : {'commands' : ['let g:columnmove_strict_wbege=0', 'let g:columnmove_fold_treatment=0']}, 'post' : {}
    \             },
    \
    \   "30"   : {'caption'     : 'iskeyword, empty',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : 'b',
    \             'key_input'   : "5j\<M-g>e",
    \             'breaking'    : 6,
    \             'abort'       : 0,
    \             'pre' : {'commands' : ['let g:columnmove_strict_wbege=0', 'let g:columnmove_fold_treatment=0']}, 'post' : {}
    \             },
    \
    \   "31"   : {'caption'     : 'not-iskeyword, space',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : ':',
    \             'key_input'   : "9j\<M-g>e",
    \             'breaking'    : 9,
    \             'abort'       : 0,
    \             'pre' : {'commands' : ['let g:columnmove_strict_wbege=0', 'let g:columnmove_fold_treatment=0']}, 'post' : {}
    \             },
    \
    \   "32"   : {'caption'     : 'not-iskeyword, iskeyword',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : '\',
    \             'key_input'   : "9j\<M-g>e",
    \             'breaking'    : 9,
    \             'abort'       : 0,
    \             'pre' : {'commands' : ['let g:columnmove_strict_wbege=0', 'let g:columnmove_fold_treatment=0']}, 'post' : {}
    \             },
    \
    \   "33"   : {'caption'     : 'not-iskeyword, empty',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : ':',
    \             'key_input'   : "6j\<M-g>e",
    \             'breaking'    : 6,
    \             'abort'       : 0,
    \             'pre' : {'commands' : ['let g:columnmove_strict_wbege=0', 'let g:columnmove_fold_treatment=0']}, 'post' : {}
    \             },
    \
    \   "34"   : {'caption'     : 'space, iskeyword',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : 'a',
    \             'key_input'   : "9j\<M-g>e",
    \             'breaking'    : 9,
    \             'abort'       : 0,
    \             'pre' : {'commands' : ['let g:columnmove_strict_wbege=0', 'let g:columnmove_fold_treatment=0']}, 'post' : {}
    \             },
    \
    \   "35"   : {'caption'     : 'space, not-iskeyword',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : ';',
    \             'key_input'   : "9j\<M-g>e",
    \             'breaking'    : 9,
    \             'abort'       : 0,
    \             'pre' : {'commands' : ['let g:columnmove_strict_wbege=0', 'let g:columnmove_fold_treatment=0']}, 'post' : {}
    \             },
    \
    \   "36"   : {'caption'     : 'space, empty',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : 'a',
    \             'key_input'   : "7j\<M-g>e",
    \             'breaking'    : 7,
    \             'abort'       : 0,
    \             'pre' : {'commands' : ['let g:columnmove_strict_wbege=0', 'let g:columnmove_fold_treatment=0']}, 'post' : {}
    \             },
    \
    \   "37"  : {'caption'     : 'iskeyword, space, folded lines',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : 'b',
    \             'key_input'   : "8j\<M-g>e",
    \             'breaking'    : 10,
    \             'abort'       : 0,
    \             'pre' : {'commands' : ['let g:columnmove_strict_wbege=0', 'let g:columnmove_fold_treatment=0']}, 'post' : {}
    \             },
    \
    \   "38"   : {'caption'     : 'iskeyword, not-iskeyword, folded lines',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : 'b',
    \             'key_input'   : "7j\<M-g>e",
    \             'breaking'    : 10,
    \             'abort'       : 0,
    \             'pre' : {'commands' : ['let g:columnmove_strict_wbege=0', 'let g:columnmove_fold_treatment=0']}, 'post' : {}
    \             },
    \
    \   "39"   : {'caption'     : 'iskeyword, empty, folded lines',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : 'b',
    \             'key_input'   : "5j\<M-g>e",
    \             'breaking'    : 7,
    \             'abort'       : 0,
    \             'pre' : {'commands' : ['let g:columnmove_strict_wbege=0', 'let g:columnmove_fold_treatment=0']}, 'post' : {}
    \             },
    \
    \   "40"   : {'caption'     : 'not-iskeyword, space, folded lines',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : ' ',
    \             'key_input'   : "9j\<M-g>e",
    \             'breaking'    : 10,
    \             'abort'       : 0,
    \             'pre' : {'commands' : ['let g:columnmove_strict_wbege=0', 'let g:columnmove_fold_treatment=0']}, 'post' : {}
    \             },
    \
    \   "41"   : {'caption'     : 'not-iskeyword, iskeyword, folded lines',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : 'a',
    \             'key_input'   : "9j\<M-g>e",
    \             'breaking'    : 10,
    \             'abort'       : 0,
    \             'pre' : {'commands' : ['let g:columnmove_strict_wbege=0', 'let g:columnmove_fold_treatment=0']}, 'post' : {}
    \             },
    \
    \   "42"   : {'caption'     : 'not-iskeyword, empty, folded lines',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : ';',
    \             'key_input'   : "6j\<M-g>e",
    \             'breaking'    : 7,
    \             'abort'       : 0,
    \             'pre' : {'commands' : ['let g:columnmove_strict_wbege=0', 'let g:columnmove_fold_treatment=0']}, 'post' : {}
    \             },
    \
    \   "43"   : {'caption'     : 'space, iskeyword, folded lines',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : 'a',
    \             'key_input'   : "8j\<M-g>e",
    \             'breaking'    : 10,
    \             'abort'       : 0,
    \             'pre' : {'commands' : ['let g:columnmove_strict_wbege=0', 'let g:columnmove_fold_treatment=0']}, 'post' : {}
    \             },
    \
    \   "44"   : {'caption'     : 'space, not-iskeyword, folded lines',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : ';',
    \             'key_input'   : "8j\<M-g>e",
    \             'breaking'    : 10,
    \             'abort'       : 0,
    \             'pre' : {'commands' : ['let g:columnmove_strict_wbege=0', 'let g:columnmove_fold_treatment=0']}, 'post' : {}
    \             },
    \
    \   "45"   : {'caption'     : 'space, empty, folded lines',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : ' ',
    \             'key_input'   : "7j\<M-g>e",
    \             'breaking'    : 8,
    \             'abort'       : 0,
    \             'pre' : {'commands' : ['let g:columnmove_strict_wbege=0', 'let g:columnmove_fold_treatment=0']}, 'post' : {}
    \             },
    \
    \   "46"   : {'caption'     : 'iskeyword, space, folded lines',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : ' ',
    \             'key_input'   : "8j\<M-g>e",
    \             'breaking'    : 9,
    \             'abort'       : 0,
    \             'pre' : {'commands' : ['let g:columnmove_strict_wbege=0', 'let g:columnmove_fold_treatment=1']}, 'post' : {}
    \             },
    \
    \   "47"   : {'caption'     : 'iskeyword, not-iskeyword, folded lines',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : ';',
    \             'key_input'   : "8j\<M-g>e",
    \             'breaking'    : 9,
    \             'abort'       : 0,
    \             'pre' : {'commands' : ['let g:columnmove_strict_wbege=0', 'let g:columnmove_fold_treatment=1']}, 'post' : {}
    \             },
    \
    \   "48"   : {'caption'     : 'iskeyword, empty, folded lines',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : 'b',
    \             'key_input'   : "7j\<M-g>e",
    \             'breaking'    : 8,
    \             'abort'       : 0,
    \             'pre' : {'commands' : ['let g:columnmove_strict_wbege=0', 'let g:columnmove_fold_treatment=1']}, 'post' : {}
    \             },
    \
    \   "49"   : {'caption'     : 'not-iskeyword, space, folded lines',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : ';',
    \             'key_input'   : "8j\<M-g>e",
    \             'breaking'    : 9,
    \             'abort'       : 0,
    \             'pre' : {'commands' : ['let g:columnmove_strict_wbege=0', 'let g:columnmove_fold_treatment=1']}, 'post' : {}
    \             },
    \
    \   "50"   : {'caption'     : 'not-iskeyword, iskeyword, folded lines',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : ':',
    \             'key_input'   : "8j\<M-g>e",
    \             'breaking'    : 9,
    \             'abort'       : 0,
    \             'pre' : {'commands' : ['let g:columnmove_strict_wbege=0', 'let g:columnmove_fold_treatment=1']}, 'post' : {}
    \             },
    \
    \   "51"   : {'caption'     : 'not-iskeyword, empty, folded lines',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : ':',
    \             'key_input'   : "7j\<M-g>e",
    \             'breaking'    : 8,
    \             'abort'       : 0,
    \             'pre' : {'commands' : ['let g:columnmove_strict_wbege=0', 'let g:columnmove_fold_treatment=1']}, 'post' : {}
    \             },
    \
    \   "52"  : {'caption'     : 'space, iskeyword, folded lines',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : 'a',
    \             'key_input'   : "8j\<M-g>e",
    \             'breaking'    : 9,
    \             'abort'       : 0,
    \             'pre' : {'commands' : ['let g:columnmove_strict_wbege=0', 'let g:columnmove_fold_treatment=1']}, 'post' : {}
    \             },
    \
    \   "53"  : {'caption'     : 'space, not-iskeyword, folded lines',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : ';',
    \             'key_input'   : "8j\<M-g>e",
    \             'breaking'    : 9,
    \             'abort'       : 0,
    \             'pre' : {'commands' : ['let g:columnmove_strict_wbege=0', 'let g:columnmove_fold_treatment=1']}, 'post' : {}
    \             },
    \
    \   "54"  : {'caption'     : 'space, empty, folded lines',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : ' ',
    \             'key_input'   : "6j\<M-g>e",
    \             'breaking'    : 8,
    \             'abort'       : 0,
    \             'pre' : {'commands' : ['let g:columnmove_strict_wbege=0', 'let g:columnmove_fold_treatment=1']}, 'post' : {}
    \             },
    \
    \   "55"   : {'caption'     : 'fold opening',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : ';',
    \             'key_input'   : "7j\<M-g>e",
    \             'breaking'    : 9,
    \             'abort'       : 0,
    \             'pre' : {'commands' : ['let g:columnmove_strict_wbege=1', 'let g:columnmove_fold_treatment=0', 'let g:columnmove_fold_open=1']}, 'post' : {}
    \             },
    \
    \   "56"   : {'caption'     : 'fold opening',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : 'd',
    \             'key_input'   : "7j\<M-g>e",
    \             'breaking'    : 9,
    \             'abort'       : 0,
    \             'pre' : {'commands' : ['let g:columnmove_strict_wbege=1', 'let g:columnmove_fold_treatment=0', 'let g:columnmove_fold_open=1']}, 'post' : {}
    \             },
    \
    \   "57"   : {'caption'     : 'fold opening',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : 'd',
    \             'key_input'   : "7j\<M-g>e",
    \             'breaking'    : 9,
    \             'abort'       : 0,
    \             'pre' : {'commands' : ['let g:columnmove_strict_wbege=0', 'let g:columnmove_fold_treatment=0', 'let g:columnmove_fold_open=1']}, 'post' : {}
    \             },
    \
    \   "58"   : {'caption'     : 'folded lines',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : 'b',
    \             'key_input'   : "7j\<M-g>e",
    \             'breaking'    : 13,
    \             'abort'       : 0,
    \             'pre' : {'commands' : ['let g:columnmove_strict_wbege=0', 'let g:columnmove_fold_treatment=0', 'let g:columnmove_fold_open=1']}, 'post' : {}
    \             },
    \
    \   "59"   : {'caption'     : 'preserved column position at line end',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : 'c',
    \             'key_input'   : "3j$k\<M-g>e",
    \             'breaking'    : 3,
    \             'abort'       : 0,
    \             'pre' : {'commands' : ['let g:columnmove_strict_wbege=1']}, 'post' : {}
    \             },
    \
    \   "60"   : {'caption'     : 'preserved column position at line end',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : 'c',
    \             'key_input'   : "3j$k\<M-g>e",
    \             'breaking'    : 3,
    \             'abort'       : 0,
    \             'pre' : {'commands' : ['let g:columnmove_strict_wbege=0']}, 'post' : {}
    \             },
    \
    \   }

let test_info.11      = {
    \   "pre"  : {'breaking' : 1 , 'commands' : [':let g:columnmove_fold_open=0', ':let g:columnmove_expand_range=0', ':let g:columnmove_fold_treatment=0']},
    \   "1"    : {'caption'     : 'iskeyword, space',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : 'd',
    \             'key_input'   : "\<M-W>",
    \             'breaking'    : 5,
    \             'abort'       : 0,
    \             'pre' : {'commands' : 'let g:columnmove_strict_wbege=1'}, 'post' : {}
    \             },
    \
    \   "2"    : {'caption'     : 'iskeyword, not-iskeyword',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : 'd',
    \             'key_input'   : "\<M-W>",
    \             'breaking'    : 6,
    \             'abort'       : 0,
    \             'pre' : {'commands' : 'let g:columnmove_strict_wbege=1'}, 'post' : {}
    \             },
    \
    \   "3"    : {'caption'     : 'iskeyword, empty',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : 'd',
    \             'key_input'   : "\<M-W>",
    \             'breaking'    : 5,
    \             'abort'       : 0,
    \             'pre' : {'commands' : 'let g:columnmove_strict_wbege=1'}, 'post' : {}
    \             },
    \
    \   "4"    : {'caption'     : 'not-iskeyword, space',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : '/',
    \             'key_input'   : "\<M-W>",
    \             'breaking'    : 5,
    \             'abort'       : 0,
    \             'pre' : {'commands' : 'let g:columnmove_strict_wbege=1'}, 'post' : {}
    \             },
    \
    \   "5"    : {'caption'     : 'not-iskeyword, iskeyword',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : '/',
    \             'key_input'   : "\<M-W>",
    \             'breaking'    : 6,
    \             'abort'       : 0,
    \             'pre' : {'commands' : 'let g:columnmove_strict_wbege=1'}, 'post' : {}
    \             },
    \
    \   "6"    : {'caption'     : 'not-iskeyword, empty',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : '/',
    \             'key_input'   : "\<M-W>",
    \             'breaking'    : 5,
    \             'abort'       : 0,
    \             'pre' : {'commands' : 'let g:columnmove_strict_wbege=1'}, 'post' : {}
    \             },
    \
    \   "7"    : {'caption'     : 'space, iskeyword',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : 'a',
    \             'key_input'   : "\<M-W>",
    \             'breaking'    : 5,
    \             'abort'       : 0,
    \             'pre' : {'commands' : 'let g:columnmove_strict_wbege=1'}, 'post' : {}
    \             },
    \
    \   "8"    : {'caption'     : 'space, not-iskeyword',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : ';',
    \             'key_input'   : "\<M-W>",
    \             'breaking'    : 5,
    \             'abort'       : 0,
    \             'pre' : {'commands' : 'let g:columnmove_strict_wbege=1'}, 'post' : {}
    \             },
    \
    \   "9"    : {'caption'     : 'space, empty',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : 'a',
    \             'key_input'   : "\<M-W>",
    \             'breaking'    : 6,
    \             'abort'       : 0,
    \             'pre' : {'commands' : 'let g:columnmove_strict_wbege=1'}, 'post' : {}
    \             },
    \
    \   "10"   : {'caption'     : 'iskeyword, space, folded lines',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : 'e',
    \             'key_input'   : "\<M-W>",
    \             'breaking'    : 6,
    \             'abort'       : 0,
    \             'pre' : {'commands' : ['let g:columnmove_strict_wbege=1', ':let g:columnmove_fold_treatment=0']}, 'post' : {}
    \             },
    \
    \   "11"   : {'caption'     : 'iskeyword, not-iskeyword, folded lines',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : 'e',
    \             'key_input'   : "\<M-W>",
    \             'breaking'    : 7,
    \             'abort'       : 0,
    \             'pre' : {'commands' : 'let g:columnmove_strict_wbege=1'}, 'post' : {}
    \             },
    \
    \   "12"   : {'caption'     : 'iskeyword, empty, folded lines',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : 'e',
    \             'key_input'   : "\<M-W>",
    \             'breaking'    : 6,
    \             'abort'       : 0,
    \             'pre' : {'commands' : 'let g:columnmove_strict_wbege=1'}, 'post' : {}
    \             },
    \
    \   "13"   : {'caption'     : 'not-iskeyword, space, folded lines',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : '\',
    \             'key_input'   : "\<M-W>",
    \             'breaking'    : 6,
    \             'abort'       : 0,
    \             'pre' : {'commands' : 'let g:columnmove_strict_wbege=1'}, 'post' : {}
    \             },
    \
    \   "14"   : {'caption'     : 'not-iskeyword, iskeyword, folded lines',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : '\',
    \             'key_input'   : "\<M-W>",
    \             'breaking'    : 7,
    \             'abort'       : 0,
    \             'pre' : {'commands' : 'let g:columnmove_strict_wbege=1'}, 'post' : {}
    \             },
    \
    \   "15"   : {'caption'     : 'not-iskeyword, empty, folded lines',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : '\',
    \             'key_input'   : "\<M-W>",
    \             'breaking'    : 6,
    \             'abort'       : 0,
    \             'pre' : {'commands' : 'let g:columnmove_strict_wbege=1'}, 'post' : {}
    \             },
    \
    \   "16"   : {'caption'     : 'space, iskeyword, folded lines',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : 'a',
    \             'key_input'   : "\<M-W>",
    \             'breaking'    : 6,
    \             'abort'       : 0,
    \             'pre' : {'commands' : 'let g:columnmove_strict_wbege=1'}, 'post' : {}
    \             },
    \
    \   "17"   : {'caption'     : 'space, not-iskeyword, folded lines',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : ';',
    \             'key_input'   : "\<M-W>",
    \             'breaking'    : 6,
    \             'abort'       : 0,
    \             'pre' : {'commands' : 'let g:columnmove_strict_wbege=1'}, 'post' : {}
    \             },
    \
    \   "18"   : {'caption'     : 'space, empty, folded lines',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : 'a',
    \             'key_input'   : "\<M-W>",
    \             'breaking'    : 6,
    \             'abort'       : 0,
    \             'pre' : {'commands' : 'let g:columnmove_strict_wbege=1'}, 'post' : {}
    \             },
    \
    \   "19"   : {'caption'     : 'iskeyword, space, folded lines',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : 'd',
    \             'key_input'   : "j\<M-W>",
    \             'breaking'    : 7,
    \             'abort'       : 0,
    \             'pre' : {'commands' : ['let g:columnmove_strict_wbege=1', 'let g:columnmove_fold_treatment=1']}, 'post' : {}
    \             },
    \
    \   "20"   : {'caption'     : 'iskeyword, not-iskeyword, folded lines',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : 'd',
    \             'key_input'   : "j\<M-W>",
    \             'breaking'    : 7,
    \             'abort'       : 0,
    \             'pre' : {'commands' : ['let g:columnmove_strict_wbege=1', 'let g:columnmove_fold_treatment=1']}, 'post' : {}
    \             },
    \
    \   "21"   : {'caption'     : 'iskeyword, empty, folded lines',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : 'd',
    \             'key_input'   : "j\<M-W>",
    \             'breaking'    : 7,
    \             'abort'       : 0,
    \             'pre' : {'commands' : ['let g:columnmove_strict_wbege=1', 'let g:columnmove_fold_treatment=1']}, 'post' : {}
    \             },
    \
    \   "22"   : {'caption'     : 'not-iskeyword, space, folded lines',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : '/',
    \             'key_input'   : "j\<M-W>",
    \             'breaking'    : 7,
    \             'abort'       : 0,
    \             'pre' : {'commands' : ['let g:columnmove_strict_wbege=1', 'let g:columnmove_fold_treatment=1']}, 'post' : {}
    \             },
    \
    \   "23"   : {'caption'     : 'not-iskeyword, iskeyword, folded lines',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : '/',
    \             'key_input'   : "j\<M-W>",
    \             'breaking'    : 7,
    \             'abort'       : 0,
    \             'pre' : {'commands' : ['let g:columnmove_strict_wbege=1', 'let g:columnmove_fold_treatment=1']}, 'post' : {}
    \             },
    \
    \   "24"   : {'caption'     : 'not-iskeyword, empty, folded lines',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : '/',
    \             'key_input'   : "j\<M-W>",
    \             'breaking'    : 7,
    \             'abort'       : 0,
    \             'pre' : {'commands' : ['let g:columnmove_strict_wbege=1', 'let g:columnmove_fold_treatment=1']}, 'post' : {}
    \             },
    \
    \   "25"   : {'caption'     : 'space, iskeyword, folded lines',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : 'a',
    \             'key_input'   : "j\<M-W>",
    \             'breaking'    : 7,
    \             'abort'       : 0,
    \             'pre' : {'commands' : ['let g:columnmove_strict_wbege=1', 'let g:columnmove_fold_treatment=1']}, 'post' : {}
    \             },
    \
    \   "26"   : {'caption'     : 'space, not-iskeyword, folded lines',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : ';',
    \             'key_input'   : "j\<M-W>",
    \             'breaking'    : 7,
    \             'abort'       : 0,
    \             'pre' : {'commands' : ['let g:columnmove_strict_wbege=1', 'let g:columnmove_fold_treatment=1']}, 'post' : {}
    \             },
    \
    \   "27"   : {'caption'     : 'space, empty, folded lines',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : 'a',
    \             'key_input'   : "j\<M-W>",
    \             'breaking'    : 7,
    \             'abort'       : 0,
    \             'pre' : {'commands' : ['let g:columnmove_strict_wbege=1', 'let g:columnmove_fold_treatment=1']}, 'post' : {}
    \             },
    \
    \   "28"   : {'caption'     : 'fold opening',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : ':',
    \             'key_input'   : "2j\<M-W>",
    \             'breaking'    : 11,
    \             'abort'       : 0,
    \             'pre' : {'commands' : ['let g:columnmove_strict_wbege=1', 'let g:columnmove_fold_treatment=0', 'let g:columnmove_fold_open=1']}, 'post' : {}
    \             },
    \
    \   "29"   : {'caption'     : 'fold opening',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : 'c',
    \             'key_input'   : "2j\<M-W>",
    \             'breaking'    : 9,
    \             'abort'       : 0,
    \             'pre' : {'commands' : ['let g:columnmove_strict_wbege=1', 'let g:columnmove_fold_treatment=0', 'let g:columnmove_fold_open=1']}, 'post' : {}
    \             },
    \
    \   "30"   : {'caption'     : 'fold opening',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : 'c',
    \             'key_input'   : "2j\<M-W>",
    \             'breaking'    : 9,
    \             'abort'       : 0,
    \             'pre' : {'commands' : ['let g:columnmove_strict_wbege=0', 'let g:columnmove_fold_treatment=0', 'let g:columnmove_fold_open=1']}, 'post' : {}
    \             },
    \
    \   "31"   : {'caption'     : 'folded lines',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : 'i',
    \             'key_input'   : "3j\<M-W>",
    \             'breaking'    : 15,
    \             'abort'       : 0,
    \             'pre' : {'commands' : ['let g:columnmove_strict_wbege=0', 'let g:columnmove_fold_treatment=0', 'let g:columnmove_fold_open=1']}, 'post' : {}
    \             },
    \
    \   "32"   : {'caption'     : 'preserved column position at line end',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : 'k',
    \             'key_input'   : "$j\<M-W>",
    \             'breaking'    : 2,
    \             'abort'       : 0,
    \             'pre' : {'commands' : ['let g:columnmove_strict_wbege=1']}, 'post' : {}
    \             },
    \
    \   "post" : {'breaking' : 2, 'commands' : ['let g:columnmove_strict_wbege=0', 'let g:columnmove_fold_treatment=1']},
    \   }

let test_info.12      = {
    \   "pre"  : {'breaking' : 0 , 'commands' : [':let g:columnmove_fold_open=0', ':let g:columnmove_expand_range=0', ':let g:columnmove_fold_treatment=0']},
    \   "1"    : {'caption'     : 'iskeyword, space',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : 'c',
    \             'key_input'   : "5j\<M-B>",
    \             'breaking'    : 5,
    \             'abort'       : 0,
    \             'pre' : {'commands' : 'let g:columnmove_strict_wbege=1'}, 'post' : {}
    \             },
    \
    \   "2"    : {'caption'     : 'iskeyword, not-iskeyword',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : 'a',
    \             'key_input'   : "6j\<M-B>",
    \             'breaking'    : 6,
    \             'abort'       : 0,
    \             'pre' : {'commands' : 'let g:columnmove_strict_wbege=1'}, 'post' : {}
    \             },
    \
    \   "3"    : {'caption'     : 'iskeyword, empty',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : 'd',
    \             'key_input'   : "5j\<M-B>",
    \             'breaking'    : 5,
    \             'abort'       : 0,
    \             'pre' : {'commands' : 'let g:columnmove_strict_wbege=1'}, 'post' : {}
    \             },
    \
    \   "4"    : {'caption'     : 'not-iskeyword, space',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : '/',
    \             'key_input'   : "5j\<M-B>",
    \             'breaking'    : 5,
    \             'abort'       : 0,
    \             'pre' : {'commands' : 'let g:columnmove_strict_wbege=1'}, 'post' : {}
    \             },
    \
    \   "5"    : {'caption'     : 'not-iskeyword, iskeyword',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : 'a',
    \             'key_input'   : "6j\<M-B>",
    \             'breaking'    : 6,
    \             'abort'       : 0,
    \             'pre' : {'commands' : 'let g:columnmove_strict_wbege=1'}, 'post' : {}
    \             },
    \
    \   "6"    : {'caption'     : 'not-iskeyword, empty',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : '/',
    \             'key_input'   : "5j\<M-B>",
    \             'breaking'    : 5,
    \             'abort'       : 0,
    \             'pre' : {'commands' : 'let g:columnmove_strict_wbege=1'}, 'post' : {}
    \             },
    \
    \   "7"    : {'caption'     : 'space, iskeyword',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : 'a',
    \             'key_input'   : "5j\<M-B>",
    \             'breaking'    : 5,
    \             'abort'       : 0,
    \             'pre' : {'commands' : 'let g:columnmove_strict_wbege=1'}, 'post' : {}
    \             },
    \
    \   "8"    : {'caption'     : 'space, not-iskeyword',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : ';',
    \             'key_input'   : "5j\<M-B>",
    \             'breaking'    : 5,
    \             'abort'       : 0,
    \             'pre' : {'commands' : 'let g:columnmove_strict_wbege=1'}, 'post' : {}
    \             },
    \
    \   "9"    : {'caption'     : 'space, empty',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : 'a',
    \             'key_input'   : "6j\<M-B>",
    \             'breaking'    : 6,
    \             'abort'       : 0,
    \             'pre' : {'commands' : 'let g:columnmove_strict_wbege=1'}, 'post' : {}
    \             },
    \
    \   "10"   : {'caption'     : 'iskeyword, space, folded lines',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : 'c',
    \             'key_input'   : "5j\<M-B>",
    \             'breaking'    : 6,
    \             'abort'       : 0,
    \             'pre' : {'commands' : ['let g:columnmove_strict_wbege=1', ':let g:columnmove_fold_treatment=0']}, 'post' : {}
    \             },
    \
    \   "11"   : {'caption'     : 'iskeyword, not-iskeyword, folded lines',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : 'a',
    \             'key_input'   : "6j\<M-B>",
    \             'breaking'    : 7,
    \             'abort'       : 0,
    \             'pre' : {'commands' : 'let g:columnmove_strict_wbege=1'}, 'post' : {}
    \             },
    \
    \   "12"   : {'caption'     : 'iskeyword, empty, folded lines',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : 'a',
    \             'key_input'   : "5j\<M-B>",
    \             'breaking'    : 7,
    \             'abort'       : 0,
    \             'pre' : {'commands' : 'let g:columnmove_strict_wbege=1'}, 'post' : {}
    \             },
    \
    \   "13"   : {'caption'     : 'not-iskeyword, space, folded lines',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : ']',
    \             'key_input'   : "5j\<M-B>",
    \             'breaking'    : 6,
    \             'abort'       : 0,
    \             'pre' : {'commands' : 'let g:columnmove_strict_wbege=1'}, 'post' : {}
    \             },
    \
    \   "14"   : {'caption'     : 'not-iskeyword, iskeyword, folded lines',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : ';',
    \             'key_input'   : "6j\<M-B>",
    \             'breaking'    : 7,
    \             'abort'       : 0,
    \             'pre' : {'commands' : 'let g:columnmove_strict_wbege=1'}, 'post' : {}
    \             },
    \
    \   "15"   : {'caption'     : 'not-iskeyword, empty, folded lines',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : ']',
    \             'key_input'   : "5j\<M-B>",
    \             'breaking'    : 6,
    \             'abort'       : 0,
    \             'pre' : {'commands' : 'let g:columnmove_strict_wbege=1'}, 'post' : {}
    \             },
    \
    \   "16"   : {'caption'     : 'space, iskeyword, folded lines',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : 'a',
    \             'key_input'   : "5j\<M-B>",
    \             'breaking'    : 6,
    \             'abort'       : 0,
    \             'pre' : {'commands' : 'let g:columnmove_strict_wbege=1'}, 'post' : {}
    \             },
    \
    \   "17"   : {'caption'     : 'space, not-iskeyword, folded lines',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : ';',
    \             'key_input'   : "5j\<M-B>",
    \             'breaking'    : 6,
    \             'abort'       : 0,
    \             'pre' : {'commands' : 'let g:columnmove_strict_wbege=1'}, 'post' : {}
    \             },
    \
    \   "18"   : {'caption'     : 'space, empty, folded lines',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : 'a',
    \             'key_input'   : "6j\<M-B>",
    \             'breaking'    : 7,
    \             'abort'       : 0,
    \             'pre' : {'commands' : 'let g:columnmove_strict_wbege=1'}, 'post' : {}
    \             },
    \
    \   "19"   : {'caption'     : 'iskeyword, space, folded lines',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : 'f',
    \             'key_input'   : "6j\<M-B>",
    \             'breaking'    : 7,
    \             'abort'       : 0,
    \             'pre' : {'commands' : ['let g:columnmove_strict_wbege=1', 'let g:columnmove_fold_treatment=1']}, 'post' : {}
    \             },
    \
    \   "20"   : {'caption'     : 'iskeyword, not-iskeyword, folded lines',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : ';',
    \             'key_input'   : "6j\<M-B>",
    \             'breaking'    : 7,
    \             'abort'       : 0,
    \             'pre' : {'commands' : ['let g:columnmove_strict_wbege=1', 'let g:columnmove_fold_treatment=1']}, 'post' : {}
    \             },
    \
    \   "21"   : {'caption'     : 'iskeyword, empty, folded lines',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : 'e',
    \             'key_input'   : "6j\<M-B>",
    \             'breaking'    : 7,
    \             'abort'       : 0,
    \             'pre' : {'commands' : ['let g:columnmove_strict_wbege=1', 'let g:columnmove_fold_treatment=1']}, 'post' : {}
    \             },
    \
    \   "22"   : {'caption'     : 'not-iskeyword, space, folded lines',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : '\',
    \             'key_input'   : "6j\<M-B>",
    \             'breaking'    : 7,
    \             'abort'       : 0,
    \             'pre' : {'commands' : ['let g:columnmove_strict_wbege=1', 'let g:columnmove_fold_treatment=1']}, 'post' : {}
    \             },
    \
    \   "23"   : {'caption'     : 'not-iskeyword, iskeyword, folded lines',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : '\',
    \             'key_input'   : "6j\<M-B>",
    \             'breaking'    : 7,
    \             'abort'       : 0,
    \             'pre' : {'commands' : ['let g:columnmove_strict_wbege=1', 'let g:columnmove_fold_treatment=1']}, 'post' : {}
    \             },
    \
    \   "24"   : {'caption'     : 'not-iskeyword, empty, folded lines',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : '\',
    \             'key_input'   : "6j\<M-B>",
    \             'breaking'    : 7,
    \             'abort'       : 0,
    \             'pre' : {'commands' : ['let g:columnmove_strict_wbege=1', 'let g:columnmove_fold_treatment=1']}, 'post' : {}
    \             },
    \
    \   "25"   : {'caption'     : 'space, iskeyword, folded lines',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : 'a',
    \             'key_input'   : "6j\<M-B>",
    \             'breaking'    : 7,
    \             'abort'       : 0,
    \             'pre' : {'commands' : ['let g:columnmove_strict_wbege=1', 'let g:columnmove_fold_treatment=1']}, 'post' : {}
    \             },
    \
    \   "26"   : {'caption'     : 'space, not-iskeyword, folded lines',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : ';',
    \             'key_input'   : "6j\<M-B>",
    \             'breaking'    : 7,
    \             'abort'       : 0,
    \             'pre' : {'commands' : ['let g:columnmove_strict_wbege=1', 'let g:columnmove_fold_treatment=1']}, 'post' : {}
    \             },
    \
    \   "27"   : {'caption'     : 'space, empty, folded lines',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : 'a',
    \             'key_input'   : "6j\<M-B>",
    \             'breaking'    : 7,
    \             'abort'       : 0,
    \             'pre' : {'commands' : ['let g:columnmove_strict_wbege=1', 'let g:columnmove_fold_treatment=1']}, 'post' : {}
    \             },
    \
    \   "28"   : {'caption'     : 'fold opening',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : ';',
    \             'key_input'   : "7j\<M-B>",
    \             'breaking'    : 10,
    \             'abort'       : 0,
    \             'pre' : {'commands' : ['let g:columnmove_strict_wbege=1', 'let g:columnmove_fold_treatment=0', 'let g:columnmove_fold_open=1']}, 'post' : {}
    \             },
    \
    \   "29"   : {'caption'     : 'fold opening',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : 'e',
    \             'key_input'   : "7j\<M-B>",
    \             'breaking'    : 9,
    \             'abort'       : 0,
    \             'pre' : {'commands' : ['let g:columnmove_strict_wbege=1', 'let g:columnmove_fold_treatment=0', 'let g:columnmove_fold_open=1']}, 'post' : {}
    \             },
    \
    \   "30"   : {'caption'     : 'preserved column position at line end',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : 'c',
    \             'key_input'   : "4j$k\<M-B>",
    \             'breaking'    : 3,
    \             'abort'       : 0,
    \             'pre' : {'commands' : ['let g:columnmove_strict_wbege=1']}, 'post' : {}
    \             },
    \
    \   "post" : {'breaking' : 2},
    \   }

let test_info.13      = {
    \   "pre"  : {'breaking' : 0 , 'commands' : [':let g:columnmove_fold_open=0', ':let g:columnmove_expand_range=0', ':let g:columnmove_fold_treatment=0']},
    \   "1"    : {'caption'     : 'iskeyword, space',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : 'c',
    \             'key_input'   : "\<M-E>",
    \             'breaking'    : 5,
    \             'abort'       : 0,
    \             'pre' : {'commands' : 'let g:columnmove_strict_wbege=1'}, 'post' : {}
    \             },
    \
    \   "2"    : {'caption'     : 'iskeyword, not-iskeyword',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : ';',
    \             'key_input'   : "\<M-E>",
    \             'breaking'    : 6,
    \             'abort'       : 0,
    \             'pre' : {'commands' : 'let g:columnmove_strict_wbege=1'}, 'post' : {}
    \             },
    \
    \   "3"    : {'caption'     : 'iskeyword, empty',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : 'c',
    \             'key_input'   : "\<M-E>",
    \             'breaking'    : 5,
    \             'abort'       : 0,
    \             'pre' : {'commands' : 'let g:columnmove_strict_wbege=1'}, 'post' : {}
    \             },
    \
    \   "4"    : {'caption'     : 'not-iskeyword, space',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : ']',
    \             'key_input'   : "\<M-E>",
    \             'breaking'    : 5,
    \             'abort'       : 0,
    \             'pre' : {'commands' : 'let g:columnmove_strict_wbege=1'}, 'post' : {}
    \             },
    \
    \   "5"    : {'caption'     : 'not-iskeyword, iskeyword',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : 'a',
    \             'key_input'   : "\<M-E>",
    \             'breaking'    : 6,
    \             'abort'       : 0,
    \             'pre' : {'commands' : 'let g:columnmove_strict_wbege=1'}, 'post' : {}
    \             },
    \
    \   "6"    : {'caption'     : 'not-iskeyword, empty',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : ']',
    \             'key_input'   : "\<M-E>",
    \             'breaking'    : 5,
    \             'abort'       : 0,
    \             'pre' : {'commands' : 'let g:columnmove_strict_wbege=1'}, 'post' : {}
    \             },
    \
    \   "7"    : {'caption'     : 'space, iskeyword',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : 'a',
    \             'key_input'   : "\<M-E>",
    \             'breaking'    : 5,
    \             'abort'       : 0,
    \             'pre' : {'commands' : 'let g:columnmove_strict_wbege=1'}, 'post' : {}
    \             },
    \
    \   "8"    : {'caption'     : 'space, not-iskeyword',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : ';',
    \             'key_input'   : "\<M-E>",
    \             'breaking'    : 5,
    \             'abort'       : 0,
    \             'pre' : {'commands' : 'let g:columnmove_strict_wbege=1'}, 'post' : {}
    \             },
    \
    \   "9"    : {'caption'     : 'space, empty',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : 'a',
    \             'key_input'   : "\<M-E>",
    \             'breaking'    : 6,
    \             'abort'       : 0,
    \             'pre' : {'commands' : 'let g:columnmove_strict_wbege=1'}, 'post' : {}
    \             },
    \
    \   "10"   : {'caption'     : 'iskeyword, space, folded lines',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : 'd',
    \             'key_input'   : "\<M-E>",
    \             'breaking'    : 6,
    \             'abort'       : 0,
    \             'pre' : {'commands' : ['let g:columnmove_strict_wbege=1', ':let g:columnmove_fold_treatment=0']}, 'post' : {}
    \             },
    \
    \   "11"   : {'caption'     : 'iskeyword, not-iskeyword, folded lines',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : 'f',
    \             'key_input'   : "\<M-E>",
    \             'breaking'    : 6,
    \             'abort'       : 0,
    \             'pre' : {'commands' : 'let g:columnmove_strict_wbege=1'}, 'post' : {}
    \             },
    \
    \   "12"   : {'caption'     : 'iskeyword, empty, folded lines',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : 'd',
    \             'key_input'   : "\<M-E>",
    \             'breaking'    : 6,
    \             'abort'       : 0,
    \             'pre' : {'commands' : 'let g:columnmove_strict_wbege=1'}, 'post' : {}
    \             },
    \
    \   "13"   : {'caption'     : 'not-iskeyword, space, folded lines',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : '/',
    \             'key_input'   : "\<M-E>",
    \             'breaking'    : 6,
    \             'abort'       : 0,
    \             'pre' : {'commands' : 'let g:columnmove_strict_wbege=1'}, 'post' : {}
    \             },
    \
    \   "14"   : {'caption'     : 'not-iskeyword, iskeyword, folded lines',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : ';',
    \             'key_input'   : "\<M-E>",
    \             'breaking'    : 6,
    \             'abort'       : 0,
    \             'pre' : {'commands' : 'let g:columnmove_strict_wbege=1'}, 'post' : {}
    \             },
    \
    \   "15"   : {'caption'     : 'not-iskeyword, empty, folded lines',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : '/',
    \             'key_input'   : "\<M-E>",
    \             'breaking'    : 6,
    \             'abort'       : 0,
    \             'pre' : {'commands' : 'let g:columnmove_strict_wbege=1'}, 'post' : {}
    \             },
    \
    \   "16"   : {'caption'     : 'space, iskeyword, folded lines',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : 'a',
    \             'key_input'   : "\<M-E>",
    \             'breaking'    : 6,
    \             'abort'       : 0,
    \             'pre' : {'commands' : 'let g:columnmove_strict_wbege=1'}, 'post' : {}
    \             },
    \
    \   "17"   : {'caption'     : 'space, not-iskeyword, folded lines',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : ';',
    \             'key_input'   : "\<M-E>",
    \             'breaking'    : 6,
    \             'abort'       : 0,
    \             'pre' : {'commands' : 'let g:columnmove_strict_wbege=1'}, 'post' : {}
    \             },
    \
    \   "18"   : {'caption'     : 'space, empty, folded lines',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : 'a',
    \             'key_input'   : "\<M-E>",
    \             'breaking'    : 6,
    \             'abort'       : 0,
    \             'pre' : {'commands' : 'let g:columnmove_strict_wbege=1'}, 'post' : {}
    \             },
    \
    \   "19"   : {'caption'     : 'iskeyword, space, folded lines',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : 'b',
    \             'key_input'   : "j\<M-E>",
    \             'breaking'    : 7,
    \             'abort'       : 0,
    \             'pre' : {'commands' : ['let g:columnmove_strict_wbege=1', 'let g:columnmove_fold_treatment=1']}, 'post' : {}
    \             },
    \
    \   "20"   : {'caption'     : 'iskeyword, not-iskeyword, folded lines',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : 'b',
    \             'key_input'   : "j\<M-E>",
    \             'breaking'    : 7,
    \             'abort'       : 0,
    \             'pre' : {'commands' : ['let g:columnmove_strict_wbege=1', 'let g:columnmove_fold_treatment=1']}, 'post' : {}
    \             },
    \
    \   "21"   : {'caption'     : 'iskeyword, empty, folded lines',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : 'b',
    \             'key_input'   : "j\<M-E>",
    \             'breaking'    : 7,
    \             'abort'       : 0,
    \             'pre' : {'commands' : ['let g:columnmove_strict_wbege=1', 'let g:columnmove_fold_treatment=1']}, 'post' : {}
    \             },
    \
    \   "22"   : {'caption'     : 'not-iskeyword, space, folded lines',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : ':',
    \             'key_input'   : "j\<M-E>",
    \             'breaking'    : 7,
    \             'abort'       : 0,
    \             'pre' : {'commands' : ['let g:columnmove_strict_wbege=1', 'let g:columnmove_fold_treatment=1']}, 'post' : {}
    \             },
    \
    \   "23"   : {'caption'     : 'not-iskeyword, iskeyword, folded lines',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : ':',
    \             'key_input'   : "j\<M-E>",
    \             'breaking'    : 7,
    \             'abort'       : 0,
    \             'pre' : {'commands' : ['let g:columnmove_strict_wbege=1', 'let g:columnmove_fold_treatment=1']}, 'post' : {}
    \             },
    \
    \   "24"   : {'caption'     : 'not-iskeyword, empty, folded lines',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : ':',
    \             'key_input'   : "j\<M-E>",
    \             'breaking'    : 7,
    \             'abort'       : 0,
    \             'pre' : {'commands' : ['let g:columnmove_strict_wbege=1', 'let g:columnmove_fold_treatment=1']}, 'post' : {}
    \             },
    \
    \   "25"   : {'caption'     : 'space, iskeyword, folded lines',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : 'a',
    \             'key_input'   : "j\<M-E>",
    \             'breaking'    : 7,
    \             'abort'       : 0,
    \             'pre' : {'commands' : ['let g:columnmove_strict_wbege=1', 'let g:columnmove_fold_treatment=1']}, 'post' : {}
    \             },
    \
    \   "26"   : {'caption'     : 'space, not-iskeyword, folded lines',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : ';',
    \             'key_input'   : "j\<M-E>",
    \             'breaking'    : 7,
    \             'abort'       : 0,
    \             'pre' : {'commands' : ['let g:columnmove_strict_wbege=1', 'let g:columnmove_fold_treatment=1']}, 'post' : {}
    \             },
    \
    \   "27"   : {'caption'     : 'space, empty, folded lines',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : 'a',
    \             'key_input'   : "j\<M-E>",
    \             'breaking'    : 7,
    \             'abort'       : 0,
    \             'pre' : {'commands' : ['let g:columnmove_strict_wbege=1', 'let g:columnmove_fold_treatment=1']}, 'post' : {}
    \             },
    \
    \   "28"   : {'caption'     : 'fold opening',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : ':',
    \             'key_input'   : "2j\<M-E>",
    \             'breaking'    : 10,
    \             'abort'       : 0,
    \             'pre' : {'commands' : ['let g:columnmove_strict_wbege=1', 'let g:columnmove_fold_treatment=0', 'let g:columnmove_fold_open=1']}, 'post' : {}
    \             },
    \
    \   "29"   : {'caption'     : 'fold opening',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : 'b',
    \             'key_input'   : "2j\<M-E>",
    \             'breaking'    : 9,
    \             'abort'       : 0,
    \             'pre' : {'commands' : ['let g:columnmove_strict_wbege=1', 'let g:columnmove_fold_treatment=0', 'let g:columnmove_fold_open=1']}, 'post' : {}
    \             },
    \
    \   "30"   : {'caption'     : 'preserved column position at line end',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : 'k',
    \             'key_input'   : "$j\<M-E>",
    \             'breaking'    : 1,
    \             'abort'       : 0,
    \             'pre' : {'commands' : ['let g:columnmove_strict_wbege=1']}, 'post' : {}
    \             },
    \
    \   "post" : {'breaking' : 2, 'commands' : ['let g:columnmove_strict_wbege=0', 'let g:columnmove_fold_treatment=1']},
    \   }

let test_info.14      = {
    \   "pre"  : {'breaking' : 0 , 'commands' : [':let g:columnmove_fold_open=0', ':let g:columnmove_expand_range=0', ':let g:columnmove_fold_treatment=0']},
    \   "1"    : {'caption'     : 'iskeyword, space',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : 'b',
    \             'key_input'   : "5j\<M-g>E",
    \             'breaking'    : 5,
    \             'abort'       : 0,
    \             'pre' : {'commands' : 'let g:columnmove_strict_wbege=1'}, 'post' : {}
    \             },
    \
    \   "2"    : {'caption'     : 'iskeyword, not-iskeyword',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : 'b',
    \             'key_input'   : "6j\<M-g>E",
    \             'breaking'    : 6,
    \             'abort'       : 0,
    \             'pre' : {'commands' : 'let g:columnmove_strict_wbege=1'}, 'post' : {}
    \             },
    \
    \   "3"    : {'caption'     : 'iskeyword, empty',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : 'b',
    \             'key_input'   : "5j\<M-g>E",
    \             'breaking'    : 5,
    \             'abort'       : 0,
    \             'pre' : {'commands' : 'let g:columnmove_strict_wbege=1'}, 'post' : {}
    \             },
    \
    \   "4"    : {'caption'     : 'not-iskeyword, space',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : ':',
    \             'key_input'   : "5j\<M-g>E",
    \             'breaking'    : 5,
    \             'abort'       : 0,
    \             'pre' : {'commands' : 'let g:columnmove_strict_wbege=1'}, 'post' : {}
    \             },
    \
    \   "5"    : {'caption'     : 'not-iskeyword, iskeyword',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : ':',
    \             'key_input'   : "5j\<M-g>E",
    \             'breaking'    : 6,
    \             'abort'       : 0,
    \             'pre' : {'commands' : 'let g:columnmove_strict_wbege=1'}, 'post' : {}
    \             },
    \
    \   "6"    : {'caption'     : 'not-iskeyword, empty',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : ':',
    \             'key_input'   : "5j\<M-g>E",
    \             'breaking'    : 5,
    \             'abort'       : 0,
    \             'pre' : {'commands' : 'let g:columnmove_strict_wbege=1'}, 'post' : {}
    \             },
    \
    \   "7"    : {'caption'     : 'space, iskeyword',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : 'a',
    \             'key_input'   : "5j\<M-g>E",
    \             'breaking'    : 5,
    \             'abort'       : 0,
    \             'pre' : {'commands' : 'let g:columnmove_strict_wbege=1'}, 'post' : {}
    \             },
    \
    \   "8"    : {'caption'     : 'space, not-iskeyword',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : ';',
    \             'key_input'   : "5j\<M-g>E",
    \             'breaking'    : 5,
    \             'abort'       : 0,
    \             'pre' : {'commands' : 'let g:columnmove_strict_wbege=1'}, 'post' : {}
    \             },
    \
    \   "9"    : {'caption'     : 'space, empty',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : 'a',
    \             'key_input'   : "6j\<M-g>E",
    \             'breaking'    : 6,
    \             'abort'       : 0,
    \             'pre' : {'commands' : 'let g:columnmove_strict_wbege=1'}, 'post' : {}
    \             },
    \
    \   "10"   : {'caption'     : 'iskeyword, space, folded lines',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : 'b',
    \             'key_input'   : "5j\<M-g>E",
    \             'breaking'    : 6,
    \             'abort'       : 0,
    \             'pre' : {'commands' : ['let g:columnmove_strict_wbege=1', ':let g:columnmove_fold_treatment=0']}, 'post' : {}
    \             },
    \
    \   "11"   : {'caption'     : 'iskeyword, not-iskeyword, folded lines',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : 'b',
    \             'key_input'   : "6j\<M-g>E",
    \             'breaking'    : 7,
    \             'abort'       : 0,
    \             'pre' : {'commands' : 'let g:columnmove_strict_wbege=1'}, 'post' : {}
    \             },
    \
    \   "12"   : {'caption'     : 'iskeyword, empty, folded lines',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : 'b',
    \             'key_input'   : "4j\<M-g>E",
    \             'breaking'    : 6,
    \             'abort'       : 0,
    \             'pre' : {'commands' : 'let g:columnmove_strict_wbege=1'}, 'post' : {}
    \             },
    \
    \   "13"   : {'caption'     : 'not-iskeyword, space, folded lines',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : ':',
    \             'key_input'   : "5j\<M-g>E",
    \             'breaking'    : 6,
    \             'abort'       : 0,
    \             'pre' : {'commands' : 'let g:columnmove_strict_wbege=1'}, 'post' : {}
    \             },
    \
    \   "14"   : {'caption'     : 'not-iskeyword, iskeyword, folded lines',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : ':',
    \             'key_input'   : "6j\<M-g>E",
    \             'breaking'    : 7,
    \             'abort'       : 0,
    \             'pre' : {'commands' : 'let g:columnmove_strict_wbege=1'}, 'post' : {}
    \             },
    \
    \   "15"   : {'caption'     : 'not-iskeyword, empty, folded lines',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : ':',
    \             'key_input'   : "5j\<M-g>E",
    \             'breaking'    : 6,
    \             'abort'       : 0,
    \             'pre' : {'commands' : 'let g:columnmove_strict_wbege=1'}, 'post' : {}
    \             },
    \
    \   "16"   : {'caption'     : 'space, iskeyword, folded lines',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : 'a',
    \             'key_input'   : "5j\<M-g>E",
    \             'breaking'    : 6,
    \             'abort'       : 0,
    \             'pre' : {'commands' : 'let g:columnmove_strict_wbege=1'}, 'post' : {}
    \             },
    \
    \   "17"   : {'caption'     : 'space, not-iskeyword, folded lines',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : ';',
    \             'key_input'   : "5j\<M-g>E",
    \             'breaking'    : 6,
    \             'abort'       : 0,
    \             'pre' : {'commands' : 'let g:columnmove_strict_wbege=1'}, 'post' : {}
    \             },
    \
    \   "18"   : {'caption'     : 'space, empty, folded lines',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : 'a',
    \             'key_input'   : "5j\<M-g>E",
    \             'breaking'    : 6,
    \             'abort'       : 0,
    \             'pre' : {'commands' : 'let g:columnmove_strict_wbege=1'}, 'post' : {}
    \             },
    \
    \   "19"   : {'caption'     : 'iskeyword, space, folded lines',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : 'b',
    \             'key_input'   : "6j\<M-g>E",
    \             'breaking'    : 7,
    \             'abort'       : 0,
    \             'pre' : {'commands' : ['let g:columnmove_strict_wbege=1', 'let g:columnmove_fold_treatment=1']}, 'post' : {}
    \             },
    \
    \   "20"   : {'caption'     : 'iskeyword, not-iskeyword, folded lines',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : 'b',
    \             'key_input'   : "6j\<M-g>E",
    \             'breaking'    : 7,
    \             'abort'       : 0,
    \             'pre' : {'commands' : ['let g:columnmove_strict_wbege=1', 'let g:columnmove_fold_treatment=1']}, 'post' : {}
    \             },
    \
    \   "21"   : {'caption'     : 'iskeyword, empty, folded lines',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : 'b',
    \             'key_input'   : "6j\<M-g>E",
    \             'breaking'    : 7,
    \             'abort'       : 0,
    \             'pre' : {'commands' : ['let g:columnmove_strict_wbege=1', 'let g:columnmove_fold_treatment=1']}, 'post' : {}
    \             },
    \
    \   "22"   : {'caption'     : 'not-iskeyword, space, folded lines',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : ':',
    \             'key_input'   : "6j\<M-g>E",
    \             'breaking'    : 7,
    \             'abort'       : 0,
    \             'pre' : {'commands' : ['let g:columnmove_strict_wbege=1', 'let g:columnmove_fold_treatment=1']}, 'post' : {}
    \             },
    \
    \   "23"   : {'caption'     : 'not-iskeyword, iskeyword, folded lines',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : ':',
    \             'key_input'   : "6j\<M-g>E",
    \             'breaking'    : 7,
    \             'abort'       : 0,
    \             'pre' : {'commands' : ['let g:columnmove_strict_wbege=1', 'let g:columnmove_fold_treatment=1']}, 'post' : {}
    \             },
    \
    \   "24"   : {'caption'     : 'not-iskeyword, empty, folded lines',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : ':',
    \             'key_input'   : "6j\<M-g>E",
    \             'breaking'    : 7,
    \             'abort'       : 0,
    \             'pre' : {'commands' : ['let g:columnmove_strict_wbege=1', 'let g:columnmove_fold_treatment=1']}, 'post' : {}
    \             },
    \
    \   "25"   : {'caption'     : 'space, iskeyword, folded lines',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : 'a',
    \             'key_input'   : "6j\<M-g>E",
    \             'breaking'    : 7,
    \             'abort'       : 0,
    \             'pre' : {'commands' : ['let g:columnmove_strict_wbege=1', 'let g:columnmove_fold_treatment=1']}, 'post' : {}
    \             },
    \
    \   "26"   : {'caption'     : 'space, not-iskeyword, folded lines',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : ';',
    \             'key_input'   : "6j\<M-g>E",
    \             'breaking'    : 7,
    \             'abort'       : 0,
    \             'pre' : {'commands' : ['let g:columnmove_strict_wbege=1', 'let g:columnmove_fold_treatment=1']}, 'post' : {}
    \             },
    \
    \   "27"   : {'caption'     : 'space, empty, folded lines',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : 'a',
    \             'key_input'   : "6j\<M-g>E",
    \             'breaking'    : 7,
    \             'abort'       : 0,
    \             'pre' : {'commands' : ['let g:columnmove_strict_wbege=1', 'let g:columnmove_fold_treatment=1']}, 'post' : {}
    \             },
    \
    \   "28"   : {'caption'     : 'fold opening',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : 'd',
    \             'key_input'   : "7j\<M-g>E",
    \             'breaking'    : 10,
    \             'abort'       : 0,
    \             'pre' : {'commands' : ['let g:columnmove_strict_wbege=1', 'let g:columnmove_fold_treatment=0', 'let g:columnmove_fold_open=1']}, 'post' : {}
    \             },
    \
    \   "29"   : {'caption'     : 'fold opening',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : 'd',
    \             'key_input'   : "7j\<M-g>E",
    \             'breaking'    : 9,
    \             'abort'       : 0,
    \             'pre' : {'commands' : ['let g:columnmove_strict_wbege=1', 'let g:columnmove_fold_treatment=0', 'let g:columnmove_fold_open=1']}, 'post' : {}
    \             },
    \
    \   "30"   : {'caption'     : 'preserved column position at line end',
    \             'result'      : 'getline(".")[col(".")-1]',
    \             'expectation' : 'c',
    \             'key_input'   : "3j$k\<M-g>E",
    \             'breaking'    : 3,
    \             'abort'       : 0,
    \             'pre' : {'commands' : ['let g:columnmove_strict_wbege=1']}, 'post' : {}
    \             },
    \   }

let test_info.post     = {
    \   'breaking' : 0,
    \   'commands' : []}
let test_info.n        = { 'title' : { 'title' : 'Test', 'post' : {'line' : {'char' : '-', 'width' : 60 } } }, 'post' : { 'line' : {'char' : '-', 'width' : 60 } } }
"}}}

" define Required functions"{{{
function! s:buffer_configuration(test_info)  "{{{
  if expand("%") != a:test_info.general.test_script
    if filereadable(a:test_info.general.test_script)
      setlocal noswapfile
      lcd %:p:h
      execute 'edit ' . a:test_info.general.test_script
    else
      return 1
    endif
  elseif expand("%:t") == a:test_info.general.test_script
    lcd %:h
  else
    return 1
  endif

  simalt ~x

  let s:scrollopt = &scrollopt
  set scrollopt-=jump
  setlocal scrollbind
  setlocal buftype=nowrite
  let s:test_script_tab_nr    = tabpagenr()
  let s:test_script_win_nr    = winnr()
  let s:test_script_buf_nr    = bufnr('%')
  let s:commentstring         = a:test_info.general.commentstring
  let s:caption_result        = a:test_info.general.caption_result
  let s:caption_expectation   = a:test_info.general.caption_expectation
  let s:minimum_caption_width = a:test_info.general.minimum_caption_width
  " save the containts of registers
  let s:reg_q     = getreg('q')
  let s:reg_slash = getreg("/")
  " Preparing ProcessManager module from vital.vim
  if !exists('s:V')
    let s:V  = vital#of('scilabcomplete')
    let s:PM = s:V.import('ProcessManager')
    let s:S  = s:V.import("Data.List")
  endif
  " Preparing result buffer
  execute a:test_info.general.split_command

  let s:result_tab_nr = tabpagenr()
  let s:result_win_nr = winnr()
  let s:result_buf_nr = bufnr('%')
  setlocal scrollbind
  setlocal noautoindent
  setlocal nosmartindent
  setlocal nocindent
  setlocal nohlsearch
  setlocal nowrapscan
  setlocal buftype=nowrite
  " Highlighting settings
  hi! link ScilabCompleteTestComment    Comment
  hi! link ScilabCompleteTestUnderlined Underlined
  hi! link ScilabCompleteTestPassed     Diffadd
  hi! link ScilabCompleteTestFailed     DiffDelete
  hi! link ScilabCompleteTestAbort      DiffChange
  hi! link ScilabCompleteTestBad        SpellBad
  hi! link ScilabCompleteTestCap        SpellCap
  call matchadd("ScilabCompleteTestComment",    '\%1l')
  call matchadd("ScilabCompleteTestComment",    '^\d\+-\d\+\ .*\ze:')
  call matchadd("ScilabCompleteTestUnderlined", '^' . s:caption_result)
  call matchadd("ScilabCompleteTestUnderlined", '^' . s:caption_expectation)

  if s:result_win_nr == s:test_script_win_nr
    return 1
  endif

  return 0
endfunction
"}}}
function! s:move_to_test_script()   "{{{
  execute 'tabnext ' . s:test_script_tab_nr
  execute s:test_script_tab_nr . 'wincmd w'
  execute 'buffer ' . s:test_script_buf_nr
endfunction
"}}}
function! s:move_to_result_buffer()   "{{{
  execute 'tabnext ' . s:result_tab_nr
  execute s:result_win_nr . 'wincmd w'
  execute 'buffer ' . s:result_buf_nr
endfunction
"}}}

function! s:write_down(line)    "{{{
  if line('.') == 1
    execute 'normal! i' . a:line
  else
    execute 'normal! o' . a:line
  endif
endfunction
"}}}
function! s:generate_caption(draft)  "{{{
  let caption     = ''
  let draft_width = len(a:draft)
  let spacing     = s:minimum_caption_width - draft_width

  if spacing > 0
    let caption = a:draft . repeat(' ', spacing)
"   elseif spacing < 0
"     let caption = a:draft[:spacing-1]
  else
    let caption = a:draft
  endif
  let caption = caption . ": "

  return caption
endfunction
"}}}
function! s:insert_template_pre(dict)    "{{{
  if !has_key(a:dict, 'pre')
    return
  endif

  if type(a:dict.pre) == type([])
    for order in a:dict.pre
      execute order
    endfor
  elseif type(a:dict.pre) == type({})
    if has_key(a:dict.pre, 'breaking')
      if a:dict.pre.breaking > 0
        if type(a:dict.pre.breaking) == type(0) && a:dict.pre.breaking > 0
          execute "normal! " . a:dict.pre.breaking . "o"
        endif
      endif
    endif

    if has_key(a:dict.pre, 'text')
      if type(a:dict.pre.text) == type('')
        call s:write_down(a:dict.pre.text)
        call matchadd("ScilabCompleteTestComment", '\%' . line('.') . 'l')
      elseif type(a:dict.pre.text) == type([])
        " don't know why, but it didn't works
        " call append(line('.'), a:dict.pre.text)
        for line in a:dict.pre.text
          call s:write_down(line)
          call matchadd("ScilabCompleteTestComment", '\%' . line('.') . 'l')
        endfor
      endif
    endif

    if has_key(a:dict.pre, 'line')
      normal! o
      execute "normal! " . printf("%s", a:dict.pre.line.width) . "i" . printf("%s", a:dict.pre.line.char)
      call matchadd("ScilabCompleteTestComment", '^' . a:dict.pre.line.char . '\{' . a:dict.pre.line.width . '}')
    endif
  endif
endfunction
"}}}
function! s:insert_template_title(dict)  "{{{
  if !has_key(a:dict, 'title')
    return
  endif

  if has_key(a:dict, 'title')
    if type(a:dict.title) == type('')
      call s:write_down(a:dict.title . ' ' . join(a:dict.address, '.'))
      call matchadd("ScilabCompleteTestComment", '\%' . line('.') . 'l')
    elseif type(a:dict.title) == type({})
      if has_key(a:dict.title, 'pre')
        call s:insert_template_pre(a:dict.title)
      endif

      if has_key(a:dict.title, 'title')
        if type(a:dict.title.title) == type('')
          call s:write_down(a:dict.title.title . ' ' . join(a:dict.address, '.'))
          call matchadd("ScilabCompleteTestComment", '\%' . line('.') . 'l')
        endif
      endif

      if has_key(a:dict.title, 'post')
        call s:insert_template_post(a:dict.title)
      endif
    endif
  endif
endfunction
"}}}
function! s:insert_template_cap(dict)  "{{{
  if !has_key(a:dict, 'caption')
    return
  endif

  if has_key(a:dict, 'caption')
    if type(a:dict.caption) == type('')
      let label_nr = join(a:dict.address, '.')
      let caption = s:generate_caption(label_nr . " " . a:dict.caption)
      call s:write_down(caption)
    elseif type(a:dict.caption) == type({})
      if has_key(a:dict.caption, 'pre')
        call s:insert_template_pre(a:dict.caption)
      endif

      if has_key(a:dict.caption, 'caption')
        let label_nr = join(a:dict.address, '-')
        let caption = s:generate_caption(label_nr . " " . a:dict.caption.caption)
        call s:write_down(caption)
      endif

      if has_key(a:dict.caption, 'post')
        call s:insert_template_post(a:dict.caption)
      endif
    endif
  endif
endfunction
"}}}
function! s:insert_template_res(dict)  "{{{
  if !has_key(a:dict, 'result')
    return
  endif

  if has_key(a:dict, 'result')
    let caption = s:generate_caption(s:caption_result)
    call s:write_down(caption)
  endif
endfunction
"}}}
function! s:insert_template_exp(dict)  "{{{
  if !has_key(a:dict, 'expectation')
    return
  endif

  if has_key(a:dict, 'expectation')
    let caption = s:generate_caption(s:caption_expectation)
    call s:write_down(caption . a:dict.expectation)
    if  has_key(a:dict, 'breaking')
      if type(a:dict.breaking) == type(0) && a:dict.breaking > 0
        execute "normal! " . a:dict.breaking . "o"
      endif
    endif
  endif
endfunction
"}}}
function! s:insert_template_post(dict)    "{{{
  if !has_key(a:dict, 'post')
    return
  endif

  if type(a:dict.post) == type([])
    for order in a:dict.post
      execute order
    endfor
  elseif type(a:dict.post) == type({})
    if has_key(a:dict.post, 'line')
      normal! o
      execute "normal! " . printf("%s", a:dict.post.line.width) . "i" . printf("%s", a:dict.post.line.char)
      call matchadd("ScilabCompleteTestComment", '^' . a:dict.post.line.char . '\{' . a:dict.post.line.width . '}')
    endif

    if has_key(a:dict.post, 'text')
      if type(a:dict.post.text) == type('')
        call s:write_down(a:dict.post.text)
        call matchadd("ScilabCompleteTestComment", '\%' . line('.') . 'l')
      elseif type(a:dict.post.text) == type([])
        " don't know why, but it didn't works
        " call append(line('.'), a:dict.post.text)
        for line in a:dict.post.text
          call s:write_down(line)
          call matchadd("ScilabCompleteTestComment", '\%' . line('.') . 'l')
        endfor
      endif
    endif

    if has_key(a:dict.post, 'breaking')
      if a:dict.post.breaking > 0
        if type(a:dict.post.breaking) == type(0) && a:dict.post.breaking > 0
          execute "normal! " . a:dict.post.breaking . "o"
        endif
      endif
    endif
  endif
endfunction
"}}}
function! s:extend_public_factor(dict, test_info, current_address)    "{{{
  let dict = a:dict
  let public = a:test_info
  let idx = 0
  if !empty(a:current_address)
    while idx < len(a:current_address)
      if has_key(public, 'n')
        let public = public.n
      else
        let public = {}
        break
      endif
      let idx += 1
    endwhile
  else
    let public = {}
  endif

  if has_key(public, 'pre')
    if has_key(dict, 'pre')
      call extend(dict.pre, public.pre, 'keep')
    else
      let dict.pre = public.pre
    endif
  endif

  if has_key(public, 'title')
    if has_key(dict, 'title')
      call extend(dict.title, public.title, 'keep')
    else
      let dict.title = public.title
    endif
  endif

  if has_key(public, 'label')
    if has_key(dict, 'label')
      call extend(dict.label, public.label, 'keep')
    else
      let dict.label = public.label
    endif
  endif

  if has_key(public, 'post')
    if has_key(dict, 'post')
      call extend(dict.post, public.post, 'keep')
    else
      let dict.post = public.post
    endif
  endif

  return dict
endfunction
"}}}

function! s:run_key_input(dict)    "{{{
  if get(a:dict, 'switch', 'on') !=? 'off'
    if has_key(a:dict, 'caption')
      call s:move_to_test_script()
      normal! gg

      call search(s:commentstring . join(a:dict.address, '\.') . ' ' . a:dict.caption)
      normal! j0
      if has_key(a:dict, 'key_input')
        call setreg('q', a:dict.key_input)
        normal! @q
      endif
    endif
  endif
endfunction
"}}}
function! s:copy_result(dict, quit_flag)   "{{{
  if get(a:dict, 'switch', 'on') !=? 'off'
    if a:quit_flag == 0
      if has_key(a:dict, 'result')
        let final_result = eval(a:dict.result)
        call s:move_to_result_buffer()
        normal! gg
        call search('^' . join(a:dict.address, '\.') . ' ' . a:dict.caption)
        execute "normal! jA" . final_result
      endif
    endif
  endif
endfunction
"}}}
function! s:judge(dict, quit_flag) "{{{
  let failed = []

  if has_key(a:dict, 'caption')
    let failed = [1]
    call s:move_to_result_buffer()
    normal! gg

    let matched_line = search('^' . join(a:dict.address, '\.') . ' ' . a:dict.caption)
    let caption_res  = s:generate_caption(s:caption_result)
    let caption_exp  = s:generate_caption(s:caption_expectation)
    let result       = matchstr(getline(matched_line + 1), '^' . caption_res . '\zs.*')
    let expectation  = matchstr(getline(matched_line + 2), '^' . caption_exp . '\zs.*')
    if get(a:dict, 'switch', 'on') ==? 'off'
      normal! ASkipped
      call matchadd("ScilabCompleteTestAbort", join(a:dict.address, '.') . ' ' . a:dict.caption . ' *: \zs.*')
    elseif a:quit_flag > 0
      normal! AAbort
      call matchadd("ScilabCompleteTestAbort", join(a:dict.address, '.') . ' ' . a:dict.caption . ' *: \zs.*')
    elseif result ==# expectation
      let failed = [0]
      normal! APassed
      call matchadd("ScilabCompleteTestPassed", join(a:dict.address, '.') . ' ' . a:dict.caption . ' *: \zs.*')
    else
      normal! AFailed
      call matchadd("ScilabCompleteTestFailed", join(a:dict.address, '.') . ' ' . a:dict.caption . ' *: \zs.*')
      let pos = 0
      while pos <= len(result)
        let c_res = result[pos]
        let c_exp = expectation[pos]
        if c_res !=# c_exp
          break
        endif
        let pos += 1
      endwhile
      call matchadd("ScilabCompleteTestBad", '\%' . printf("%s", matched_line + 1) . 'l\%' . printf("%s", pos + len(caption_res) + 1) . 'c\zs.*')
      call matchadd("ScilabCompleteTestCap", '\%' . printf("%s", matched_line + 2) . 'l\%' . printf("%s", pos + len(caption_exp) + 1) . 'c\zs.*')
    endif
    normal! 0
  endif

  return failed
endfunction
"}}}
function! s:run_commands(dict)   "{{{
  let failed = []

  if get(a:dict, 'switch', 'on') !=? 'off'
    call s:move_to_test_script()
    if has_key(a:dict, 'commands')
      if type(a:dict.commands) == type('')
        if a:dict.commands[0] == ":"
          let command = a:dict.commands
        else
          let command = ":" . a:dict.commands
        endif

        execute a:dict.commands
        call add(failed, 0)
      elseif type(a:dict.commands) == type([])
        for command in a:dict.commands
          if command[0] != ":"
            let command = ":" . command
          endif

          execute command
          call add(failed, 0)
        endfor
      endif
    endif
  endif

  return failed
endfunction
"}}}
function! s:touch_quit_info(dict, quit_info, failed, pos)  "{{{
  let quit_flag = a:quit_info.flag

  if !empty(a:failed)
    if has_key(a:dict, 'abort')
      let abort = a:dict.abort
    else
      let abort = 0
    endif

    if quit_flag == 0
      if a:pos ==# 'pre' || a:pos ==# 'post'
        if !empty(filter(a:failed, 'v:val != 0'))
          let a:quit_info.failed   = a:failed
          let a:quit_info.position = a:pos
          let a:quit_info.flag     = 1
        endif
      elseif a:pos ==# 'test'
        if and(abort, a:failed[0])
          let a:quit_info.failed   = a:failed
          let a:quit_info.position = a:pos
          let a:quit_info.flag     = 1
        endif
      endif
    endif
  endif
endfunction
"}}}

function! s:test_main_func(test_info)    "{{{
  call s:move_to_result_buffer()

  let glanced_nrs     = []
  let current_address = []
  let post_stack      = []
  let dict            = a:test_info
  let n_loop          = 0

  let quit_info = { 'flag' : 0,  'address' : [], 'failed' : [], 'position' : ''}
  let failed = []

  while n_loop < 1000
    let address = {'address' : current_address}
    call extend(dict, address, "force")

    let dict = s:extend_public_factor(dict, a:test_info, current_address)

    " expand template
    call s:move_to_result_buffer()
    normal! G
    call s:insert_template_pre(dict)
    call s:insert_template_title(dict)
    call s:insert_template_cap(dict)
    call s:insert_template_res(dict)
    call s:insert_template_exp(dict)

    " run test
    let quit_info.address = current_address

    let failed = s:run_commands(dict.pre)
    call s:touch_quit_info(dict, quit_info, failed, 'pre')

    call s:run_key_input(dict)
    call s:copy_result(dict, quit_info.flag)
    let failed = s:judge(dict, quit_info.flag)
    call s:touch_quit_info(dict, quit_info, failed, 'test')

    let failed = s:run_commands(dict.post)
    call s:touch_quit_info(dict, quit_info, failed, 'post')

    let nrs = s:S.sort(filter(keys(dict), 'v:val =~ ''\d\+'''), 'str2nr(a:a) - str2nr(a:b)')
    if !empty(nrs)
      call add(post_stack, join(current_address, '.'))

      let dict = dict[nrs[0]]
      call add(current_address, nrs[0])
      call add(glanced_nrs, deepcopy(nrs))
    else
      call s:move_to_result_buffer()
      normal! G
      call s:insert_template_post(dict)

      call remove(glanced_nrs[-1], 0)
      call remove(current_address, -1)
      let nr = get(glanced_nrs[-1], 0, -1)

      if nr >= 0
        call add(current_address, nr)

        execute 'let dict = a:test_info.' . join(current_address, '.')
        let address = {'address' : current_address}
        call extend(dict, address, "force")
      else
        call remove(glanced_nrs, -1)
        call remove(glanced_nrs[-1], 0)
        if !empty(glanced_nrs[0])
          call remove(current_address, -1)

          let address = {'address' : remove(post_stack, -1)}
          execute 'let dict = a:test_info.' . address.address
          call extend(dict, address, "force")

          let dict = s:extend_public_factor(dict, a:test_info, current_address)

          call s:move_to_result_buffer()
          normal! G
          call s:insert_template_post(dict)

          call add(current_address, glanced_nrs[-1][0])
          execute 'let dict = a:test_info.' . join(current_address, '.')

          let address = {'address' : current_address}
          call extend(dict, address, "force")

          let public = a:test_info
          let idx = 0
          while idx < len(current_address)
            if !has_key(public, 'n')
                let public = public.n
            else
                let public = {}
                break
            endif
            let idx += 1
          endwhile
          call extend(dict, public,  "keep")
        else
          let address = {'address' : remove(post_stack, -1)}
          execute 'let dict = a:test_info.' . address.address
          call extend(dict, address, "force")

          let dict = s:extend_public_factor(dict, a:test_info, current_address)

          call s:move_to_result_buffer()
          normal! G
          call s:insert_template_post(dict)
          call s:insert_template_post(a:test_info)
          break
        endif
      endif
    endif

    let n_loop += 1
  endwhile
endfunction
"}}}

function! s:finalize()   "{{{
  " Freeze result buffer
  call s:move_to_test_script()
  normal! gg
  call s:move_to_result_buffer()
  normal! gg
  setlocal nomodifiable
  " Restore global settings
  let &scrollopt = s:scrollopt
  " Restore registers
  let reg_q     = setreg('q', s:reg_q)
  let reg_slash = setreg("/", s:reg_slash)
endfunction
"}}}
"}}}

" Testing!
" buffer configuration
if !s:buffer_configuration(test_info)

  " Start test
  call s:test_main_func(test_info)

  " Finalize
  call s:finalize()
endif
