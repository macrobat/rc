" just :source ~/.gvimrc
"colorscheme darkslategray
"colo rootwater
"colo pyte              " light
"colo torte             " for vim on terms with less colors,
"colorscheme navajo_night
"colorscheme chocolateliquor
"colorscheme pyte
"colo oceandeep
"colorscheme camo
"colo aiseered
"colo autumnleaf
"colo wombat256 "too subtle cursor, red bkgrnd on : $ #
colo wombat256mod  " better diffcolors

"set guifont=DejaVu\ Sans\ Mono\ 10
" l and 1 are too close. l has a serif for the left side of the foot
"set guifont=Inconsolata\ 11
set guifont=Inconsolata\ 12
"set guifont=Terminus\ 12

"no toolbar or menu
set guioptions-=T
set guioptions-=m
let &guicursor = &guicursor . ",a:blinkon0"
"set nu "line numbering
"set rnu "relative line numbering
set nonu
"noh    "don't know how highlight works, fixed C-l in .vimrc
"set wildmenu

"don't show the mouse pointer when I write
set mousehide

"open all files in tabs. (use the -p --remote-tab-silent options too)
"see gvim.desktop in ~/.local/share/applications
tab all

" :Man whatever. How bind it to K?
" :so /usr/share/vim/vim74/ftplugin/man.vim
" nunmap K
" no such mapping. it is a default mapping
nnoremap K <Nop>

" first, enable status line always
set laststatus=2

" like emacs M-x (why is it an ø?) . only in gvim. specific for my setup?
nnoremap ø :

" emacsy C-SPC visual line
nnoremap <C-space> V
inoremap <C-space> <C-o>V

" <A-q> to format a para
nnoremap ñ gqap
" keeps cursor at the same position. won't use the remapped gw below
inoremap ñ <esc>gwapi

" vimtip 1287
" now set it up to change the status line based on mode
"if version >= 700
  "au InsertEnter * hi StatusLine term=reverse ctermbg=5 gui=undercurl guisp=Magenta
  "au InsertLeave * hi StatusLine term=reverse ctermfg=0 ctermbg=2 gui=bold,reverse
"endif

" use vim-airline instead!
" less garish colors than magenta,green,blue,red
" default the statusline to green when entering Vim
hi statusline guibg=#597418
function! InsertStatuslineColor(mode)
  "a: means parameter of the current function
  if a:mode == 'i'
    hi statusline guibg=#2C6A78 "cyan dark
  elseif a:mode == 'r'
    hi statusline guibg=#2632AA "blue desaturated
  else
    hi statusline guibg=#D4B728 "yellow dark
  endif
endfunction
"v: means a vim predefined var
au InsertEnter * call InsertStatuslineColor(v:insertmode)
au InsertLeave * hi statusline guibg=#597418  "green, mossy
"there is no VisualEnter

" horizontal scrollbar
if &diff == 1
    set guioptions+=b
"else
   " set guioptions-=b
endif

