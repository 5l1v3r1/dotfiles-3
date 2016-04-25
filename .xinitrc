#!/bin/bash
#~/.xinitrc

#source xinitrc.d scripts :)
if [ -d /etc/X11/xinit/xinitrc.d ]; then
  for f in /etc/X11/xinit/xinitrc.d/*; do
    [ -x "$f" ] && . "$f"
  done
  unset f
fi

# add font paths
xset fp default
[[ -d /usr/share/fonts/local ]] && xset +fp /usr/share/fonts/local
[[ -d /usr/share/fonts/OTF ]] && xset +fp /usr/share/fonts/OTF
[[ -d $HOME/.local/share/fonts ]] && xset +fp $HOME/.local/share/fonts
xset fp rehash
fc-cache -f -v &

# set background
~/.fehbg

#Xresources
xrdb -merge ~/.Xresources

#Add Lang switching in alt+shift
setxkbmap -option grp:switch,grp:alt_shift_toggle,grp_led:scroll us,il

#Terminal daemon 
urxvtd &

#Nothing to say about mpd, it`s so awesome !
mpd &

#Compton
compton --config $HOME/.compton/compton.conf &

# start WMStatusbar
dwm-statusbar &
exec dwm 2> ~/log/dwm.log 
