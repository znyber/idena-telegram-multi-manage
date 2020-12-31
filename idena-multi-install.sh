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
if [ ! -d /home/idenafastsync ]
then
wget --load-cookies /tmp/cookies.txt "https://docs.google.com/uc?export=download&confirm=$(wget --quiet --save-cookies /tmp/cookies.txt --keep-session-cookies --no-check-certificate 'https://docs.google.com/uc?export=download&id=1ydTWIPhXZ4fVG5uUmUYpNLNW-SbqYxJI' -O- | sed -rn 's/.*confirm=([0-9A-Za-z_]+).*/\1\n/p')&id=1ydTWIPhXZ4fVG5uUmUYpNLNW-SbqYxJI" -O /home/idenachain.db.zip && rm -rf /tmp/cookies.txt
cd /home && unzip fastsync.zip
cd /home && pwd && links https://drive.google.com/file/d/1ydTWIPhXZ4fVG5uUmUYpNLNW-SbqYxJI/view?usp=sharing && unzip fastsync.zip
if [ ! -d /home/idenachain.db ]
then
cd /home && pwd && links https://www.mediafire.com/file/ajrxzbulicfqi3v/idenachain.db.zip/file && unzip idenachain.db
fi
if [ ! -d /home/idenachain.db ]
then
echo "idenachain.db tidak bisa di download mohon masukan secara manual"
echo "ini link download untuk idenachain.db "
echo "https://drive.google.com/file/d/1PBHh2B0ZHabqqamXcKXpzmSg7k_t-5hB/view?usp=sharing"
echo "https://www.mediafire.com/file/ajrxzbulicfqi3v/idenachain.db.zip/file"
else
exit 1
fi
else
echo "folder idenachain.db ada"
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
$idenahome
EOF

	idena_download=$(curl -s https://api.github.com/repos/idena-network/idena-go/releases/latest | grep linux | cut -d '"' -f 4 | head -n 2 | tail -n 1)
	
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
	"Profile": "server",
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

echo "wait.... build datadir"
sleep 30
echo $idenakeystore > /home/$idenahome/$portRpc/keystore/nodekey
systemctl stop idena-$idenahome@$portRpc
systemctl daemon-reload
if [ -d /home/idenafastsync ]
		then
		rm -rf /home/$idenahome/$portRpc/idenachain.db
		echo "import idena fast sync"
		rsync -avz -P /home/idenafastsync/ /home/$idenahome/$idenanumber/idenachain.db/
		else
		echo "file tidak ada tidak ada"
		fi

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
cat $idenahome
echo "port" && echo $portRpc
exit 0
fi
else
    echo "user node $idenahome sudah ada mohon ganti"
    echo "hubungi pembuat @znyber"
	exit 1
fi