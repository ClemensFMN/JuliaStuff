#!/bin/bash
while :
do
  ping -c 1 www.google.at | tail -1| awk -F '/' 'END {print $5}' >> ping_result.txt
  sleep 2
done
