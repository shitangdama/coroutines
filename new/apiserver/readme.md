

vi /usr/lib/systemd/system/etcd.service


server-csr.json


enable-aggregator-routing：master节点上没有kube-proxy时，需要设定为true


ExecStart=/usr/bin/kube-apiserver \
--enable-admission-plugins=NamespaceLifecycle,NodeRestriction,LimitRanger,ServiceAccount,DefaultStorageClass,ResourceQuota \
--bind-address=10.206.0.12 \
--secure-port=6443 \
--advertise-address=10.206.0.12 \
--authorization-mode=Node,RBAC \

--enable-bootstrap-token-auth=true \
--token-auth-file=/home/ubuntu/cert/token.csv \

--service-cluster-ip-range=192.168.0.0/16 \
--service-node-port-range=6000-52766 \

<!-- --tls-xxx-file：apiserver https证书 -->

--tls-cert-file=/home/ubuntu/cert/kubernetes.pem  \
--tls-private-key-file=/home/ubuntu/cert/kubernetes-key.pem \

--client-ca-file=/home/ubuntu/cert/ca.pem \


<!-- --kubelet-client-xxx：apiserver访问kubelet客户端证书 -->
--kubelet-client-certificate=/home/ubuntu/cert/kubernetes.pem \
--kubelet-client-key=/home/ubuntu/cert/kubernetes-key.pem \

--service-account-key-file=/home/ubuntu/certca-key.pem \
--service-account-signing-key-file=/opt/kubernetes/ssl/server-key.pem \\
--service-account-issuer=api \\



--etcd-servers=http://10.206.0.12:2379,http://10.206.0.16:2379,http://10.206.0.17:2379 \
--enable-swagger-ui=true \
--allow-privileged=true \
--audit-log-maxage=30 \
--audit-log-maxbackup=3 \
--audit-log-maxsize=100 \
--audit-log-path=/home/ubuntu/logs/audit.log \
--event-ttl=1h \
--logtostderr=true --v=2 


–etcd_servers: 指定etcd服务的URL
–insecure-bind-address： apiserver绑定主机的非安全端口，设置0.0.0.0表示绑定所有IP地址
–insecure-port: apiserver绑定主机的非安全端口号，默认为8080
–service-cluster-ip-range: Kubernetes集群中service的虚拟IP地址范围，以CIDR表示，该IP范围不能与物理机的真实IP段有重合。
–service-node-port-range: kubernetes集群中Service可映射的物理机端口号范围，默认为30000–32767.
–admission_control: kubernetes集群的准入控制设置，各控制模块以插件的形式依次生效
–logtostderr: 设置为false表示将日志写入文件，不写入stderr
–log-dir: 日志目录
–v: 日志级别



–service-cluster-ip-range: Kubernetes集群中service的虚拟IP地址范围，以CIDR表示，该IP范围不能与物理机的真实IP段有重合。

Kubernetes 集群中Service 的虚拟IP 地址段范围，以CIDR 格式表示，例如169.169.0.0/16，该IP 范围不能与物理机的真实IP 段有重合。


