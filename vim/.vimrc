runtime! debian.vim

if has("syntax")
  syntax on
endif

set background=dark

set showcmd		" Show (partial) command in status line.
set showmatch		" Show matching brackets.
set mouse=a		" Enable mouse usage (all modes)

set number

set nowrap
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab

set nowb
set noswapfile
set noar

highlight NoTabs ctermbg=red ctermfg=white guibg=#592929
match NoTabs /\t/

filetype on

let Tlist_Process_File_Always = 1
let Tlist_Exit_Only_Window = 1
let Tlist_Use_Right_Window = 1
let Tlist_Auto_Open = 1
let Tlist_Display_Prototype = 1

execute pathogen#infect()
syntax on

autocmd vimenter * NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
