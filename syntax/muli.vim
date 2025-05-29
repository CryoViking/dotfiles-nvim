" Vim syntax file
" Language:	MULI BASIC
" Maintainer:	Allan Kelly <allan@fruitloaf.co.uk>
" Last Change:	Tue Sep 14 14:24:23 BST 1999

" First version based on Micro$soft QBASIC circa 1989, as documented in
" 'Learn BASIC Now' by Halvorson&Rygmyr. Microsoft Press 1989.
" This syntax file not a complete implementation yet.  Send suggestions to the
" maintainer.

" For version 5.x: Clear all syntax items
" For version 6.x: Quit when a syntax file was already loaded
if version < 600
  syntax clear
elseif exists("b:current_syntax")
  finish
endif

" A bunch of useful BASIC keywords
syn keyword basicStatement	BREAK break
syn keyword basicStatement	CALL call ABS abs
syn keyword basicStatement	CHAIN chain 
syn keyword basicStatement	CLOSE close 
syn keyword basicStatement	COPY copy
syn keyword basicStatement	COMMON common 
syn keyword basicStatement	CONTINUE continue
syn keyword basicStatement	CONSTANT constant DATA data
syn keyword basicStatement	DIM dim
syn keyword basicStatement	DO do
syn keyword basicStatement	END end End
syn keyword basicStatement	ERROR error EXIT exit
syn keyword basicStatement	FOR for NEXT next
syn keyword basicStatement	FUN fun 
syn keyword basicStatement	GOSUB gosub GOTO goto
syn keyword basicStatement	IF if THEN then ELSE else FI fi ENDIF endif
syn keyword basicStatement	IOCTL ioctl Ioctl KEY key Key
syn keyword basicStatement	LET let
syn keyword basicStatement	UNLOCK unlock
syn keyword basicStatement	ON on OR or
syn keyword basicStatement	ERROR error OPEN open 
syn keyword basicStatement	OPTION option BASED based
syn keyword basicStatement	PRINT print 
syn keyword basicStatement	READ read
syn keyword basicStatement	RESTORE restore
syn keyword basicStatement	RETURN return 
syn keyword basicStatement	SLEEP sleep
syn keyword basicStatement	STOP stop
syn keyword basicStatement	SUB sub 
syn keyword basicStatement	WHILE while WEND wend
syn keyword basicStatement	WRITE write
syn keyword basicStatement	STRIP$ strip$ LSTRIP$ lstrip$

syn keyword basicFunction	ABS abs Abs ASC asc Asc
syn keyword basicFunction	ATN atn
syn keyword basicFunction	COS cos \#CLONE\.REC
syn keyword basicFunction	ERDEV erdev Erdev ERL erl Erl
syn keyword basicFunction	ERR err Err EXP exp Exp 
syn keyword basicFunction	IOERR ioerr 
syn keyword basicFunction	INT int
syn keyword basicFunction	LEN len #LOC #loc 
syn keyword basicFunction	PEN pen Pen POINT point Point
syn keyword basicFunction	POS pos Pos RND rnd Rnd
syn keyword basicFunction	SGN sgn Sgn SIN sin Sin
syn keyword basicFunction	SPC spc Spc SQR sqr Sqr
syn keyword basicFunction	TAB tab Tab TAN tan Tan
syn match basicFunction	"VAL(" "val("
syn keyword basicFunction	CHR$ Chr$ chr$ COMMAND$ command$ Command$
syn keyword basicFunction	DATE$ date$ Date$ ENVIRON$ environ$ Environ$
syn keyword basicFunction	ERDEV$ erdev$ Erdev$ HEX$ hex$ Hex$
syn keyword basicFunction	INKEY$ inkey$ Inkey$ INPUT$ input$ Input$
syn keyword basicFunction	IOCTL$ ioctl$ Ioctl$ LCASES$ lcases$ Lcases$
syn keyword basicFunction	MID$ mid$
syn keyword basicFunction	STR$ str$ Str$
syn keyword basicTodo contained	TODO
syn match muli1 "[\&]"
syn match muli2 " = "

"integer number, or floating point number without a dot.
syn match  basicNumber		"\<\d\+\>"
"floating point number, with dot
syn match  basicNumber		"\<\d\+\.\d*\>"
"floating point number, starting with a dot
syn match  basicNumber		"[0-9]+\.\d\+\>"

" String and Character contstants
syn match   basicSpecial contained "\\\d\d\d\|\\."
syn region  basicString		  start=+"+  skip=+\\\\\|\\"+  end=+"+  contains=basicSpecial

syn match   basicTypeSpecifier  "[a-zA-Z0-9._][\$]"ms=s+1
syn match   basicVarRef "$\a[a-zA-Z0-9_.]*"
syn match  basicFunction  "[a-zA-Z0-9._]*[\$]"
" Used with OPEN statement
"syn sync ccomment basicComment
" syn match   basicMathsOperator "[<>+\*^/\\=-]"
syn match   basicMathsOperator   "-\|=\|[:<>+\*^/\\]\|AND\|OR"

syn region  basicComment	start="REM" end="$" contains=basicTodo
syn region  basicComment	start="|" end="$" contains=basicTodo
syn region  basicComment	start="\-\-" end="$" contains=basicTodo

" Define the default highlighting.
" For version 5.7 and earlier: only when not done already
" For version 5.8 and later: only when an item doesn't have highlighting yet
if version >= 508 || !exists("did_basic_syntax_inits")
  if version < 508
    let did_basic_syntax_inits = 1
    command -nargs=+ HiLink hi link <args>
  else
    command -nargs=+ HiLink hi def link <args>
  endif

  HiLink basicLabel		Label
  HiLink basicConditional	Conditional
  HiLink basicRepeat		Repeat
  HiLink basicLineNumber	Comment
  HiLink basicNumber		Number
  HiLink basicError		Error
  HiLink basicStatement	Statement
  HiLink basicString		String
  HiLink basicComment		Comment
  HiLink basicSpecial		Special
  HiLink basicTodo		Todo
  HiLink basicFunction		Identifier
  HiLink basicVarRef      Type
  HiLink  muli1		Statement
  HiLink  muli2		Identifier
  HiLink basicTypeSpecifier Type
  HiLink basicFilenumber basicTypeSpecifier
  "hi basicMathsOperator term=bold cterm=bold gui=bold

  delcommand HiLink
endif

let b:current_syntax = "muli"

" vim: ts=3
