
守护进程的位置

/usr/lib/systemd/system


etcd.service

sudo systemctl daemon-reload
sudo systemctl start etcd
sudo systemctl enable etcd

systemctl stauts etcd


sudo mkdir /var/lib/etcd/

sudo vi /usr/lib/systemd/system/etcd.service