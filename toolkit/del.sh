#!/bin/bash
systemctl stop idena-$1@$2
sleep 3
rm -rf /home/$1/$2
rm -f /home/$1/$2.bat
rm -f /home/$1/$2.json
echo "$2" >> /home/
sed -i "/$2/d" /home/$1/$1-portRpc.txt
sed -i "/$2/d" /home/all-portRpcUse.txt
echo "$2" >> /home/portRpc.txt
HEAD=$(cat /home/$1/headport.txt)
if [[ "$HEAD" == "$2" ]]
then
cat /home/$1/$1-portRpc.txt | head -1 > /home/$1/headport.txt
systemctl restart idenamount-$1
systemctl daemon-reload
else
echo "no headport next del port.."
fi
systemctl disable idena-$1@$2
systemctl daemon-reload
echo "user $1 delete node $2"