#!/bin/bash
idenahome="$1"
idenakeystore="$2"

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
	sed -n "1{p;q}" /home/portRpc.txt >> /home/all-portRpcUse.txt
	portRpc=$(tail -1 /home/$idenahome/$idenahome-portRpc.txt)
	sed -i "1d" /home/portRpc.txt

cat <<EOF >> /home/user.txt
@$idenahome
EOF

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
if [ ! -d /etc/systemd/system/idena.target.wants ] &> /dev/null
then
cat <<EOF > /lib/systemd/system/idena.target
[Unit]
Description=idena target
Requires=multi-user.target
After=multi-user.target
AllowIsolate=yes
[Install]
WantedBy=multi-user.target
EOF
systemctl enable idena.target
else
echo" idena target sudah ada"
fi
cat <<EOF > /home/$idenahome/$portRpc.json
{
  "DataDir": "$portRpc",
  "RPC": {
    "HTTPHost": "localhost",
    "HTTPPort": $portRpc
  },
  "IpfsConf": {
    "IpfsPort": $portIpf
  }
}

EOF
if [ -f /lib/systemd/system/idena-$idenahome@.service ]; then
    echo "file exists."
else

cat <<EOF > /lib/systemd/system/idena-$idenahome@.service
[Unit]
PartOf=idena.target
Description=idena $idenahome service
After=network.target
StartLimitIntervalSec=0

[Service]
Type=simple
Restart=always
RestartSec=1
WorkingDirectory=/home/$idenahome
User=root
ExecStart=/usr/bin/idena --config=%i.json

[Install]
WantedBy=idena.target
EOF

fi

if [ -f /etc/systemd/system/idena.target.wants/idena-$idenahome@$portRpc.service ]; then
echo " data sudah ada.. hubungi pembuat. @znyber"
exit 1
else

systemctl start idena-$idenahome@$portRpc
systemctl enable idena-$idenahome@$portRpc

echo "wait.... build datadir"
sleep 30
echo $idenakeystore > /home/$idenahome/$portRpc/keystore/nodekey
echo $idenahome > /home/$idenahome/$portRpc/api.key
systemctl stop idena-$idenahome@$portRpc
systemctl daemon-reload
rm -rf /home/$idenahome/$idenanumber/idenachain.db/*
mount --bind /home/datadir/idenachain.db /home/$idenahome/$idenanumber/idenachain.db
cat <<EOF >> /etc/fstab
/home/datadir/idenachain.db /home/$idenahome/$idenanumber/idenachain.db none bind
EOF
rm -rf /home/$idenahome/$idenanumber/ipfs/*
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

systemctl start idena-$idenahome@$portRpc
echo " node telah ter install , ini api untuk menyambungkan"
cat /home/$idenahome/$idenanumber/api.key && echo ''
echo "port" && echo $portRpc
exit 0
fi
else
    echo "user node $idenahome sudah ada mohon ganti"
    echo "hubungi pembuat @znyber"
	exit 1
fi