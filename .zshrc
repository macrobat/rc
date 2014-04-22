HISTFILE=~/.zsh_history
HISTSIZE=16384 # in RAM
SAVEHIST=16383 # on disk
setopt APPEND_HISTORY
# write each new cmd to file continously
setopt INC_APPEND_HISTORY
# for sharing history between zsh processes
setopt SHARE_HISTORY

# använd !-1 och inte !:1
export HISTIGNORE="ls:[bf]g:exit:reset:clear:cd*"
setopt HIST_IGNORE_ALL_DUPS
#setopt HIST_IGNORE_SPACE #ign lines with spc start
setopt HIST_REDUCE_BLANKS
setopt HIST_SAVE_NO_DUPS
# Whenever the user enters a line with history expansion,
# don't execute the line directly; instead, perform history expansion
# and  reload the line into the editing buffer.
setopt HIST_VERIFY

setopt autocd extendedglob
# globdots ?
# correct mistakes
setopt CORRECT
setopt AUTO_LIST
# allow tab completion in the middle of a word
setopt COMPLETE_IN_WORD
# tab completion moves to end of word
setopt ALWAYS_TO_END
setopt listtypes
# comment in the interactive shell
setopt interactivecomments

unsetopt beep
bindkey -e
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '~/.zshrc'

# autoload commandline options:
#-U -- suppress alias expansion for functions
#-k -- mark function for ksh-style autoloading
#-t -- turn on execution tracing for functions
#-w -- specify that arguments refer to files compiled with zcompile
#-z -- mark function for zsh-style autoloading

autoload -Uz compinit
compinit

autoload -U colors
colors

# End of lines added by compinstall

# http://grml.org/zsh/zsh-lovers.html

# Wrap characters, that do *not* consume space in %{…%}. Repeat ten times!
# Escape sequences for colors are such characters.
# moved color prompt into the color test
# this will be a change from the .bashrc
# maybe a 2-line prompt for narrow terminals?
#PROMPT='%n%B[%~]%b%% '
#PROMPT=$'%{\e[1;32m%}%zsh%{\e[1;00m%}|%n%B[%~]%b%% '
#PROMPT='zsh|%n%B[%~]%b%% ' #setting it again, further down
#PROMPT=$'%{\e[1;32m%}zsh%{\e[1;00m%}|%n%B[%~]%b%% '

PROMPT_BAK="$PROMPT"
# migrate to double line prompt. write a function to change it?
PROMPT=$'%{\e[1;32m%}%n%{\e[1;00m%}@%m%B[%~]%b%% '
PROMPT1="$PROMPT"
PROMPT_2LINES=$'%{\e[1;32m%}%n%{\e[1;00m%}@%m%B[%~]%b\n%% '

if [[ $TERM = "dumb" ]]
then
	PROMPT="%n@%m%B[%~]%b%% "
fi

# revise these! man zshcompsys
#zstyle ':completion:*' completer _expand _complete _correct _approximate
# for example make zathura autocomplete pdf files
# zstyle ':completion:*:zathura:*' file-patterns '*.pdf'
zstyle ':completion:*' completions 1
zstyle ':completion:*' file-sort name
zstyle ':completion:*' glob 1
zstyle ':completion:*' insert-unambiguous true
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the char to insert%s
zstyle ':completion:*' max-errors 2
zstyle ':completion:*' original true
zstyle ':completion:*' prompt 'correction: %e '
## zstyle ':completion:*' squeeze-slashes true    #for ln. useful?
zstyle ':completion:*' squeeze-slashes false
zstyle ':completion:*' substitute 1
#zstyle ':completion:*' menu select
# cd will never select the parent directory (e.g.: cd ../<TAB>) a good thing?
zstyle ':completion:*:cd:*' ignore-parents parent pwd

