#!/bin/bash
wget https://raw.githubusercontent.com/znyber/idena-telegram-multi-manage/master/corekit/idena-multi-install.sh -q -O /usr/bin/idena-multi
chmod +x /usr/bin/idena-multi
wget https://raw.githubusercontent.com/znyber/idena-telegram-multi-manage/master/toolkit/cool.sh -q -O /usr/bin/cool-uptime
chmod +x /usr/bin/cool-uptime
wget https://raw.githubusercontent.com/znyber/idena-telegram-multi-manage/master/corekit/idena-node-installer.sh -q -O /usr/bin/idena-node-share
wget https://raw.githubusercontent.com/znyber/idena-telegram-multi-manage/master/corekit/idena-uninstall.sh -q -O /usr/bin/idena-uninstall
wget https://raw.githubusercontent.com/znyber/idena-telegram-multi-manage/master/toolkit/wBatch.sh -q -O /usr/bin/wBatch
wget https://raw.githubusercontent.com/znyber/idena-telegram-multi-manage/master/toolkit/clear-ipfs.sh -q -O /usr/bin/clear-ipfs
wget https://raw.githubusercontent.com/znyber/idena-telegram-multi-manage/master/toolkit/ceklek-htm.sh -q -O /usr/bin/ceklek-htm
wget https://raw.githubusercontent.com/znyber/idena-telegram-multi-manage/master/toolkit/list-ic.sh -q -O /usr/bin/list-ic
wget https://raw.githubusercontent.com/znyber/idena-telegram-multi-manage/master/toolkit/miningallon.sh -q -O /usr/bin/miningallon
wget https://raw.githubusercontent.com/znyber/idena-telegram-multi-manage/master/toolkit/del.sh -q -O /usr/bin/delnode
chmod +x /usr/bin/clear-ipfs
chmod +x /usr/bin/delnode
chmod +x /usr/bin/ceklek-htm
chmod +x /usr/bin/list-ic
chmod +x /usr/bin/miningallon
chmod +x /usr/bin/wBatch
chmod +x /usr/bin/idena-uninstall
chmod +x /usr/bin/idena-node-share
idena-node-share