" vimtip 1287
" just :source ~/.vimrc

" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" colorscheme desert

" open all files in tabs. (use the -p --remote-tab-silent options too)
"tab all

" slipp :vert före diffsplit
" (for horizontal splits "-o" as cmdline arg)
set diffopt+=vertical

" first, enable status line always. "statusline, :h stl
set laststatus=2

" Make command line two lines high
set ch=2

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

set history=7000	" keep lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching

" Don't use Ex mode, use Q for formatting
map Q gq

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

set autoindent

" Use 'filetype indent on' and be happy.
"set smartindent "XXX don't use

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

" One of the most important options to activate. Allows you to switch from an
" unsaved buffer without saving it first. Also allows you to keep an undo
" history for multiple files. Vim will complain if you try to quit without
" saving, and swap files will keep you safe if your computer crashes.
set hidden

" Modelines have historically been a source of security vulnerabilities.  As
" such, it may be a good idea to disable them and use the securemodelines
" script, <http://www.vim.org/scripts/script.php?script_id=1876>.
" set nomodeline

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  " Also don't do it when the mark is in the first line, that is the default
  " position when opening a file.
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

  " autocmd FileType make setlocal noexpandtab " Makefile

  augroup END

  " move more stuff here
"else

endif " has("autocmd")

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" place new stuff below:

" To use gc to transpose the current character with the next, without changing
" the cursor position:
:nnoremap <silent> gc xph

" To use gw to transpose the current word with the next, without changing cursor
" position: (See note.)
" :nnoremap <silent> gw "_yiw:s/\(\%#\w\+\)\(\W\+\)\(\w\+\)/\3\2\1/<CR><c-o><c-l>
" This version will work across newlines:
:nnoremap <silent> gw "_yiw:s/\(\%#\w\+\)\(\_W\+\)\(\w\+\)/\3\2\1/<CR><c-o><c-l>

" To use gl to transpose the current word with the previous, keeping cursor on
" current word: (This feels like "pushing" the word to the left.)
:nnoremap <silent> gl "_yiw?\w\+\_W\+\%#<CR>:s/\(\%#\w\+\)\(\_W\+\)\(\w\+\)/\3\2\1/<CR><c-o><c-l>

" To use gr to transpose the current word with the next, keeping cursor on
" current word: (This feels like "pushing" the word to the right.)
:nnoremap <silent> gr "_yiw:s/\(\%#\w\+\)\(\_W\+\)\(\w\+\)/\3\2\1/<CR><c-o>/\w\+\_W\+<CR><c-l>

" To use g} to transpose the current paragraph with the next:
:nnoremap g} {dap}P

