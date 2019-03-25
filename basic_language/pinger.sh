#!/bin/bash
while :
do
  ping -c 1 192.168.1.1 | tail -1| awk -F '/' 'END {print $5}' >> test.txt
  sleep 2
done
