# idena-installer
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
insert your name to make home directory idena
insert node key 

# idena auto update
## Install auto update idena service with systemd
download idena-update
```bash
wget https://raw.githubusercontent.com/znyber/idena-installer/master/idena-update -O /usr/bin/idena-update
```
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
