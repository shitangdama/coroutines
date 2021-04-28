kubernetes cluster.local in-addr.arpa ip6.arpa
forward . /etc/resolv.conf
clusterIP为：10.255.0.2（kubelet配置文件中的clusterDNS）


下载coredns yaml文件：https://raw.githubusercontent.com/coredns/deployment/master/kubernetes/coredns.yaml.sed
修改yaml文件:
kubernetes cluster.local in-addr.arpa ip6.arpa
forward . /etc/resolv.conf
clusterIP为：10.255.0.2（kubelet配置文件中的clusterDNS）

详细描述：
    K8s dns主机名无法正常解析，coredns服务一直处于CrashLoopBackOff状态
    kubectl log coredns
    发现log中有错误
    plugin/loop: Loop (127.0.0.1:44222 -> :53) detected for zone
解题思路：
    coredns主要和resolv.conf打交道，查询resolv中是否形成相应的环造成错误
原因分析：
    coredns会读取系统中/etc/resov.conf中的nameserver内容，如果里面存在本地回环如127.0.0.1或者127.0.0.53那么就容易造成死循环
解决步骤：
    临时修改方案： vim /etc/resolv.conf 将nameserver 临时修改为114.114.114.114
    若临时手动修改，每次重启都会被覆盖的话，则进行如下的操作：
    sudo systemctl stop systemd-resolved
    sudo systemctl disable systemd-resolved
    sudo apt install unbound
    sudo rm -rf /etc/resolv.conf
    sudo vim /etc/NetworkManager/NetworkManager.conf
    在［main］下添加
    dns=unbound
    将dns服务替换为unbound
    reboot 服务器
    之后：
    kubectl edit deployment coredns -n kube-system
    将replicates改为0，从而停止已经启动的coredns pod
    再将replicates 改为2， 这样会触发coredns重新读取系统配置，此时服务的状态为Running


    kubectl scale deployment coredns -n kube-system --replicas=0
    kubectl run -it --rm dns-test --image=busybox:1.28.4 sh
    kubectl run tmp-shell --rm -i --tty --image nicolaka/netshoot -- /bin/bash




    https://www.codenong.com/jsba6d4c63c1ef/

    https://www.itren.org/319.html