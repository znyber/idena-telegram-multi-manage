#!/bin/bash
wget https://raw.githubusercontent.com/znyber/idena-installer/master/idena-multi-install.sh -q -O /usr/bin/idena-multi
chmod +x /usr/bin/idena-multi
wget https://raw.githubusercontent.com/znyber/idena-installer/master/idena-node-installer.sh -q -O /usr/bin/idena-node-share
chmod +x /usr/bin/idena-node-share
idena-node-share