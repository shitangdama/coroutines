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