#!/bin/bash
systemctl stop idena.target
while read line; do
echo $line
DATCX=$(curl -s "http://127.0.0.1:9009/" -H 'Content-Type: application/json' --data "{\"method\":\"bcn_syncing\",\"params\":[],\"id\":1,\"key\":\"kenebaezxcpm\"}")
SYNCAX=$(echo $DATCX | sed -n 's|.*"syncing":\([^"]*\),.*|\1|p')
CURBLOCKX=$(echo $DATCX | sed -n 's|.*"currentBlock":\([^"]*\),.*|\1|p')
HIGBLOCKX=$(echo $DATCX | sed -n 's|.*"highestBlock":\([^"]*\),.*|\1|p')
#BLOCKTIMX=$(($HIGBLOCKX-$CURBLOCX))
#sleep $(($BLOCKTIMX+10))
while [ "$SYNCAX" != false ]
do
KOVETX=$(netstat -netulp |grep 127.0.0.1:9009 | awk -F "[ :]+" '/:/{print $5}')
if [[ $KOVETX == "9009" ]]
then
echo "node share sync $SYNCAX , block curent $CURBLOCKX to block high $HIGBLOCKX" >&2
DATCX=$(curl -s "http://127.0.0.1:9009/" -H 'Content-Type: application/json' --data "{\"method\":\"bcn_syncing\",\"params\":[],\"id\":1,\"key\":\"kenebaezxcpm\"}")
SYNCAX=$(echo $DATCX | sed -n 's|.*"syncing":\([^"]*\),.*|\1|p')
CURBLOCKX=$(echo $DATCX | sed -n 's|.*"currentBlock":\([^"]*\),.*|\1|p')
HIGBLOCKX=$(echo $DATCX | sed -n 's|.*"highestBlock":\([^"]*\),.*|\1|p')
BLOCKTIMX=$(($HIGBLOCKX-$CURBLOCKX))
sleep $(($BLOCKTIMX+10))
else
sleep 10
fi
done
KOVETX=$(netstat -netulp |grep 127.0.0.1:9009 | awk -F "[ :]+" '/:/{print $5}')
if [[ $KOVETX == "9009" ]]
then
echo "node share sync $SYNCAX , time to full sync $SECONDS" >&2
else
echo "node share down $KOVETX" >&2
fi
SECONDS=0
while read line2; do
systemctl stop idena-$line@$line2
rm -rf /home/$line/$line2/idenachain.db/*
rm -rf /home/$line/$line2/ipfs/*
cp -r /home/datadir/idenachain.db/* /home/$line/$line2/idenachain.db/
systemctl start idena-$line@$line2
sleep 30
DATC=$(curl -s "http://127.0.0.1:$line2/" -H 'Content-Type: application/json' --data "{\"method\":\"bcn_syncing\",\"params\":[],\"id\":1,\"key\":\"$line\"}")
SYNCA=$(echo $DATC | sed -n 's|.*"syncing":\([^"]*\),.*|\1|p')
CURBLOCK=$(echo $DATC | sed -n 's|.*"currentBlock":\([^"]*\),.*|\1|p')
HIGBLOCK=$(echo $DATC | sed -n 's|.*"highestBlock":\([^"]*\),.*|\1|p')
SECONDS=0
while [ "$SYNCA" != false ]
do
KOVET=$(netstat -netulp |grep 127.0.0.1:$line2 | awk -F "[ :]+" '/:/{print $5}')
if [[ $KOVET == $line2 ]]
then
echo "node $line2 sync $SYNCA , block curent $CURBLOCK to block high $HIGBLOCK" >&2
DATC=$(curl -s "http://127.0.0.1:$line2/" -H 'Content-Type: application/json' --data "{\"method\":\"bcn_syncing\",\"params\":[],\"id\":1,\"key\":\"$line\"}")
SYNCA=$(echo $DATC | sed -n 's|.*"syncing":\([^"]*\),.*|\1|p')
CURBLOCK=$(echo $DATC | sed -n 's|.*"currentBlock":\([^"]*\),.*|\1|p')
HIGBLOCK=$(echo $DATC | sed -n 's|.*"highestBlock":\([^"]*\),.*|\1|p')
BLOCKTIM=$(($HIGBLOCK-$CURBLOCK))
sleep $(($BLOCKTIM+10))
else
sleep 10
fi
done
KOVET=$(netstat -netulp |grep 127.0.0.1:$line2 | awk -F "[ :]+" '/:/{print $5}')
if [[ $KOVET == $line2 ]]
then
curl -s "http://127.0.0.1:$line2/" -H 'Content-Type: application/json' --data "{\"method\":\"dna_becomeOnline\",\"params\":[{}],\"id\":1,\"key\":\"$line\"}"
echo "node $line2 sync $SYNCA , time to full sync $SECONDS" >&2
else
echo "node $line2 down $KOVET" >&2
fi
SECONDS=0
done <<<$(cat /home/$line/$line-portRpc.txt)
done <<<$(cat /home/user.txt)
echo "all sync OK"
service idena start
