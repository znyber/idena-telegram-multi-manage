#!/bin/bash
read -p "Isert User home directory for idena = " idenahome
read -p "Isert node key idena (skip this if you dont have key) = " idenakeystore
mkdir -p /home/$idenahome
idena_download=$(curl -s https://api.github.com/repos/idena-network/idena-go/releases/latest | grep linux | cut -d '"' -f 4 | head -n 2 | tail -n 1)

#------------ download idena node latest version--------------#

wget $idena_download -q --show-progress -O /usr/bin/idena

chmod +x /usr/bin/idena

#--------------- create idena service-------------------------#

cat <<EOF > /lib/systemd/system/idena.service
[Unit]
Description=idena service
After=network.target
StartLimitIntervalSec=0

[Service]
Restart=always
RestartSec=1
WorkingDirectory=/home/$idenahome
User=root
ExecStart=-/usr/bin/idena

[Install]
WantedBy=multi-user.target
EOF
systemctl enable idena
service idena start

#---------------Create Auto Update APP idena Node------------#

cat <<EOF > /usr/bin/idena-update
#!/bin/bash
idenaURL=$(curl -s https://api.github.com/repos/idena-network/idena-go/releases/latest | grep linux | cut -d '-' -f 4 | head -n 1 | cut -d '"' -f 1)
idenaTXT=$(idena -v | awk '{print $3}')
idenaUPD=$(curl -s https://api.github.com/repos/idena-network/idena-go/releases/latest | grep linux | cut -d '"' -f 4 | head -n 2 | tail -n 1)
if [[ \$idenaURL == \$idenaTXT ]];then
    wget \$idenaUPD -q --show-progress -O /usr/bin/idena
	chmod +x /usr/bin/idena
	exit 0
    else
        echo -e "version available \$idenaURL no Update"
        exit 1
    fi
EOF
chmod +x /usr/bin/idena-update

#--------Create Auto Update Service---------------------------#

cat <<EOF > /lib/systemd/system/idena-update.service
[Unit]
Description=idena update service
After=network.target
StartLimitIntervalSec=0

[Service]
Restart=always
RestartSec=1
User=root
ExecStart=-/usr/bin/idena-update

[Install]
WantedBy=multi-user.target
EOF
systemctl enable idena-update
service idena-update start

echo "wait.... build datadir"
sleep 30
echo $idenakeystore > /home/$idenahome/keystore/nodekey
service idena stop
service idena start
echo " Copy this API key to your idena client "
cat /home/$idenahome/datadir/api.key && echo ''