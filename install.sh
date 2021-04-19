#!/bin/bash
if command -v yum || command -v dnf &> /dev/null
then
wget https://raw.githubusercontent.com/znyber/idena-telegram-multi-manage/master/corekit/idena-node-installer.sh -q -O /usr/bin/idena-node-share
wget https://raw.githubusercontent.com/znyber/idena-telegram-multi-manage/master/corekit/idena-uninstall.sh -q -O /usr/bin/idena-uninstall
elif command -v apt &> /dev/null
then
wget https://raw.githubusercontent.com/znyber/idena-telegram-multi-manage/master/corekit/idena-node-installer-ubnt.sh -q -O /usr/bin/idena-node-share
wget https://raw.githubusercontent.com/znyber/idena-telegram-multi-manage/master/corekit/idena-uninstall-ubnt.sh -q -O /usr/bin/idena-uninstall
else
echo "only support RHL/RHEL "
echo "centos 7/8"
echo "fedora 32/33"
echo "for ubuntu support V18/20"
exit 1
fi
wget https://raw.githubusercontent.com/znyber/idena-telegram-multi-manage/master/corekit/idena-multi-install.sh -q -O /usr/bin/idena-multi
chmod +x /usr/bin/idena-multi
wget https://raw.githubusercontent.com/znyber/idena-telegram-multi-manage/master/toolkit/cool.sh -q -O /usr/bin/cool-uptime
chmod +x /usr/bin/cool-uptime
wget https://raw.githubusercontent.com/znyber/idena-telegram-multi-manage/master/toolkit/wBatch.sh -q -O /usr/bin/wBatch
wget https://raw.githubusercontent.com/znyber/idena-telegram-multi-manage/master/toolkit/clear-ipfs.sh -q -O /usr/bin/clear-ipfs
wget https://raw.githubusercontent.com/znyber/idena-telegram-multi-manage/master/toolkit/ceklek-htm.sh -q -O /usr/bin/ceklek-htm
wget https://raw.githubusercontent.com/znyber/idena-telegram-multi-manage/master/toolkit/list-ic.sh -q -O /usr/bin/list-ic
wget https://raw.githubusercontent.com/znyber/idena-telegram-multi-manage/master/toolkit/miningallon.sh -q -O /usr/bin/miningallon
wget https://raw.githubusercontent.com/znyber/idena-telegram-multi-manage/master/toolkit/del.sh -q -O /usr/bin/delnode
wget https://raw.githubusercontent.com/znyber/idena-telegram-multi-manage/master/toolkit/backup.sh -q -O /usr/bin/backup-node
wget https://raw.githubusercontent.com/znyber/idena-telegram-multi-manage/master/toolkit/restore.sh -q -O /usr/bin/restore-node
chmod +x /usr/bin/backup-node
chmod +x /usr/bin/restore-node
chmod +x /usr/bin/clear-ipfs
chmod +x /usr/bin/delnode
chmod +x /usr/bin/ceklek-htm
chmod +x /usr/bin/list-ic
chmod +x /usr/bin/miningallon
chmod +x /usr/bin/wBatch
chmod +x /usr/bin/idena-uninstall
chmod +x /usr/bin/idena-node-share
idena-node-share