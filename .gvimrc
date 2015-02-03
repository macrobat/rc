" just :source ~/.gvimrc
" colorscheme darkslategray
" colo rootwater
" colo pyte              " light
" colo torte             " for vim on terms with less colors,
" colo navajo_night
" colo oceandeep
" colo camo
" colo anokha
" colo chocolateliquor
" colo buttercream
" colo papayawhip
" colo autumnleaf
" colo wombat256 "too subtle cursor, red bkgrnd on : $ #
colo wombat256mod  " better diffcolors

" uppercase not needed
"set guifont=DejaVu\ Sans\ Mono\ 11
" l and 1 are too close. l has a serif for the left side of the foot
" set guifont=Inconsolata\ 11
set guifont=Inconsolata\ 12
" set guifont=sourcecodepro\ 11
" set guifont=Terminus\ 12

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

" window focus follows mouse
set mousefocus

"open all files in tabs. (use the -p --remote-tab-silent options too)
"see gvim.desktop in ~/.local/share/applications
tab all

" :Man whatever. How bind it to K?
" it is already bound to <leader>K
:so /usr/share/vim/vim74/ftplugin/man.vim
" nunmap K
" no such mapping. it is a default mapping
nnoremap K <Nop>
"nnoremap K echo "use \\K or :Man <C-r><C-a> for manpages"
" wontwork
" <SNR> means <SID> 75 is the script id for man.vim
" you can only use <SID> in a script contex
" nnoremap K :call <SNR>75_PreGetPage(0)<CR>

" first, enable status line always
set laststatus=2

" like emacs M-x (why is it an ø?) . only in gvim. specific for my setup?
nnoremap ø :
vnoremap ø :
inoremap ø <Esc>:

" emacs C-SPC visual line
" save it for vimCtrlSpace?
" (buffer/file/tab explorer mixed with a fuzzy finder like CtrlP,
" and a session and project explorer.)
" nmap <C-space> V
imap <C-space> <C-o>V

" emacs <A-;> for gvim (shows as '»' in gvim)
nmap » <Plug>NERDCommenterToggle
vmap » <Plug>NERDCommenterToggle
"imap » <Esc>:<Plug>NERDCommenterToggle<CR>:startinsert
"imap » <Plug>NERDCommenterToggle

" convenient backspace, in gvim only
nnoremap <S-BS> db
inoremap <S-BS> <Esc>dbi

" <A-q> to format a paragraph
nnoremap ñ gqap
" keeps cursor at the same position. won't use the remapped gw below
inoremap ñ <esc>gwapi

" tab left, right
nnoremap <A-left> gT
nnoremap <A-right> gt

" trying alt-< and alt->
function! YRRunAfterMapsGvim()
     nnoremap <A-y>         :<C-U>YRReplace '-1', P<CR>
     nnoremap ¼             :<C-U>YRReplace '-1', P<CR>
     nnoremap ¾             :<C-U>YRReplace '1', P<CR>
endfunction


" vimtip 1287
" now set it up to change the status line based on mode
"if version >= 700
  "au InsertEnter * hi StatusLine term=reverse ctermbg=5 gui=undercurl guisp=Magenta
  "au InsertLeave * hi StatusLine term=reverse ctermfg=0 ctermbg=2 gui=bold,reverse
"endif

" use vim-airline instead!
" fallback something like: if !has("vim-airline")|  bla bla| endif
" if exists("foo")| echo "yes"| else| echo "no"| endif

" less garish colors than magenta, green, blue, red
" default the statusline to green when entering Vim
"hi statusline guibg=#597418
"function! InsertStatuslineColor(mode)
"  "a: means parameter of the current function
"  if a:mode == 'i'
"    hi statusline guibg=#2C6A78 "cyan dark
"  elseif a:mode == 'r'
"    hi statusline guibg=#2632AA "blue desaturated
"  else
"    hi statusline guibg=#D4B728 "yellow dark
"  endif
"endfunction

"v: means a vim predefined var
"au InsertEnter * call InsertStatuslineColor(v:insertmode)
"au InsertLeave * hi statusline guibg=#597418  "green, mossy
"there is no VisualEnter

" horizontal scrollbar
if &diff == 1
    set guioptions+=b
"else
   " set guioptions-=b
endif

