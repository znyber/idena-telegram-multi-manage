#!/bin/bash
idenahome="$1"
idenakeystore="$2"

if command -v npm && command -v node && [ -f /home/index.js ] &> /dev/null
then
    echo "command exists."
else if command -v yum || ! command -v dnf &> /dev/null
	then 
		yum install -y npm wget curl 
	else
	apt update -y
	apt install -y wget npm curl
	fi
wget https://raw.githubusercontent.com/znyber/idena-installer/master/index.js -q -O /home/index.js
cd /home
npm i -g pm2 &> /dev/null
npm install &> /dev/null
fi

if [ -f /home/portRpc.txt ] && [ -f /home/portIpf.txt ] && [ -f /home/api.txt ]; then
    echo "file exists."
else
wget https://raw.githubusercontent.com/znyber/idena-installer/master/portRpc.txt -q -O /home/portRpc.txt
wget https://raw.githubusercontent.com/znyber/idena-installer/master/api.txt -q -O /home/api.txt
wget https://raw.githubusercontent.com/znyber/idena-installer/master/portIpf.txt -q -O /home/portIpf.txt
fi

idenanumber=$(head -n 1 /home/portRpc.txt)

if [ ! -d /home/*/$idenanumber ] &> /dev/null
then
	mkdir -p /home/$idenahome/$idenanumber
	touch /home/$idenahome/$idenahome-portRpc.txt
	sed -n "1{p;q}" /home/portRpc.txt >> /home/$idenahome/$idenahome-portRpc.txt
	
	portRpc=$(tail -1 /home/$idenahome/$idenahome-portRpc.txt)
	sed -i "1d" /home/portRpc.txt
	
	idena_download=$(curl -s https://api.github.com/repos/idena-network/idena-go/releases/latest | grep linux | cut -d '"' -f 4 | head -n 2 | tail -n 1)
	
	touch /home/$idenahome/$idenahome-api.txt
	sed -n "1{p;q}" /home/api.txt >> /home/$idenahome/$idenahome-api.txt 
	apikey=$(tail -1 /home/$idenahome/$idenahome-api.txt)
	sed -i "1d" /home/api.txt
	
	touch /home/$idenahome/$idenahome-portIpf.txt
	sed -n "1{p;q}" /home/portIpf.txt >> /home/$idenahome/$idenahome-portIpf.txt
	portIpf=$(tail -1 /home/$idenahome/$idenahome-portIpf.txt)
	sed -i "1d" /home/portIpf.txt

	
	#------------ download idena node latest version--------------#

	wget $idena_download -q --show-progress -O /usr/bin/idena
	wget https://raw.githubusercontent.com/znyber/idena-installer/master/idena-update -q -O /usr/bin/idena-update
	chmod +x /usr/bin/idena
	chmod +x /usr/bin/idena-update
	#--------------- create idena service-------------------------#

cat <<EOF > /lib/systemd/system/idena-$idenahome-$portRpc.service
[Unit]
Description=idena $idenahome service
After=network.target
StartLimitIntervalSec=0

[Service]
Restart=always
RestartSec=1
WorkingDirectory=/home/$idenahome/$portRpc
User=root
ExecStart=-/usr/bin/idena --profile=lowpower --rpcaddr=localhost --rpcport=$portRpc --ipfsport=$portIpf --apikey=$apikey

[Install]
WantedBy=multi-user.target
EOF
systemctl enable idena-$idenahome-$portRpc
service idena-$idenahome-$portRpc start

echo "wait.... build datadir"
sleep 30
echo $idenakeystore > /home/$idenahome/$portRpc/datadir/keystore/nodekey
echo $idenahome > /home/$idenahome/$portRpc/datadir/api.key
service idena-$idenahome-$portRpc stop
systemctl daemon-reload
rm -rf /home/$idenahome/$idenanumber/datadir/idenachain.db/*
mount --bind /home/datadir/idenachain.db /home/$idenahome/$idenanumber/datadir/idenachain.db
cat <<EOF >> /etc/fstab
/home/datadir/idenachain.db /home/$idenahome/$idenanumber/datadir/idenachain.db none bind
EOF
rm -rf /home/$idenahome/$idenanumber/datadir/ipfs/*
systemctl daemon-reload

if command -v firewall-cmd &> /dev/null
then
    setenforce 0
	firewall-cmd --add-port=$portIpf/tcp --permanent
	firewall-cmd --reload
else 
	apt-get install -y iptables-persistent &> /dev/null
    iptables -A INPUT -p tcp --dport $portIpf -j ACCEPT
	iptables -A OUTPUT -p tcp --sport $portIpf -j ACCEPT
	iptables-save > /etc/iptables/rules.v4
fi

service idena-$idenahome-$portRpc start
echo " Copy this API key to your idena client "
cat /home/$idenahome/$idenanumber/datadir/api.key && echo ''
exit 0
else
    echo "user node $idenahome sudah ada mohon ganti"
    echo "hubungi pembuat @znyber"
	exit 1
fi