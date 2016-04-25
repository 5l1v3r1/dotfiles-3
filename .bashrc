#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# Add vim as default editor
export EDITOR=vim
export TERMINAL=urxvt
export BROWSER=firefox
export PATH="$PATH:$HOME/bin"
# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
#HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# set pager
export PAGER=/usr/bin/less

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# Gtk themes 
export GTK2_RC_FILES="$HOME/.gtkrc-2.0"


complete -cf sudo
complete -cf man

# User/root variables definition
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi
#Colored Xterm
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# Colored prompt
force_color_prompt=yes
if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	color_prompt=yes
    else
	color_prompt=
    fi
fi

# Shopt
shopt -s autocd
shopt -s cdspell
shopt -s cmdhist
shopt -s dotglob
shopt -s expand_aliases
shopt -s extglob
shopt -s hostcomplete
shopt -s nocaseglob

# Colour chart
T='.'   # The test text

echo -e "\n                 40m     41m     42m     43m\
     44m     45m     46m     47m";

for FGs in '    m' '   1m' '  30m' '1;30m' '  31m' '1;31m' '  32m' \
           '1;32m' '  33m' '1;33m' '  34m' '1;34m' '  35m' '1;35m' \
           '  36m' '1;36m' '  37m' '1;37m';
  do FG=${FGs// /}
  echo -en " $FGs \033[$FG  $T  "
  for BG in 40m 41m 42m 43m 44m 45m 46m 47m;
    do echo -en "$EINS \033[$FG\033[$BG  $T  \033[0m";
  done
  echo;
done
echo

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

color_prompt=yes

case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# Bash Completion
if [ -f /etc/bash_completion ]; then
	    . /etc/bash_completion
fi

# Alias definitions.
if [ -x ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# Function definitions.
if [ -x ~/.bash_functions ]; then
    . ~/.bash_functions
fi

# Prompt definitions.
if [ -x ~/.bash_prompt ]; then
    . ~/.bash_prompt
fi


# Advanced directory creation
function mkcd {
  if [ ! -n "$1" ]; then
    echo "Plz Enter A FUCKING NAME for the direcrtory !"
  elif [ -d $1 ]; then
    echo "\`$1'The Folder Already Exist !"
  else
    mkdir $1 && cd $1
  fi
}

# Go back with ..
b() {
    str=""
    count=0
    while [ "$count" -lt "$1" ];
    do
        str=$str"../"
        let count=count+1
    done
    cd $str
}

function cd()
{
 builtin cd "$*" && ls
}

function tov()
{
  if [ ! -n "$1" ]; then
    echo "Plz Enter A Name For The File"
  elif [ -d $1 ]; then
    echo "The File Already Exist !"
  else
    touch $1 && vim $1
  fi
}

## MISC ALIASES ##
alias ls='ls --group-directories-first --time-style=+"%d.%m.%Y %H:%M" --color=auto -F'
alias ll='ls -l --group-directories-first --time-style=+"%d.%m.%Y %H:%M" --color=auto -F'
alias la='ls -la --group-directories-first --time-style=+"%d.%m.%Y %H:%M" --color=auto -F'
alias grep='grep --color=tty -d skip'
alias cp="cp -i"                          # confirm before overwriting something
alias df='df -h'                          # human-readable sizes
alias free='free -m'                      # show sizes in MB
alias vp='vim PKGBUILD'
alias rf='rm -rfv'
alias volup='amixer -c0 sset Master 3dB+'
alias voldn='amixer -c0 sset Master 3dB-'
alias fuser='fuser -a -w -i -9 -m -v'

alias update='sudo pacman -Syu'
alias install='sudo pacman -S'
alias uninstall='sudo pacman -Rns'
alias search='pacman -Ss'
alias show='pacman -Si'
alias need='pacman -Qi'
alias missing='pacman -Qk'
alias trash='pacman -Qdt'

alias youtube-mp3='youtube-dl --extract-audio --audio-format mp3'
alias speedtest='speedtest-cli'
alias enternet='elinks https://duckduckgo.com'
alias randb64='openssl rand -base64'		#base64 randomizer (It Uses Every Letter Available (; ) 
alias randhex='openssl rand -hex'				#hex randomizer (Uses Only letter`s and numbers)
alias sshot='scrot -s ~/Pictures/Screenshots/%b%d_%H:%M:%S.png'
alias heb='setxkbmap -option grp:switch,grp:alt_shift_toggle,grp_led:scroll us,il'
alias ..='cd ..'
# Color man pages
man() {
	env \
		LESS_TERMCAP_mb=$(printf "\e[1;31m") \
		LESS_TERMCAP_md=$(printf "\e[1;31m") \
		LESS_TERMCAP_me=$(printf "\e[0m") \
		LESS_TERMCAP_se=$(printf "\e[0m") \
		LESS_TERMCAP_so=$(printf "\e[1;44;33m") \
		LESS_TERMCAP_ue=$(printf "\e[0m") \
		LESS_TERMCAP_us=$(printf "\e[1;32m") \
			man "$@"
}

## COMPRESSION FUNCTION ##
function compress_() {
   # Credit goes to: Daenyth
   FILE=$1
   shift
   case $FILE in
      *.tar.bz2) tar cjf $FILE $*  ;;
      *.tar.gz)  tar czf $FILE $*  ;;
      *.tgz)     tar czf $FILE $*  ;;
      *.zip)     zip $FILE $*      ;;
      *.rar)     rar $FILE $*      ;;
      *)         echo "Filetype not recognized" ;;
   esac
}