##  the differing lines from zshrc_compinstall
zstyle ':completion:*' auto-description 'option: %d'
zstyle ':completion:*' completer _expand _complete _ignored _match _correct _approximate
## zstyle ':completion:*' format 'completion of %d'
## zstyle ':completion:*' glob 'NUMERIC == 2'
## zstyle ':completion:*' group-name ''
## zstyle ':completion:*' insert-unambiguous true
## zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
## zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' match-original both
zstyle ':completion:*' matcher-list '' '+m:{[:lower:]}={[:upper:]}' '+r:|[._-/]=* r:|=*' 'l:|=* r:|=*'
## zstyle ':completion:*' max-errors 3 numeric
# menu selection only started if at least num matches:
zstyle ':completion:*' menu select=4
#zstyle ':completion:*' prompt '%e'
#zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true
zstyle :compinstall filename '~/.zsh_compinstall'
# The -e option to zstyle even allows completion function code to appear as the
# argument to a style; this requires  some  understanding  of the internals of
# completion functions (see zshcompwid(1))). We can now tab complete ../
zstyle -e ':completion:*' special-dirs '[[ $PREFIX = (../)#(|.|..) ]] && reply=(..)'

#################################################################
# verkar va olika i olika terminaler
# o-funkis:
#bindkey '\e[1~' beginning-of-line
#bindkey '^[[7^' beginning-of-line
#bindkey '^[[7~' beginning-of-line
#bindkey '\e[4~' end-of-line
#bindkey '^[[8^' end-of-line
#bindkey '^[[8~' end-of-line
#
# sabbas av "flytta tabb" i urxvt -pe tabbed
#bindkey '^[[5D' emacs-backward-word
#bindkey '^[[5C' emacs-forward-word
# funkar i xfce4 terminal:
#bindkey ';5D' emacs-backward-word
#bindkey ';5C' emacs-forward-word

bindkey ' ' magic-space # also do history expansion on space
# setup backspace correctly
#stty erase `tput kbs`   #what does this one do?
# (problems in ssh. is this why or is it because of rxvt-unicode 256colors?)
# to get backspace in tmux and vim:
stty erase '^?'         #vim in tmux
#delete key
bindkey '\e[3~' delete-char
# home-end olika för olika terms
# home
bindkey '^[OH'  beginning-of-line 	# xfce4 terminal
bindkey '^[[7~' beginning-of-line 	# urxvt
bindkey '^[[1~' beginning-of-line 	# console
# end
bindkey '^[OF'  end-of-line 		# xfce4 terminal
bindkey '^[[8~' end-of-line 		# urxvt
bindkey '^[[4~' end-of-line 		# console
#insert
bindkey '\e[2~' overwrite-mode
# pgup pgdn hist
bindkey '^[[5~' history-incremental-search-backward
bindkey '^[[6~' history-incremental-search-forward
# tab completion
bindkey '^i'    expand-or-complete-prefix

bindkey '^]'    vi-match-bracket    # C-5 (under %)
bindkey '^[k'   kill-region         # mark with C-<Space>

# bind meta f meta b for solaris

### #zsh Mikachu
function _self_insert() {
  # Don't OOM if you accidentally press some big numeric without watching.
  if (( NUMERIC > 1000 )) || (( NUMERIC < -1000)); then
    zle -M "Unsetting NUMERIC"
    unset NUMERIC
  fi
  zle .self-insert
}


# http://bbs.archlinux.org/viewtopic.php?id=64607
# Set up auto extension stuff
# läs i mailcap?
alias -s html=$BROWSER
alias -s org=$BROWSER
alias -s php=$BROWSER
alias -s com=$BROWSER
alias -s net=$BROWSER
alias -s png=geeqie
alias -s jpg=geeqie
#alias -s gif=geeqie
#alias -s eps=geeqie   # eps?
alias -s pdf=evince
#alias -s sxw=soffice  # it's libre now, baby
#alias -s doc=soffice
#alias -s xls=soffice
#alias -s ppt=soffice
#alias -s odt=soffice
alias -s gz=tar -xzvf
alias -s bz2=tar -xjvf
#alias -s java=$EDITOR
alias -s txt=$EDITOR
#alias -s tex=$EDITOR
#alias -s mws=maple
#alias -s install=$EDITOR

# man zshbuiltins:
# If  the  -s  flags  is present, define a suffix alias: if the
# command word on a command line is in the form 'text.name',
# where text is any non-empty string, it is replaced by the text
# 'value text.name'.  Note that name is treated as a literal
# string, not a pattern.  A trailing space in value is not special
# in this case.  For example,
         #alias -s ps=gv
