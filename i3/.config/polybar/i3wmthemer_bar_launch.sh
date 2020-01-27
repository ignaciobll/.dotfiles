#!/bin/env sh

pkill polybar

sleep 1;

for m in $(polybar --list-monitors | cut -d":" -f1 | tail -n1); do # tac for reverse
    MONITOR=$m polybar --reload i3wmthemer_bar &
done
