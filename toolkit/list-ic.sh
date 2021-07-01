#!/bin/bash
touch /tmp/temp.txt
touch /tmp/icdump.txt
echo "" > /tmp/temp.txt
while read line; do
echo "0" > /tmp/icdump.txt
IC=0
while read line2; do
KOVET=$(netstat -netulp |grep 127.0.0.1:$line2 | awk -F "[ :]+" '/:/{print $5}')
if [[ $KOVET == $line2 ]]
then
DATC=$(curl -s "http://127.0.0.1:$line2/" -H 'Content-Type: application/json' --data "{\"method\":\"dna_identity\",\"params\":[],\"id\":1,\"key\":\"$line\"}")
IC=$(echo $DATC | sed -n 's|.*"invites":\([^"]*\),.*|\1|p')
ICDUMP=$(cat /tmp/icdump.txt)
ICX=$(($ICDUMP+$IC))
echo $ICX > /tmp/icdump.txt
else
sleep 1
fi
done <<<$(cat /home/$line/$line-portRpc.txt)
KOPET=$(cat /tmp/icdump.txt)
if [[ $KOPET == 0 ]]
then
echo "@$line " >> /tmp/temp.txt
else
GUDMER=$(cat /tmp/icdump.txt)
echo -n "@$line " >> /tmp/temp.txt
echo "ada IC $GUDMER" >> /tmp/temp.txt
fi
done <<<$(cat /home/user.txt)
DATC=$(curl -s "http://127.0.0.1:9009/" -H 'Content-Type: application/json' --data "{\"method\":\"bcn_syncing\",\"params\":[],\"id\":1,\"key\":\"kenebaezxcpm\"}")
HIGBLOCK=$(echo $DATC | sed -n 's|.*"highestBlock":\([^"]*\),.*|\1|p')
GENBLOCK=$(echo $DATC | sed -n 's|.*"genesisBlock":\([^"]*\)}}.*|\1|p')
NANI=$(cat /tmp/temp.txt)
#read -r -d '' msg <<EOT
echo -e "list IC ,
User produksi IC $NANI
block sebelumnya <code> $GENBLOCK </code>
block saat ini <code> $HIGBLOCK </code>"
#EOT
#curl --data chat_id="$CHAT_ID" --data-urlencode "text=${msg}" "https://api.telegram.org/bot$TOKEN/sendMessage?parse_mode=HTML"
