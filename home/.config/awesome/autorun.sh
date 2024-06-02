#!/bin/sh

run() {
  if ! pgrep -f "$1" ;
  then
    $@&
  fi
}

export -f run

run "xsetroot -bg 0"
run "picom"
run "xset r rate 200"

if [ -x ~/.config/awesome/autorun.local.sh ];  then
   ~/.config/awesome/autorun.local.sh
fi
