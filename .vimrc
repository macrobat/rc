" vimtip 1287
" just :source ~/.vimrc

" Use vim settings, rather then vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" colorscheme torte

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

set history=9001    " keep lines of command history
set ruler           " show the cursor position all the time
set showcmd         " display incomplete commands
set incsearch       " do incremental searching

" Don't use Ex mode, use Q for formatting
noremap Q gqap

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

" Use 'filetype indent on'
" don't use smartindent, it's worse

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

  " For all text files set 'textwidth' to 80 characters.
  autocmd FileType text setlocal textwidth=80

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

  " there is no ft=bash
  " defaults to bash syntax highlighting on *.sh files:
  " let g:is_bash = 1
  " zsh has better syntax hilite than sh
  au FileType sh set filetype=zsh

  augroup END

    " doesntwork: autocmd BufRead,BufNew * |
    " add more ft python sh perl ruby ...?
    " ft * doesn't work either. also, opening the cmd history:
    " Error detected while processing FileType Auto commands for "*":
    " Error detected while processing FileType Auto commands for
    " "vim\|c\|lua\|python\|ruby":
    " E749: empty buffer
    " ',' separates patterns. au patterns are different
    "autocmd FileType vim\|c\|cpp\|zsh\|lua\|python\|ruby |

  augroup negnums
    au!
    autocmd FileType vim,c,cpp,zsh,lua,python,ruby |
        \ syn match negNumber '\v<\-\d+(\.\d*)?[ulf]?>' |
        \ highlight link negNumber Number
  augroup END

  " t-e~s/t! hyphen-ated foo(bar) dir/file.ext
  augroup hyphen
    au!
    au FileType * set iskeyword=@,.,/,48-57,_,192-255,-
    au FileType * set iskeyword+=-
    au FileType * set iskeyword-=(,)
  augroup END

  " move more stuff here

  " BufWritePre remove trailing whitespace

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
"# generate a populated ~/.vim/
" mkdir -p ~/.vim/
if ! isdirectory(expand('~/.vim/'))
   call mkdir(expand('~/.vim/'))
endif
" cd ~/.vim/
" git clone https://github.com/MarcWeber/vim-addon-manager
" cd ~/.vim/
" git clone https://github.com/dahu/Insertlessly
" ~/.vim/swapfiles is created from this ~/.vimrc


" git clone https://github.com/MarcWeber/vim-addon-manager
" This calls the autoload function ActivateAddons in the file vam with a
" string argument and a dictionary argument
" call vam#ActivateAddons(['pluginA', 'pluginB'], {'auto_install' : 0})
" call vam#ActivateAddons([''], {'auto_install' : 0})
function! SetupVAM()
    set runtimepath+=~/.vim/vim-addon-manager
       call vam#ActivateAddons([
        \'The_NERD_tree', 'The_NERD_Commenter', 'CSApprox', 'Gundo', 'buffergrep',
        \ 'Colour_Sampler_Pack', 'Scratch', 'unimpaired', 'YankRing',
        \ 'vim-airline', 'surround', 'vimple', 'Insertlessly'],
        \ {'auto_install' : 0})

       " 'colorizer',
endfunction

" notice that after line break '\' is on the _first_ non-whitespace

" make all commands silent while using vam to bootstrap the vim config
" hitting enter a dozen times is a little annoying
" maybe you can surround the code in redir?
" a file or a var? how use the var?
"redir >> /tmp/vamlog
"redir => vamlog redir end
silent call SetupVAM()


" other plugins:
" pluginA could be github:YourName see vam#install#RewriteName()
" vam doesn't have Insertlessly. it just loads it from ~/.vim/Insertlessly
" example: VAMActivate vim-airline
" AirlineTheme solarized " or, like, airlineish
" ctrlp     " yankring uses <C-p> for emacsy yankpop
" ultisnips
" ctrl-space

" seems vam does add these now. I want the commands and the help
"set runtimepath+=~/.vim/The_NERD_Commenter,~/.vim/unimpaired,~/.vim/Gundo,
"\ ~/.vim/Insertlessly,~/.vim/CSApprox,~/.vim/The_NERD_tree,~/.vim/YankRing,
"\ ~/.vim/surround,~/.vim/transwrd
" https://github.com/dahu/Insertlessly
" trying without. have VAM
" set runtimepath+=~/.vim/Insertlessly

" don't want colorizer defaultly enabled. 100% cpu
" E492: Not an editor command: ColorClear
" if you want it:
" VAMActivate Colorizer


" removing
" 'FuzzyFinder',

" from inside SetupVAM():
" commenting try .. endtry because trace is lost if you use it.
" There should be no exception anyway.
" catch /.*/
" echoe v:exception
" endtry

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" should I place plugin stuff inside something like has("") or exists("") ?
" no!
" place new stuff below:

