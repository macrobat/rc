#!/bin/bash
# ~/.xinitrc
# Executed by startx (run your window manager from here)

# om raden ligger efter X, visar ju led för capslock tvärtom!
# install numlockx first :D
numlockx on

# iwannazap.com
#setxkbmap -option terminate:ctrl_alt_bksp
#setxkbmap se -variant nodeadkeys
setxkbmap se -variant nodeadkeys -option terminate:ctrl_alt_bksp

# mera keybinds (~/.xbindkeysrc)
xbindkeys -f ~/.xbindkeysrc 

# tapping off for 2 secs when typing. -t allows moving:
# -K ignore Modifier+Key combos. -d daemon -i timeout
# syndaemon -d -K -t -i 2 &

# daemon quiet, bind it to x session, fork. use with urxvtc
# tmp comment
urxvtd -q -o -f

# clipbored daemon, see if it's running first? 
# crap, only gives one word, stdout-puts previous choice
#if [[ -x /usr/bin/site_perl/clipbored ]]
#then
	#/usr/bin/site_perl/clipbored &
#fi

# run this with xbindkeys:
# /usr/bin/site_perl/dmenuclip

# background, remember to disable wm background settings
# eval $(cat .fehbg) # cargo culte
source ~/.fehbg
# exmpl #feh --bg-scale 'pics/bakgrund/arch_headphones2.png'

# change mouse pointer in awesome 
xsetroot -cursor_name left_ptr
# xinput --set-prop --type=float 8 245 4.000000
# read, filter, assign, apply. RAZERID is typically 8
# properties have changed codes, to see them: xinput --list-props 8
RAZERID=$(xinput --list | awk -F "=" '/Razer Razer 1600dpi Mouse/ {print $2}' | awk '{print $1}')
# 0 is not negative enough
xinput set-prop 'Razer Razer 1600dpi Mouse' 'Device Accel Profile' -1
# xinput --set-prop --type=float $RAZERID 245 4.000000 
# disable emulate3buttons
xinput --set-prop --type=int $RAZERID 254 0

# borde ju va automagiskt
xrdb ~/.Xresources

# måste va efter setxkbmap
# funkar inte. inte ~/.Xprofile heller
#sleep 3 && xmodmap ~/.Xmodmap
#/home/occam/bin/scripts/swap_esc_caps.sh &
xmodmap ~/.Xmodmap

xscreensaver -nosplash &

# exec openbox-session
# exec gnome-session
# exec startkde
# exec startxfce4
# bug i hal, nu ska jag kunna stänga ned från X, långsamt men funkis!
# exec ck-launch-session xfce4-session

# experiment ny rc.lua
#awesome -c ~/.config/awesome/rc.new.lua
#awesome -c ~/.config/awesome/rc.lua_20101005-1.lua
#ck-launch-session awesome

if [[ WM = openbox ]] ; then 
	WM="openbox-session"
fi
#exec ck-launch-session openbox-session
# exec ck-launch-session dbus-launch ${WM:=awesome}
exec ck-launch-session dbus-launch ${WM:=startxfce4}

