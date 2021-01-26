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
   else
    echo "Port chosen is incorrect."
    clear
    idena-node-share
   fi
else
   sshPort=$(cat /etc/ssh/sshd_config |grep Port | head -1 | awk -F "[ ]+" '/Port/{print $2 }')
   echo "SSH is still: $sshPort"
fi

read -p "insert BOT api token : " bot_telex
read -p "insert BOT name : " bot_namex
read -p "insert apikey for nodeshare : " apishare
if [ ! -d /home/datadir ]
then
if command -v git && command -v links && command -v npm && command -v node && [ -f /home/index.js ] &> /dev/null
then
    echo "command exists."
	exit 1
else if command -v yum || ! command -v dnf &> /dev/null
	then 
		yum install -y npm wget curl unzip links git sshpass pwgen
cat <<EOF > /etc/yum.repos.d/bintray-ookla-rhel.repo
#bintray--ookla-rhel - packages by  from Bintray
[bintray--ookla-rhel]
name=bintray--ookla-rhel
baseurl=https://ookla.bintray.com/rhel
gpgcheck=0
repo_gpgcheck=0
enabled=1
EOF
		yum install -y speedtest
		speedtest
	else
	apt update -y
	apt install -y wget npm curl unzip links git sshpass pwgen
	apt-get install gnupg1 apt-transport-https dirmngr
	export INSTALL_KEY=379CE192D401AB61 && apt-key adv --keyserver keyserver.ubuntu.com --recv-keys $INSTALL_KEY
	echo "deb https://ookla.bintray.com/debian generic main" | sudo tee  /etc/apt/sources.list.d/speedtest.list
	apt-get update
	apt-get install speedtest
	speedtest
	fi
wget https://sync.idena-ar.com/idenachain.db.zip -O /home/idenachain.db.zip
#download idenachaindb using google drive link
## wget --load-cookies /tmp/cookies.txt "https://docs.google.com/uc?export=download&confirm=$(wget --quiet --save-cookies /tmp/cookies.txt --keep-session-cookies --no-check-certificate 'https://docs.google.com/uc?export=download&id=1PBHh2B0ZHabqqamXcKXpzmSg7k_t-5hB' -O- | sed -rn 's/.*confirm=([0-9A-Za-z_]+).*/\1\n/p')&id=1PBHh2B0ZHabqqamXcKXpzmSg7k_t-5hB" -O /home/idenachain.db.zip && rm -rf /tmp/cookies.txt
cd /home && unzip idenachain.db.zip
#alt download
#if [ ! -d /home/idenachain.db ]
#then
#cd /home && pwd && links https://drive.google.com/file/d/1PBHh2B0ZHabqqamXcKXpzmSg7k_t-5hB/view?usp=sharing && unzip idenachain.db
#if [ ! -d /home/idenachain.db ]
#then
#cd /home && pwd && links https://www.mediafire.com/file/ajrxzbulicfqi3v/idenachain.db.zip/file && unzip idenachain.db
#fi
#if [ ! -d /home/idenachain.db ]
#then
#echo "idenachain.db tidak bisa di download mohon masukan secara manual"
#echo "ini link download untuk idenachain.db "
#echo "https://drive.google.com/file/d/1PBHh2B0ZHabqqamXcKXpzmSg7k_t-5hB/view?usp=sharing"
#echo "https://www.mediafire.com/file/ajrxzbulicfqi3v/idenachain.db.zip/file"
#else
#exit 1
#fi
#fi
wget https://raw.githubusercontent.com/znyber/idena-installer/master/index.js -q -O /home/index.js
wget https://raw.githubusercontent.com/znyber/idena-installer/master/package.json -q -O /home/package.json
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
                                                        const lak = `"${line}"`
                                                        const pi = lak.split(' ')[0]
                                                        freq[pi] = (freq[pi])
                }
                                const obj = Object.keys(freq)
                                console.log(`AVAILABLE_KEYS=[${obj}]`)
        }
                processLineByLine();
EOF
cat <<EOF > /home/.env
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

	wget $idena_download -q --show-progress -O /usr/bin/idena
	wget https://raw.githubusercontent.com/znyber/idena-installer/master/idena-update -q --show-progress -O /usr/bin/idena-update
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
rsync -avz -P /home/idenachain.db/ /home/datadir/idenachain.db/
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
	apt-get install -y iptables-persistent &> /dev/null
    iptables -A INPUT -p tcp --dport 40405 -j ACCEPT
	iptables -A OUTPUT -p tcp --sport 40405 -j ACCEPT
	iptables -A INPUT -p tcp --dport 80 -j ACCEPT
	iptables -A OUTPUT -p tcp --sport 80 -j ACCEPT
	iptables-save > /etc/iptables/rules.v4
fi

service idena start
if command -v npm && command -v node && command -v git &> /dev/null
then
    echo "command exists."
else if command -v yum ||  command -v dnf &> /dev/null
	then 
		yum install -y npm wget curl git
	else
	apt update -y
	apt install -y wget npm curl git
	fi
fi
cd /home && git clone https://github.com/idena-network/idena-node-proxy.git
cd /home/idena-node-proxy
npm i -g pm2
node /home/generate.js > /home/idena-node-proxy/.env
cat <<EOF >> /home/idena-node-proxy/.env
IDENA_URL="http://localhost:9009"
IDENA_KEY="$apishare"
PORT=80
EOF
cd /home/idena-node-proxy && npm install
cd /home/idena-node-proxy && npm start 
#add notif mining down
mkdir -p /home/niteni
touch /home/niteni/user-notif.txt
cat <<EOF > /home/niteni/niteni.sh
#!/bin/bash
while read line; do
       echo $line
        while read userx; do
        if [ "$(curl -sf https://api.idena.org/api/onlineidentity/$userx |grep -Eio 'false')" == "false" ] ;then
        source /home/.env
        CHAT_IDX=$(cat /home/niteni/$line-dat/chatid.txt)
        curl "https://api.telegram.org/bot$BOT_TELE/sendMessage?chat_id=$CHAT_IDX&text='address $userx off'"
        else
            echo "They don't match"
        fi
        done < /home/niteni/$line-dat/address.txt
done < /home/niteni/user-notif.txt
EOF

cat <<EOF > /usr/lib/systemd/system/notifx.service
[Unit]
Description=execute service!
[Service]
Type=oneshot
ExecStart=/home/niteni/niteni.sh
EOF
cat <<EOF > /usr/lib/systemd/system/notifx.timer
[Unit]
Description=notif node off
[Timer]
OnCalendar=*:0/10
Unit=notif-node.service
[Install]
WantedBy=multi-user.target
EOF
systemctl enable notifx.timer
systemctl start notifx.timer
exit 0
else
    echo "datadir sudah ada , script not executed"
	exit 1
fi