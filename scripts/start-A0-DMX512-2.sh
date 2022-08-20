#! /bin/sh

# First version: Mon Sep 14 18:48:18 JST 2020
# Prev update: Sun Apr  4 08:34:57 JST 2021
# Last update: Sat Aug 20 10:34:06 JST 2022

# ローカルブローカの $MQTT_TOPIC1 から購読したメッセージを awk で加工してローカルブローカの $MQTT_TOPIC2 に出版する
# $MQTT_TOPIC1 のメッセージは KORG nanoKONTROL2 用のスクリプトからの出力を想定している

PROJECT_ID=A0
MQTT_TOPIC1=hohno/data00
MQTT_TOPIC2=hohno/DMX512

set -x
mosquitto_sub -t $MQTT_TOPIC1 \
| awk '{printf "1c %dw\n2c %dw\n4c %dw\n6c %dw\n7c %dw\n8c %dw\n9c %dw\n5c %dw\n32c %dw\n33c %dw\n34c %dw\n35c %dw\n",
    $1,$2,$3,$4,$5,$6,$7,$8,
    $9*2,$10,$11,$12;
    fflush()}' \
| awk '{if ($2 != xx[$1]) {xx[$1]=$2; printf " %s\n",$0; fflush()}}' \
| mosquitto_pub -l -t $MQTT_TOPIC2

exit 0

# $9+(($9>=120)?$13:0),$10,$11,$12;
