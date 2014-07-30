" Vim syntax file
" Language: Slim
" Maintainer: Andrew Stone <andy@stonean.com>
" Version:  1
" Last Change:  2010 Sep 25
" TODO: Feedback is welcomed.

" Quit when a syntax file is already loaded.
if exists("b:current_syntax")
  finish
endif

if !exists("main_syntax")
  let main_syntax = 'slim'
endif
" Allows a per line syntax evaluation.
let b:ruby_no_expensive = 1

" Include Ruby syntax highlighting
syn include @slimRubyTop syntax/ruby.vim
unlet! b:current_syntax
syn include @htmlTagTop syntax/html.vim
" Include Haml syntax highlighting
syn include @slimHaml syntax/haml.vim
unlet! b:current_syntax

syn match slimBegin  "^\s*\(&[^= ]\)\@!" nextgroup=slimTag,slimClassChar,slimIdChar,slimRuby

syn region  rubyCurlyBlock start="{" end="}" contains=@slimRubyTop contained

syn match  rubySlimSymbol		"[]})\"':]\@<!:\%(\^\|\~\|<<\|<=>\|<=\|<\|===\|[=!]=\|[=!]\~\|!\|>>\|>=\|>\||\|-@\|-\|/\|\[]=\|\[]\|\*\*\|\*\|&\|%\|+@\|+\|`\)"
syn match  rubySlimSymbol		"[]})\"':]\@<!:\$\%(-.\|[`~<=>_,;:!?/.'"@$*\&+0]\)"
syn match  rubySlimSymbol		"[]})\"':]\@<!:\%(\$\|@@\=\)\=\%(\h\|[^\x00-\x7F]\)\%(\w\|[^\x00-\x7F]\)*"
syn match  rubySlimSymbol		"[]})\"':]\@<!:\%(\h\|[^\x00-\x7F]\)\%(\w\|[^\x00-\x7F]\)*\%([?!=]>\@!\)\="
syn region rubySlimSymbol		start="[]})\"':]\@<!:'"  end="'"  skip="\\\\\|\\'"  contains=rubyQuoteEscape fold
syn region rubySlimSymbol		start="[]})\"':]\@<!:\"" end="\"" skip="\\\\\|\\\"" contains=@rubyStringSpecial fold

