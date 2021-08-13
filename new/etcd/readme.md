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




-name etcd2 
-advertise-client-urls http://0.0.0.0:2379 
-listen-client-urls http://0.0.0.0:2379 
-listen-peer-urls http://0.0.0.0:2380 
-initial-cluster-token etcd-cluster 
-initial-cluster "etcd1=http://etcd1:2380,etcd2=http://etcd2:2380,etcd3=http://etcd3:2380" 
-initial-cluster-state new


https://www.cnblogs.com/hujinzhong/p/14648961.html

研究出怎么换主，更换master数量


scp -rp etcd ubuntu@xxxx:etcd




member add		Adds a member into the cluster


etcdctl endpoint status --write-out=table


etcdctl put foo "Hello World!"

etcdctl get foo
etcdctl --write-out="json" get foo