## EXTRACT FUNCTION ##
extract ()
{
  if [ -f $1 ] ; then
    case $1 in
      *.tar.xz)	   tar xvJf $1	 ;;
      *.tar.bz2)   tar xvjf $1   ;;
      *.tar.gz)    tar xvzf $1   ;;
      *.bz2)       bunzip2 $1   ;;
      *.rar)       unrar x $1     ;;
      *.gz)        gunzip $1    ;;
      *.tar)       tar xf $1    ;;
      *.tbz2)      tar xjf $1   ;;
      *.tgz)       tar xzf $1   ;;
      *.zip)       unzip $1     ;;
      *.Z)         uncompress $1;;
      *.7z)        7z x $1      ;;
      *)           echo "'$1' cannot be extracted via extract()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}

# test if a file should be opened normally, or as root (edit)
argc () {
        count=0;
        for arg in "$@"; do
                if [[ ! "$arg" =~ '-' ]]; then count=$(($count+1)); fi;
        done;
        echo $count;
}

edit () { if [[ `argc "$@"` > 1 ]]; then vim $@;
                elif [ $1 = '' ]; then vim;
                elif [ ! -f $1 ] || [ -w $1 ]; then vim $@;
                else
                        echo -n "File is Read-only. Edit as root? (Y/n): "
                        read -n 1 yn; echo;
                        if [ "$yn" = 'n' ] || [ "$yn" = 'N' ];
                            then vim $*;
                            else sudo vim $*;
                        fi
                fi
            }

gedit () { if [[ `argc "$@"` > 1 ]]; then gedit $@;
                elif [ $1 = '' ]; then gedit;
                elif [ ! -f $1 ] || [ -w $1 ]; then gedit $@;
                else
                        echo -n "File is Read-only. Edit as root? (Y/n): "
                        read -n 1 yn; echo;
                        if [ "$yn" = 'n' ] || [ "$yn" = 'N' ];
                            then gedit $*;
                            else sudo gedit $*;
                        fi
                fi
            }

# test encode & decode base64
decode () {
  echo "$1" | base64 -d ; echo
}

encode () {
  echo "$1" | base64 - ; echo
}

# access translate.google.com from terminal
translate () { 
 
# adjust to taste
DEFAULT_TARGET_LANG=en
 
if [[ $1 = -h || $1 = --help ]]
then
    echo "$help"
    exit
fi
 
if [[ $3 ]]; then
    source="$2"
    target="$3"
elif [[ $2 ]]; then
    source=auto
    target="$2"
else
    source=auto
    target="$DEFAULT_TARGET_LANG"
fi
 
echo $i" " $text
result=$(curl -s -i --user-agent "" -d "sl=$source" -d "tl=$target" --data-urlencode "text=$1" http://translate.google.com)
encoding=$(awk '/Content-Type: .* charset=/ {sub(/^.*charset=["'\'']?/,""); sub(/[ "'\''].*$/,""); print}' <<<"$result")
iconv -f $encoding <<<"$result" |  awk 'BEGIN {RS="</div>"};/<span[^>]* id=["'\'']?result_box["'\'']?/' | html2text
}

# prompt
#PS1="\[\e[01;37m\]┌─[\t][$]: \w\[\e[01;37m\]\n\[\e[01;37m\]└──\[\e[01;37m\]──╼\[\e[0m\] "


# Prompt
if [ -n "$SSH_CONNECTION" ]; then
export PS1="\[$(tput setaf 1)\]┌─╼ \[$(tput setaf 7)\][\w]\n\[$(tput setaf 1)\]\$(if [[ \$? == 0 ]]; then echo \"\[$(tput setaf 1)\]└────╼ \[$(tput setaf 7)\][ssh]\"; else echo \"\[$(tput setaf 1)\]└╼ \[$(tput setaf 7)\][ssh]\"; fi) \[$(tput setaf 7)\]"
else
export PS1="\[$(tput setaf 6)\]┌─╼ \[$(tput setaf 7)\][\w]\n\[$(tput setaf 2)\]\$(if [[ \$? == 0 ]]; then echo \"\[$(tput setaf 6)\]└────╼\"; else echo \"\[$(tput setaf 1)\]└╼\"; fi) \[$(tput setaf 7)\]"
fi

#trap 'echo -ne "\e[0m"' DEBUG
