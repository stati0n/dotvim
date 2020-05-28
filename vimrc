"Enable modern Vim features.
set nocompatible

"Leader
let mapleader = "\<Space>"
let g:mapleader = g:mapleader

" Temporary File locations
set undofile
set undodir=~/.vim/.undo//
set backupdir=~/.vim/.backup//
set directory=~/.vim/.swp//


"Vunle configuration
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" Get Vundle Plugins
Plugin 'gmarik/vundle'

" Sessions
Plugin 'xolox/vim-misc'
Plugin 'xolox/vim-session'
let g:session_autosave = 'yes'
let g:session_autoload = 'yes'
let g:session_autosave_periodic = 1

Plugin 'tpope/vim-commentary'

Plugin 'tpope/vim-surround'
" Markdown bold
let b:surround_{char2nr('b')} = "**\r**"

Plugin 'tpope/vim-repeat'

Plugin 'tpope/vim-fugitive'

Plugin 'tpope/vim-unimpaired'

" Signify
Plugin 'mhinz/vim-signify'
let g:signify_sign_change='~'

Plugin 'bling/vim-airline'

Plugin 'kien/ctrlp.vim'

"Get Color schemes
Plugin 'altercation/vim-colors-solarized'
Plugin 'chriskempson/base16-vim'
Plugin 'lsdr/monokai'
Plugin 'morhetz/gruvbox'
Plugin 'romainl/Apprentice'
Plugin 'yassinebridi/vim-purpura'

"End Vundle
call vundle#end()
filetype plugin indent on


"Syntax
syntax enable

"Tabs
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set smarttab

"Searches
set incsearch
set hlsearch
set ignorecase
set smartcase

"Line numbers
set number

"Indent
set autoindent
set smartindent
set smarttab

"Title
set title

"Display
set background=dark
set t_Co=256
set cursorline
set scrolloff=3
set laststatus=2
set display+=lastline

"Word wrap
"set textwidth=79
:set nowrap

"Friendly Backspace
:set backspace=2

"Whitespace
:set listchars=eol:$,tab:>-,trail:~,extends:>,precedes:<
noremap <leader>h :set list!<CR>

"Paste toggle
:set pastetoggle=<F2>

"Lots of history
:set history=1000

"Let vim create hidden buffers
set hidden

"Format JSON
nmap <leader>jt <Esc>:%!python -m json.tool<CR><Esc>:set filetype=json<CR>

"Highlight trailing spaces while not in insert mode"
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/

"Highlight greater than 80 columns"
if exists('+colorcolumn')
    set colorcolumn=80
else
    :au BufWinEnter * let w:m2=matchadd('ErrorMsg', '\%>80v.\+', -1)
endif

"Set Status Line"
:set nocompatible ruler laststatus=2 showcmd showmode number

" Function that preserves state
function! Preserve(command)
  " Preparation: save last search, and cursor position.
  let _s=@/
  let l = line(".")
  let c = col(".")
  " Do the business:
  execute a:command
  " Clean up: restore previous search history, and cursor position
  let @/=_s
  call cursor(l, c)
endfunction

" Remove trailing whitespace from file
nmap _$ :call Preserve("%s/\\s\\+$//e")<CR>
" Retab file
nmap _= :call Preserve("normal gg=G")<CR>

" Map %% to expand directory of current file anywhere at the command line
cnoremap %% <C-R>=fnameescape(expand('%:h')).'/'<cr>

" Edit commands starting with current file's directory
map <leader>ew :e %%
map <leader>es :sp %%
map <leader>ev :vsp %%
map <leader>et :tabe %%

" Splits
nnoremap <Leader><Bar> <C-w>v
nnoremap <Leader>\ <C-w>v
nnoremap <Leader>- <C-w>s
nnoremap <Leader>_ <C-w>s

map <Leader>cd :cd %:p:h<CR>
map <Leader>lcd :lcd %:p:h<CR>

"DiffOrig via http://vimdoc.sourceforge.net/htmldoc/diff.html#:DiffOrig
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
          \ | wincmd p | diffthis
endif

" Try to replace ctrlP
" Find from project root
set path=.,**
nnoremap <leader>f :find *
nnoremap <leader>s :sfind *
nnoremap <leader>v :vert sfind *
nnoremap <leader>t :tabfind *

" Find from directory of current file
nnoremap <leader>F :find <C-R>=expand('%:h').'/*'<CR>
nnoremap <leader>S :sfind <C-R>=expand('%:h').'/*'<CR>
nnoremap <leader>V :vert sfind <C-R>=expand('%:h').'/*'<CR>
nnoremap <leader>T :tabfind <C-R>=expand('%:h').'/*'<CR>

" Easily switch between buffers
nnoremap gb :ls<CR>:b<Space>

" Disable highlight
map <silent> <leader><cr> :noh<cr>

" Smart way to move between windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" Insert line
nnoremap K a<CR><Esc>

" Source the vimrc file after saving it
if has("autocmd")
  autocmd bufwritepost .vimrc source $MYVIMRC
endif