syn region rubySlimSymbol matchgroup=rubySymbolDelimiter start="%s\z([~`!@#$%^&*_\-+=|\:;"',.? /]\)"   end="\z1" skip="\\\\\|\\\z1" fold
syn region rubySlimSymbol matchgroup=rubySymbolDelimiter start="%s{"				   end="}"   skip="\\\\\|\\}"	fold contains=rubyNestedCurlyBraces,rubyDelimEscape
syn region rubySlimSymbol matchgroup=rubySymbolDelimiter start="%s<"				   end=">"   skip="\\\\\|\\>"	fold contains=rubyNestedAngleBrackets,rubyDelimEscape
syn region rubySlimSymbol matchgroup=rubySymbolDelimiter start="%s\["				   end="\]"  skip="\\\\\|\\\]"	fold contains=rubyNestedSquareBrackets,rubyDelimEscape
syn region rubySlimSymbol matchgroup=rubySymbolDelimiter start="%s("				   end=")"   skip="\\\\\|\\)"	fold contains=rubyNestedParentheses,rubyDelimEscape
" syn match  rubySlimSymbol		"\%([{(,]\_s*\)\@<=\l\w*[!?]\=::\@!"he=e-1
" syn match  rubySlimSymbol		"[]})\"':]\@<!\%(\h\|[^\x00-\x7F]\)\%(\w\|[^\x00-\x7F]\)*[!?]\=:[[:space:],]\@="he=e-1
" syn match  rubySlimSymbol		"\%([{(,]\_s*\)\@<=[[:space:],{]\l\w*[!?]\=::\@!"hs=s+1,he=e-1
" Needed for most symbols
syn match  rubySlimSymbol		"[[:space:],{(]\%(\h\|[^\x00-\x7F]\)\%(\w\|[^\x00-\x7F]\)*[!?]\=:[[:space:],]\@="hs=s+1,he=e-1


syn cluster slimRubyTop  contains=rubyCurlyBlock,rubyInteger,rubyCapitalizedMethod,rubyOperator,rubyString,rubySlimSymbol,rubyControl,rubyGlobalVariable,rubyInstanceVariable
" syn cluster slimRubyTop add=rubyCurlyBlock
syn cluster slimComponent contains=slimClassChar,slimIdChar,slimWrappedAttrs,slimRuby,slimAttr,slimInlineTagChar

syn keyword slimDocType        contained html 5 1.1 strict frameset mobile basic transitional
syn match   slimDocTypeKeyword "^\(doctype\)\s\+" nextgroup=slimDocType

syn keyword slimTodo        FIXME TODO NOTE OPTIMIZE XXX contained
syn keyword htmlTagName     contained script

syn match slimTag           "\w\+[><]*"         contained contains=htmlTagName nextgroup=@slimComponent
syn match slimIdChar        "#{\@!"        contained nextgroup=slimId
syn match slimId            "\%(\w\|-\)\+" contained nextgroup=@slimComponent
syn match slimClassChar     "\."           contained nextgroup=slimClass
syn match slimClass         "\%(\w\|-\)\+" contained nextgroup=@slimComponent
syn match slimInlineTagChar "\s*:\s*"      contained nextgroup=slimTag,slimClassChar,slimIdChar

syn region slimWrappedAttrs matchgroup=slimWrappedAttrsDelimiter start="\s*{\s*" skip="}\s*\""  end="\s*}\s*"  contained contains=slimAttr nextgroup=slimRuby
syn region slimWrappedAttrs matchgroup=slimWrappedAttrsDelimiter start="\s*\[\s*" end="\s*\]\s*" contained contains=slimAttr nextgroup=slimRuby
syn region slimWrappedAttrs matchgroup=slimWrappedAttrsDelimiter start="\s*(\s*"  end="\s*)\s*"  contained contains=slimAttr nextgroup=slimRuby

syn match slimAttr /\s*\%(\w\|-\)\+\s*=/me=e-1 contained contains=htmlArg nextgroup=slimAttrAssignment
syn match slimAttrAssignment "\s*=\s*" contained nextgroup=slimWrappedAttrValue,slimAttrString

syn region slimWrappedAttrValue start="[^"']" end="\s\|$" contained contains=slimAttrString,@slimRubyTop nextgroup=slimAttr,slimRuby,slimInlineTagChar
syn region slimWrappedAttrValue matchgroup=slimWrappedAttrValueDelimiter start="{" end="}" contained contains=slimAttrString,@slimRubyTop nextgroup=slimAttr,slimRuby,slimInlineTagChar
syn region slimWrappedAttrValue matchgroup=slimWrappedAttrValueDelimiter start="\[" end="\]" contained contains=slimAttrString,@slimRubyTop nextgroup=slimAttr,slimRuby,slimInlineTagChar
syn region slimWrappedAttrValue matchgroup=slimWrappedAttrValueDelimiter start="(" end=")" contained contains=slimAttrString,@slimRubyTop nextgroup=slimAttr,slimRuby,slimInlineTagChar

syn region slimAttrString start=+\s*"+ skip=+\%(\\\\\)*\\"+ end=+"\s*+ contained contains=slimInterpolation,slimInterpolationEscape nextgroup=slimAttr,slimRuby,slimInlineTagChar
syn region slimAttrString start=+\s*'+ skip=+\%(\\\\\)*\\"+ end=+'\s*+ contained contains=slimInterpolation,slimInterpolationEscape nextgroup=slimAttr,slimRuby,slimInlineTagChar

syn region slimInnerAttrString start=+\s*"+ skip=+\%(\\\\\)*\\"+ end=+"\s*+ contained contains=slimInterpolation,slimInterpolationEscape nextgroup=slimAttr
syn region slimInnerAttrString start=+\s*'+ skip=+\%(\\\\\)*\\"+ end=+'\s*+ contained contains=slimInterpolation,slimInterpolationEscape nextgroup=slimAttr

syn region slimInterpolation matchgroup=slimInterpolationDelimiter start="#{" end="}" contains=@slimRubyTop containedin=javascriptStringS,javascriptStringD,slimWrappedAttrs
syn region slimInterpolation matchgroup=slimInterpolationDelimiter start="#{{" end="}}" contains=@slimRubyTop containedin=javascriptStringS,javascriptStringD,slimWrappedAttrs
syn match  slimInterpolationEscape "\\\@<!\%(\\\\\)*\\\%(\\\ze#{\|#\ze{\)"

syn region slimRuby matchgroup=slimRubyOutputChar start="\s*[=]\==[']\=" skip="\%\(,\s*\|\\\)$" end="$" contained contains=@slimRubyTop keepend
syn region slimRuby matchgroup=slimRubyChar       start="\s*-"           skip="\%\(,\s*\|\\\)$" end="$" contained contains=@slimRubyTop keepend

syn match slimComment /^\(\s*\)[/].*\(\n\1\s.*\)*/ contains=slimTodo
syn match slimText    /^\(\s*\)[`|'].*\(\n\1\s.*\)*/ contains=slimInterpolation

syn match slimFilter /\s*\w\+:\s*/                            contained
syn match slimHaml   /^\(\s*\)\<haml:\>.*\(\n\1\s.*\)*/       contains=@slimHaml,slimFilter

syn match slimIEConditional "\%(^\s*/\)\@<=\[\s*if\>[^]]*]" contained containedin=slimComment

hi def link slimAttrString                String
hi def link slimBegin                     String
hi def link slimClass                     Type
hi def link slimAttr                      Type
hi def link slimClassChar                 Type
hi def link slimComment                   Comment
hi def link slimDocType                   Identifier
hi def link slimDocTypeKeyword            Keyword
hi def link slimFilter                    Keyword
hi def link slimIEConditional             SpecialComment
hi def link slimId                        Identifier
hi def link slimIdChar                    Identifier
hi def link slimInnerAttrString           String
hi def link slimInterpolationDelimiter    Delimiter
hi def link slimRubyChar                  Special
hi def link slimRubyOutputChar            Special
hi def link slimText                      String
hi def link slimTodo                      Todo
hi def link slimWrappedAttrValueDelimiter Delimiter
hi def link slimWrappedAttrsDelimiter     Delimiter
hi def link slimInlineTagChar             Delimiter
hi def link rubySlimSymbol			          String


let b:current_syntax = "slim"
