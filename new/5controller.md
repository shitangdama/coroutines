KUBE_CONFIG="/home/ubuntu/cert/kube-controller-manager.kubeconfig"
KUBE_APISERVER="https://10.206.16.11:6443"

kubectl config set-cluster kubernetes \
  --certificate-authority=/home/ubuntu/cert/ca.pem \
  --embed-certs=true \
  --server=${KUBE_APISERVER} \
  --kubeconfig=${KUBE_CONFIG}
kubectl config set-credentials kube-controller-manager \
  --client-certificate=./kube-controller-manager.pem \
  --client-key=/home/ubuntu/cert/kube-controller-manager-key.pem \
  --embed-certs=true \
  --kubeconfig=${KUBE_CONFIG}
kubectl config set-context default \
  --cluster=kubernetes \
  --user=kube-controller-manager \
  --kubeconfig=${KUBE_CONFIG}
kubectl config use-context default --kubeconfig=${KUBE_CONFIG}

sudo vi /usr/lib/systemd/system/kube-controller-manager.service


sudo systemctl daemon-reload
sudo systemctl restart --now kube-controller-manager
sudo systemctl start --now kube-controller-manager
sudo systemctl enable kube-controller-manager
sudo systemctl status kube-controller-manager


kube-controller-manager --secure-port=10257 \
--bind-address=127.0.0.1 \
--kubeconfig=/home/ubuntu/cert/kube-controller-manager.kubeconfig \
--service-cluster-ip-range=10.255.0.0/16 \
--cluster-name=kubernetes \
--cluster-signing-cert-file=/home/ubuntu/cert/ca.pem \
--cluster-signing-key-file=/home/ubuntu/cert/ca-key.pem \
--allocate-node-cidrs=true \
--cluster-cidr=172.168.0.0/16 \
--experimental-cluster-signing-duration=87600h \
--root-ca-file=/home/ubuntu/cert/ca.pem \
--service-account-private-key-file=/home/ubuntu/cert/ca-key.pem \
--leader-elect=true \
--feature-gates=RotateKubeletServerCertificate=true \
--controllers=*,bootstrapsigner,tokencleaner \
--horizontal-pod-autoscaler-sync-period=10s \
--tls-cert-file=/home/ubuntu/cert/kube-controller-manager.pem \
--tls-private-key-file=/home/ubuntu/cert/kube-controller-manager-key.pem \
--use-service-account-credentials=true \
--log-dir=/home/ubuntu/log \
--v=2

kube-controller-manager --secure-port=10257 \
--bind-address=127.0.0.1 \
--kubeconfig=/home/ubuntu/cert/kube-controller-manager.kubeconfig \
--service-cluster-ip-range=10.255.0.0/16 \
--cluster-name=kubernetes \
--cluster-signing-cert-file=/home/ubuntu/cert/ca.pem \
--cluster-signing-key-file=/home/ubuntu/cert/ca-key.pem \
--allocate-node-cidrs=true \
--cluster-cidr=172.168.0.0/16 \
--experimental-cluster-signing-duration=87600h \
--root-ca-file=/home/ubuntu/cert/ca.pem \
--service-account-private-key-file=/home/ubuntu/cert/ca-key.pem \
--leader-elect=true \
--feature-gates=RotateKubeletServerCertificate=true \
--controllers=*,bootstrapsigner,tokencleaner \
--horizontal-pod-autoscaler-sync-period=10s \
--log-dir=/home/ubuntu/log \
--v=2

kube-controller-manager  \
--logtostderr=false \
--v=2 \
--log-dir=/home/ubuntu/log \
--leader-elect=true \
--kubeconfig=/home/ubuntu/cert/kube-controller-manager.kubeconfig \
--bind-address=127.0.0.1 \
--allocate-node-cidrs=true \
--cluster-cidr=10.80.0.0/8 \
--service-cluster-ip-range=10.255.0.0/8 \
--cluster-signing-cert-file=/home/ubuntu/cert/ca.pem \
--cluster-signing-key-file=/home/ubuntu/cert/ca-key.pem \
--root-ca-file=/home/ubuntu/cert/ca.pem \
--service-account-private-key-file=/home/ubuntu/cert/ca-key.pem \
--cluster-signing-duration=87600h0m0s

https://github.com/opsnull/follow-me-install-kubernetes-cluster/issues/304

https://www.jianshu.com/p/b02c428950df
