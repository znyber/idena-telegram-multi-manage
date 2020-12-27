#!/bin/bash
idenahome="$1"
idenanumber="$2"
idenakeystore="$3"
sed -n "1{p;q}" api.txt >> $idenahome.txt && tail -1 $idenahome.txt && sed -i "1d" api.txt
if [ ! -d /home/datadir ]
then
	mkdir -p /home/$idenahome/$idenanumber
	idena_download=$(curl -s https://api.github.com/repos/idena-network/idena-go/releases/latest | grep linux | cut -d '"' -f 4 | head -n 2 | tail -n 1)

	#------------ download idena node latest version--------------#

	wget $idena_download -q --show-progress -O /usr/bin/idena
	wget https://raw.githubusercontent.com/znyber/idena-installer/master/idena-update -q --show-progress -O /usr/bin/idena-update
	chmod +x /usr/bin/idena
	chmod +x /usr/bin/idena-update
	#--------------- create idena service-------------------------#

cat <<EOF > /lib/systemd/system/idena-$idenahome-$idenanumber.service
[Unit]
Description=idena $idenahome service
After=network.target
StartLimitIntervalSec=0

[Service]
Restart=always
RestartSec=1
WorkingDirectory=/home/$idenahome/$idenanumber
User=root
ExecStart=-/usr/bin/idena

[Install]
WantedBy=multi-user.target
EOF
systemctl enable idena-$idenahome-$idenanumber
service idena-$idenahome-$idenanumber start

echo "wait.... build datadir"
sleep 30
echo $idenakeystore > /home/$idenahome/$idenanumber/datadir/keystore/nodekey
echo $idenahome > /home/$idenahome/$idenanumber/datadir/api.key
service idena stop
systemctl daemon-reload
rm -rf /home/$idenahome/$idenanumber/datadir/idenachain.db/*
mount --bind /home/datadir/idenachain.db /home/$idenahome/$idenanumber/datadir/idenachain.db
cat <<EOF >> /etc/fstab
/home/datadir/idenachain.db /home/$idenahome/$idenanumber/datadir/idenachain.db none bind
EOF
rm -rf /home/$idenahome/$idenanumber/datadir/ipfs/*
systemctl daemon-reload
service idena start
echo " Copy this API key to your idena client "
cat /home/$idenahome/$idenanumber/datadir/api.key && echo ''
else
    echo "user node $idenahome sudah ada mohon ganti"
    echo "ex:" $idenahome"1" $idenahome"2" $idenahome"3" "dst.."
fi