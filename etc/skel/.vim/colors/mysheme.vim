" Vim color file
" Maintainer:	Bragagia Mathias <mathias.bragagia@gmail.com>

hi clear Normal
set bg&

hi clear

if exists("syntax_on")
  syntax reset
endif

let colors_name = "mysheme"

set t_Co=8

hi Normal             ctermfg=White
hi MatchParen         ctermbg=DarkGray
hi NonText            ctermfg=Gray
                      
hi Comment            cterm=italic ctermfg=DarkGray
hi SpecialComment     cterm=italic ctermfg=DarkYellow
                      
hi Constant           ctermfg=DarkCyan
hi String             ctermfg=DarkYellow
hi Character          ctermfg=Yellow
hi Number             ctermfg=DarkCyan
hi Boolean            ctermfg=Blue
hi Float              ctermfg=DarkCyan
" TagHL               
hi GlobalConstant     ctermfg=DarkGreen
                      
hi Identifier         ctermfg=DarkBlue
hi Function           ctermfg=DarkBlue
                      
hi Statement          ctermfg=DarkMagenta
"hi Repeat             ctermfg=Green
"hi Label              ctermfg=Green
hi Operator           ctermfg=Red
"hi Keyword            ctermfg=Green
"hi Exception          ctermfg=Green
                      
hi PreProc            ctermfg=Yellow
hi Include            ctermfg=Yellow
hi Define             ctermfg=Yellow
hi Macro              ctermfg=Yellow
hi PreCondit          ctermfg=Yellow
                      
hi Type               ctermfg=DarkGreen
hi StorageClass       ctermfg=DarkGreen
hi Structure          ctermfg=DarkGreen
hi Typedef            ctermfg=DarkGreen
" TagHL               
hi Class              ctermfg=DarkGreen
hi DefinedName        ctermfg=DarkGreen
hi Enumerator         ctermfg=DarkGreen
hi EnumerationName    ctermfg=DarkGreen
hi Member             ctermfg=DarkGreen
hi Structure          ctermfg=DarkGreen
hi Union              ctermfg=DarkGreen
hi GlobalVariable     ctermfg=DarkGreen
hi LocalVariable      ctermfg=DarkGreen
                      
hi Special            ctermfg=Red
hi SpecialChar        ctermfg=Yellow
hi Tag                ctermfg=White ctermbg=Gray
hi Delimiter          ctermfg=Gray
hi Debug              ctermfg=Red
hi SpecialKey         ctermfg=Black
                      
hi LineNr             ctermfg=Black
                      
hi TabLineFill        cterm=NONE
hi TabLine            cterm=NONE ctermfg=White ctermbg=Black
hi TabLineSel         cterm=NONE ctermfg=White

hi VertSplit          ctermfg=Black
                      
hi CursorLine         cterm=NONE
