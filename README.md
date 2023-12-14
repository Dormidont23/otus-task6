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
-rw-r--r--. 1 nfsnobody nfsnobody 0 Dec 14 13:57 client_file
