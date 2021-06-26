#! /bin/sh

# First version: Mon Sep 14 18:48:18 JST 2020
# Last update: Sun Apr  4 08:35:33 JST 2021

PROJECT_ID=A0
MQTT_BROKER=RPi20181113-2019X.local
MQTT_BROKER=192.168.59.6
MQTT_TOPIC_IN=hohno/MIDI00
MQTT_TOPIC_OUT=hohno/data00

set -x
mosquitto_sub -t $MQTT_TOPIC_IN -h $MQTT_BROKER \
| $HOME/bin/nanoKONTROL2.sh  \
| awk '{printf "%d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d\n", \
    int($2/8*16), int($3/4)*8, int($4/4)*8, int($5/8)*16, int($6/8)*16, int($7/8)*16, int($8/8)*16, int($9/8)*16,
    int($11/4)*4, int($12/8)*16, int($13/8)*16, int($14/8)*16,
    int($15/4)*4, int($16/8)*16, int($17/8)*16, int($18/8)*16,
    fflush()}' \
| mosquitto_pub -l -t $MQTT_TOPIC_OUT
