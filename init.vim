" vim-plug {{{
function! DoRemote(arg)
  UpdateRemotePlugins
endfunction

call plug#begin()

Plug 'rafi/awesome-vim-colorschemes'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

Plug 'neoclide/coc.nvim', {'branch': 'release'}

Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'ludovicchabant/vim-gutentags'

Plug 'lervag/vimtex'

Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'


Plug 'jpalardy/vim-slime'
Plug 'JuliaEditorSupport/julia-vim'

" I am sorry litte computer, I do not want to harm you, but I have to.
Plug 'daeyun/vim-matlab', { 'do': function('DoRemote') }

call plug#end()

" }}}

" Mappings {{{
let mapleader = ","
" let mapleader="\<Space>"
let localmapleader = "\\"

" Copy and pasting
vnoremap <C-y> "*y :let @+=@*<CR>
noremap <leader>p "+P`[v`]=

" Easier move between methods
nnoremap <leader>m ]m

" Make moving between wraped lines more intuitive
nnoremap j gj
nnoremap k gk
nnoremap 0 g0
nnoremap ^ g^
nnoremap $ g$

" Execute current line with your shell interpreter and paste result in buffer
nnoremap Q !!$SHELL<CR>

" make moving between buffers easier
nmap gh <C-w>h
nmap gj <C-w>j
nmap gk <C-w>k
nmap gl <C-w>l

" make scolling faster
nnoremap J 5j
nnoremap K 5k
noremap <leader>j J
noremap <leader>k K

nnoremap <leader>sc :lclose<CR>
nnoremap <leader>sn :lnext<CR>
nnoremap <leader>sp :lprevious<CR>

nnoremap <leader><space> :noh<cr>
nnoremap <leader>x xp
nnoremap <enter> o<esc>
noremap <leader>- dd2kp
noremap <leader>_ ddp

" buffer navigations
nnoremap <leader>bn :bn<CR>
nnoremap <leader>bN :bp<CR>

" tag navigations
nnoremap <leader>tn :tn<CR>
nnoremap <leader>tN :tp<CR>

" make arrow keys usefull
nnoremap <C-Up> :resize +2<CR>
nnoremap <C-Down> :resize -2<CR>
nnoremap <C-Left> :vertical resize -2<CR>
nnoremap <C-Right> :vertical resize +2<CR>

" Enable folding with the spacebar
nnoremap <space> za
nnoremap <leader>rf :set foldlevel=1<CR>
nnoremap <leader>uf :set foldlevel=2<CR>

" TagBar
nnoremap <silent> <Leader>b :TagbarToggle<CR>

"Editing and sourcing ~/.vimrc
nnoremap <leader>ev :vsplit $MYVIMRC<CR>
nnoremap <leader>sv :source $MYVIMRC<CR>

" netrw
nnoremap <leader>ee :Explore<CR>
nnoremap <leader>le :Lexplore<bar>vertical resize 30<CR>

" move block of code
vnoremap J :m '>+1<cr>gv=gv
vnoremap K :m '<-2<cr>gv=gv

nnoremap <leader>a :call SwitchHeader("find")<CR>
nnoremap <leader>va :call SwitchHeader("vert sf")<CR>
nnoremap <leader>ta :call SwitchHeader("tab sf")<CR>

" }}}

" Options {{{

set number
set relativenumber
set ttimeoutlen=10

" Tab to spaces
set tabstop=2
set shiftwidth=2
set expandtab

" File fuzzy finding
set path+=**
set wildignore+=**/build/**

" See matching character
set showmatch

" Better indentation
set smartindent
set cindent
set cino=j1,(0,ws,Ws " Better C++ indentation of lambda function

" french and english spelling
set spelllang=en,fr

" }}}

" Plugin options {{{

" vim-airline
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif

let g:airline_powerline_fonts=1
let g:airline_detect_modified=1
let g:airline_detect_paste=1
let g:airline_theme='base16'

" Coc
" use <tab> for trigger completion and navigate to the next complete item
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction

inoremap <silent><expr> <Tab>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
nnoremap <leader>gd <Plug>(coc-definition)

" vimtex
let g:vimtex_compiler_progname = 'nvr'

" NerdTree
map <C-t> :NERDTreeToggle <CR>

" vim-slime
" let g:slime_target = "tmux"
let g:slime_target = "neovim"

" }}}


" colorscheme zenburn
colorscheme dracula
" colorscheme gotham

" Vimscript file settings {{{
augroup filetype_vim
    autocmd!
    autocmd FileType vim setlocal foldmethod=marker | setlocal foldlevel=0
augroup END
" }}}

" XML file settings {{{
augroup filetype_html
  autocmd!
	autocmd BufNewFile,BufRead *.launch,*.ui set filetype=xml
augroup END
" }}}

" Python file settings {{{
augroup filetype_python
    autocmd!
	" enable folding
	autocmd bufnewfile,bufread python setlocal tabstop=4 softtabstop=4 shiftwidth=4 textwidth=120 expandtab autoindent fileformat=unix foldlevel=1
  autocmd filetype python nnoremap <leader>r :CocCommand python.execInTerminal<CR>
augroup end
" }}}

" Julia file settings {{{
augroup filetype_julia
  let g:latex_to_unicode_tab = 0
  autocmd!
	autocmd BufNewFile,BufRead *.jl set filetype=julia
  set tabstop=4
  set shiftwidth=4
  set expandtab
augroup end
" }}}

" Terminal settings  {{{

" exit terminal with ESC
tnoremap <Esc> <C-\><C-n>
nnoremap <F1> :vsplit term://julia<CR>i
nnoremap <F2> :vsplit term://zsh<CR>i
nnoremap <F3> :vsplit term://bpython3<CR>i


tnoremap <C-Up> <C-\><C-n>:resize +2<CR>i
tnoremap <C-Down> <C-\><C-n>:resize -2<CR>i
tnoremap <C-Left> <C-\><C-n>:vertical resize -2<CR>i
tnoremap <C-Right> <C-\><C-n>:vertical resize +2<CR>i

tnoremap <C-t> <C-\><C-n>:NERDTreeToggle<CR>

" }}}

" Matlab {{{

let g:matlab_server_split = 'horizontal'

" }}}

" YAML {{{

autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab

" }}}

" Functions {{{

function! SwitchHeader(cmd)
  let filename = expand("%:t:r")
  if expand("%:e") == "hpp"
    let filename = filename . ".cpp"
    echom filename
    execute(a:cmd . " " . filename)
  elseif expand("%:e") == "cpp"
    let filename = filename . ".hpp"
    echom filename
    execute(a:cmd . " " . filename)
  endif
endfunction

" }}}