" To use g{ to transpose the current paragraph with the prev:
:nnoremap g{ {dap{P}


" swap directory, uniquified names where % is /
" set directory=~/.vim/swapfiles//,.,~/tmp,/var/tmp,/tmp
if ! isdirectory(expand('~/.vim/swapfiles'))
   call mkdir(expand('~/.vim/swapfiles'))
endif
if isdirectory(expand('~/.vim/swapfiles'))
   set directory=~/.vim/swapfiles//
else
   set directory=.,/var/tmp,/tmp
endif

" change dir to wherever you are (will break stuff?)
se autochdir

" http://sjl.bitbucket.org/gundo.vim/
" p on a state to show diff between current and selected state
let gundo_preview_bottom = 1
nnoremap <F5> :GundoToggle<CR>

" håll sverige rent. slipp fil~
set nobackup
" backup file before overwriting, delete original
set writebackup
" don't join with two spaces after a '.', '?' and '!'  
set nojoinspaces

" persistent undo with undofile
" Undo files are normally saved in the same directory as the file.  This can be
" changed with the 'undodir' option. You should keep 'undofile' off, 
" otherwise you end up with two undo files for every write.

"yankring . finns yankring-tutorial
"let g:yankring
"let g:yankring_min_element_length = 2
"let g:yankring_max_element_length 64K "ought to be enough for anyone
"let g:yankring_max_display = 70 "max of what will be shown
"let g:yankring_persist = 0
"let g:yankring_share_between_instances = 0
" let g:yankring_dot_repeat_yank = 1 "0
"let g:yankring_history_file = '~/.vim/yankring_history'
let g:yankring_history_file = '.vim/yankring_history'

" defaults to bash syntax highlighting on *.sh files
let g:is_bash = 1

" http://vimcasts.org/episodes/bubbling-text/
" move selected lines <C-Up> or <C-Down>
" not working in terminal, needs other binds
" downloaded tpopes unimpaired.vim http://www.vim.org/scripts/script.php?script_id=1590
" <C-Up> or <C-Down> wontwork. 
" using M-k and M-j for 
" Bubble single lines in normal
nmap <A-Up> [e
nmap <A-Down> ]e
" terminal:
nmap k [e
nmap j ]e
" Bubble multiple lines in visual
vmap <A-Up> [egv
vmap <A-Down> ]egv
vmap k [egv
vmap j ]egv
" Visually select the text that was last edited/pasted
nmap gV `[v`]

" :set ve="all" is useful for tables & visual blocks
" function names starts with Capital or s: and ends with()
" ! replaces an old definition, should I redefine it
function! ToggleVirtualEdit()
  if &virtualedit == "all"
    set virtualedit=""
  elseif &virtualedit == ""
    set virtualedit=all
  endif
endfunction
nnoremap <leader>v :call ToggleVirtualEdit()<CR>

" shortcut " leader is '\'
" nmap <leader>v :tabedit $MYVIMRC<CR>
"" Source the vimrc file after saving it
"if has("autocmd")
  "autocmd bufwritepost .vimrc source $MYVIMRC
"endif


" "t-e~s/t!
" is set per buffer? :( then run it whenever i open one? no ending <CR>?
" why is ( and not * keywords?
" error if opening dirs (or other buftypes?)
" E474: Invalid argument: iskeyword+=-,~,/,!,
" autocmd! BufAdd * set iskeyword+=-,~,/,!,.,
"autocmd FileType * set iskeyword+=-,~,/,!,.
"nmap <leader>w :set iskeyword+=-,~,/,!,
"If you don't want to remove all autocommands, you can instead use a variable
"to ensure that Vim includes the autocommands only once: >
if !exists("autocommands_loaded")
  let autocommands_loaded = 1
  au FileType * set iskeyword+=-,~,/,!,.,*
  au FileType * set iskeyword-=(,)
  " au FileType * set noet " what about yaifa  " DONOTWANT! OR NEED!
endif

" comment and see if tabs get redrawn when switched to.
" Don't update the display while executing macros
"set lazyredraw
set nolazyredraw

" vim känner av number of colors själv. $TERM
" don't do set t_Co=88 "isf 256
" testa för icke gui först
" CSApprox.vim is _sometimes_ better than this:
if !has("gui_running")
    " colo torte
    " colo calmar256_light
	" colo jellybeans
	" colo neverness
	" colo northland
	" colo oceanblack
	" colo vibrantink 
	" colo 
    colo vividchalk " too subtle search hilite
endif

set wrapscan
" set text wrapping toggles
nmap <silent> ,w :set invwrap<CR>:set wrap?<CR>

" Help yourself! help in its own tab
command! -bang -nargs=? -complete=help Help tab help<bang> <args>
command! -bang -nargs=? -complete=help H tab help<bang> <args>

" does yankring break this?
" http://vim.wikia.com/wiki/Mapping_keys_in_Vim_-_Tutorial_(Part_1)
" If you would prefer Y to be consistent with C and D: (don't change S)
nnoremap Y y$

" dont use, you have to press esc twice to get normal
"nnoremap x :  " <esc><esc>
"vnoremap x :
"inoremap x : <esc>: " meh :(

" move in visual lines, (nice if line is wrapped)
" currently not working. because of "text bubbling"?
nnoremap k gk
nnoremap j gj
nnoremap <Up> gk
nnoremap <Down> gj

nnoremap <S-h> gT
nnoremap <S-l> gt

" maps ',b' to display the buffer list and invoke the ':buffer' command. 
" You can enter the desired buffer number and hit <Enter> to edit the buffer.
" (Enter space after)
nnoremap ,b :ls<CR>:buffer<Space>

" see whitespace
" nnoremap ,l :set list!:buffer<CR>
" leader is '\'
nmap <leader>l :set list!<CR>

" set working dir to current buffer
map ,cd :cd %:p:h<CR>
" vimtip2, use %% to expand path for current buf
cabbr <expr> %% expand('%:p:h')
" cannot search for strings starting with t
cabbr t tabe
imap jj <esc>

"http://vimcasts.org/episodes/the-edit-command/
"cnoremap %% <C-R>=expand('%:h').'/'<cr>
"map <leader>ew :e %%
"map <leader>es :sp %%
"map <leader>ev :vsp %%
"map <leader>et :tabe %%

" stop hiliting with C-l
nnoremap <silent> <C-l> :nohl<CR><C-l>
inoremap <silent> <C-l> <Esc>:nohl<CR>a
inoremap <silent> <C-S-l> <Esc>:nohl<CR><C-o>i "kind of useless
" fail mappings: inserts stuff like ":nohl ":
" inoremap <silent> <C-l> :execute "nohl"
" inoremap <silent> <C-l> <C-o>:nohl<CR><C-l>

  "<2-LeftMouse>   - Left mouse button double-click
  "doubleclick for WORD select
  " test-ord.med/path/
  "nnoremap <2-LeftMouse> <B><v><E>
  "nnoremap <2-LeftMouse> <B>:visual<CR><E>
" get more when wordmoving & doubleclicling

" Better command-line completion for emenu, popup...
set wildmenu
" Use case insensitive search, except when using capital letters
set ignorecase
set smartcase

" Stop certain movements from always going to the first character of a line.
" While this behaviour deviates from that of Vi, it does what most users
" coming from other editors would expect.
set nostartofline

" Instead of failing a command because of unsaved changes, instead raise a
" dialogue asking if you wish to save changed files.
set confirm

" Set the command window height to 2 lines, to avoid many cases of having to
" "press <Enter> to continue"
set cmdheight=2
" q: q? q/ for the cmd window. C-f in cmd mode
set cmdwinheight=10

" Quickly time out on keycodes, but never time out on mappings
set notimeout ttimeout ttimeoutlen=200

" Use <F11> to toggle between 'paste' and 'nopaste'
" Why would I ever want to set paste?
" set pastetoggle=<F11>
"can't use <S-Insert> with set paste
set nopaste "see softtabstop

" Indentation settings for using spaces instead of tabs.
" Do not change 'tabstop' from its default value of 8 with this setup.
" ('softtabstop' is set to 0 when the 'paste' option is set.
" See also |ins-expandtab|.  When 'expandtab' is not set, the number of
" spaces is minimized by using <Tab>s.)
" set softtabstop=4
set expandtab
" set noexpandtab "don't expand a tab to a number of spaces
" spaces for each tab with normal >> == << and visual > = <

" setting this earlier in the file, inside if (has autocmd)
" autocmd FileType make setlocal noexpandtab " Makefile

set shiftwidth=4 "8
set softtabstop=4 "0
" if ts=8 sts=4, vim converts 1 tab to 4 spaces and 8 spaces to 1 tab
" DONOTWANT!!!
set tabstop=4 "8
" needs autocommand?
set textwidth=80

" using :YAIFAMagic (plugin) to detect settings
" this is not what i want :(
" set sts=2 | set tabstop=8 | set expandtab | set shiftwidth=2

" Indentation settings for using hard tabs for indent. Display tabs as
" two characters wide.
" set shiftwidth=4
" set tabstop=4  Why is it 8?
" http://vim.wikia.com/wiki/Indenting_source_code
" if you want to distinguish between "indentation" and "alignment", i.e., 
" the number of hard tabs equals the indentation level, use the Smart Tabs plug-in.

" Toggle the NERD Tree with F7
nmap <F7> :NERDTreeToggle<CR>
         
" derekwyatt has more ,binds for emacs cmdline and windowing

" Swap two words. from cursor to end of next
" får problem med massa markeringar, yank-paste blir konstigt
" nmap <silent> gw :s/\(\%#\w\+\)\(\_W\+\)\(\w\+\)/\3\2\1/<CR>`'

" http://vim.wikia.com/wiki/Mapping_keys_in_Vim_-_Tutorial_(Part_1)
" cannot search /W when :W is mapped to :w
" cnoremap W w
" allow emacs-like command line editing
" :h CTRL-R
cnoremap <C-A>      <Home>
cnoremap <C-E>      <End>
"cnoremap <C-N>      <End> "<Down>
cnoremap <C-P>      <Up>
cnoremap <C-B>      <S-Left>
" I want to enable the cmd-line window instead
"cnoremap <C-F>      <S-Right>
cnoremap <ESC>b     <S-Left>
cnoremap <ESC>f     <S-Right>
cnoremap <ESC><C-H> <C-W>
" cnoremap <C-B>      <Left>    "should be alt
" cnoremap <C-F>      <Right>

"let the old window stay in the same place when :sp or :vs
set splitbelow
set splitright

" Maps to make handling windows a bit easier
noremap <silent> ,h :wincmd h<CR>
noremap <silent> ,j :wincmd j<CR>
noremap <silent> ,k :wincmd k<CR>
noremap <silent> ,l :wincmd l<CR>
noremap <silent> ,sb :wincmd p<CR>
" like hjkl
noremap <silent> <C-F9>  :vertical resize -10<CR>
noremap <silent> <C-F10> :resize +10<CR>
noremap <silent> <C-F11> :resize -10<CR>
noremap <silent> <C-F12> :vertical resize +10<CR>
noremap <silent> ,s8 :vertical resize 83<CR>
noremap <silent> ,L <C-W>L
noremap <silent> ,K <C-W>K
noremap <silent> ,H <C-W>H
noremap <silent> ,J <C-W>J
" kolla ev krock med nerdcommenter (bara normal & visual?)
" noremap <silent> ,cj :wincmd j<CR>:close<CR>
" noremap <silent> ,ck :wincmd k<CR>:close<CR>
" noremap <silent> ,ch :wincmd h<CR>:close<CR>
" noremap <silent> ,cl :wincmd l<CR>:close<CR>
" noremap <silent> ,cc :close<CR>
" noremap <silent> ,cw :cclose<CR>
" noremap <silent> ,ml <C-W>L
" noremap <silent> ,mk <C-W>K
" noremap <silent> ,mh <C-W>H
" noremap <silent> ,mj <C-W>J

" some addons aren't managed. 
" notice that line break \ is on _first_ non-whitespace
function! SetupVAM()
    set runtimepath+=~/.vim/vim-addon-manager
    " commenting try .. endtry because trace is lost if you use it.
    " There should be no exception anyway.
	" This calls the autoload function ActivateAddons in the file vam with a 
	" string argument and a dictionary argument
    "  call vam#ActivateAddons(['pluginA', 'pluginB'], {'auto_install' : 0})
    "   call vam#ActivateAddons([''], {'auto_install' : 0})
       call vam#ActivateAddons([
		\'The_NERD_tree', 'The_NERD_Commenter', 'CSApprox', 'Gundo', 'buffergrep',
		\ 'Color_Sampler_Pack', 'FuzzyFinder', 'Scratch', 'unimpaired', 'YankRing',
		\ 'colorizer', 'surround', 'Insertlessly'], {'auto_install' : 0})
      " pluginA could be github:YourName see vam#install#RewriteName()
    " catch /.*/
    " echoe v:exception
    " endtry
