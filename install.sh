#!/bin/bash
wget https://raw.githubusercontent.com/znyber/idena-installer/master/idena-multi-install.sh -q -O /usr/bin/idena-multi
chmod +x /usr/bin/idena-multi
wget https://raw.githubusercontent.com/znyber/idena-installer/master/cool.sh -q -O /usr/bin/cool-uptime
chmod +x /usr/bin/cool-uptime
wget https://raw.githubusercontent.com/znyber/idena-installer/master/idena-node-installer.sh -q -O /usr/bin/idena-node-share
wget https://raw.githubusercontent.com/znyber/idena-installer/master/idena-uninstall.sh -q -O /usr/bin/idena-uninstall
wget https://raw.githubusercontent.com/znyber/idena-installer/master/wBatch.sh -q -O /usr/bin/wBatch
chmod +x /usr/bin/wBatch
chmod +x /usr/bin/idena-uninstall
chmod +x /usr/bin/idena-node-share
idena-node-share
