#!/bin/sh
while read line; do
while read line2; do
cd /home/$line/$line2/ipfs/ && pwd
systemctl stop idena-$line@$line2
rm -rf /home/$line/$line2/ipfs/*
rm -rf /home/$line/$line2/logs/*
systemctl start idena-$line@$line2
done <<<$(cat /home/$line/$line-portRpc.txt)
done <<<$(cat /home/user.txt)