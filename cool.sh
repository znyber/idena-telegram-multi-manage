#!/bin/sh
echo ">>>>>Resource<<<<<<"
free -m | awk 'NR==2{printf "Memory Usage: %s/%sMB (%.2f%%)\n", $3,$2,$3*100/$2 }'
df -h | awk '$NF=="/"{printf "Disk Usage: %d/%dGB (%s)\n", $3,$2,$5}'
top -bn1 | grep load | awk '{printf "CPU Load Average: %.2f\n", $(NF-2)}'
top -bn1 | awk -F  "[: ]+" '/Cpu/{print "CPU Usage Total :", $2 "%"}'
echo "load CPU Usage /Core"
n=1
while read line; do
echo "Cpu Core $n : $line"
n=$((n+1))
done <<<$(top -bn1 1 | awk -F  "[: ]+" '/Cpu/{print $2 "%"}')
echo "Total Download & Upload Internet"
ifconfig | grep "RX packets" | awk -F "[ ]+" '/RX/{print "Download :", $2,$(NF-1), $(NF-0)}' |head -n 1
ifconfig | grep "TX packets" | awk -F "[ ]+" '/TX/{print "Upload :", $2,$(NF-1), $(NF-0)}' |head -n 1
echo "Total Download & Upload Local/Tunnel"
ifconfig | grep "RX packets" | awk -F "[ ]+" '/RX/{print "Download :", $2,$(NF-1), $(NF-0)}' |tail -n 1
ifconfig | grep "TX packets" | awk -F "[ ]+" '/TX/{print "Upload :", $2,$(NF-1), $(NF-0)}' |tail -n 1
echo "status Server ON"
uptime -p
