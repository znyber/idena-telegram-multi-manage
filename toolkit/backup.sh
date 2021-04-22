#!/bin/bash
touch /root/restore.txt
while read line; do
echo $line
while read line2; do
NUKE=$(cat /home/$line/$line2/keystore/nodekey)
echo "$line2"
echo "$line $NUKE" >> /root/restore.txt
done <<<$(cat /home/$line/$line-portRpc.txt)
done <<<$(cat /home/user.txt)
sort /home/chatidX.txt | uniq -c | awk '{print $2}' > /root/chatidX.txt
echo "backup complete"