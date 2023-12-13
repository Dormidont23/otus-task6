#!/bin/bash

sudo -i

# Утилиты для работы с NFS
yum install -y nfs-utils

# Включить firewall
systemctl enable firewalld --now

# Добавить строку для монтирования каталога с сервера
echo "192.168.56.10:/srv/share/ /mnt nfs vers=3,proto=udp,noauto,x-systemd.automount 0 0" >> /etc/fstab
systemctl daemon-reload 
systemctl restart remote-fs.target 
echo "done."