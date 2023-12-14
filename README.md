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

На сервере заходим в каталог **/srv/share/upload** и создаём тестовый файл **touch check_file**:\
[root@nfss ~]# cd /srv/share/upload\
[root@nfss upload]# touch check_file\
[root@nfss upload]# ls -la\
total 0\
drwxrwxrwx. 2 nfsnobody nfsnobody 24 Dec 14 13:49 .\
drwxr-xr-x. 3 nfsnobody nfsnobody 20 Dec 14 13:34 ..\
-rw-r--r--. 1 root      root       0 Dec 14 13:49 check_file\
