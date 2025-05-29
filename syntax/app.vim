" Vim syntax file
" Language:	MULI BASIC
" Maintainer:	Chris Brownlie <browch@muli.com.au>
" Last Change:	Tue Sep 14 14:24:23 BST 1999

" maintainer.

" For version 5.x: Clear all syntax items
" For version 6.x: Quit when a syntax file was already loaded
if version < 600
  syntax clear
elseif exists("b:current_syntax")
  finish
endif

syn match basicFunction "\zs\<[a-za-z0-9_]\+\(\$*\)\ze("
" A bunch of useful BASIC keywords
syn keyword basicStatement	BREAK break
syn keyword basicStatement	CALL call ABS abs
syn keyword basicStatement	CHAIN chain 
syn keyword basicStatement	CLOSE close 
syn keyword basicStatement	COPY copy CREATE create
syn keyword basicStatement	COMMON common 
syn keyword basicStatement	CONTINUE continue
syn keyword basicStatement	CONSTANT constant DATA data
syn keyword basicStatement	DIM dim NUMERIC numeric CHAR char VARCHAR varchar date DATE
syn keyword basicStatement	DO do
syn keyword basicStatement	END end End
syn keyword basicStatement	ERROR error EXIT exit
syn keyword basicStatement	FALSE false
syn keyword basicStatement	FOR for NEXT next
syn keyword basicStatement	FUN fun 
syn keyword basicStatement	GOSUB gosub GOTO goto
syn keyword basicStatement	IF if THEN then ELSE else FI fi ENDIF endif
syn keyword basicStatement	IOCTL ioctl Ioctl KEY key Key
syn keyword basicStatement	include INCLUDE tinclude TINCLUDE struct STRUCT
syn keyword basicStatement SCLEAR sclear
syn keyword basicStatement	LET let
syn keyword basicStatement	UNLOCK unlock
syn keyword basicStatement	ON on OR or AND and
syn keyword basicStatement	OPTION option BASED based
syn keyword basicStatement	PRINT print
syn keyword basicStatement	READ read
syn keyword basicStatement	RESTORE restore
syn keyword basicStatement	RETURN return
syn keyword basicStatement	SLEEP sleep
syn keyword basicStatement	STOP stop
syn keyword basicStatement	SUB sub
syn keyword basicStatement	TRUE true
syn keyword basicStatement	WHILE while WEND wend
syn keyword basicStatement	WRITE write

"integer number, or floating point number without a dot.
syn match  basicNumber		"\<\d\+\>"
"floating point number, with dot
syn match  basicNumber		"\<\d\+\.\d*\>"
"floating point number, starting with a dot
syn match  basicNumber		"[0-9]+\.\d\+\>"

syn match basicComment  "REM.*"
syn match basicComment  "|.*"
" Define a region for comments starting with '--' not following a character
syntax match basicComment /\(^\s*--\|\s--\).*/ contains=NONE
" Define a region for strings to avoid highlighting comments inside strings
syntax region basicString start=+"+ end=+"+ skip=+\\"+ contains=NONE
syntax cluster strCluster add=basicComment,basicString


" String and Character contstants
syn match  basicSpecial contained "\\\d\d\d\|\\."

syn match basicLabel "\<[a-zA-Z0-9_]\+:"


highlight CustomMuliFunctionColour guifg=#7E9CD8 guibg=NONE

hi link basicLineNumber      Comment
hi link basicComment         Comment
hi link basicConditional     Conditional
hi link basicError           Error
hi link basicFunction        CustomMuliFunctionColour
hi link muliStatement        CustomMuliFunctionColour
hi link basicLabel           CustomMuliFunctionColour
hi link basicNumber          Number
hi link basicRepeat          Repeat
hi link basicSpecial         Special
hi link basicStatement       Statement
hi link basicString          String
hi link basicTodo            Todo
hi link basicVarRef          Type
hi link basicTypeSpecifier   Type
hi link basicFilenumber      basicTypeSpecifier

let b:current_syntax = "muli"

" vim: ts=3
