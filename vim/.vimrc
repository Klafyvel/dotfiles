" Vi sucks
set nocompatible

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
Plugin 'flazz/vim-colorschemes'
Plugin 'scrooloose/syntastic'
Plugin 'Valloric/YouCompleteMe'
Plugin 'bling/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'scrooloose/nerdcommenter'
Plugin 'scrooloose/nerdtree'
Plugin 'Xuyuanp/nerdtree-git-plugin'
Plugin 'vim-scripts/indentpython.vim'
Plugin 'nvie/vim-flake8'
Plugin 'kien/ctrlp.vim'
Plugin 'tell-k/vim-autopep8'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

" Airline theme
let g:airline_theme='simple'

" Open nerdtree
" autocmd vimenter * NERDTree

" Encoding
set encoding=utf-8
set fileencoding=utf-8

" Syntax options
syn on
let python_highlight_all=1
syntax on

" Indent options
set showmatch
set shiftwidth=4 softtabstop=4
set tabstop=4 " Size of a tab character
set smartindent

" Mouse is evil, but sometimes useful
set mouse=a

" Interface
set number

set showcmd
set colorcolumn=80
set ruler
set scrolloff=3
set ls=2

" Allow files to be hidden in order to call :e without having to save
set hidden

" No audible bell but visual bell instead
set visualbell
set noerrorbells

" Searching
set hlsearch
set incsearch
set ignorecase
set smartcase

" Faster scroll
nnoremap <C-e> 3<C-e>
nnoremap <C-y> 3<C-y>

" Changing leader key for a more azerty-friendly one (or not)
let mapleader = ','

" Do the same but with another key for the local leader key
let maplocalleader = ';'

" Leader bindings
" nmap <silent> <Leader>nu :set relativenumber<CR>
nnoremap <silent> <Leader>sp :set spell!<CR>
nnoremap <silent> <Leader>b :b#<CR>

fun! StripTrailingWhitespace()
    " Do not strip the whitespaces on these specific filetypes
    if &ft =~ 'markdown'
        return
    endif
    %s/\s\+$//e
endfun

" Autocmd stuff
if has("autocmd")

    " Delete all useless whitespaces at the end of each line on saving
    au BufWritePre * call StripTrailingWhitespace()

    " Remember location in file
    au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal g'\"" | endif

    " Highlight trailing spaces
    au BufWinEnter * hi ExtraWhitespace ctermbg=red guibg=red
    au BufWinEnter * match ExtraWhitespace /\s\+$/

    " Custom syntax highlighting for specific extensions

    " C and C++ files
    au BufNewFile,BufRead *.h,*.c set ft=c.doxygen
    au BufNewFile,BufRead *.hpp,*.cpp set ft=cpp.doxygen

    " Yaml and JSON data files
    au BufRead,BufNewFile *.{yml,yaml} set ft=yaml
    au BufNewFile,BufRead *.json set ft=javascript

    " Eliom files for Ocsigen
    au BufNewFile,BufRead *.eliom set ft=ocaml

    " Markdown
    au BufRead,BufNewFile *.md set ft=markdown

    " Other misc autocmds

    " Autowrap on editing mails
    au BufRead /tmp/mutt-* set tw=72 colorcolumn=72

endif

" Allow backspacing over everything in insert mode
set backspace=indent,eol,start

" Wordwrap
set wrap
set linebreak

" Showing invisible characters with cool unicode chars
exec "set listchars=tab:\uBB ,trail:\uB7,nbsp:\u237D"
set list

hi NonText ctermfg=8 guifg=grey
hi SpecialKey ctermfg=8 guifg=grey

" Spellchecking
set spelllang=~/.vim/spell/fr.utf-8.spl
set spellfile=~/.vim/spell/fr.utf-8.add

" Completion
filetype plugin on
set omnifunc=syntaxcomplete#Complete

let g:ycm_autoclose_preview_window_after_completion=1

" open NERDTree with Ctrl+t
map <C-t> :NERDTreeToggle <CR>

" tab
map <C-Left> gT <CR>
map <C-Right> gt <CR>
map <C-n> :tabnew <CR>

" run Autopep8 on F8
nmap <F8> :Autopep8 <CR>
