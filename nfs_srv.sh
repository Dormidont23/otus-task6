#!/bin/bash

sudo -i

# Утилиты для работы с NFS
yum install -y nfs-utils

# Включить firewall
systemctl enable firewalld --now

# Разрешить в firewall доступ к службам NFS
firewall-cmd --add-service="nfs3" --add-service="rpc-bind" --add-service="mountd" --permanent
firewall-cmd --reload

# Включить сервер NFS
systemctl enable nfs --now

# Создать и настраить каталог, который будет экспортирован далее
mkdir -p /srv/share/upload
chown -R nfsnobody:nfsnobody /srv/share
chmod 0777 /srv/share/upload

# Экспорт ранее созданного каталога
echo "/srv/share 192.168.56.11/32(rw,sync,root_squash)" >> /etc/exports
exportfs -r
echo "done."