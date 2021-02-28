#!/bin/bash
user=$1
useX=$(awk -F: '{ print $1}' /etc/passwd |grep $user)
rpcP=$2
idenaURL=$(curl -s 'https://github.com/idena-network/idena-desktop/releases/' |grep idena-client-win | cut -d '"' -f 2 | head -n 1 | awk -F "[/v]+" '/download/{print $(NF-1)}')
myIP=$(curl ifconfig.me)
pSSH=$(cat /etc/ssh/sshd_config |grep Port | head -1 | awk -F "[ ]+" '/Port/{print $2 }')
if [[ ! $user == $useX ]]; then
ZXCPWD=$(openssl rand -base64 8)
useradd $user
echo -e "$ZXCPWD\n$ZXCPWD\n" | passwd $user
echo $ZXCPWD > /home/$user/pswd.txt
cat <<EOF > /home/$user/$rpcP.bat
@echo off
title run node remote
IF NOT EXIST %userprofile%\AppData\Local\Programs\idena-desktop\Idena.exe (
bitsadmin /transfer IDNA /download /priority normal https://github.com/idena-network/idena-desktop/releases/download/v$idenaURL/idena-client-win-$idenaURL.exe %temp%\idena.exe
START /WAIT idena.exe
echo { "url": "http://localhost:$rpcP", "internalPort": 9119, "tcpPort": 50505, "ipfsPort": 50506, "uiVersion": "$idenaURL", "useExternalNode": true, "runInternalNode": false, "internalApiKey": "xtwwi6o73pdfmq71pe5stgm7recbahr9", "externalApiKey": "$user", "lng": "en", "initialized": true, "zoomLevel": -2 } > %appdata%\Idena\settings.json
IF NOT EXIST %appdata%\Idena\plink.exe (
bitsadmin /transfer NODE /download /priority normal https://the.earth.li/~sgtatham/putty/latest/w64/plink.exe %appdata%\Idena\plink.exe
echo n | %appdata%\Idena\plink.exe -ssh $user@$myIP -P $pSSH -pw "$ZXCPWD" -L $rpcP:localhost:$rpcP -N
) ELSE (
echo n | %appdata%\Idena\plink.exe -ssh $user@$myIP -P $pSSH -pw "$ZXCPWD" -L $rpcP:localhost:$rpcP -N
)
) ELSE (
echo { "url": "http://localhost:$rpcP", "internalPort": 9119, "tcpPort": 50505, "ipfsPort": 50506, "uiVersion": "$idenaURL", "useExternalNode": true, "runInternalNode": false, "internalApiKey": "xtwwi6o73pdfmq71pe5stgm7recbahr9", "externalApiKey": "$user", "lng": "en", "initialized": true, "zoomLevel": -2 } > %appdata%\Idena\settings.json
Echo. | start %userprofile%\AppData\Local\Programs\idena-desktop\Idena.exe
IF NOT EXIST %appdata%\Idena\plink.exe (
bitsadmin /transfer NODE /download /priority normal https://the.earth.li/~sgtatham/putty/latest/w64/plink.exe %appdata%\Idena\plink.exe
echo n | %appdata%\Idena\plink.exe -ssh $user@$myIP -P $pSSH -pw "$ZXCPWD" -L $rpcP:localhost:$rpcP -N
) ELSE (
echo n | %appdata%\Idena\plink.exe -ssh $user@$myIP -P $pSSH -pw "$ZXCPWD" -L $rpcP:localhost:$rpcP -N
)
)
echo Done.
EOF
else
ZXCPWD=$(cat /home/$user/pswd.txt)
cat <<EOF > /home/$user/$rpcP.bat
@echo off
title run node remote
IF NOT EXIST %userprofile%\AppData\Local\Programs\idena-desktop\Idena.exe (
bitsadmin /transfer IDNA /download /priority normal https://github.com/idena-network/idena-desktop/releases/download/v$idenaURL/idena-client-win-$idenaURL.exe %temp%\idena.exe
START /WAIT %temp%\idena.exe
echo { "url": "http://localhost:$rpcP", "internalPort": 9119, "tcpPort": 50505, "ipfsPort": 50506, "uiVersion": "$idenaURL", "useExternalNode": true, "runInternalNode": false, "internalApiKey": "xtwwi6o73pdfmq71pe5stgm7recbahr9", "externalApiKey": "$user", "lng": "en", "initialized": true, "zoomLevel": -2 } > %appdata%\Idena\settings.json
IF NOT EXIST %appdata%\Idena\plink.exe (
bitsadmin /transfer NODE /download /priority normal https://the.earth.li/~sgtatham/putty/latest/w64/plink.exe %appdata%\Idena\plink.exe
echo n | %appdata%\Idena\plink.exe -ssh $user@$myIP -P $pSSH -pw "$ZXCPWD" -L $rpcP:localhost:$rpcP -N
) ELSE (
echo n | %appdata%\Idena\plink.exe -ssh $user@$myIP -P $pSSH -pw "$ZXCPWD" -L $rpcP:localhost:$rpcP -N
)
) ELSE (
echo { "url": "http://localhost:$rpcP", "internalPort": 9119, "tcpPort": 50505, "ipfsPort": 50506, "uiVersion": "$idenaURL", "useExternalNode": true, "runInternalNode": false, "internalApiKey": "xtwwi6o73pdfmq71pe5stgm7recbahr9", "externalApiKey": "$user", "lng": "en", "initialized": true, "zoomLevel": -2 } > %appdata%\Idena\settings.json
Echo. | start %userprofile%\AppData\Local\Programs\idena-desktop\Idena.exe
IF NOT EXIST %appdata%\Idena\plink.exe (
bitsadmin /transfer NODE /download /priority normal https://the.earth.li/~sgtatham/putty/latest/w64/plink.exe %appdata%\Idena\plink.exe
echo n | %appdata%\Idena\plink.exe -ssh $user@$myIP -P $pSSH -pw "$ZXCPWD" -L $rpcP:localhost:$rpcP -N
) ELSE (
echo n | %appdata%\Idena\plink.exe -ssh $user@$myIP -P $pSSH -pw "$ZXCPWD" -L $rpcP:localhost:$rpcP -N
)
)
echo Done.
EOF
fi