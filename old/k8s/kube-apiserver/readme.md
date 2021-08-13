https://blog.csdn.net/zhonglinzhang/article/details/90697495

https://www.cnblogs.com/hujinzhong/p/14648961.html

https://blog.csdn.net/zhonglinzhang/article/details/90697495

https://blog.csdn.net/weixin_45739949/article/details/115334807
一文带你彻底厘清 Kubernetes 中的证书工作机制
https://zhaohuabing.com/post/2020-05-19-k8s-certificate/#%E4%BD%BF%E7%94%A8-tls-bootstrapping-%E7%AE%80%E5%8C%96-kubelet-%E8%AF%81%E4%B9%A6%E5%88%B6%E4%BD%9C

https://blog.csdn.net/yucaifu1989/article/details/104721788

如果 hosts 字段不为空则需要指定授权使用该证书的 IP 或域名列表。
由于该证书后续被 kubernetes master 集群使用，需要将master节点的IP都填上，同时还需要填写 service 网络的首个IP。(一般是 kube-apiserver 指定的 service-cluster-ip-range 网段的第一个IP，如 10.254.0.1)

healthz check failed apiserver 是什么原因造成的
