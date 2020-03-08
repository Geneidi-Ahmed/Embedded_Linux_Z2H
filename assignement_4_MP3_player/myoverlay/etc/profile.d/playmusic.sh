#!/bin/sh
export PS1='<rapi_shell> : \w\$'
modprobe snd-bcm2835
. /myApplications/Player.sh 4 17 27 22 &
