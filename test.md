https://buy.cloud.tencent.com/cvm?tab=custom&step=1&devPayMode=spotpaid&regionId=33&instanceType=S5.LARGE8&platform=CentOS&systemDiskType=CLOUD_PREMIUM&systemDiskSize=50&bandwidthType=TRAFFIC_POSTPAID_BY_HOUR&bandwidth=1


sudo systemctl daemon-reload
sudo systemctl start kube-manager-controller
sudo systemctl enable kube-manager-controller

设置集群参数
[root@master1 work]# kubectl config set-cluster kubernetes --certificate-authority=ca.pem --embed-certs=true --server=https://172.10.0.20:6443 --kubeconfig=kube.config
设置客户端认证参数
[root@master1 work]# kubectl config set-credentials admin --client-certificate=admin.pem --client-key=admin-key.pem --embed-certs=true --kubeconfig=kube.config
设置上下文参数
[root@master1 work]# kubectl config set-context kubernetes --cluster=kubernetes --user=admin --kubeconfig=kube.config
设置默认上下文
[root@master1 work]# kubectl config use-context kubernetes --kubeconfig=kube.config
[root@master1 work]# mkdir ~/.kube
[root@master1 work]# cp kube.config ~/.kube/config
授权kubernetes证书访问kubelet api权限
[root@master1 work]# kubectl create clusterrolebinding kube-apiserver:kubelet-apis --clusterrole=system:kubelet-api-admin --user kubernetes


在说Cgroupfs与Systemd之间的区别之前