# will  cause the command `*.ps' to be expanded to `gv *.ps'.
# As alias expansion is carried out earlier than globbing, the
# `*.ps' will then be expanded.  Suffix aliases constitute a
# different name space from other aliases (so in the above
# example it is still possible to  create an alias for the command
# ps) and the two sets are never listed together.

# alias -g gets expanded invisibly (and may interfere with stuff?)
# use something more exotic than I
#alias -g Il=" | less -M -e "
#alias -g Ix=" | xargs "
#alias -g Ig=" | grep -i "
#alias -g Im=" | column -t "
## \n jumps to a new line that has: pipe pipe quote> ' ' '
#alias -g It=" | tr '\n' ' ' "
#alias -g Ic=" | cut -d ' ' -f "
#alias -g Ii=" | xclip -in "
#alias -g Io=" xclip -out "

# from now on, you can't even paste these symbols, instantly expanded. man zshzle.
#                                       alt_gr + key
bindkey -s ł " | less -M -e "           #l
bindkey -s » " | xargs "                #x
bindkey -s ŋ " | grep -i "              #g
bindkey -s µ " | column -t "            #m
# \n, jumps to a new line that has: pipe pipe quote> ' ' '
bindkey -s þ " | tr '\n' ' ' "          #t or p
bindkey -s © " | cut -d ' ' -f "        #c
bindkey -s → " | xclip -in "            #i
bindkey -s œ " xclip -out "             #o
bindkey -s đ " find -iname '**' "	#f  #see drop()
#bindkey -s " |  "

# <  is a builtin pager. > edits a new file
# zsh screencast. tab funkar inte som där.
# menu select
####################################################
# should be almost like .bashrc below:
# can ~ be used in PATH?
#PATH=~/bin:/usr/local/bin:/usr/bin:/bin:/usr/games:~/bin/scripts
test "$PATH_BAK" || PATH_BAK="$PATH"

# franz allegro lisp ~/bin/packages/franz/acl82express
PATH=/usr/local/bin:/usr/bin:/bin:/usr/games:/sbin:/usr/sbin:/usr/bin/core_perl:/opt/java/bin
export PATH

# (some folders i dont have), i might want /opt/qt/bin . mtr is in /usr/sbin
#export PATH="/bin:/usr/bin:/sbin:/usr/sbin:/opt/java/jre/bin:/usr/bin/perlbin/site:/usr/bin/perlbin/vendor:/usr/bin/perlbin/core:/opt/qt/bin:/usr/local/bin:~/bin"
# orig path med GNUtjafs
#~/GNUstep/Tools:/opt/GNUstep/Local/Tools:/opt/GNUstep/System/Tools:/bin:/usr/bin:/sbin:/usr/sbin:/opt/java/jre/bin:/usr/bin/perlbin/site:/usr/bin/perlbin/vendor:/usr/bin/perlbin/core:/opt/qt/bin:/usr/local/bin

# kolla om vi kan ha color, dumb terminal & pacman-color
# use ENV_VAR, check debians .bashrc
# enable color support of ls and also add handy aliases
alias p='pacman'      #not in debian
if [ "$TERM" != "dumb" ]; then
    # no longer in arch:
    #if [ -x /bin/dircolors ]; then
    # debian:
    if [ -x /usr/bin/dircolors ]; then
      eval "`dircolors -b`"
      alias ls='ls --color=auto'
    fi
    # export GREP_COLOR="1;33" # deprecated
    export GREP_COLORS="ms=01;33:mc=01;35:sl=:cx=:fn=35:ln=32:bn=32:se=36"
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
    # colored manpages
    export LESS_TERMCAP_mb=$'\E[01;31m'     # begin blinking
    export LESS_TERMCAP_md=$'\E[01;33m'     # begin bold
    export LESS_TERMCAP_me=$'\E[0m'         # end mode
    export LESS_TERMCAP_se=$'\E[0m'         # end standout-mode
    export LESS_TERMCAP_so=$'\E[01;44;33m'  # begin -"- infobox
    export LESS_TERMCAP_ue=$'\E[0m'         # end underline
    export LESS_TERMCAP_us=$'\E[01;32m'     # begin underline

    if [[ -x /usr/bin/pacman-color ]]; then
      alias p='pacman-color'
    fi
fi

