参数分为两种

https://www.cnblogs.com/hujinzhong/p/14648961.html

https://blog.csdn.net/kanganrui/article/details/105936821
https://blog.51cto.com/u_13053917/2596613

https://blog.csdn.net/ljx1528/article/details/108465272


参数
https://blog.csdn.net/qq_34857250/article/details/84995381


通过保存在硬盘的配置文件设置 kubelet 的部分配置参数，这可以作为命令行参数的替代。 此功能在 v1.10 中为 beta 版。

建议通过配置文件的方式提供参数，因为这样可以简化节点部署和配置管理。

关于 bootstrap.kubeconfig的问题

关于啊
kubectl create clusterrolebinding kubelet-bootstrap --clusterrole=system:node-bootstrapper --user=kubelet-bootstrap

kubectl create clusterrolebinding system-node-role-bound --clusterrole=system:node --group=system:nodes

$ kubectl certificate approve node-csr-QzuuQiuUfcSdp3j5W4B2UOuvQ_n9aTNHAlrLzVFiqrk
certificatesigningrequest.certificates.k8s.io "node-csr-QzuuQiuUfcSdp3j5W4B2UOuvQ_n9aTNHAlrLzVFiqrk" approved
ß∂ßß
关于这个 统一死要
https://blog.csdn.net/weixin_33894640/article/details/93946295


Container runtime network not ready: NetworkReady=false reason:NetworkPluginNotReady message:docker: network plugin is not ready: cni config uninitialized