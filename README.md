# idena-node-installer
## Installation

download script 
```bash
wget https://raw.githubusercontent.com/znyber/idena-installer/master/install-node.sh
```
change permision 
```bash
chmod +x install-node.sh
```
execute script
```bash
./install-node.sh
```
insert your name to make home directory idena & insert node key 

# idena auto update node with telegram bot notification
download idena-update
```bash
wget https://raw.githubusercontent.com/znyber/idena-installer/master/idena-update -O /usr/bin/idena-update
```
1- create new bot telegram [@BotFather](https://telegram.me/BotFather)
```
/newbot
```
2- create name for bot
```
uptoyou
```
3- Now let's choose a username for your bot. It must end in `bot`. copy telegram bot token
```
uptoyou_bot
```
![alt text](https://raw.githubusercontent.com/znyber/idena-installer/master/TGbot.png)
```
```
4- now you chat on your bot 
```
/start
```
5- get client id with curl
```bash
curl -s https://api.telegram.org/bot1232365776:AAErBHDfQvSb7joXQljyB2xhZeB7khJHCfk/getUpdates |cut -d '"' -f 9 | grep -Eoh '[0-9]{1,9}'
```
## Edit idena auto update with your telegram bot
edit in file ``/usr/bin/idena-update``
```bash
...
		TOKEN=1232333333:AAErBHDfQvSb7joXQljyB2xhZeB7kkkkkkk
		CHAT_ID=123456789
...
```
## Install auto update idena node service with systemd

change permision
```bash
chmod a+x /usr/bin/idena-update
```
make file service in folder ```/lib/systemd/system/idena-update.service ```
```bash
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
```
enable auto update on start up
```bash
systemctl enable idena-update
```
start service 
```bash
service idena-update start
```

## Contributing
Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.

Please make sure to update tests as appropriate.

## License
[MIT](https://choosealicense.com/licenses/mit/)
