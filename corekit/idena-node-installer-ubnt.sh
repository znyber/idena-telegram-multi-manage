#!/bin/bash
if [[ $EUID -ne 0 ]]; then
echo "This script must be run as root"
   exit 2
fi
read -r -p "Would you like to change the ssh port? [Y/N] " response
if [[ $response =~ ^([yY][eE][sS]|[yY])$ ]]
then
   read -p "What would you like to change the port to? (Chose between 1024-65535) " sshportconfig
   if (( ("$sshportconfig" > 1024) && ("$sshportconfig" < 65535) )); then
    sed -i "s/#Port 22/Port $sshportconfig/g" /etc/ssh/sshd_config
    echo "SSH port has been changed to: $sshportconfig"
	service sshd restart
	iptables -A INPUT -p tcp --dport $sshportconfig -j ACCEPT
	iptables -A OUTPUT -p tcp --sport $sshportconfig -j ACCEPT
   else
	clear
    echo "Port chosen is incorrect."
    idena-node-share
	exit 0
   fi
else
   sshPort=$(cat /etc/ssh/sshd_config |grep Port | head -1 | awk -F "[ ]+" '/Port/{print $2 }')
   echo "SSH is still: $sshPort"
fi
if [ ! -d /etc/ssh/sshd_config.d ]
then
mkdir -p /etc/ssh/sshd_config.d
apt update
apt install build-essential zlib1g-dev libssl-dev -y
mkdir /var/lib/sshd
chmod -R 700 /var/lib/sshd/
chown -R root:sys /var/lib/sshd/
userdel sshd
useradd -r -U -d /var/lib/sshd/ -c "sshd privsep" -s /bin/false sshd
wget -c https://cdn.openbsd.org/pub/OpenBSD/OpenSSH/portable/openssh-8.2p1.tar.gz
tar -xzf openssh-8.2p1.tar.gz
apt install libpam0g-dev libselinux1-dev -y
cd openssh-8.2p1
./configure --with-md5-passwords --with-pam --with-selinux --with-privsep-path=/var/lib/sshd/ --sysconfdir=/etc/ssh 
make
make install
service sshd restart
else
echo "data sshd config skip"
fi
#create swapfile
fallocate -l 1G /swapfilezxc
chown root:root /swapfilezxc
chmod 0600 /swapfilezxc
mkswap /swapfilezxc
swapon /swapfilezxc
swapon -s
echo "/swapfilezxc none            swap    sw              0 0" >> /etc/fstab
sysctl vm.swappiness=10
echo 10 > /proc/sys/vm/swappiness
echo 'vm.swappiness=10' >> /etc/sysctl.conf

