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
set t_Co=256
let g:solarized_termcolors=256
colorscheme solarized
set cursorline

"Word wrap
:set nowrap

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

" Source the vimrc file after saving it
if has("autocmd")
  autocmd bufwritepost .vimrc source $MYVIMRC
endif
