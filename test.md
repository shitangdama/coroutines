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


批量修改label


关于CrashLoopBackOff


nfs 和 glusterfs 

https://www.hellodemos.com/hello-glusterfs/glusterfs-gluster-quick-start-1.html
https://zhuanlan.zhihu.com/p/51553441
https://www.cnblogs.com/saneri/p/12378121.html


nfs 
https://www.cnblogs.com/yyxx8888/p/10521196.html

https://blog.csdn.net/m0_38138879/article/details/117111578

https://github.com/shitangdama/gin-demo/blob/master/nfs/nfs.md
https://zhuanlan.zhihu.com/p/106719192?utm_source=wechat_session


pstack

iostat


国内自研的s3架构基本都长这样


用户上传10G的文件，s3网关接收。然后讲10GB的文件进行切块。这个切块通常是固定大小。比如按照4M切块

切完。然后查一下元数据 根据chunk容量 负载等信息，选出一台。然后直接rpc 将这个块发给chunk

然后这10GB的块都上传给不同的chunk之后。再将文件的元信息 写入数据库。一个上传完成

这里涉及到一致性和并发问题？没关系 再写个gc线程 。每个chunk节点的进程有个gc线程 定期去扫描 自己服务器数据块是否再数据库上

没有就清理掉

然后chunk进程管理自己的服务器和硬盘。怎么管理？把硬盘切成固定大小的chunk块。然后给这个块的头部作为索引 比如大小+偏移。剩下的操作是啥？一旦有新请求进来 进行追加写即可

拿这么多硬盘和chunk怎么选？你把对象名做成有序，然后二分法 对数时间很快的。再加快？chunk的header 也就是元数据 放到内存上 不就行了

我这讲完 你基本就知晓分布式对象存储怎么实现了

并且还能拿出来鼓吹。ceph是开源的代表。这些自研都喜欢鼓吹 比ceph牛。为啥？ceph挂掉一个节点 新增一个节点 会触发数据迁移。我的不会啊！ 为啥？ceph的对象数据跟存储节点的位置信息是离线算出来的。而这些自研的是存在数据库中的 当然不会迁移了。

所以自研s3最难的地方在哪里。s3对象网关。

https://blog.csdn.net/fly0512/article/details/117886282
https://www.jianshu.com/p/b02c428950df

如果 hosts 字段不为空则需要指定授权使用该证书的 IP 或域名列表。由于该证书被 集群使用，需要将节点的IP都填上，为了方便后期扩容可以多写几个预留的IP。同时还需要填写 service 网络的首个IP(一般是 kube-apiserver 指定的 service-cluster-ip-range 网段的第一个IP，如 10.96.0.1)。


cfssl gencert -ca=ca.pem -ca-key=ca-key.pem -config=ca-config.json -profile=kubernetes kube-apiserver-csr.json | cfssljson -bare kube-apiserver

cat > token.csv << EOF
$(head -c 16 /dev/urandom | od -An -t x | tr -d ' '),kubelet-bootstrap,10001,"system:kubelet-bootstrap"
EOF

https://blog.csdn.net/xuejianxinokok/article/details/119604432
https://blog.csdn.net/fly0512/article/details/117886282

升级到1.22