" with shift, just one line. why doesn't it work in insert?
noremap <S-ScrollWheelUp> <C-Y>
noremap <S-ScrollWheelDown> <C-E>

nnoremap _ :
nnoremap - :

" swapping. ' is easier to reach. now moves to the specific column
nnoremap ' `
nnoremap ` '

" don't accidentally the windows. if really want, use :only
nnoremap <C-w>O     <Nop>
nnoremap <C-w>o     <Nop>
nnoremap <C-w><C-O> <Nop>

let g:insertlessly_cleanup_all_ws = 1
let g:insertlessly_cleanup_trailing_ws = 0
" to see value
" echo g:insertlessly_cleanup_trailing_ws
"Insertlessly enter doesn't work in Scratch.
"because of :set buftype=nofile
"function! s:InsertNewline() only inserts on &buftype == ""
  " can't rewrite like this. E32: no filename
  " if &buftype == "" || expand('%') == "Scratch"

" trace output for testing and debugging C
" quinely precedes a statement with its own quote and wraps it in a printf()
" assumes int return type. needs a line ending in ;
" If the [!] is given, mappings will not be used
" :call Ctrace()
function! Ctrace()
    normal! ^yt;iprintf("$i: %d\n", @"pa)T%
endfunction

" better with normal mode and leader?
cnoremap Ct         call Ctrace()<CR>
nnoremap <leader>c :call Ctrace()<CR>
" normal mode. first non-whitespace. yank to before ;.
" insert printf(". end of line. insert : %d\n", . paste
" insert ). move to after the %


"horizontal sort
command! Hsort call setline('.', join(sort(split(getline('.'), ' ')), ' '))

" emacs kill next word and undo bind
nnoremap <A-d> dw
nnoremap <C-_> u
inoremap <C-_> <esc>ui

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

" why? useless
" cnoremap <ESC><C-H> <C-W>
" cnoremap <C-B>      <Left>    " should be alt
" cnoremap <C-F>      <Right>   " commandline history window
" see also the NERDCommenter <A-;> bind

" To use gc to transpose the current character with the next,
" without changing the cursor position:
nnoremap <silent> gc xph

" derekwyatt has more ,binds for emacs cmdline and windowing
" Swap two words. from cursor to end of next
" får problem med massa markeringar, yank-paste blir konstigt
" nmap <silent> gw :s/\(\%#\w\+\)\(\_W\+\)\(\w\+\)/\3\2\1/<CR>`'

" TODO:
" add nohl on these. How? <esc>:nohl<C-m>
" learn more regex
" doesn't work for åäö. something fails - last line?
" gw transpose the current word with the next, keep cursor position:
" This version will work across newlines:
nnoremap <silent> gw "_yiw:s/\(\%#\w\+\)\(\_W\+\)\(\w\+\)/\3\2\1/<CR><c-o><c-l>

" To use gl to transpose the current word with the previous, keeping cursor on
" current word: (This feels like "pushing" the word to the left.)
nnoremap <silent> gl "_yiw?\w\+\_W\+\%#<CR>:s/\(\%#\w\+\)\(\_W\+\)\(\w\+\)/\3\2\1/<CR><c-o><c-l>

" To use gr to transpose the current word with the next, keeping cursor on
" current word: (This feels like "pushing" the word to the right.)
nnoremap <silent> gr "_yiw:s/\(\%#\w\+\)\(\_W\+\)\(\w\+\)/\3\2\1/<CR><c-o><c-l>

" To use g} to transpose the current paragraph with the next:
nnoremap g} {dap}P

