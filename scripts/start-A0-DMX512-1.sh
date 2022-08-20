#! /bin/sh

# First version: Mon Sep 14 18:48:18 JST 2020
# Prev update: Fri Sep 18 21:55:48 JST 2020
# Prev update: Mon Sep 21 07:39:11 JST 2020
# Last update: Sat Aug 20 10:32:56 JST 2022

# ローカルブローカの $MQTT_TOPIC からメッセージを購読し $TTYPORT に送信する．
# $TTYPORT から読みだしたメッセージを標準出力に出力する

PROJECT_ID=A0
PROJECT_DIR=$HOME/workspace/Scripts/screenCTRL
PROJECT_FILE=${PROJECT_DIR}/Project.cfg

SUDO=
SUDO=sudo

MQTT_TOPIC=hohno/DMX512
DEF_TTYPORT=/dev/ttyACM-A0_DMX512

TTYPORT=${TTYPORT:-$1}
TTYPORT=${TTYPORT:-$DEF_TTYPORT}
[ "x$TTYPORT" = "x" -o ! -e $TTYPORT ] && TTYPORT=$(grep $PROJECT_ID $PROJECT_FILE | awk '{print $3}')
[ "x$TTYPORT" = "x" -o ! -e $TTYPORT ] && exit 2

# echo "[$TTYPORT]"
ls -l $TTYPORT || exit 9 
ls -lL $TTYPORT || exit 8 

set -x
mosquitto_sub -t $MQTT_TOPIC | awk '{printf "%s\n",$0; fflush();if ((NR%6)==0){system("sleep 0.01");printf "--------\n";}}' | $sudo cu -s 57600 -l $TTYPORT | cat -u -n
set +x

exit $?

