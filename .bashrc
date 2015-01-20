#PS1='Arch\u:[ ´pwd´] # '§
#PS1='Arch \u:[ \w]# '
PS1='\u:[\w]$ '
#export PS1

# export PATH="$PATH:/usr/local/bin"
PATH_BAK="$PATH"
PATH=/usr/local/bin:/usr/bin:/bin:/usr/games:/sbin:/usr/sbin
export PATH

# don't stop output on C-s
stty -ixon
stty ixany

# (some folders i dont have), i might want /opt/qt/bin . mtr is in /usr/sbin
#export PATH="/bin:/usr/bin:/sbin:/usr/sbin:/opt/java/jre/bin:/usr/bin/perlbin/site:/usr/bin/perlbin/vendor:/usr/bin/perlbin/core:/opt/qt/bin:/usr/local/bin:~/bin"
# orig path med GNUtjafs
#~/GNUstep/Tools:/opt/GNUstep/Local/Tools:/opt/GNUstep/System/Tools:/bin:/usr/bin:/sbin:/usr/sbin:/opt/java/jre/bin:/usr/bin/perlbin/site:/usr/bin/perlbin/vendor:/usr/bin/perlbin/core:/opt/qt/bin:/usr/local/bin

# kolla om vi kan ha color, dumb terminal & pacman-color
# use ENV_VAR, check debians .bashrc
# enable color support of ls and also add handy aliases
alias p='pacman'      #not in debian
if [ "$TERM" != "dumb" ]; then
    # arch:
    if [ -x /bin/dircolors ]; then
    # debian:
    #if [ -x /usr/bin/dircolors ]; then
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

c() { (($#)) && pushd "$@" || popd; ls -C; } # golfing
cx() { (($#)) && pushd "$@" || popd; }

function bak() { cp $1{,.bak} ; }
function swp() { find ${1:=.} -name "*.swp" -exec rm -i {} \; ; }
# put the rest of the argument list at the end. $@:something 2
function drop() { find -L ${2:=.} -iname "*$1*" ; }
function ec() { emacsclient --create-frame --alternate-editor="" -nw "$@" ; }
function rot13() { tr '[a-m][n-z][A-M][N-Z]' '[n-z][a-m][N-Z][A-M]'; }

#alias vl='c /var/log'
alias ca='c ~/.config/awesome'
alias go='c ~/bin/projects/C'    #temp
alias cd-='cd -'
alias cd..='cd ..'
alias ..='cd ..'
alias ...='cd ../../'
alias ....='cd ../../../'
alias cu='cd ../'

alias l='ls -CF'
alias ll='ls -lAh'
alias la='ls -Ah'
alias lu='l ..'
alias l..='l ..'
alias lg='ls -CF --group-directories-first'
alias lsl='l | less -e'
alias lll='ll | less -e'

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

# åxå lagt in som C-RET i .xbindkeysrc
# connection refused even if daemon running?
# urt --cursorColor Orange
alias urt='urxvt -pe tabbed'   #have urxvtd -q -o -f running
alias URT='urxvt -name URxvt' #transparent (.Xdefaults)
alias tid='watch -t -n1 "date +%T| figlet"'
alias m='cat /proc/mounts'
alias ec='emacsclient'
# alias ack='ack-grep' # not necessary in arch

#alias ub='mount -t vfat /dev/sdb1 /media/usb/; cd /media/usb/'
#alias batt='cat /proc/acpi/battery/C23B/state'
#alias htp='htpdate -s www.kth.se www.sr.se www.nrk.no'

#alias chub='sudo chown -R bob:users'

#alias =''
#alias =''

if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi

#want completion, even if i'm in the wheel group and do sudo
#look in /etc/bash_completion, if it's not working
complete -cf sudo
#alias ae='source ~/.bashrc'
#alias sb='source ~/.bashrc'
alias vb='vim ~/.bashrc'

# the string example
poppins="supercalifragilisticexpialidocious"