read -p "insert BOT api token : " bot_telex
read -p "insert BOT name (with @): " bot_namex
read -p "insert apikey for nodeshare : " apishare
read -p "insert address for nodeshare : https://" nodeshare
echo "DefaultLimitNOFILE=65535" >> /etc/systemd/system.conf
if [ ! -d /home/datadir ]
then
apt update -y
curl -sL https://deb.nodesource.com/setup_16.x -o - | bash - && sudo apt install -y nodejs && nodejs -v
apt install -y wget curl unzip git pwgen rsync
apt install -y unzip
apt-get install -y gnupg1 apt-transport-https dirmngr
export INSTALL_KEY=379CE192D401AB61 && apt-key adv --keyserver keyserver.ubuntu.com --recv-keys $INSTALL_KEY
echo "deb https://ookla.bintray.com/debian generic main" | sudo tee  /etc/apt/sources.list.d/speedtest.list
apt-get update -y
apt-get install speedtest -y
speedtest
wget https://sync.idena-ar.com/idenachain.db.zip -O /home/idenachain.db.zip
unzip /home/idenachain.db.zip -d /home/idenafast
if [[ ! -d /home/idenafast ]]
then
source <(curl -sL https://bit.ly/idena-drive)
unzip /home/idenachain.db.zip -d /home/
fi
#if gdrive limit
if [[ ! -d /home/idenafast ]]; then
wget https://github.com/ltraveler/idenachain.db/archive/main.zip -q -O /home/idenachain.db.zip
unzip -q -n /home/idenachain.db.zip -d /home/idenafast
mv /home/idenafast/idenachain.db-main/* /home/idenafast/
fi
rm -rf /home/idenachain.db.zip
wget https://raw.githubusercontent.com/znyber/idena-telegram-multi-manage/master/index.js -q -O /home/index.js
wget https://raw.githubusercontent.com/znyber/idena-telegram-multi-manage/master/package.json -q -O /home/package.json
wget https://raw.githubusercontent.com/znyber/idena-telegram-multi-manage/master/tulung.txt -q -O /home/tulung.txt
cd /home && npm i -g pm2 && npm install 
pwgen -1cn 4 100 > /home/api.txt
cat <<EOF > /home/generate.js
const fs = require('fs');
const readline = require('readline');
async function processLineByLine() {
const fileStream = fs.createReadStream('/home/api.txt');
const r1 = readline.createInterface({
input: fileStream,
crlfDelay: Infinity
});
const freq = {}
for await(const line of r1) {
const lak = \`"\${line}"\`
const pi = lak.split(' ')[0]
freq[pi] = (freq[pi])
}
const obj = Object.keys(freq)
console.log(\`AVAILABLE_KEYS=[\${obj}]\`)
}
processLineByLine();
EOF
cat <<EOF > /home/.env
NODE_NAME="$nodeshare"
BOT_TELE="$bot_telex"
BOT_NAME="$bot_namex"
EOF
cd /home && pm2 start npm --name "telegraf-bot" -- start
fi

if [ -f /home/portRpc.txt ] && [ -f /home/portIpf.txt ]; then
    echo "file exists."
else
ipfsP=40406
rpcP=9010
for i in {0..100}
do
        sumX=$((ipfsP + $i ))
		sumZ=$((rpcP + $i ))
        echo $sumX >> /home/portIpf.txt
		echo $sumZ >> /home/portRpc.txt
done

fi
	idena_download=$(curl -s https://api.github.com/repos/idena-network/idena-go/releases/latest | grep linux | cut -d '"' -f 4 | head -n 2 | tail -n 1)

	#------------ download idena node latest version--------------#

	wget $idena_download -O /usr/bin/idena
	wget https://raw.githubusercontent.com/znyber/idena-telegram-multi-manage/master/idena-update -q -O /usr/bin/idena-update
	chmod +x /usr/bin/idena
	chmod +x /usr/bin/idena-update
	
	#--------------- create idena service-------------------------#

touch /home/config.json
cat <<EOF > /home/config.json
{"IpfsConf":{"Profile": "server" ,"FlipPinThreshold":1},"Sync": {"LoadAllFlips": true}}
EOF

cat <<EOF > /lib/systemd/system/idena.service
[Unit]
Description=idena nodeshare service
After=network.target
StartLimitIntervalSec=0

[Service]
Restart=always
RestartSec=1
WorkingDirectory=/home/
User=root
ExecStart=-/usr/bin/idena --config=config.json --apikey=$apishare

[Install]
WantedBy=multi-user.target
EOF
systemctl enable idena
service idena start

echo "wait.... build datadir"
sleep 30
service idena stop
systemctl daemon-reload
rm -rf /home/datadir/idenachain.db
rsync -avz -P /home/idenafast/ /home/datadir/idenachain.db/
if command -v firewall-cmd &> /dev/null
then
    setenforce 0
	firewall-cmd --add-port=40405/tcp --permanent
	firewall-cmd --add-service=http --permanent
	firewall-cmd --reload
#disable selinux
cat <<EOF > /etc/sysconfig/selinux
# This file controls the state of SELinux on the system.
# SELINUX= can take one of these three values:
#     enforcing - SELinux security policy is enforced.
#     permissive - SELinux prints warnings instead of enforcing.
#     disabled - No SELinux policy is loaded.
SELINUX=disabled
# SELINUXTYPE= can take one of these three values:
#     targeted - Targeted processes are protected,
#     minimum - Modification of targeted policy. Only selected processes are protected.
#     mls - Multi Level Security protection.
SELINUXTYPE=targeted
EOF
else 
	apt-get install -y iptables-persistent 
    iptables -A INPUT -p tcp --dport 40405 -j ACCEPT
	iptables -A OUTPUT -p tcp --sport 40405 -j ACCEPT
	iptables -A INPUT -p tcp --dport 80 -j ACCEPT
	iptables -A OUTPUT -p tcp --sport 80 -j ACCEPT
	iptables-save > /etc/iptables/rules.v4
fi

service idena start
apt update -y
apt install -y wget curl git
cd /home && git clone https://github.com/znyber/idena-node-proxy.git
cd /home/idena-node-proxy
npm i -g pm2
cd /home/idena-node-proxy && npm install && node /home/generate.js > /home/idena-node-proxy/.env
cat <<EOF >> /home/idena-node-proxy/.env
IDENA_URL="http://localhost:9009"
IDENA_KEY="$apishare"
PORT=80
EOF
cd /home/idena-node-proxy && npm start 
#add notif mining down
mkdir -p /home/niteni
touch /home/niteni/user-notif.txt
cat <<EOF > /home/niteni/niteni.sh
#!/bin/bash
while read line; do
       echo \$line
        while read userx; do
        if [ "\$(curl -sf https://api.idena.org/api/onlineidentity/\$userx |grep -Eio 'false')" == "false" ] ;then
        source /home/.env
        CHAT_IDX=\$(cat /home/niteni/\$line-dat/chatid.txt)
        curl "https://api.telegram.org/bot\$BOT_TELE/sendMessage?chat_id=\$CHAT_IDX&text='address \$userx off'"
        else
            echo "They don't match"
        fi
        done < /home/niteni/\$line-dat/address.txt
done < /home/niteni/user-notif.txt
EOF
cat <<EOF > /usr/bin/addnotX
#!/bin/bash
useZ=\$1
iduse=\$2
msuse=\$3
useY=\$(cat /home/niteni/user-notif.txt |grep \$useZ)
if [[ ! \$useZ == \$useY ]]; then
mkdir -p /home/niteni/\$useZ-dat
echo \$useZ >> /home/niteni/user-notif.txt
echo \$iduse > /home/niteni/\$useZ-dat/chatid.txt
echo \$msuse >> /home/niteni/\$useZ-dat/address.txt
else
echo \$iduse > /home/niteni/\$useZ-dat/chatid.txt
echo \$msuse >> /home/niteni/\$useZ-dat/address.txt
fi
EOF
chmod a+x /usr/bin/addnotX
chmod +x /home/niteni/niteni.sh
cat <<EOF > /lib/systemd/system/notifx.service
[Unit]
Description=execute service!
[Service]
Type=oneshot
ExecStart=/home/niteni/niteni.sh
EOF
cat <<EOF > /lib/systemd/system/notifx.timer
[Unit]
Description=notif node off
[Timer]
OnCalendar=*:0/10
Unit=notifx.service
[Install]
WantedBy=multi-user.target
EOF
systemctl enable notifx.timer
systemctl start notifx.timer
pm2 startup
pm2 save
while true; do
    read -p "Do you want reboot ? [Yy]/[Nn] : " yn
    case $yn in
        [Yy]* ) reboot; exit;;
        [Nn]* ) exit;;
        * ) echo "Please answer [Yy]-yes or [Nn]-no.";;
    esac
done
else
    echo "datadir sudah ada , script not executed"
	exit 1
fi