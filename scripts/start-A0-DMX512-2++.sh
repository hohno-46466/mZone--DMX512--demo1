#! /bin/sh

# First version: Mon Sep 14 18:48:18 JST 2020
# Prev update: Sun Apr  4 08:34:57 JST 2021
# Last update: Sat Aug 20 10:34:06 JST 2022

# ローカルブローカの $MQTT_TOPIC1 から購読したメッセージを awk で加工してローカルブローカの $MQTT_TOPIC2 に出版する
# $MQTT_TOPIC1 のメッセージは KORG nanoKONTROL2 用のスクリプトからの出力を想定している

PROJECT_ID=A0
MQTT_TOPIC1=${1:-"hohno/data00"}
MQTT_TOPIC2=${2:-"hohno/DMX512"}

set -x
mosquitto_sub -t $MQTT_TOPIC1 \
| awk '{printf "1c %dw\n201c %dw\n2c %dw\n202c %dw\n4c %dw\n206c %dw\n6c %dw\n203c %dw\n7c %dw\n203c %dw\n8c %dw\n203c %dw\n9c %dw\n203c %dw\n5c %dw\n205c %dw\n", $1,$1, $2,$2, $3,$3, $4,12, $5,32, $6,40, $7,4, $8,255; fflush()}' \
| awk '{if ($2 != xx[$1]) {xx[$1]=$2; printf " %s\n",$0; fflush()}}' \
| mosquitto_pub -l -t $MQTT_TOPIC2

exit 0

# $9+(($9>=120)?$13:0),$10,$11,$12;
