#!/bin/sh
while read line; do
echo $line
while read line2; do
KOVET=$(netstat -netulp |grep $line2 | awk -F "[ :]+" '/:/{print $5}')
if [[ $KOVET == $line2 ]]
then
echo "node $line2 ON"
DATC=$(curl -s "http://127.0.0.1:$line2/" -H 'Content-Type: application/json' --data "{\"method\":\"dna_identity\",\"params\":[],\"id\":1,\"key\":\"$line\"}")
states=$(echo $DATC | sed -n 's|.*"state":"\([^"]*\)".*|\1|p')
addrss=$(echo $DATC | sed -n 's|.*"address":"\([^"]*\)".*|\1|p')
add1=$(echo $addrss | head -c 3)
add2=$(echo $addrss | tail -c 3)
minir=$(echo $DATC | sed -n 's|.*"online":\([^"]*\),.*|\1|p')
if [[ $minir == true ]]
then
online="ON"
else
online="OFF"
fi
echo "Status : $states Address : $add1...$add2 Mining : $online"
else
echo "node $line2 OFF"
fi
done <<<$(cat /home/$line/$line-portRpc.txt)
echo "--------------------"
done <<<$(cat /home/user.txt)