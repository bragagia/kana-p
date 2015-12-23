set nocompatible
set number
set cursorline
set updatetime=1000

filetype plugin on
filetype plugin indent on
syntax on

if &term =~ "xterm\\|rxvt"
  " insert mode
  " let &t_SI = "\<Esc>]12;orange\x7"
  let &t_SI .= "\<Esc>[5 q"
  " normal mode
  " let &t_EI = "\<Esc>]12;orange\x7"
  " silent !echo -ne "\033]12;orange\007"
  let &t_EI .= "\<Esc>[2 q"
  " reset cursor when vim exits
  " autocmd VimLeave * silent !echo -ne "\033]12;gray\007"
  " 1 or 0 -> blinking block
  " 3 -> blinking underscore
  " 5 -> blinking vertical bar
  " 6 -> solid vertical bar
endif

set hidden
set laststatus=2
set listchars=tab:··
set fillchars+=vert:\ 
set list
set backspace=indent,eol,start
set ruler
set showcmd
set scrolloff=5
set incsearch

set mouse=a
set ttymouse=urxvt

if has("vms")
	set nobackup
else
	set backup
endif

set t_Co=256

colorscheme mysheme

call pathogen#infect()
call pathogen#helptags()

au BufNewFile,BufRead *.z set filetype=c

let mapleader=" "

let g:delimitMate_expand_cr = 1
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#whitespace#enabled = 0

nmap s <Plug>(easymotion-s2)
map  / <Plug>(easymotion-sn)
omap / <Plug>(easymotion-tn)

let NERDTreeMinimalUI=1
let NERDTreeQuitOnOpen=1
let NERDTreeDirArrows=0
let NERDTreeIgnore = ['\.[od]$', '\~$']

nmap <Leader>OA :wincmd k<CR>
nmap <Leader>OB :wincmd j<CR>
nmap <Leader>OD :wincmd h<CR>
nmap <Leader>OC :wincmd l<CR>
nmap £ :NERDTreeToggle<CR>
nmap Oc :bn<CR>
nmap Od :bp<CR>
imap Oc :bn<CR>
imap Od :bp<CR>

nmap <Tab> ==
imap œ ==A
map [29~ 
imap [29~ 

set tabstop=4
set shiftwidth=4
set noexpandtab
set autoindent

command -nargs=* Make make <args> | cwindow 3

source ~/.vim/epitech.vim

set listchars+=nbsp:#

autocmd VimEnter * AirlineTheme wombat