endf
call SetupVAM()
" experimental: run after gui has been started (gvim) [3]
" option1: au VimEnter * call SetupVAM()
" option2: au GUIEnter * call SetupVAM()

" vam doesn't add these. I want the commands and the help
set runtimepath+=~/.vim/The_NERD_Commenter,~/.vim/unimpaired,~/.vim/FuzzyFinder,~/.vim/Gundo,~/.vim/Insertlessly,~/.vim/CSApprox,~/.vim/L9,~/.vim/The_NERD_tree,~/.vim/YankRing,~/.vim/surround,~/.vim/transwrd

" maybe <silent> 
noremap <F2> :call ToggleLineNumbering()<CR>
 
func! ToggleLineNumbering()
    if !exists('s:LineNumbering')
        let s:LineNumbering = -1
    else
        let s:LineNumbering = (s:LineNumbering + 1) % 3
    endif
 
    if s:LineNumbering == 0
        set nornu nonu
    elseif &rnu == 1
        set nu
    else
        set rnu
    endif
endfunc

" NERD_commenter is acting up, needs more binds
nmap  ,cc           <Plug>NERDCommenterComment
vmap  ,cc           <Plug>NERDCommenterComment
nmap  ,c<Space>     <Plug>NERDCommenterToggle
vmap  ,c<Space>     <Plug>NERDCommenterToggle
nmap  ,cm           <Plug>NERDCommenterMinimal
vmap  ,cm           <Plug>NERDCommenterMinimal
nmap  ,cs           <Plug>NERDCommenterSexy
vmap  ,cs           <Plug>NERDCommenterSexy
nmap  ,ci           <Plug>NERDCommenterInvert
vmap  ,ci           <Plug>NERDCommenterInvert
nmap  ,cy           <Plug>NERDCommenterYank
vmap  ,cy           <Plug>NERDCommenterYank
nmap  ,cl           <Plug>NERDCommenterAlignLeft
vmap  ,cl           <Plug>NERDCommenterAlignLeft
nmap  ,cb           <Plug>NERDCommenterAlignBoth
vmap  ,cb           <Plug>NERDCommenterAlignBoth
nmap  ,cn           <Plug>NERDCommenterNest
vmap  ,cn           <Plug>NERDCommenterNest
nmap  ,cu           <Plug>NERDCommenterUncomment
vmap  ,cu           <Plug>NERDCommenterUncomment
nmap  ,c$           <Plug>NERDCommenterToEOL
vmap  ,c$           <Plug>NERDCommenterToEOL
nmap  ,cA           <Plug>NERDCommenterAppend
vmap  ,cA           <Plug>NERDCommenterAppend
nmap  ,ca           <Plug>NERDCommenterAltDelims

