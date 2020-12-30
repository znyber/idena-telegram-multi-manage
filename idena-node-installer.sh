#!/bin/bash
if [ ! -d /home/datadir ]
then
if command -v npm && command -v node && [ -f /home/index.js ] &> /dev/null
then
    echo "command exists."
	exit 1
else if command -v yum || ! command -v dnf &> /dev/null
	then 
		yum install -y npm wget curl unzip
	else
	apt update -y
	apt install -y wget npm curl unzip
	fi
wget https://raw.githubusercontent.com/znyber/idena-installer/master/index.js -q -O /home/index.js
wget https://raw.githubusercontent.com/znyber/idena-installer/master/package.json -q -O /home/package.json
cd /home && npm i -g pm2 && npm install 
sed -i '3s/.*/const bot = new Telegraf("1422705649:AAFJWFkgiHRRE5K72XtV_1gU4lKHROa9nZI")/' /home/index.js 
cd /home && pm2 start npm --name "telegraf-bot" -- start
fi

if [ -f /home/portRpc.txt ] && [ -f /home/portIpf.txt ] && [ -f /home/api.txt ]; then
    echo "file exists."
else
wget https://raw.githubusercontent.com/znyber/idena-installer/master/portRpc.txt -q -O /home/portRpc.txt
wget https://raw.githubusercontent.com/znyber/idena-installer/master/api.txt -q -O /home/api.txt
wget https://raw.githubusercontent.com/znyber/idena-installer/master/portIpf.txt -q -O /home/portIpf.txt
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
Description=idena $idenahome service
After=network.target
StartLimitIntervalSec=0

[Service]
Restart=always
RestartSec=1
WorkingDirectory=/home/
User=root
ExecStart=-/usr/bin/idena --config=config.json --apikey=kenebaezxcpm

[Install]
WantedBy=multi-user.target
EOF
systemctl enable idena
service idena start

echo "wait.... build datadir"
sleep 30
service idena stop
wget https://media.githubusercontent.com/media/znyber/idena-installer/master/idenachain.db.zip -O /home/datadir/idenachain.db.zip
systemctl daemon-reload
rm -rf /home/datadir/idenachain.db
unzip /home/datadir/idenachain.db.zip -d /home/datadir/
if command -v firewall-cmd &> /dev/null
then
    setenforce 0
	firewall-cmd --add-port=40405/tcp --permanent
	firewall-cmd --reload
else 
	apt-get install -y iptables-persistent &> /dev/null
    iptables -A INPUT -p tcp --dport 40405 -j ACCEPT
	iptables -A OUTPUT -p tcp --sport 40405 -j ACCEPT
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
cat <<EOF > /home/idena-node-proxy/.env
AVAILABLE_KEYS=["TWYQCz","qjVtfD","xDhnjN","AtjJZK","Qvzasq","sLAxpY","vAYrET","haxBAJ","DXxjwN","yGqKvw","PWXxHs","cnjsEa","JwevTh","Kyjqsk","ZGWnry","AbBZgS","bBXhLH","qNwhyF","jTANLY","RcHSwA","VNMvyT","EeMXhu","cntZwx","fCHrDq","uGVeaQ","cVMqTh","NjVBuk","gpFZkU","dKQtZT","nThUZf","sCUZLx","ebFLmg","LbcCGg","gpyVbU","cYPsTR","tQJRPB","QDpmuj","ewEnBL","VPUtWk","GMNvew","mtpwDG","xtGqXW","GfLEnR","tPhEfH","ZzEvXp","wbQVyr","MCGmRd","ELvkpb","xvbGsg","DXkvYg","TbDQxS","JCarHq","mSPEsQ","KNzxPA","Xtnwzc","jNhgaT","tWvfxw","uxSKdb","YuFAKP","eDhZzY","qmZuEG","vZnWcM","uenyRh","TkHntS","CJjxyA","CHJpqD","esMGxY","rvEeGF","gDHyqC","crUELg","jSFnaJ","dWtmUH","RrdZEP","cbCgdH","BSarDs","zkmBCh","JBwfNd","gRhLwv","tLyZeg","HnhQjG","fxmSRD","EsCLAM","ghBaXP","KMThZk","ZLWFuH","dqARNt","rRQfKA","VUpKbt","EAfdhm","xLGAmK","ymZgEk","gTEUyM","WSMErH","kwFKXQ","USWsQK","wEBYSx","FZrWBT","wbjUYV","WNzmBf","pTPJVU","hZRPDX","EVygmu","NaXjgh","zEcMBQ","qheVzQ","SZMhJL","JUyxam","jPxpGm","EVsBFh","JYvXjV","EhTpVM","ZXhebg","QFUeav","LUfryb","HXcWSE","RNKcCv","CVkbPL","fSQcrC","xdsDwQ","MfKRZT","BaEXeD","jSTYPd","wQgGtF","yDawEK","PLtvwT","bKJFSc","HnDkcy","urKvMN","WTdAzJ","SVBnEz","ngavFe","MCUbgf","EekNcX","ehsgCr","zADdtc","LZqNpu","AjedNv","MRbdTf","eHjETP","vBnYbT","TEnWDJ","XJsjUw","WkQPrp","WwEFbZ","BJmcAK","QhsKzx","XRMcGf","BAVmzF","QtmhkX","nNywLe","zDQtVN","jpZYFq","TZcRNn","ZBdxEH","QvwhpG","jUrFBY","ZMUGBy","XnDxec","NxghuZ","ScXCKn","ayMEFK","jZKwrR","ktpXdn","xUFcRL","FxAbHz","LRvdeC","XRmFaz","CEVNft","QuXBZE","WtKcsr","bmCkUf","gkaYsF","LEqfvk","umeLsb","CKTkbW","JPMaHg","LwChbX","ZXHmxW","NnetgE","zbHVLs","GAbpzJ","vVgcxk","BfvXea","XYqnHb","LnrwEt","aGwSbe","stBPpE","XDGAgM","qVSsre","jJhKZG","FWuRSG","jCuePY","MqjNHb","MnUzCJ","GUtFPn","hWrCkG","nFcAKt","EmNHua","FBPzwQ","aHQkhb"]
IDENA_URL="http://localhost:9009"
IDENA_KEY="kenebaezxcpm"
PORT=80
EOF
cd /home/idena-node-proxy && npm install
cd /home/idena-node-proxy && npm start 
echo " Copy this API key to your idena client "
cat /home/datadir/api.key && echo ''
exit 0
else
    echo "datadir sudah ada , script not executed"
	exit 1
fi