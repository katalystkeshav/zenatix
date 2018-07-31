#!/bin/bash

while true

do

CPU_USAGE=$(top -bn1 | grep "Cpu(s)" | \
           sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | \
           awk '{print 100 - $1}')

RAM_USAGE=$(free | grep Mem | awk '{print $3/$2 * 100.0}')
		   
echo $CPU_USAGE

echo $RAM_USAGE

#influx INSERT cpu,host=serverA value=$CPU_USAGE exit

influx -database 'monitor' -execute 'INSERT CPU_Usage,host=serverA value'=$CPU_USAGE

influx -database 'monitor' -execute 'INSERT RAM_Usage,host=serverA value'=$RAM_USAGE

sleep 300

done
