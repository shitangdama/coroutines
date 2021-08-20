这里需要调整下多接点的部署

针对1.22这个版本学习
所有组件放在

opt 这个文件夹下

opt/etcd
opt/etcd/bin
opt/etcd/cfg


opt/kubernetes
opt/kubernetes/ssl
/opt/kubernetes/cfg


cat /usr/lib/systemd/system/kubelet.service 


[Unit]
Description=Kubernetes Kubelet
After=docker.service
Before=docker.service

[Service]
EnvironmentFile=/opt/kubernetes/cfg/kubelet.conf
ExecStart=/opt/kubernetes/bin/kubelet $KUBELET_OPTS
Restart=on-failure
LimitNOFILE=65535

[Install]
WantedBy=multi-user.target

 initial-cluster-token 表示在一个集群立


 etcdctl member add etcd2 --peer-urls="http://10.206.0.17:2380"



etcdctl --write-out=table --endpoints=http://10.206.0.17:2379 endpoint status


TOKEN=my-etcd-token-1
CLUSTER_STATE=new
NAME_1=etcd-node-1
NAME_2=etcd-node-2
NAME_3=etcd-node-3
HOST_1=10.206.0.4
HOST_2=10.206.0.17
HOST_3=10.206.0.2
CLUSTER=etcd-1=http://10.206.0.12:2380,etcd-2=http://10.206.0.16:2380,etcd-3=http://10.206.0.17:2380

# For node 1
etcd --data-dir=~/etcd --name etcd-1 \
--initial-advertise-peer-urls http://10.206.0.12:2380 \
--listen-peer-urls http://10.206.0.12:2380 \
--advertise-client-urls http://10.206.0.12:2379 \
--listen-client-urls http://10.206.0.12:2379 \
--initial-cluster etcd-1=http://10.206.0.12:2380,etcd-2=http://10.206.0.16:2380,etcd-3=http://10.206.0.17:2380 \
--initial-cluster-state new \
--initial-cluster-token etcd-token

# For node 2
etcd --data-dir=~/etcd  --name etcd-2 \
--initial-advertise-peer-urls http://10.206.0.16:2380 \
--listen-peer-urls http://10.206.0.16:2380 \
--advertise-client-urls http://10.206.0.16:2379 \
--listen-client-urls http://10.206.0.16:2379 \
--initial-cluster etcd-1=http://10.206.0.12:2380,etcd-2=http://10.206.0.16:2380,etcd-3=http://10.206.0.17:2380 \
--initial-cluster-state new \
--initial-cluster-token etcd-token

# For node 3
etcd --data-dir=~/etcd --name etcd-3 \
--initial-advertise-peer-urls http://10.206.0.17:2380 \
--listen-peer-urls http://10.206.0.17:2380 \
--advertise-client-urls http://10.206.0.17:2379 \
--listen-client-urls http://10.206.0.17:2379 \
--initial-cluster etcd-1=http://10.206.0.12:2380,etcd-2=http://10.206.0.16:2380,etcd-3=http://10.206.0.17:2380 \
--initial-cluster-state new \
--initial-cluster-token etcd-token


ENDPOINTS=$HOST_1:2379,$HOST_2:2379,$HOST_3:2379


CLUSTER=etcd-1=http://10.206.0.12:2380,etcd-2=http://10.206.0.16:2380,etcd-3=http://10.206.0.17:2380

etcdctl endpoint status --endpoints=http://10.206.0.12:2379,http://10.206.0.16:2379,http://10.206.0.17:2379 --write-out=table


vim /usr/lib/systemd/system/etcd.service
#文件内容如下，监听地址端口只支持ip地址，不支持hostname
[Unit]
Description=etcd server
After=network.target

[Service]
Type=notify
EnvironmentFile=-/etc/etcd/etcd.conf
ExecStart=/usr/bin/etcd

Restart=on-failure
RestartSec=5
LimitNOFILE=65536

[Install]
WantedBy=multi-user.target


hostnamectl set-hostname <hostname> 