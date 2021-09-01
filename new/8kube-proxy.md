cfssl gencert -ca=ca.pem -ca-key=ca-key.pem -config=ca-config.json -profile=kubernetes kube-proxy-csr.json | cfssljson -bare kube-proxy


KUBE_CONFIG="/home/ubuntu/cert/kube-proxy.kubeconfig"
KUBE_APISERVER="https://10.206.16.11:6443"

kubectl config set-cluster kubernetes \
  --certificate-authority=/home/ubuntu/cert/ca.pem \
  --embed-certs=true \
  --server=${KUBE_APISERVER} \
  --kubeconfig=${KUBE_CONFIG}
kubectl config set-credentials kube-proxy \
  --client-certificate=./kube-proxy.pem \
  --client-key=./kube-proxy-key.pem \
  --embed-certs=true \
  --kubeconfig=${KUBE_CONFIG}
kubectl config set-context default \
  --cluster=kubernetes \
  --user=kube-proxy \
  --kubeconfig=${KUBE_CONFIG}
kubectl config use-context default --kubeconfig=${KUBE_CONFIG}


sudo vi /usr/lib/systemd/system/kube-proxy.service

sudo systemctl daemon-reload 
sudo systemctl start kube-proxy
sudo systemctl restart kube-proxy
sudo systemctl enable --now kube-proxy
sudo systemctl status kube-proxy