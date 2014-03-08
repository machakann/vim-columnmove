vim-columnmove
================

This plugin serves you several keymappings to move cursor in vertical direction.

# columnmove-f
columnmove-f and its variants are the commands for bringing cursor to the position assigned by a character in the same column.

This group has six keymappings, that is, "columnmove-f", "columnmove-t", "columnmove-F", "columnmove-T", "columnmove-;", "columnmove-,".  Each of them are the imitations of "f", "t", "F", "T", ";", "," commands, but work in vertical direction.

Please remember that these commands would search for the candidates of destination in the range of the lines displayed. Because I think that it is not easy to memorize the characters in the same column out of one's sight precisely. If you want to expand the range of searching, give the number of lines to `g:columnmove_expand_range`. For example, if you want to add ten lines to the range, please write following line to your vimrc.
`
	let g:columnmove_expand_range = 10
`
Or you just want to expand to the whole file, give the negative number to `g:columnmove_expand_range`.
`
	let g:columnmove_expand_range = -1
`

# columnmove-w
columnmove-w and its variants are the commands for moving cursor in word-wise.  This group has four keymappings, that is, "columnmove-w", "columnmove-b", "columnmove-e", "columnmove-ge". Each of them are the imitations of "w", "b", "e", "ge" commands, but work in vertical direction. These commands regard the column which cursor is on as a line and search for the head or tail of word to move.  These commands regard a empty part of the column (like empty lines) as a space to skip it. For example, assume a vimscript code like this:
`
	let foo = 1
	let bar = 2

	" addition
	let addition = foo + bar

	echo foo
	echo bar
	echo addition
`
Cut out the first column.
`
	l
	l

	"
	l

	e
	e
	e
`
Consider it as a line.
`
	ll "l eee
`
Empty columns are converted to spaces. Words are defined by using the option
'iskeyword'. Usually '"' is not keyword in vimscript code. Thus if the cursor
is placed on the first 'l', w command brings cursor like, '"' -> 'l' -> 'e'.
Hence |columnmove-w| command bring cursor to the first column of fourth,
fifth, and, seventh lines from the first column of first line.

However, actually, almost all the programming languages are semantic in
line-wise. It means hardly to align characters vertically in semantic way, and
these "strict" commands might not be useful always. If you find that, why
don't you try "spoiled" commands with following configuration?
`
	let g:columnmove_strict_wbege = 0
`
With this configuration, |columnmove-w| and its variants do not think whether
characters are included in 'iskeyword' or not. Just judge whether there is a
empty or a character. Here, write again the first column of the example code.
`
	l
	l

	"
	l

	e
	e
	e
`
"spoiled" commands would stop cursor on the fourth and seventh line since
""l" and "eee" are strings which are separated by empty line. It means that if
there is a space, still stops cursor there.
