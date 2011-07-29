#PS1='Arch\u:[ ´pwd´] # '§
#PS1='Arch \u:[ \w]# '
PS1='\u:[\w]$ '
#export PS1

export PATH="$PATH:/usr/local/bin"
#/home/occam/GNUstep/Tools:/opt/GNUstep/Local/Tools:/opt/GNUstep/System/Tools:/bin:/usr/bin:/sbin:/usr/sbin:/opt/java/jre/bin:/usr/bin/perlbin/site:/usr/bin/perlbin/vendor:/usr/bin/perlbin/core:/opt/qt/bin:/usr/local/bin

#kolla om vi kan ha color, dumb terminal & pacman-color
#use ENV_VAR, check debians .bashrc
# enable color support of ls and also add handy aliases
alias p='pacman'
if [ "$TERM" != "dumb" ]; then
    if [ -x /bin/dircolors ]; then
      eval "`dircolors -b`"
      alias ls='ls --color=auto' 
      export GREP_COLORS="ms=01;33:mc=01;35:sl=:cx=:fn=35:ln=32:bn=32:se=36"
      # export GREP_COLOR="1;33" #deprecated
      alias grep='grep --color=auto'
      alias fgrep='fgrep --color=auto'
      alias egrep='egrep --color=auto'
    fi

    #colored manpages
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
export BROWSER="conkeror"
export PAGER="less -M -e"
export EDITOR="vim"

function cx () { if [[ $# -eq 0 ]] ; then popd ; ls -CF ;  else pushd "$@" ; ls -CF ; fi ;}
function c () { if [[ $# -eq 0 ]] ; then popd ; else pushd "$@" ; fi ;}

alias ca='cx ~/.config/awesome'
alias go='cx ~/bin/projects/kod'    #temp
alias cd..='cd ..'
alias ..='cd ..'
alias ...='cd ../../'
alias ....='cd ../../../'
alias cd-='cd -'
alias cu='cd ../'
alias l='ls -CF'
alias ll='ls -lAh'
alias la='ls -Ah'
alias lu='l ..'
alias l..='l ..'
alias lg='ls -CF --group-directories-first'
alias lsl='l | less -e'

alias lsg='less -M +G'
alias lm='less -M -e'
alias lhc='hexdump -C | less -M -e'

alias grepc='grep -c'
alias grepi='grep -i'
alias grepn='grep -n'
alias grepv='grep -v'

alias t60='tail -n 60'
alias t30='tail -n 30'

alias pp='ps u | grep [U]SER; ps aux | grep -i'


alias ss='p -Ss'	# search
alias si='p -Si'	# show
alias qs='p -Qs' 	# search installed
alias qi='p -Qi' 	# show installed
alias qo='p -Qo' 	# show pkg owning file
alias ql='p -Ql' 	# list files belonging to
alias qdt='p -Qdt' 	# see orphans
alias qm='p -Qm' 	# list foreign / own compiled 
alias qc='p -Qc' 	# read changelog

alias km='killall mc'
alias killal='killall'
alias kilall='killall'

alias shutdown='shutdown -t3 -hP now'
alias reboot='/sbin/reboot'
alias halt='/sbin/halt'

#ladda swap av esc och caps
alias xD='xmodmap ~/.Xmodmap'

#alias wxyc='mplayer -cache 500 http://152.46.7.128:8000/wxyc.ogg'
alias wxyc='mplayer -cache 500 http://wxyc.org/wxyc-mp3.m3u'
#sätt cache i Kb och börja spela efter 3% fyllnad av den, varva lagom
alias cpl='mplayer cdda:// -cache 3000 -cache-min 3 -cdda speed=7'
#åxå lagt in som C-RET i .xbindkeysrc
alias urt='urxvt -pe tabbed'
alias tid='watch -t -n1 "date +%T| figlet"'
alias m='cat /proc/mounts'

alias ub='mount -t vfat /dev/sdb1 /media/usb/; cd /media/usb/'
alias batt='cat /proc/acpi/battery/C177/state'
alias htp='htpdate -s www.kth.se www.sr.se www.nrk.no'

alias choc='chown -R occam:users'
alias chov='chown -R veder:users'
alias chot='chown -R trazan:users'


#alias =''
#alias =''

if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi

#want completion, even if i'm in the wheel group and do sudo
#look in /etc/bash_completion, if it's not working
complete -cf sudo
alias ae='source ~/.bashrc'
alias sb='source ~/.bashrc'
alias vb='vim ~/.bashrc'