#export BROWSER="opera -w"
export BROWSER="firefox"
#export BROWSER="conkeror"
export PAGER="less -M -e"
export EDITOR="vim"
# for conkeror, may take precedence over EDITOR
# do not want: su makes root use the same value.
# use su - and source the shell init rc from .profile
# export VISUAL="gvim -f"

# zsh has pushd and popd
#function cx() { if [[ $# -eq 0 ]] ; then popd ; else pushd "$@" ; fi ; }
#function c()  { if [[ $# -eq 0 ]] ; then popd ; ls -CF ;  else pushd "$@" ; ls -CF ; fi ; }
#function cx() { if [[ $# -eq 0 ]] ; then popd ; else pushd "$@" ; fi ; }
#function c()  { if [[ $# -eq 0 ]] ; then popd ; else pushd "$@" ; fi ; ls -CF ; }
#function c()  { if (( $# ))       ; then pushd "$@" ; ls -CF ;  else popd ; ls -CF ; fi ; }

c() { (($#)) && pushd "$@" || popd; ls -C; } # golfing
cx() { (($#)) && pushd "$@" || popd; }

function bak() { cp $1{,.bak} ; }
# made vim use ~/.vim/swapfiles as a swapdir
#function swp() { find ${1:=.} -name "*.swp" -exec rm -i {} \; ; }
# put the rest of the argument list at the end. $@:something 2
function drop() { find -L ${2:=.} -iname "*$1*" ; }
function ec() { emacsclient --create-frame --alternate-editor="" -nw "$@" ; }
# bsd-games /usr/bin/rot13 is: exec /usr/bin/caesar 13 "$@"
function rot13() { tr '[a-m][n-z][A-M][N-Z]' '[n-z][a-m][N-Z][A-M]'; }
function tobc() {echo "scale=5; $1 $2 $3" | bc } # escape the *

#alias vl='c /var/log'
#alias ca='c ~/.config/awesome'
#alias go='c ~/bin/projects/lisp/kurs'    #temp
#alias go='c ~/bin/projects/ada'
alias go='c ~/bin/projects/java/tddc69'    #temp
alias gn_='for f in *.adb; do gnatclean "$f"; done'
alias g--='g++ -std=c++98 -pedantic -Wall -Wextra'
alias proj='c ~/bin/projects/'
alias cd-='cd -'
alias cd..='cd ..'
# alias ..='cd ..'
# alias ...='cd ../../'
# alias ....='cd ../../../'
# alias cu='cd ../'

# expand . to /..
# Allow stuff like "cd ..../dir"
rationalise-dot() {
    if [[ $LBUFFER = *.. ]]; then
        LBUFFER+=/..
    else
        LBUFFER+=.
    fi
}
zle -N rationalise-dot
bindkey . rationalise-dot

# alias l='ls -CF' vill inte ha mus-copy-paste farligt '*' extratecken
# har ju redan färgkodning
# -F, --classify
#        append indicator (one of */=>@|) to entries
# --file-type
#        likewise, except do not append `*'

alias l='ls -C'
alias ll='ls -lAh'
alias la='ls -Ah'
alias lu='l ..'
alias l..='l ..'
alias lg='ls -C --group-directories-first'
alias lsl='l | less -e'
alias lll='ll | less -e'
alias l,='ls -m' # comma-separated
alias l_='ls -x' # horizontal order

alias lsg='less -M +G'
alias lm='less -M -e'
alias lhc='hexdump -C | less -M -e'

alias grepc='grep -c'
alias grepi='grep -i'
alias grepn='grep -n'
alias grepv='grep -v'

alias t60='tail -n 60'
alias t30='tail -n 30'
alias sudo='sudo '
alias x='chmod u+x'

# alias pp='pgrep -l'
# alias pp='ps u | grep [U]SER; ps aux | grep -i'
# function pp() { ps u | grep [U]SER; ps aux | grep -v "grep --color=auto" | grep -i "$@" ; }
# lite fult, tar bort       pp: no matches found: [U]SER
# en process per pipe, ju :)
function pp() { ps u | grep USER; ps aux | grep -v "grep --color=auto" | grep -i "$@" ; }
# vill inte ferga "USER", kan se till att inte visa pid-numret #en process per pipe, ju :)

#alias p='pacman-color'
if [[ -e /usr/bin/pacman ]]
then
	alias ss='p -Ss'	# search
	alias si='p -Si'	# show
	alias qs='p -Qs' 	# search installed
	alias qi='p -Qi' 	# show installed
	alias qo='p -Qo' 	# show pkg owning file
	alias ql='p -Ql' 	# list files belonging to
	alias qdt='p -Qdt' 	# see orphans
	alias qm='p -Qm' 	# list foreign ( AUR / my own pkgs )
	alias qc='p -Qc' 	# read changelog
fi

## debian stuffs
if [[ -e /usr/bin/aptitude ]]
then
	alias a='aptitude'
	alias au='sudo aptitude update'
	alias adg='sudo aptitude update && sudo aptitude full-upgrade'
	alias ai='sudo aptitude install'
	alias ah='apt-cache search' # snabbare, local db
	alias s='aptitude search'
	# apt-cache show visar inte status installerat eller ej
	alias aw='aptitude show'  # "as" is the gnu assembler
	alias acw='apt-cache show'  # snabbare, local db
	alias ach='apt-cache showpkg'
	alias ac='apt-cache'
	alias acp='apt-cache policy'
	alias dpl='dpkg -l | grep "ii " |  grep -i'
	dpkg --get-selections | grep -i  #bara namn, inte vers/descr
	#alias rel='ept-cache related' #stopped working. axi-cache
fi

if [[ -e /usr/bin/colordiff ]]
then
	alias diff="colordiff"
fi

alias killal='killall'
alias kilall='killall'

# fixa visudo/ chmod +s . (fixa inittab?)
# /sbin is not in PATH
alias shutdown='/sbin/shutdown -t3 -hP now'
alias reboot='/sbin/reboot'
alias halt='/sbin/halt'

# swap esc och caps, compose multikey, numpad decimal.
alias xD='xmodmap ~/.Xmodmap'

alias pm='pmount /dev/disk/by-label/konserv'
alias pum='pumount /dev/disk/by-label/konserv'

alias mplayer='mplayer -nolirc '
#alias wxyc='mplayer http://152.46.7.128:8000/wxyc.ogg'
#alias wxyc='mplayer http://wxyc.org/wxyc-mp3.m3u'
#alias wxyc='mplayer -cache 300 http://wxyc.org/wxyc-ogg.pls'
alias wxyc='mplayer http://audio-mp3.ibiblio.org:8000/wxyc.mp3'
#alias wxyc='mplayer  -msglevel all=-1 -cache 300 http://wxyc.org/files/streams/wxyc-ogg.pls'
#alias wknc='mplayer -cache 3000 http://wknc.sma.ncsu.edu:8000/wknchq.ogg' # hq
alias wknc='mplayer -cache 1500 http://wknc.sma.ncsu.edu:8000/wkncmq.ogg'  # ncsu
#sätt cache i Kb och börja spela efter 3% fyllnad av den, varva lagom
alias cpl='mplayer cdda:// -cache 3000 -cache-min 3 -cdda speed=7'

alias acro='~/bin/acrobat/bin/acroread'

# åxå lagt in som C-RET i .xbindkeysrc
# connection refused even if daemon running?
# urt --cursorColor Orange
alias urt='urxvt -pe tabbed'   #have urxvtd -q -o -f running
alias URT='urxvt -name URxvt' #transparent (.Xdefaults)
alias tid='watch -t -n1 "date +%T| figlet"'
alias m='cat /proc/mounts'
# use the ec function. or uemacs for fun
# alias em='emacsclient'
# alias ack='ack-grep' # not necessary in arch

alias ub='mount -t vfat /dev/sdb1 /media/usb/; cd /media/usb/'
#alias batt='cat /proc/acpi/battery/C23B/state'
# icmp allowed and ntp works, no need for htpdate
#alias htp='htpdate -s www.kth.se www.sr.se www.nrk.no'

alias choc='chown -R occam:users'
alias chov='chown -R veder:users'
alias chot='chown -R trazan:users'
#alias chuk='sudo chown -R duke:duke'

#alias =''
#alias =''

# alias ae='source ~/.zshrc'
alias sb='source ~/.zshrc'
alias vb='vim ~/.zshrc'

# the string example
poppins="supercalifragilisticexpialidocious"

