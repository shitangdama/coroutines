KUBE_CONFIG="/home/ubuntu/coroutines/pki/config.kubeconfig"
KUBE_APISERVER="https://172.17.0.2:6443"

# BOOTSTRAP_TOKEN=4218903d0f96c61ce3be55a8f61639c4  #token.csv中的token

# KUBE_APISERVER=https://172.17.0.2:6443  #api-server访问地址

kubectl config set-cluster kubernetes \
  --certificate-authority=/home/ubuntu/coroutines/pki/ca.pem \
  --embed-certs=true \
  --server=${KUBE_APISERVER} \
  --kubeconfig=${KUBE_CONFIG}
kubectl config set-credentials kube-controller-manager \
  --client-certificate=/home/ubuntu/coroutines/pki/admin.pem \ #使用admin。pem
  --client-key=/home/ubuntu/coroutines/pki/admin-key.pem \
  --embed-certs=true \
  --kubeconfig=${KUBE_CONFIG}
kubectl config set-context default \
  --cluster=kubernetes \
  --user=kube-controller-manager \
  --kubeconfig=${KUBE_CONFIG}
kubectl config use-context default --kubeconfig=${KUBE_CONFIG}