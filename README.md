## Задание № 6. Vagrant стенд для NFS ##
Цель задания:
- Научиться самостоятельно разворачивать сервис NFS и подключать к нему клиента.

В Vagrantfile настроено развёртывание двух ВМ:
- Сервер **nfss** (192.168.56.10);
- Клиент **nfsc** (192.168.56.11).

Также в Vagrantfile прописано выполнение двух скриптов:
- **nfs_srv.sh** - выполняется на сервере nfss;
- **nfs_client** - выполняется на клиенте nfsc.

После развёртывания ВМ проверим работоспособность стенда.

На сервере заходим в каталог **/srv/share/upload** и создаём тестовый файл:\
[root@nfss ~]# **cd /srv/share/upload**\
[root@nfss upload]# **touch check_file**\
[root@nfss upload]# **ls -l**\
total 0\
-rw-r--r--. 1 root root 0 Dec 14 13:49 check_file

Заходим на клиент в каталог **/mnt/upload** и проверяем наличие ранее созданного файла:\
[root@nfsc ~]# **cd /mnt/upload**\
[root@nfsc upload]# **ls -l**\
total 0\
-rw-r--r--. 1 root root 0 Dec 14 13:49 check_file\
Создаём тестовый файл и проверяем, что он успешно создан:\
[root@nfsc upload]# **touch client_file**\
[root@nfsc upload]# **ls -l**\
total 0\
-rw-r--r--. 1 root      root      0 Dec 14 13:49 check_file\
-rw-r--r--. 1 nfsnobody nfsnobody 0 Dec 14 13:57 client_file\
Перезагружаем клиент, заходим в каталог **/mnt/upload** и проверяем наличие ранее созданных файлов:\
[root@nfsc ~]# **cd /mnt/upload**\
[root@nfsc upload]# **ls -l**\
total 0\
-rw-r--r--. 1 root      root      0 Dec 14 13:49 check_file\
-rw-r--r--. 1 nfsnobody nfsnobody 0 Dec 14 13:57 client_file

Заходим на сервер в отдельном окне терминала, перезагружаем сервер и снова заходим на сервер. Проверяем наличие файлов в каталоге **/srv/share/upload:**\
[root@nfss ~]# **cd /srv/share/upload**\
[root@nfss upload]# **ls -l**\
total 0\
-rw-r--r--. 1 root      root      0 Dec 14 13:49 check_file\
-rw-r--r--. 1 nfsnobody nfsnobody 0 Dec 14 13:57 client_file\
Проверяем статус сервера NFS:\
[root@nfss upload]# **systemctl status nfs**\
● nfs-server.service - NFS server and services\
   Loaded: loaded (/usr/lib/systemd/system/nfs-server.service; enabled; vendor preset: disabled)\
  Drop-In: /run/systemd/generator/nfs-server.service.d\
           └─order-with-mounts.conf\
   Active: active (exited) since Thu 2023-12-14 14:04:58 UTC; 2min 32s ago\
  Process: 805 ExecStartPost=/bin/sh -c if systemctl -q is-active gssproxy; then systemctl reload gssproxy ; fi (code=exited, status=0/SUCCESS)\
  Process: 781 ExecStart=/usr/sbin/rpc.nfsd $RPCNFSDARGS (code=exited, status=0/SUCCESS)\
  Process: 776 ExecStartPre=/usr/sbin/exportfs -r (code=exited, status=0/SUCCESS)\
 Main PID: 781 (code=exited, status=0/SUCCESS)\
   CGroup: /system.slice/nfs-server.service

Dec 14 14:04:58 nfss systemd[1]: Starting NFS server and services...\
Dec 14 14:04:58 nfss systemd[1]: Started NFS server and services.\
Проверяем статус firewall:\
[root@nfss upload]# **systemctl status firewalld**\
● firewalld.service - firewalld - dynamic firewall daemon\
   Loaded: loaded (/usr/lib/systemd/system/firewalld.service; enabled; vendor preset: enabled)\
   Active: active (running) since Thu 2023-12-14 14:04:53 UTC; 4min 22s ago\
     Docs: man:firewalld(1)\
 Main PID: 402 (firewalld)\
   CGroup: /system.slice/firewalld.service\
           └─402 /usr/bin/python2 -Es /usr/sbin/firewalld --nofork --nopid

Dec 14 14:04:52 nfss systemd[1]: Starting firewalld - dynamic firewall daemon...\
Dec 14 14:04:53 nfss systemd[1]: Started firewalld - dynamic firewall daemon.\
Dec 14 14:04:54 nfss firewalld[402]: WARNING: AllowZoneDrifting is enabled. This is considered an insecure configuration option. It will ...g it now.\
Hint: Some lines were ellipsized, use -l to show in full.\
Проверяем экспортированный каталог:\
[root@nfss upload]# **exportfs -s**\
/srv/share  192.168.56.11/32(sync,wdelay,hide,no_subtree_check,sec=sys,rw,secure,root_squash,no_all_squash)\
Проверяем работу RPC:\
[root@nfss upload]# **showmount -a 192.168.56.10**\
All mount points on 192.168.56.10:\
192.168.56.11:/srv/share

