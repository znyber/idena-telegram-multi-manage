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
	touch /home/all-portRpcUse.txt
	sed -n "1{p;q}" /home/portRpc.txt >> /home/all-portRpcUse.txt
	portRpc=$(tail -1 /home/$idenahome/$idenahome-portRpc.txt)
	sed -i "1d" /home/portRpc.txt
if ! grep -Fxq $idenahome /home/user.txt
then
touch /etc/ssh/sshd_config.d/$idenahome.conf
cat <<EOF > /etc/ssh/sshd_config.d/$idenahome.conf
AllowAgentForwarding no
PermitOpen localhost:$portRpc
EOF
touch /etc/ssh/sshd_config
cat <<EOF >> /etc/ssh/sshd_config
Match User $idenahome
Include /etc/ssh/sshd_config.d/$idenahome.conf
EOF
service sshd restart
touch /home/user.txt
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
touch /lib/systemd/system/idena.target
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
touch /home/$idenahome/$portRpc.json
cat <<EOF > /home/$idenahome/$portRpc.json
{
  "DataDir": "$portRpc",
  "P2P": {
    "MaxInboundPeers": 8,
    "MaxOutboundPeers": 4
  },
  "RPC": {
    "HTTPHost": "localhost",
    "HTTPPort": $portRpc
  },
  "IpfsConf": {
	"Profile": "server",
    "IpfsPort": $portIpf,
	"BlockPinThreshold": 1,
    "FlipPinThreshold": 1
  },
  "Sync": {
    "FastSync": true
  }
}

EOF
if [ -f /lib/systemd/system/idena-$idenahome@.service ]; then
sleep 1
touch /etc/ssh/sshd_config.d/$idenahome.conf
echo "$(cat /etc/ssh/sshd_config.d/$idenahome.conf) localhost:$portRpc" > /etc/ssh/sshd_config.d/$idenahome.conf
service sshd restart
else
touch /lib/systemd/system/idena-$idenahome@.service
cat <<EOF > /lib/systemd/system/idena-$idenahome@.service
[Unit]
PartOf=idena.target
Description=idena $idenahome service
After=network.target
StartLimitIntervalSec=0

[Service]
CPUWeight=20
CPUQuota=35%
IOWeight=20
MemorySwapMax=0
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
touch /home/$idenahome/$portRpc/keystore/nodekey
echo $idenakeystore > /home/$idenahome/$portRpc/keystore/nodekey
systemctl stop idena-$idenahome@$portRpc
systemctl daemon-reload

rm -rf /home/$idenahome/$portRpc/idenachain.db/*
#download fastsync
if [ ! -f /home/$idenahome/headport.txt ]; then
touch /home/$idenahome/headport.txt
cat <<EOF > /home/$idenahome/headport.txt
$idenanumber
EOF
wget https://sync.idena-ar.com/idenachain.db.zip -q -O /home/$idenahome/idenachain.db.zip
unzip -q -n /home/$idenahome/idenachain.db.zip -d /home/$idenahome/idenafast
#if link error alt google drive
if [[ ! -d /home/$idenahome/idenafast ]]
then
source <(curl -sL https://bit.ly/idena-drive)
unzip -q -n /home/idenachain.db.zip -d /home/$idenahome/
rm -f /home/idenachain.db.zip
fi
#if gdrive limit
if [[ ! -d /home/$idenahome/idenafast ]]; then
wget https://github.com/ltraveler/idenachain.db/archive/main.zip -q -O /home/$idenahome/idenachain.db.zip
unzip -q -n /home/$idenahome/idenachain.db.zip -d /home/$idenahome/idenafast
mv /home/$idenahome/idenafast/idenachain.db-main/* /home/$idenahome/idenafast
fi
rm -rf /home/$idenahome/idenachain.db.zip
rsync -azq /home/$idenahome/idenafast/ /home/$idenahome/$idenanumber/idenachain.db/
rm -rf /home/$idneahome/idenafast/*

touch /home/$idenahome/idenafast-mount.sh
cat <<EOF > /home/$idenahome/idenafast-mount.sh
#!/bin/bash
HEAD=\$(cat /home/$idenahome/headport.txt)
mount --bind /home/$idenahome/\$HEAD/idenachain.db /home/$idenahome/idenafast
EOF
chmod a+x /home/$idenahome/idenafast-mount.sh

touch /home/$idenahome/idenafast-umount.sh
cat <<EOF > /home/$idenahome/idenafast-umount.sh
#!/bin/bash
umount /home/$idenahome/idenafast
EOF
chmod a+x /home/$idenahome/idenafast-umount.sh

touch /lib/systemd/system/idenamount-$idenahome.service
cat <<EOF > /lib/systemd/system/idenamount-$idenahome.service
[Unit]
Description=Mount directory $idenahome fastsync
After=network.target

[Service]
Type=oneshot
ExecStart=/home/$idenahome/idenafast-mount.sh
RemainAfterExit=true
ExecStop=/home/$idenahome/idenafast-umount.sh
StandardOutput=journal

[Install]
WantedBy=multi-user.target
EOF

systemctl daemon-reload
systemctl enable idenamount-$idenahome.service
systemctl start idenamount-$idenahome.service

else
RPDC=$(cat /home/$idenahome/headport.txt)
systemctl stop idena-$idenahome@$RPDC
systemctl daemon-reload
rsync -azq /home/$idenahome/idenafast/ /home/$idenahome/$idenanumber/idenachain.db/
systemctl start idena-$idenahome@$RPDC
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
