"Enable Vundle
set nocompatible
filetype off
let win_shell = (has('win32') || has('win64')) && &shellcmdflag =~ '/'
let win_gui = (has('gui_running') && (win_shell))
let vimDir = win_shell ? '$HOME/vimfiles' : '$HOME/.vim'
let &runtimepath .= ',' . expand(vimDir . '/bundle/Vundle.vim')
call vundle#begin(expand(vimDir . '/bundle'))

"Get Vundle Pluginss
Plugin 'VundleVim/Vundle.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-commentary'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-unimpaired'
Plugin 'tpope/vim-repeat'
Plugin 'bling/vim-airline'
Plugin 'kien/ctrlp.vim'
Plugin 'xolox/vim-easytags'
Plugin 'xolox/vim-misc'
Plugin 'majutsushi/tagbar'

"Get Vundle Color schemes
Plugin 'altercation/vim-colors-solarized'
Plugin 'chriskempson/base16-vim'
Plugin 'lsdr/monokai'
Plugin 'morhetz/gruvbox'
Plugin 'romainl/Apprentice'

"End Vundle
call vundle#end()
filetype plugin indent on

"Leader
let mapleader = "\<Space>"

"Syntax
syntax enable

"Tabs
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab

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

"Title
set title

"Display
set background=dark
if win_gui
    colorscheme gruvbox
    set guioptions-=m  "remove menu bar
    set guioptions-=T  "remove toolbar
    set guioptions-=r  "remove right-hand scroll bar
    set guioptions-=L  "remove left-hand scroll bar
elseif win_shell
    colorscheme elflord
else
    set t_Co=256
    let g:solarized_termcolors=256
    colorscheme solarized
endif
set cursorline

"Word wrap
:set nowrap

"Friendly Backspace
:set backspace=indent,eol,start

"Whitespace
:set listchars=eol:$,tab:>-,trail:~,extends:>,precedes:<
:set list

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

"Highlight greater than 100 columns"
if exists('+colorcolumn')
    set colorcolumn=100
else
    :au BufWinEnter * let w:m2=matchadd('ErrorMsg', '\%>100v.\+', -1)
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

" Copy and paste to system clipboard
vmap <Leader>y "+y
vmap <Leader>d "+d
nmap <Leader>p "+p
nmap <Leader>P "+P
vmap <Leader>p "+p
vmap <Leader>P "+P

" Enter visual mode
nmap <Leader><Leader> V

" Write fast
nnoremap <Leader>w :w<CR>
"
" Splits
map <leader>ex :Explore<CR>
map <leader>vex :Vexplore<CR>
map <leader>sex :Sexplore<CR>

"Tagbar
nnoremap <silent> <leader>tt :TagbarToggle<CR>

"Copy full path to system clipboard
nnoremap <leader>cp :let @+ = expand("%:p")

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

" Source the vimrc file after saving it
if has("autocmd")
  autocmd bufwritepost $MYVIMRC source $MYVIMRC
endif
