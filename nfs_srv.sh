#!/bin/bash

sudo -i

# ������� ��� ������ � NFS
yum install -y nfs-utils

# �������� firewall
systemctl enable firewalld --now

# ��������� � firewall ������ � ������� NFS
firewall-cmd --add-service="nfs3" --add-service="rpc-bind" --add-service="mountd" --permanent
firewall-cmd --reload

# �������� ������ NFS
systemctl enable nfs --now

# ������� � ��������� �������, ������� ����� ������������� �����
mkdir -p /srv/share/upload
chown -R nfsnobody:nfsnobody /srv/share
chmod 0777 /srv/share/upload

# ������� ����� ���������� ��������
echo "/srv/share 192.168.56.11/32(rw,sync,root_squash)" >> /etc/exports
exportfs -r
echo "done."