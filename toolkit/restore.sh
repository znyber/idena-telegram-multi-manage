#!/bin/bash
if [ -f /root/restore.txt ]; then
echo "file OK gass"
else
echo "file not found"
exit 0
fi
while read line; do
USER=$(echo "$line" | awk '{print $1}')
idena-multi $line
sleep 10
echo "$USER"
RPCD=$(tail -n 1 /home/$USER/$USER-portRpc.txt)
DATC=$(curl -s "http://127.0.0.1:$RPCD/" -H 'Content-Type: application/json' --data "{\"method\":\"bcn_syncing\",\"params\":[],\"id\":1,\"key\":\"$USER\"}")
SYNCA=$(echo $DATC | sed -n 's|.*"syncing":\([^"]*\),.*|\1|p')
CURBLOCK=$(echo $DATC | sed -n 's|.*"currentBlock":\([^"]*\),.*|\1|p')
HIGBLOCK=$(echo $DATC | sed -n 's|.*"highestBlock":\([^"]*\),.*|\1|p')
SECONDS=0
while [ "$SYNCA" != false ]
do
KOVET=$(netstat -netulp |grep 127.0.0.1:$RPCD | awk -F "[ :]+" '/:/{print $5}')
if [[ $KOVET == $RPCD ]]
then
echo "node $RPCD sync $SYNCA , block curent $CURBLOCK to block high $HIGBLOCK" >&2
DATC=$(curl -s "http://127.0.0.1:$RPCD/" -H 'Content-Type: application/json' --data "{\"method\":\"bcn_syncing\",\"params\":[],\"id\":1,\"key\":\"$USER\"}")
SYNCA=$(echo $DATC | sed -n 's|.*"syncing":\([^"]*\),.*|\1|p')
CURBLOCK=$(echo $DATC | sed -n 's|.*"currentBlock":\([^"]*\),.*|\1|p')
HIGBLOCK=$(echo $DATC | sed -n 's|.*"highestBlock":\([^"]*\),.*|\1|p')
BLOCKTIM=$(($HIGBLOCK-$CURBLOCK))
sleep $(($BLOCKTIM+10))
else
sleep 10
fi
done
KOVET=$(netstat -netulp |grep 127.0.0.1:$RPCD | awk -F "[ :]+" '/:/{print $5}')
if [[ $KOVET == $RPCD ]]
then
echo "node $RPCD sync $SYNCA , time to full sync $SECONDS" >&2
else
echo "node $RPCD down $KOVET" >&2
fi
SECONDS=0
done <<<$(cat /root/restore.txt)
while read notifz; do
TOKEN=1422705649:AAFJWFkgiHRRE5K72XtV_1gU4lKHROa9nZI
CHAT_ID=$notifz
MESSAGE="<b>data node imported at</b>%0A<tg-spoiler>$(date)</tg-spoiler>  %0Asuccess"
URL="https://api.telegram.org/bot$TOKEN/sendMessage"

curl -s -X POST $URL -d chat_id=$CHAT_ID -d parse_mode=HTML -d text="$MESSAGE"
done <<<$(cat /root/chatidX.txt)
echo "all restore clear"