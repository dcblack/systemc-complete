" VIM settings
set nocompatible
set autoindent         " always set autoindenting on
set backspace=2	       " allow backspacing over everything in insert mode
set backup
set writebackup
set undodir=./$und,$HOME/$und,$HOME/bak,.,/tmp
set undofile
set backupdir=./$bak,$HOME/$bak,$HOME/bak,.,/tmp
set backupext=~
set backupskip=/tmp/*
set cpoptions+=W
set spell
set spelllang=en_us
set cmdheight=2
set statusline=%<%f%h%m%r%{fugitive#statusline()}%=%b\ 0x%B\ \ %l,%c%V\ %P
set diffopt=filler,iwhite
set exrc
set fileformats=unix,mac,dos
set history=150
set number
set hlsearch
set incsearch
set noignorecase
set path=,,.
set path+=../Includes
set path+=$HOME/include
set path+=/opt/local/include
set path+=/usr/local/include
set path+=$INCLUDE
set path+=$SYSTEMC_HOME/include
set printheader="%=Page %N"
set report=2
set ruler
set showtabline=2
set scrolloff=2
set listchars=tab:>-,trail:-,nbsp:+,extends:>,precedes:<
set nolist
set showcmd
set showmatch
set showmode
set linebreak
set sidescroll=5
set splitbelow
set suffixes=.bak.o.swp.db.bin.sea.sit.tar.Z.cpt.z.exe.dmp.gz.taz
set expandtab
set shiftwidth=2
set softtabstop=2
set tabstop=8
set tags=tags\ ../tags
set textwidth=0
set undolevels=1000
set nowrap
set wildmenu
set menuitems=42
"For non-GUI
if !has("gui_running")
  set cpoptions-=<
  set wildcharm=<C-Z>
  map <F5> :emenu <C-Z>
else
  set toolbar=icons,text,tooltips
endif
set wildignore+=*.o,*.so,*.a,*.x,*.exe,*.P,.d
set winheight=10
set wrapmargin=-200
set wrapscan
set cryptmethod=blowfish2
let g:netrw_rsync_cmd = "rsync -e ssh -a"
"-------------------------------------------------------------------------------
" Goto next unresolved template item {:lc:A:} or /*{:b:}*/
:nmap <C-N> /\(\/\*\)\?{:.\{-}:}\(\*\/\)\?<CR>
"-------------------------------------------------------------------------------
" Goto next window
:nmap gw <C-W>w
"-------------------------------------------------------------------------------
" Goto previous window
:nmap gW <C-W>p
"-------------------------------------------------------------------------------
" Goto next tab
:nmap gt :tabnext<cr>
"-------------------------------------------------------------------------------
" Goto previous tab
:nmap gT :tabprev<cr>
"-------------------------------------------------------------------------------
" CTRL-y = execute buffer 'a'
:nmap <C-Y> @a

"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
" The Silver Searcher
if executable('ag')
  " Use ag over grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0
  " bind \ (backward slash) to grep shortcut
  command! -nargs=+ -complete=file -bar Ag silent! grep! <args>|cwindow|redraw!
endif
" bind K to grep word under cursor
nnoremap K :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>

