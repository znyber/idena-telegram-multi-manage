#!/bin/bash
rm -rf /home/*
systemctl disable idena.service
rm -rf /usr/lib/systemd/system/idena*
rm -rf /etc/systemd/system/
rm -rf /etc/systemd/system/idena.target*
rm -rf /usr/bin/idena*
firewall-cmd --remove-port=40405/tcp --permanent
firewall-cmd --reload
pm2 delete idena-node-proxy
pm2 delete telegraf-bot