" To use g{ to transpose the current paragraph with the prev:
nnoremap g{ {dap{P}


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
"let gundo_preview_bottom = 1
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

" does yankring break this? Yes!
" http://vim.wikia.com/wiki/Mapping_keys_in_Vim_-_Tutorial_(Part_1)
" If you would prefer Y to be consistent with C and D: (don't change S)
"nnoremap Y y$
"map Y y$

"yankring. there is yankring-tutorial
" place binds inside this function. it will be run after mappings
" M-y is more emacsy yankpop than <C-p>
" use <C-n> to go through the ring in the other direction.
" doesn't take the place of omnicomplete, that works in insert mode
     "nnoremap <C-P>         :<C-U>YRReplace '-1', P<CR>
function! YRRunAfterMaps()
     nnoremap <silent> <F4> :YRShow<CR>
     nnoremap Y             :<C-U>YRYankCount 'y$'<CR>
endfunction

let g:yankring_min_element_length = 3
"let g:yankring_max_element_length " 64K ? ought to be enough for anyone
let g:yankring_max_display = 50 "max of what will be shown
let g:yankring_window_height = 14
"let g:yankring_persist = 0
let g:yankring_share_between_instances = 0
" let g:yankring_dot_repeat_yank = 1
" do not use. is a prefix for the file name
"let g:yankring_history_file = '~/.vim/yankring_history'
let g:yankring_history_dir = '$HOME/.vim/'
" don't want all clipboard history in the yankring. maybe this helps?
let g:yankring_clipboard_monitor = 0

" http://vimcasts.org/episodes/bubbling-text/
" move selected lines <A-Up> and <A-Down>
" bubble single lines in normal
" using tpopes unimpaired.vim
" http://www.vim.org/scripts/script.php?script_id=1590
" <A-k> and <A-j> for terminal vim
" <Plug>unimpairedMoveUp
" <Plug>unimpairedMoveDown
" <Plug>unimpairedMoveSelectionUp
" <Plug>unimpairedMoveSelectionDown

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
" visually select the text that was last edited/pasted
nmap gV `[v`]

" :set ve="all" is useful for tables & visual blocks
" :set ve="block" allows virtual editing in visual block mode
" user function names starts with Capital or s: and ends with()
" fu! will replace an old function definition, should it be redefined
function! ToggleVirtualEdit()
  if &virtualedit == "all"
    set virtualedit=""
  elseif &virtualedit == ""
    set virtualedit=all
  endif
endfunction
nnoremap <leader>v :call ToggleVirtualEdit()<CR>

" do tabs get redrawn when switched to?
" Don't update the display while executing macros
set lazyredraw
"set nolazyredraw

" E185: Cannot find color scheme 'vividchalk'
" since we have VAM, try without adding to runtimepath
" set runtimepath+=~/.vim/Color_Sampler_Pack/
" vim knows the number of colors in the terminal
" don't set t_Co=88 instead of 256
" CSApprox.vim is _sometimes_ better than this:
" test for non gui first. " colo torte for emergencies
" don't want themes like anokha or chocolateliquor in a terminal
if !has("gui_running")
    " colo calmar256_light
    " colo jellybeans
    " colo neverness
    " colo northland
    " colo oceanblack
    " colo vividchalk " too subtle search hilite
    colo vibrantink
    " colo torte
endif

set wrapscan
" set text wrapping toggles
nnoremap <silent> ,w :set invwrap<CR>:set wrap?<CR>

" Help yourself! help in its own tab
command! -bang -nargs=? -complete=help Help tab help<bang> <args>
command! -bang -nargs=? -complete=help H tab help<bang> <args>

" dont use, you have to press esc twice to get normal
"nnoremap x :  " <esc><esc>
"vnoremap x :
"inoremap x : <esc>: " meh :(

" move in visual lines, (useful with long, wrapped lines) and the opposite
nnoremap k gk
nnoremap j gj
nnoremap gk k
nnoremap gj j
nnoremap <Up> gk
nnoremap <Down> gj

" maybe the CtrlSpace plugin
" nnoremap <S-h> gT
" nnoremap <S-l> gt
" just in gvim:
nnoremap <A-Left> gT
nnoremap <A-Right> gt

" see whitespace. tab is two squiggles
" nnoremap ,l :set list!:buffer<CR>
" find better unicodes. orig is eol:$
nnoremap <leader>l :set list!<CR>
" set listchars=tab:\→_,eol:$,trail:°
set listchars=tab:\⇒\ ,trail:\‣,extends:\↷,precedes:\↶

" maps ',b' to display the buffer list and invoke the ':buffer' command.
" You can enter the desired buffer number and hit <Enter> to edit the buffer.
" (Enter space after) <C-6> switches between 2 last used buffers
nnoremap ,b :ls<CR>:buffer<Space>
"nnoremap <leader>l :ls<CR>:b<Space>

"switch to buffers tab/window if it's in a tab/window
set switchbuf=usetab

" set working dir to current buffer. (unused in NERDCommenter)
noremap ,cd :cd %:p:h<CR>
" vimtip2, use %% to expand path for current buf
cabbr <expr> %% expand('%:p:h')
" cannot search for strings starting with t. maybe "t " is better
" cabbr t tabe

" tjejjer och grejjer
inoremap jj <esc>

"http://vimcasts.org/episodes/the-edit-command/
"cnoremap %% <C-R>=expand('%:h').'/'<cr>
"map <leader>ew :e %%
"map <leader>es :sp %%
"map <leader>ev :vsp %%
"map <leader>et :tabe %%

" stop hiliting with C-l
nnoremap <silent> <C-l> :nohl<CR><C-l>
inoremap <silent> <C-l> <Esc>:nohl<CR>a
"inoremap <silent> <C-S-l> <Esc>:nohl<CR><C-o>i
" fail mappings: inserts stuff like ":nohl ":
" inoremap <silent> <C-l> :execute "nohl"
" inoremap <silent> <C-l> <C-o>:nohl<CR><C-l>

" Better command-line completion for emenu, popup...
set wildmenu
" Use case insensitive search, except when using capital letters
set ignorecase
set smartcase

" Stop certain movements from always going to the first character of a line.
" While this behaviour deviates from that of vi, it does what most users
" coming from other editors would expect.
set nostartofline

" Instead of failing a command because of unsaved changes, instead raise a
" dialogue asking if you wish to save changed files.
set confirm

" Set the command window height to 2 lines, to avoid many cases of having to
" "press <Enter> to continue"
set cmdheight=2
" q: q? q/ for the cmd window. C-f in cmd mode
set cmdwinheight=14

" quickly time out on keycodes, but never time out on mappings
set notimeout ttimeout ttimeoutlen=200

" Use <F11> to toggle between 'paste' and 'nopaste'
" Why would I ever want to set paste?
" set pastetoggle=<F11>
" can't use <S-Insert> with set paste
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


set shiftwidth=4 "8
set softtabstop=4 "0
" DONOTWANT!!!
" if ts=8 sts=4, vim converts 1 tab to 4 spaces and 8 spaces to 1 tab
set tabstop=4 "8
" needs autocommand?
set textwidth=80

" this is not what i want :(
" using :YAIFAMagic (plugin) to detect settings
" set sts=2 | set tabstop=8 | set expandtab | set shiftwidth=2

" Indentation settings for using hard tabs for indent. Display tabs as
" two characters wide.
" set shiftwidth=4
" set tabstop=4  Why is it 8?
" http://vim.wikia.com/wiki/Indenting_source_code
" if you want to distinguish between "indentation" and "alignment", i.e.,
" the number of hard tabs equals the indentation level, use the Smart Tabs plug-in.

" Toggle the NERD Tree with F7
nnoremap <F7> :NERDTreeToggle<CR>

" http://vim.wikia.com/wiki/Mapping_keys_in_Vim_-_Tutorial_(Part_1)
" cannot search /W when :W is mapped to :w
" cnoremap W w

"let the old window stay in the same place when :sp or :vs
set splitbelow
set splitright

" change windows
noremap <silent> ,h :wincmd h<CR>
noremap <silent> ,j :wincmd j<CR>
noremap <silent> ,k :wincmd k<CR>
noremap <silent> ,l :wincmd l<CR>
noremap <silent> ,p :wincmd p<CR>
" bad keys to map
" use :res or z{nr} instead
" vertical means horizontal
"noremap <silent> <C-F9>  :vertical resize -10<CR>
"noremap <silent> <C-F10> :resize +10<CR>
"noremap <silent> <C-F11> :resize -10<CR>
"noremap <silent> <C-F12> :vertical resize +10<CR>
noremap <silent> ,L <C-W>L
noremap <silent> ,K <C-W>K
noremap <silent> ,H <C-W>H
noremap <silent> ,J <C-W>J
" noremap <silent> ,ml <C-W>L
" noremap <silent> ,mk <C-W>K
" noremap <silent> ,mh <C-W>H
" noremap <silent> ,mj <C-W>J
" kolla ev krock med nerdcommenter (bara normal & visual?)
" noremap <silent> ,cj :wincmd j<CR>:close<CR>
" noremap <silent> ,ck :wincmd k<CR>:close<CR>
" noremap <silent> ,ch :wincmd h<CR>:close<CR>
" noremap <silent> ,cl :wincmd l<CR>:close<CR>
" noremap <silent> ,cc :close<CR>
" noremap <silent> ,cw :cclose<CR>

" did I write this one myself?
" se nu! and se rnu! are toggles and can be combined
func! ToggleLineNumbering()
    if !exists('s:LineNumbering')
        "echo s:LineNumbering
        let s:LineNumbering = 0
    else
        let s:LineNumbering = (s:LineNumbering + 1) % 3
    endif
    " maybe 1 rnu, 2 nu, anything else - nothing
    if s:LineNumbering == 0
        set nu
        set nornu
        echo "nu"
    "elseif &rnu == 1
    elseif s:LineNumbering == 1
        set nu
        set rnu
        echo "rnu nu"
    else
        set nonu
        set nornu
        echo
    endif
endfunc
noremap <silent> <F2> :call ToggleLineNumbering()<CR>


" NERD_commenter needs some binds. don't noremap?
" emacs <A-;> for gvim (shows as '»' in gvim)
" nmap  »             <Plug>NERDCommenterInvert
" vmap  »             <Plug>NERDCommenterInvert
nmap  ,cc           <Plug>NERDCommenterComment
vmap  ,cc           <Plug>NERDCommenterComment
nmap  ,<Space>      <Plug>NERDCommenterInvert
vmap  ,<Space>      <Plug>NERDCommenterInvert
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
" want this always set for C. autocommands?
nmap  ,ca           <Plug>NERDCommenterAltDelims


