set runtimepath^=~/.vim/bundle/ctrlp.vim
filetype off                   " required!

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Bundle 'gmarik/vundle'
Bundle 'jonathanfilip/vim-lucius'
Bundle 'gregsexton/Atom'
Bundle 'tpope/vim-fugitive'
Bundle 'tpope/vim-rails.git'
Bundle 'tpope/vim-surround'
Bundle 'tpope/vim-commentary'
Bundle 'tpope/vim-endwise'
Bundle 'tpope/vim-ragtag'
Bundle 'tpope/vim-rvm'
Bundle 'vim-ruby/vim-ruby'
Bundle 'gregsexton/gitv'
Bundle 'scrooloose/nerdtree'
Bundle 'kien/ctrlp.vim'
Bundle 'bling/vim-airline'
Bundle 'rstacruz/sparkup', {'rtp': 'vim/'}
Bundle 'austintaylor/vim-choosecolor'
Bundle 'ap/vim-css-color'
Bundle 'cakebaker/scss-syntax.vim'
Bundle 'ghostbar/snipmate.vim'
Bundle 'AndrewRadev/switch.vim'
Bundle 'kana/vim-textobj-user'
Bundle 'rhysd/vim-textobj-ruby'
Bundle 'jiangmiao/auto-pairs'
Bundle 'majutsushi/tagbar'
Bundle 't9md/vim-ruby-xmpfilter'
Bundle "szw/vim-ctrlspace" 
Bundle 'kchmck/vim-coffee-script'
Bundle 'mustache/vim-mustache-handlebars'

inoremap jj <esc>
syntax enable
filetype plugin indent on     " required!

let mapleader=","
let maplocalleader=","
set clipboard=unnamed         " mvim use clipboard
set complete=.,t              " auto-complete use tags and open file

nnoremap - :Switch<cr>
nmap <leader>tb :TagbarToggle<CR>   " Toggle Tagbar

" Splits
" map ctrl-w + hjkl to ctrl-hjkl
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Window resizing mappings /*{{{*/
nnoremap <Up><Up> <C-W>10+
nnoremap <Down><Down> <C-W>10-
nnoremap <Left><Left> <C-W>10<
nnoremap <Right><Right> <C-W>10>

" better defaults for splits
set splitbelow
set splitright

nmap <C-\> :vsplit<CR>:let word=expand("<cword>")<CR><C-W><C-W>:exec "tag" word<CR>

set mouse=a                 "use mouse in iterm

" Use spaces instead of tabs at the start of the line
set smarttab
set expandtab

set title                   " Reset the window title in non-GUI mode to something a little more helpful.
set foldmethod=marker       " Use a manual foldmethod so that folds persist in files

" Tab completion in command mode shows all possible completions, shell style.
set wildmenu
set wildmode=longest:full,full

" Custom Fugitive shortcuts
noremap <leader>gs :Gstatus <CR><C-w>20+
noremap <leader>gc :Gcommit <CR>
noremap <leader>gd :Gdiff <CR>
noremap <leader>gb :Gblame <CR>

" GitV
let g:Gitv_DoNotMapCtrlKey = 1
nmap <leader>gv :Gitv --all<cr>
nmap <leader>gV :Gitv! --all<cr>
vmap <leader>gV :Gitv! --all<cr>
cabbrev git Git
highlight diffAdded guifg=#00bf00
highlight diffRemoved guifg=#bf0000
set lazyredraw

set smartcase
syntax on
colorscheme lucius
set t_Co=256
set ambiwidth=double

" No need for the Error Bell in any form, thanks
autocmd! GUIEnter * set vb t_vb=
set noerrorbells
set novisualbell

" reload vimrc
nnoremap <leader>rv :source $MYVIMRC<cr>

let g:airline_powerline_fonts = 1
let g:airline_theme = 'lucius'
let g:airline_right_sep = ''
let g:airline_exclude_preview = 1 "for ctrl-space

function! AirLineConfig()
  function! Modified()
    return &modified ? " +" : ''
  endfunction

  call airline#parts#define_raw('filename', '%<%f')
  call airline#parts#define_function('modified', 'Modified')

  let g:airline_section_b = airline#section#create_left(['filename'])
  let g:airline_section_c = airline#section#create([''])
  let g:airline_section_gutter = airline#section#create(['modified', '%='])
  let g:airline_section_x = airline#section#create_right([''])
  let g:airline_section_y = airline#section#create_right([''])
  let g:airline_section_z = airline#section#create(['branch'])
endfunction
autocmd Vimenter * call AirLineConfig()

set nocompatible            " Disable vi-compatibility
set laststatus=2            " Always show the statusline
set encoding=utf-8          " Necessary to show Unicode glyphs
set number                  " use numbers 
set ignorecase
set tabstop=2
set shiftwidth=2
set expandtab
set hlsearch
map // :noh <cr>

" The Silver Searcher
if executable('ag')
  set grepprg=ag\ --nogroup\ --nocolor
  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0
endif

" bind K to grep word under cursor
nnoremap K :grep! "\b<C-R><C-W>\b"<CR>:cw<CR><CR>

command! -nargs=+ -complete=file -bar Ag silent! grep! <args>|cwindow|redraw!

" bind \ (backward slash) to grep shortcut
nnoremap \ :Ag<SPACE>

" Quickfix window auto height
au FileType qf call AdjustWindowHeight(3, 40)
function! AdjustWindowHeight(minheight, maxheight)
  let l = 1
  let n_lines = 0
  let w_width = winwidth(0)
  while l <= line('$')
      " number to float for division
      let l_len = strlen(getline(l)) + 0.0
      let line_width = l_len/w_width
      let n_lines += float2nr(ceil(line_width))
      let l += 1
  endw
  exe max([min([n_lines, a:maxheight]), a:minheight]) . "wincmd _"
endfunction

" Nerdtree
let g:NERDTreeWinSize = 40
map <leader>n :NERDTreeToggle /Users/levibrown/g5 <CR>
map <leader><leader>n :NERDTreeFind <CR>

let NERDTreeQuitOnOpen=1    "close nerdtree after file opened
let g:NERDTreeChDirMode=2

set guioptions-=r           " Disable right sidebar mvim
set guioptions-=L           " Disable left sidebar mvim

let g:ragtag_global_maps = 1

" SuperTab
let g:SuperTabMappingTabLiteral = '<tab>' " Keep tab default
let g:SuperTabMappingForward = '<C-tab>'
let g:SuperTabMappingBackward = '<s-tab>' 

augroup sparkup_types
  autocmd!
  autocmd FileType eruby runtime! ftplugin/html/sparkup.vim
augroup END

" Ruby specific options
let ruby_operators = 1
augroup rubyindentstyle
autocmd!
  autocmd FileType ruby,eruby,yaml set autoindent shiftwidth=2 softtabstop=2 expandtab
augroup END
