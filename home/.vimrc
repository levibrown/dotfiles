set runtimepath^=~/.vim/bundle/ctrlp.vim

set nocompatible              " be iMproved, required
filetype off                  " required

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'gmarik/Vundle.vim'
Plugin 'jonathanfilip/vim-lucius'
Plugin 'gregsexton/Atom'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-rails.git'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-commentary'
Plugin 'tpope/vim-endwise'
Plugin 'tpope/vim-ragtag'
Plugin 'tpope/vim-rvm'
Plugin 'vim-ruby/vim-ruby'
Plugin 'gregsexton/gitv'
Plugin 'scrooloose/nerdtree'
Plugin 'rking/ag.vim'
Plugin 'kien/ctrlp.vim'
Plugin 'bling/vim-airline'
Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
Plugin 'austintaylor/vim-choosecolor'
Plugin 'ap/vim-css-color'
Plugin 'cakebaker/scss-syntax.vim'
Plugin 'ghostbar/snipmate.vim'
Plugin 'AndrewRadev/switch.vim'
Plugin 'kana/vim-textobj-user'
Plugin 'rhysd/vim-textobj-ruby'
Plugin 'jiangmiao/auto-pairs'
Plugin 'majutsushi/tagbar'
Plugin 't9md/vim-ruby-xmpfilter'
Plugin 'kchmck/vim-coffee-script'
Plugin 'mustache/vim-mustache-handlebars'

call vundle#end()            " required
filetype plugin indent on    " required

inoremap jj <esc>
syntax enable

let mapleader=","
let maplocalleader=","
set clipboard=unnamed         " mvim use clipboard
set complete=.,t              " auto-complete use tags and open file

nnoremap - :Switch<cr>
nmap <leader>tb :TagbarToggle<CR>   " Toggle Tagbar

" auto-pairs
let g:AutoPairs={'(':')', '[':']', '{':'}'}

" Splits
" map ctrl-w + hjkl to ctrl-hjkl
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Window resizing mappings
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
let g:airline_section_x = airline#section#create_right([''])
let g:airline_section_y = airline#section#create_right([''])

let g:airline#extensions#default#section_truncate_width = {
  \ 'b': 60,
  \ 'x': 80,
  \ 'y': 80,
  \ 'z': 80
  \ }

let g:airline_mode_map = {
  \ '__' : '-',
  \ 'n'  : 'N',
  \ 'i'  : 'I',
  \ 'R'  : 'R',
  \ 'v'  : 'V',
  \ 'V'  : 'V-L',
  \ 'c'  : 'C',
  \ '' : 'V-B',
  \ 's'  : 'S',
  \ 'S'  : 'S-L',
  \ '' : 'S-B',
  \ }

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


if executable('ag')
  set grepprg=ag\ --nogroup\ --nocolor
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
  let g:ctrlp_use_caching = 1
endif

let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/]\.(git|bower_components|node_modules)$',
  \ 'file': '\v\.(exe|so|dll|swp)$',
  \ }

" bind K to grep word under cursor
nnoremap K :Ag! "\b<C-R><C-W>\b"<CR>:cw<CR><CR>

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
map <leader>n :NERDTreeToggle /Users/levibrown/Sites <CR>
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
