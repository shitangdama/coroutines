cat << EOF | tee ${HOST_PATH}/roles/etcd/templates/etcd
ETCD_OPTS="--name={{ ansible_hostname }} \\
           --data-dir=${ETCD_DATA_DIR}\\
           --wal-dir=${ETCD_WAL_DIR}/wal \\
           --listen-peer-urls=http://{{ $API_IPV4 }}:2380 \\
           --listen-client-urls=http://{{ $API_IPV4 }}:2379,http://127.0.0.1:2379 \\
           --advertise-client-urls=http://{{ $API_IPV4 }}:2379 \\
           --initial-advertise-peer-urls=http://{{ $API_IPV4 }}:2380 \\
           --initial-cluster={{ INITIAL_CLUSTER }} \\
           --initial-cluster-token={{ INITIAL_CLUSTER }} \\
           --initial-cluster-state=new \\
           --heartbeat-interval=6000 \\
           --election-timeout=30000 \\
           --snapshot-count=5000 \\
           --auto-compaction-retention=1 \\
           --max-request-bytes=33554432 \\
           --quota-backend-bytes=17179869184 \\




cat << EOF | tee ${HOST_PATH}/roles/etcd/templates/etcd.service
[Unit]
Description=Etcd Server
After=network.target
After=network-online.target
Wants=network-online.target
Documentation=https://github.com/etcd-io/etcd
[Service]
Type=notify
LimitNOFILE=1024000
LimitNPROC=1024000
LimitCORE=infinity
LimitMEMLOCK=infinity
User=etcd
Group=etcd
WorkingDirectory=${ETCD_DATA_DIR}
EnvironmentFile=-${ETCD_PATH}/conf/etcd
ExecStart=${ETCD_PATH}/bin/etcd \$ETCD_OPTS
Restart=on-failure




https://www.cnblogs.com/hujinzhong/p/14648961.html

研究出怎么换主，更换master数量


scp -rp etcd ubuntu@xxxx:etcd


--endpoints=

member add		Adds a member into the cluster

ENDPOINTS="http://10.206.16.11:2380,http://10.206.16.3:2380,http://10.206.16.12:2380"
 
etcdctl endpoint status --endpoints=$ENDPOINTS --write-out=table

etcdctl put --endpoints=$ENDPOINTS foo "Hello World!"

etcdctl get etcdctl put --endpoints=$ENDPOINTS foo "Hello World!" foo
etcdctl --write-out="json" get foo


etcdctl --endpoints=$ENDPOINTS put web1 value1
etcdctl --endpoints=$ENDPOINTS put web2 value2
etcdctl --endpoints=$ENDPOINTS put web3 value3

etcdctl --endpoints=$ENDPOINTS get web --prefix



etcdctl --endpoints=$ENDPOINTS put key myvalue
etcdctl --endpoints=$ENDPOINTS del key

etcdctl --endpoints=$ENDPOINTS put k1 value1
etcdctl --endpoints=$ENDPOINTS put k2 value2
etcdctl --endpoints=$ENDPOINTS del k --prefix

事务写入

https://etcd.io/docs/v3.5/demo/#transactional-write

https://etcd.io/docs/v3.5/demo/
