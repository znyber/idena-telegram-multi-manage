#!/bin/bash
idenahome="$1"
idenakeystore="$2"

idenanumber=$(head -n 1 /home/portRpc.txt)

if [ ! -d /home/*/$idenanumber ] &> /dev/null
then
/usr/bin/wBatch $idenahome $idenanumber
	mkdir -p /home/$idenahome/$idenanumber
	touch /home/$idenahome/$idenahome-portRpc.txt
	sed -n "1{p;q}" /home/portRpc.txt >> /home/$idenahome/$idenahome-portRpc.txt
	sed -n "1{p;q}" /home/portRpc.txt >> /home/all-portRpcUse.txt
	portRpc=$(tail -1 /home/$idenahome/$idenahome-portRpc.txt)
	sed -i "1d" /home/portRpc.txt
if ! grep -Fxq $idenahome /home/user.txt
then
cat <<EOF >> /home/user.txt
$idenahome
EOF
fi

	touch /home/$idenahome/$idenahome-portIpf.txt
	sed -n "1{p;q}" /home/portIpf.txt >> /home/$idenahome/$idenahome-portIpf.txt
	portIpf=$(tail -1 /home/$idenahome/$idenahome-portIpf.txt)
	sed -i "1d" /home/portIpf.txt

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
fi
cat <<EOF > /home/$idenahome/$portRpc.json
{
  "DataDir": "$portRpc",
  "RPC": {
    "HTTPHost": "localhost",
    "HTTPPort": $portRpc
  },
  "IpfsConf": {
	"Profile": "server",
    "IpfsPort": $portIpf
  }
}

EOF
if [ -f /lib/systemd/system/idena-$idenahome@.service ]; then
sleep 1
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
ExecStart=/usr/bin/idena --config=%i.json --apikey=$idenahome

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

sleep 30
echo $idenakeystore > /home/$idenahome/$portRpc/keystore/nodekey
systemctl stop idena-$idenahome@$portRpc
systemctl daemon-reload
wget https://sync.idena-ar.com/idenachain.db.zip -q -O /home/$idenahome/idenachain.db.zip
rm -rf /home/$idenahome/$portRpc/idenachain.db/*
mkdir -p /home/$idenahome/idenafast
cd /home/$idenahome && unzip -q -n idenachain.db.zip -d /home/$idenahome/idenafast
if [[ ! -e /home/idenachain.db.zip ]]
then
source <(curl -sL https://bit.ly/idena-drive)
cd /home/$idenahome && unzip -q -n idenachain.db.zip -d /home/$idenahome/idenafast
fi
rm -rf /home/$idenahome/idenachain.db.zip
rsync -azq /home/$idenahome/idenafast/ /home/$idenahome/$idenanumber/idenachain.db/

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
#echo " node telah ter install , ini api untuk menyambungkan"
#echo $idenahome && echo "port"
echo $portRpc
exit 0
fi
else
    echo "user node $idenahome sudah ada mohon ganti"
    echo "hubungi pembuat @znyber"
	exit 1
fi