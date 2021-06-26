#! /bin/bash

# First version: Mon Sep 14 18:48:18 JST 2020

PROJECT_ID=A0
MQTT_TOPIC=hohno/data00
INTERVAL=${1:-6}

while [ 1 ]; do
  /bin/echo -n "$(($RANDOM % 256)) "
  /bin/echo -n "$(($RANDOM % 256)) "
  /bin/echo -n "$((32+(($RANDOM % 7)*32))) "
  /bin/echo -n "$((($RANDOM % 4)*64)) "
  /bin/echo -n "$((($RANDOM % 4)*64)) "
  /bin/echo -n "$((($RANDOM % 4)*64)) "
  /bin/echo -n "$((16+($RANDOM % 2)*0)) "
  /bin/echo -n "$((($RANDOM % 2)*0)) "
  /bin/echo -n "$(($RANDOM % 128)) "
  /bin/echo -n "$(($RANDOM % 256)) "
  /bin/echo -n "$(($RANDOM % 256)) "
  /bin/echo -n "$(($RANDOM % 256)) "
  /bin/echo -n "$(($RANDOM % 128))"
  /bin/echo ""
  (LANG=C; LC_ALL=C; date 1>&2)
  sleep $INTERVAL
done \
| mosquitto_pub -l -t $MQTT_TOPIC
