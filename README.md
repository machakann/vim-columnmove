vim-columnmove
================
[![Build Status](https://travis-ci.org/machakann/vim-columnmove.svg?branch=master)](https://travis-ci.org/machakann/vim-columnmove)
[![Build status](https://ci.appveyor.com/api/projects/status/5k6bnara2wsjomok?svg=true)](https://ci.appveyor.com/project/machakann/vim-columnmove)


This plugin implements several keymappings to move cursor in vertical direction.

# columnmove-f
columnmove-f and its variants are the motion commands to bring cursor to the position assigned by a character in the same column.

This group has six keymappings, that is, `columnmove-f`, `columnmove-t`, `columnmove-F`, `columnmove-T`, `columnmove-;`, `columnmove-,`.  Each of them are the imitations of `f`, `t`, `F`, `T`, `;`, `,` commands, but work in vertical direction.

Those commands are mapped to `<M-f>`, `<M-t>`, `<M-F>`, `<M-T>`, `<M-;>`, `<M-,>` in default.

![columnmove-f](http://kura2.photozou.jp/pub/986/3080986/photo/199161494_org.v1394284952.gif)



# columnmove-w
columnmove-w and its variants are the commands for moving cursor in word-wise.  This group has eight keymappings, that is, `columnmove-w`, `columnmove-b`, `columnmove-e`, `columnmove-ge`, `columnmove-W`, `columnmove-B`, `columnmove-E`, `columnmove-gE`. Each of them are the imitations of `w`, `b`, `e`, `ge`, `W`, `B`, `E`, `gE` commands, but work in vertical direction. These commands regard the column which the cursor is on as a line and search for the head or tail of word to move.  These commands regard a empty part of the column (like empty lines) as a space to skip it. For example, assume a vimscript code like this:

```vim
echo "first line"
echo "second line"
echo "--- separator ---"

echo "fifth line"
echo "sixth line"
echo "seventh line"

echo "--- separator ---"
echo "tenth line"
echo "eleventh line"
```

Cut out the seventh column.

```
f
s
-

f
s
s

-
t
e
```

Consider it as a line.

`
fs- fss -te
`

Empty columns are converted to spaces. Words are defined by using the option 'iskeyword'. Usually `-` is not keyword in vimscript code. Thus if the cursor is placed on the first `f`, w command brings cursor like, `-` -> `f` -> `-` -> `t`.  Hence `columnmove-w` command bring cursor to the third, fifth, and, nineth, and, tenth lines from the first line.

These commands are mapped to `<M-w>`, `<M-b>`, `<M-e>`, `<M-g>e`, `<M-W>`, `<M-B>`, `<M-E>`, `<M-g>E` in default.

![columnmove-w:strict](http://kura2.photozou.jp/pub/986/3080986/photo/199164951_org.v1394286992.gif)

However, actually, almost all the programming languages are semantic in line-wise. It means hardly to align characters vertically in semantic way, and these "strict" commands might not be useful always. If you find that, why don't you try "spoiled" commands with following configuration?

`
	let g:columnmove_strict_wbege = 0
`

With this configuration, `columnmove-w` and its variants do not think whether characters are included in 'iskeyword' or not. Just judge whether there is a empty or a character. Here, write again the example code.

```
f
s
-

f
s
s

-
t
e
```

"spoiled" commands would stop cursor on the fifth and nineth line since `fs-`, `fss`, and, `-te` are strings which are separated by empty line. It means that if there is a space, still stops cursor on the space.

![columnmove-w:spoiled](http://kura2.photozou.jp/pub/986/3080986/photo/199165599_org.v1394287362.gif)

