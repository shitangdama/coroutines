--hostname-override：显示名称，集群中唯一

--network-plugin：启用CNI

--kubeconfig：空路径，会自动生成，后面用于连接apiserver

--bootstrap-kubeconfig：首次启动向apiserver申请证书

--config：配置参数文件

--cert-dir：kubelet证书生成目录

--pod-infra-container-image：管理Pod网络容器的镜像


BOOTSTRAP_TOKEN=$(awk -F "," '{print $1}' /home/ubuntu/cert/token.csv)

kubectl config set-cluster kubernetes --certificate-authority=ca.pem --embed-certs=true --server=https://192.168.128.208:16443 --kubeconfig=kubelet-bootstrap.kubeconfig

kubectl config set-credentials kubelet-bootstrap --token=${BOOTSTRAP_TOKEN} --kubeconfig=kubelet-bootstrap.kubeconfig

kubectl config set-context default --cluster=kubernetes --user=kubelet-bootstrap --kubeconfig=kubelet-bootstrap.kubeconfig

kubectl config use-context default --kubeconfig=kubelet-bootstrap.kubeconfig

kubectl create clusterrolebinding kubelet-bootstrap --clusterrole=system:node-bootstrapper --user=kubelet-bootstrap --kubeconfig=kubelet-bootstrap.kubeconfig


KUBE_CONFIG="/home/ubuntu/kubelet/bootstrap.kubeconfig"
KUBE_APISERVER="https://10.206.16.11:6443"
# apiserver IP:PORT
TOKEN="94c210d1f3c51f47a48f74b77f884510" 
# 与token.csv里保持一致

# 生成 kubelet bootstrap kubeconfig 配置文件
kubectl config set-cluster kubernetes \
  --certificate-authority=/home/ubuntu/cert/ca.pem \
  --embed-certs=true \
  --server=${KUBE_APISERVER} \
  --kubeconfig=${KUBE_CONFIG}
kubectl config set-credentials "kubelet-bootstrap" \
  --token=${TOKEN} \
  --kubeconfig=${KUBE_CONFIG}
kubectl config set-context default \
  --cluster=kubernetes \
  --user="kubelet-bootstrap" \
  --kubeconfig=${KUBE_CONFIG}
kubectl config use-context default --kubeconfig=${KUBE_CONFIG}


kubectl create clusterrolebinding kubelet-bootstrap \
--clusterrole=system:node-bootstrapper \
--user=kubelet-bootstrap

sudo vi /usr/lib/systemd/system/kubelet.service


sudo systemctl daemon-reload 
sudo systemctl start kubelet
sudo systemctl restart kubelet
sudo systemctl enable --now kubelet
sudo systemctl status kubelet


确认kubelet服务启动成功后，接着到master上Approve一下bootstrap请求。
kubectl get csr | grep Pending | awk '{print $1}' | xargs kubectl certificate approve
查看一下node是否加入成功
kubectl get nodes


# 查看kubelet证书请求
kubectl get csr
NAME                                                   AGE   SIGNERNAME                                    REQUESTOR           CONDITION
node-csr-jaqXhwxFBnD-1ui9omPdF__0SGovk2ZRhszz_QMGJxI   62s   kubernetes.io/kube-apiserver-client-kubelet   kubelet-bootstrap   Pending

# 批准申请
kubectl certificate approve node-csr-jaqXhwxFBnD-1ui9omPdF__0SGovk2ZRhszz_QMGJxI

# 查看节点（由于网络插件还没有部署，节点会没有准备就绪 NotReady）
kubectl get node
NAME          STATUS     ROLES    AGE   VERSION
k8s-master1   NotReady   <none>   7s    v1.20.4