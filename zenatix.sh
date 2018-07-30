#!/bin/bash

while true

do

CPU_USAGE=$(top -bn1 | grep "Cpu(s)" | \
           sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | \
           awk '{print 100 - $1}')

echo $CPU_USAGE

#influx INSERT cpu,host=serverA value=$CPU_USAGE exit

influx -database 'monitor' -execute 'INSERT CPU_Usage,host=serverA value'=$CPU_USAGE

sleep 300

done
